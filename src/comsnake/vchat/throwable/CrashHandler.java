package comsnake.vchat.throwable;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.lang.Thread.UncaughtExceptionHandler;
import java.lang.reflect.Field;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import com.snake.vchat.app.Constants;
import com.snake.vchat.app.VChatApplication;
import com.snake.vchat.manager.UserInfoManager;
import com.snake.vchat.pojo.LoginAO;

import android.app.ActivityManager;
import android.app.ActivityManager.MemoryInfo;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Build;
import android.os.Environment;
import android.os.Looper;
import android.text.format.Formatter;
import android.util.Log;
import android.widget.Toast;


/**
 * UncaughtException处理类,当程序发生Uncaught异常的时候,有该类来接管程序,并记录发送错误报告.
 * 
 * @author user
 * 
 */
public class CrashHandler implements UncaughtExceptionHandler {
	
	public static final String TAG = "CrashHandler";
	
	//系统默认的UncaughtException处理类 
	private Thread.UncaughtExceptionHandler mDefaultHandler;
	//CrashHandler实例
	private static CrashHandler INSTANCE = new CrashHandler();
	//程序的Context对象
	private Context mContext;
	//用来存储设备信息和异常信息
	private Map<String, String> infos = new HashMap<String, String>();

	//用于格式化日期,作为日志文件名的一部分
	private DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss", Locale.CHINA);
	
	// 错误文件头部
	private final String FILE_PRE = Constants.ERROR_FILE_NAME_PREFIX;

	/** 保证只有一个CrashHandler实例 */
	private CrashHandler() {
	}

	/** 获取CrashHandler实例 ,单例模式 */
	public static CrashHandler getInstance() {
		return INSTANCE;
	}

	/**
	 * 初始化
	 * 
	 * @param context
	 */
	public void init(Context context) {
		mContext = context;
		//获取系统默认的UncaughtException处理器
		mDefaultHandler = Thread.getDefaultUncaughtExceptionHandler();
		//设置该CrashHandler为程序的默认处理器
		Thread.setDefaultUncaughtExceptionHandler(this);
	}

	/**
	 * 当UncaughtException发生时会转入该函数来处理
	 */
	@Override
	public void uncaughtException(Thread thread, Throwable ex) {
		Log.i(TAG, "uncaughtException");
		if (!handleException(ex) && mDefaultHandler != null) {
			//如果用户没有处理则让系统默认的异常处理器来处理
			mDefaultHandler.uncaughtException(thread, ex);
		} else {
			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				Log.e(TAG, "error : ", e);
			}
			//退出程序
			System.exit(0);
			android.os.Process.killProcess(android.os.Process.myPid());
		}
	}

	/**
	 * 自定义错误处理,收集错误信息 发送错误报告等操作均在此完成.
	 * 
	 * @param ex
	 * @return true:如果处理了该异常信息;否则返回false.
	 */
	private boolean handleException(Throwable ex) {
		if (ex == null) {
			return false;
		}
		//使用Toast来显示异常信息
		new Thread() {
			@Override
			public void run() {
				Looper.prepare();
				Toast.makeText(mContext, "网络不给力，请耐心等待", Toast.LENGTH_LONG).show();
				Looper.loop();
			}
		}.start();
		//保存日志文件 
		saveCrashInfo2File(ex);
		return true;
	}
	
	/**
	 * 收集设备参数信息
	 * @param ctx
	 */
	public void collectDeviceInfo(Context ctx) {
		try {
			PackageManager pm = ctx.getPackageManager();
			PackageInfo pi = pm.getPackageInfo(ctx.getPackageName(), PackageManager.GET_ACTIVITIES);
			if (pi != null) {
				String versionName = pi.versionName == null ? "null" : pi.versionName;
				String versionCode = pi.versionCode + "";
				infos.put("versionName", versionName);
				infos.put("versionCode", versionCode);
			}
		} catch (NameNotFoundException e) {
			Log.e(TAG, "an error occured when collect package info", e);
		}
		Field[] fields = Build.class.getDeclaredFields();
		for (Field field : fields) {
			try {
				field.setAccessible(true);
				infos.put(field.getName(), field.get(null).toString());
				Log.d(TAG, field.getName() + " : " + field.get(null));
			} catch (Exception e) {
				Log.e(TAG, "an error occured when collect crash info", e);
			}
		}
	}

	/**
	 * 保存错误信息到文件中
	 * 
	 * @param ex
	 */
	private void saveCrashInfo2File(Throwable ex) {
		// 文件名start
		LoginAO loginAO = UserInfoManager.getInstance().getUserInformation();
		String name = "unknow";
		if (!"".equals(loginAO.username)){
			name = loginAO.username;
		}
		String time = formatter.format(new Date());
		String fileName = FILE_PRE + "_" + time + "_" + name + ".log";
		// 文件名end
		StringBuffer sb = new StringBuffer();
		if (!Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
			return;
		}
		File file = new File(mContext.getFilesDir(), fileName);
/*		File [] files= mContext.getFilesDir().listFiles(filenameFilter);
		if(files.length > 0){
			file = files[0];
		}
		if (file.isDirectory()){
			file.delete();
		}*/
		if (!file.exists()){
			//收集设备参数信息 
			collectDeviceInfo(mContext);
			for (Map.Entry<String, String> entry : infos.entrySet()) {
				String key = entry.getKey();
				String value = entry.getValue();
				sb.append(key + "=" + value + "\n");
			}
			getTotalMemory(mContext, sb);
		}
		sb.append("\n" + formatter.format(new Date()) + " ====================================================\n");
		getMemoryInfo(mContext, sb);
		Writer writer = new StringWriter();
		PrintWriter printWriter = new PrintWriter(writer);
		ex.printStackTrace(printWriter);
		Throwable cause = ex.getCause();
		while (cause != null) {
			cause.printStackTrace(printWriter);
			cause = cause.getCause();
		}
		printWriter.close();
		String result = writer.toString();
		sb.append(result);
		try {
			FileOutputStream fos = new FileOutputStream(file, true);
			fos.write(sb.toString().getBytes());
			fos.close();
		} catch (Exception e) {
			Log.e(TAG, "an error occured while writing file...", e);
		}
	}
	
	// 获取内存信息
		private void getMemoryInfo(Context context, StringBuffer stringBuffer) {
			ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
			// 单个app的内存信息
			int appMaxMemory = activityManager.getMemoryClass();
			MemoryInfo machineMi = new MemoryInfo();
			activityManager.getMemoryInfo(machineMi);
			// 全局可用内存
			String availMem = Formatter.formatFileSize(context, machineMi.availMem);
			// 系统内存不足的阀值，即临界值
			String threshold = Formatter.formatFileSize(context, machineMi.threshold);
			// 如果当前可用内存<=threshold，该值为真
			boolean isLowMemory = machineMi.lowMemory;
			stringBuffer.append("MachineCurrentMemory : availMem=" + availMem + ", threshold=" + threshold + ", isLowMemory=" + isLowMemory + "\n");
			android.os.Debug.MemoryInfo[] appMi = activityManager.getProcessMemoryInfo(new int[] { android.os.Process.myPid() });
			if (appMi != null) {
				// 获取进程占内存信息形如3.14MB
				double memSize = (appMi[0].getTotalPss()) / 1024.0;
				int temp = (int) (memSize * 100);
				memSize = temp / 100.0;
				stringBuffer.append("AppMaxMemory=" + appMaxMemory + ".00MB, AppCurrentMemory=" + memSize + "MB\n");
			}
		}

		// 获取总内存信息
		private void getTotalMemory(Context context, StringBuffer stringBuffer) {
			String str1 = "/proc/meminfo";// 系统内存信息文件
			String str2;
			String[] arrayOfString;
			long initial_memory = 0;
			try {
				FileReader localFileReader = new FileReader(str1);
				BufferedReader localBufferedReader = new BufferedReader(
						localFileReader, 8192);
				str2 = localBufferedReader.readLine();// 读取meminfo第一行，系统总内存大小
				arrayOfString = str2.split("\\s+");
				for (String num : arrayOfString) {
					Log.i(str2, num + "\t");
				}

				initial_memory = Integer.valueOf(arrayOfString[1]).intValue() * 1024;// 获得系统总内存，单位是KB，乘以1024转换为Byte
				localBufferedReader.close();

			} catch (IOException e) {
			}
			String totalMemory = Formatter.formatFileSize(context, initial_memory);// Byte转换为KB或者MB，内存大小规格化
			stringBuffer.append("TotalMemory=" + totalMemory + "\n");
		}
	
	// 文件名过滤器
	FilenameFilter filenameFilter = new FilenameFilter() {
		
		@Override
		public boolean accept(File dir, String filename) {
			// TODO 自动生成的方法存根
			if (filename.startsWith(FILE_PRE)) {
				return true;
			}
			return false;
		}
	};
}