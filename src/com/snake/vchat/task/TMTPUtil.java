package com.snake.vchat.task;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;

import android.app.Activity;
import android.app.ActivityManager;
import android.app.ActivityManager.RunningTaskInfo;
import android.app.AlertDialog;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.Configuration;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Paint.FontMetrics;
import android.graphics.Point;
import android.location.LocationManager;
import android.media.ExifInterface;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.os.StatFs;
import android.provider.MediaStore;
import android.telephony.TelephonyManager;
import android.util.DisplayMetrics;
import android.util.FloatMath;
import android.util.Log;
import android.view.Display;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.EditText;
import android.widget.ZoomButtonsController;

import com.gt.cl.util.CLFileUtil;
import com.gt.cl.util.CLLog;
import com.snake.vchat.R;

public final class TMTPUtil {

	private static final String TAG = "CommonUtil";

	private static int SCREEN_SIZE_1 = -1;
	private static int SCREEN_SIZE_2 = -1;
	private static Boolean isBelow480WidthDevice = null;

	public static boolean isNull(Object... objects) {
		return isNull(false, objects);
	}

	public static boolean isNull(Boolean checkChildCollections,
			Object... objects) {
		boolean flag = true;
		if (objects != null) {
			for (Object o : objects) {
				if (o != null) {
					if (checkChildCollections
							&& (o instanceof Collection<?> || o instanceof Object[])) {
						return isNull(true, o);
					} else {
						flag = "".equals(o.toString().trim());
						if (flag) {
							break;
						}
					}
				} else {
					flag = true;
					break;
				}
			}
		}
		return flag;
	}

	/**
	 * Detect whether SD card has mounted or not.
	 * 
	 * @return
	 */
	public static boolean hasMountSDCard() {
		return android.os.Environment.getExternalStorageState().equals(
				android.os.Environment.MEDIA_MOUNTED);
	}

	/**
	 * Obtain SD card total size.
	 * 
	 * @return byte unit of SD card total size.
	 */
	public static long getExternalStorageTotalSize() {
		final StatFs statfs = new StatFs(Environment
				.getExternalStorageDirectory().getAbsolutePath());
		final long blockCount = statfs.getBlockCount();
		final long blockSize = statfs.getBlockSize();
		return blockCount * blockSize;
	}

	/**
	 * Obtain SD card free size.
	 * 
	 * @return byte unit of SD card free size.
	 */
	public static long getExternalStorageFreeSize() {
		final StatFs statfs = new StatFs(Environment
				.getExternalStorageDirectory().getAbsolutePath());
		final long availableBlocks = statfs.getAvailableBlocks();
		final long blockSize = statfs.getBlockSize();
		return availableBlocks * blockSize;
	}

	public static int computePercentOfScreenWidth(Context context, int percent) {
		return getScreenWidth(context) * percent / 100;
	}

	public static int computePercentOfScreenHeight(Context context, int percent) {
		return getScreenHeight(context) * percent / 100;
	}

	public static int getScreenWidth(Context context) {
		if (SCREEN_SIZE_1 <= 0 || SCREEN_SIZE_2 <= 0) {
			DisplayMetrics dm = new DisplayMetrics();
			WindowManager wm = (WindowManager) context
					.getSystemService(Context.WINDOW_SERVICE);
			if (wm != null) {
				wm.getDefaultDisplay().getMetrics(dm);
			}
			SCREEN_SIZE_1 = dm.widthPixels;
			SCREEN_SIZE_2 = dm.heightPixels;
		}

		Configuration conf = context.getResources().getConfiguration();
		switch (conf.orientation) {
		case Configuration.ORIENTATION_LANDSCAPE:
			return SCREEN_SIZE_1 > SCREEN_SIZE_2 ? SCREEN_SIZE_1
					: SCREEN_SIZE_2;
		case Configuration.ORIENTATION_PORTRAIT:
			return SCREEN_SIZE_1 < SCREEN_SIZE_2 ? SCREEN_SIZE_1
					: SCREEN_SIZE_2;
		default:
			Log.e(TAG, "can't get screen width!");
		}
		return SCREEN_SIZE_1;
	}

	public static int getScreenHeight(Context context) {
		if (SCREEN_SIZE_1 <= 0 || SCREEN_SIZE_2 <= 0) {
			DisplayMetrics dm = new DisplayMetrics();
			WindowManager wm = (WindowManager) context
					.getSystemService(Context.WINDOW_SERVICE);
			wm.getDefaultDisplay().getMetrics(dm);
			SCREEN_SIZE_1 = dm.widthPixels;
			SCREEN_SIZE_2 = dm.heightPixels;
		}

		Configuration conf = context.getResources().getConfiguration();
		switch (conf.orientation) {
		case Configuration.ORIENTATION_LANDSCAPE:
			return SCREEN_SIZE_1 < SCREEN_SIZE_2 ? SCREEN_SIZE_1
					: SCREEN_SIZE_2;
		case Configuration.ORIENTATION_PORTRAIT:
			return SCREEN_SIZE_1 > SCREEN_SIZE_2 ? SCREEN_SIZE_1
					: SCREEN_SIZE_2;
		default:
			Log.e(TAG, "can't get screen height!");
		}
		return SCREEN_SIZE_1;
	}

	/**
	 * 判断是否为平板
	 * 
	 * @return
	 */
	public static boolean isPad(Context context) {
		boolean isPad = false;
		// {treat Galaxy Note as phone.
		Configuration config = context.getResources().getConfiguration();
		if ((config.screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK) == Configuration.SCREENLAYOUT_SIZE_NORMAL) {
			Log.i(TAG, "screenLaytout : SCREENLAYOUT_SIZE_NORMAL");
			isPad = false;
		} else if ((config.screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK) == 4) {
			// Configuration.SCREENLAYOUT_SIZE_XLARGE in API 11
			Log.i(TAG, "screenLaytout : SCREENLAYOUT_SIZE_XLARGE");
			isPad = true;
		} else {
			Log.i(TAG,
					"screenLaytout :"
							+ (config.screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK));
			isPad = false;
		}
		return isPad;
	}

	public static boolean isSmallPhone(Context context) {
		DisplayMetrics dm = new DisplayMetrics();
		WindowManager wm = (WindowManager) context
				.getSystemService(Context.WINDOW_SERVICE);
		wm.getDefaultDisplay().getMetrics(dm);
		if (dm.densityDpi <= 160 && android.os.Build.VERSION.SDK_INT <= 10) {
			return true;
		}
		return false;
	}

	public static int getHeightByText(String text, int width) {
		Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
		paint.setTextSize(20);
		float totalWidth = paint.measureText(text);
		float totalRowNumber = totalWidth / width
				+ (totalWidth % width == 0 ? 1 : 0);
		FontMetrics fm = paint.getFontMetrics();
		float fontHeight = fm.bottom - fm.top;
		return (int) ((totalRowNumber + 2) * fontHeight);
	}

	public static boolean isMediumDensity(Context context) {
		DisplayMetrics dm = new DisplayMetrics();
		WindowManager wm = (WindowManager) context
				.getSystemService(Context.WINDOW_SERVICE);
		wm.getDefaultDisplay().getMetrics(dm);
		if (dm.densityDpi <= 160) {
			return true;
		}
		return false;
	}

	/**
	 * dip单位值转成px单位值
	 * 
	 * @param px单位的值
	 * @return dip单位的值
	 */
	public static float px2dip(Context context, int px) {
		final float scale = context.getResources().getDisplayMetrics().density;
		return (px - 0.5f) / scale;
	}

	/**
	 * dip单位值转成px单位值
	 * 
	 * @param dip
	 *            dip单位的值
	 * @return px单位的值
	 */
	public static float dip2px(Context context, int dip) {
		final float scale = context.getResources().getDisplayMetrics().density;
		return (dip * scale + 0.5f);
	}

	/**
	 * Get Android System version, eg: 2.3
	 * 
	 * @param context
	 * @return version
	 * @author Tim
	 */
	public static String getOSVersion(Context context) {
		return android.os.Build.VERSION.RELEASE;
	}

	/**
	 * Get Android SDK API Level
	 * 
	 * @param context
	 * @return API level
	 */
	public static int getAPILevel(Context context) {
		return android.os.Build.VERSION.SDK_INT;
	}

	/**
	 * Get screen density.
	 * 
	 * @param context
	 * @return density
	 * @author Tim
	 */
	public static float getDensity(Context context) {
		return context.getResources().getDisplayMetrics().density;
	}

	/**
	 * Get screen density dpi.
	 * 
	 * @param context
	 * @return density dpi
	 * @author Tim
	 */
	public static int getDensityDpi(Context context) {
		return context.getResources().getDisplayMetrics().densityDpi;
	}

	/**
	 * Get current screen orientation, one of {@link #ORIENTATION_LANDSCAPE},
	 * {@link #ORIENTATION_PORTRAIT}, or {@link #ORIENTATION_SQUARE} in Class
	 * android.content.res.Configuration.
	 * 
	 * @param context
	 * @return orientation
	 * @author Tim
	 */
	public static int getOrientation(Context context) {
		return context.getResources().getConfiguration().orientation;
	}

	/**
	 * Generate random number, exclude zero.
	 * 
	 * @param howMany
	 *            how many number you want generate.
	 * @return Random number string.
	 * @author Tim
	 */
	public static String generateRandomNumber(int howMany) {
		String result = "";
		Random random = new Random();
		for (int i = 0; i < howMany; i++) {
			int randomNumber = random.nextInt(8) + 1;
			result += randomNumber;
		}
		return result;
	}

	/**
	 * Get current system locale
	 * 
	 * @param context
	 * @return locale
	 * @author Tim
	 */
	public static Locale getSystemLocale(Context context) {
		return context.getResources().getConfiguration().locale;
	}

	/**
	 * Get the application version which is launching
	 * 
	 * @param context
	 * @return application version
	 * @author Tim
	 */
	public static String getAppVersion(Context context) {
		String version = null;
		try {
			PackageManager pm = context.getPackageManager();
			PackageInfo info = pm.getPackageInfo(context.getPackageName(),
					PackageManager.GET_CONFIGURATIONS);
			version = info.versionName;
		} catch (NameNotFoundException e) {
			e.printStackTrace();
		}
		return version;
	}

	/**
	 * Get the running activities in this application (need
	 * "android.permission.GET_TASKS" permission).
	 * 
	 * @param context
	 * @return size of running activities.
	 */
	public static int countRunningActivities(Context context) {
		ActivityManager activityManager = (ActivityManager) context
				.getSystemService(Context.ACTIVITY_SERVICE);
		// activityManager.r
		// ActivityManager.RunningTaskInfo a = context.
		RunningTaskInfo task = null;
		try {
			task = activityManager.getRunningTasks(1).get(0);
		} catch (SecurityException e) {
			// TODO: handle exception
			Log.e(TAG, "No \"android.permission.GET_TASKS\" permission.");
			task = null;
		}
		return task == null ? 0 : task.numRunning;
	}

	public static String getImagePathFromUri(Activity activity, Uri uri) {
		String path = null;
		String[] projection = { MediaStore.Images.Media.DATA };
		Cursor cursor = activity
				.managedQuery(uri, projection, null, null, null);
		if (cursor != null) {
			int column_index = cursor
					.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
			cursor.moveToFirst();
			path = cursor.getString(column_index);
		}
		return path;
	}

	public static String getFilePathFromUri(Context context, Uri uri) {
		if ("content".equalsIgnoreCase(uri.getScheme())) {
			String[] projection = { "_data" };
			Cursor cursor = null;

			try {
				cursor = context.getContentResolver().query(uri, projection,
						null, null, null);
				int column_index = cursor.getColumnIndexOrThrow("_data");
				if (cursor.moveToFirst()) {
					return cursor.getString(column_index);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("file".equalsIgnoreCase(uri.getScheme())) {
			return uri.getPath();
		}

		return null;
	}

	// public static String date2String(String date, String parseStr) {
	// SimpleDateFormat sdf = null;
	// Log.i(TAG, "date:" + date + " |parseStr:" + parseStr);
	// if (parseStr == null) {
	// sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	// } else {
	// sdf = new SimpleDateFormat(parseStr);
	// }
	// Date d = null;
	// try {
	// d = sdf.parse(date);
	// } catch (ParseException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// if (Language.CurrentLanguage != null &&
	// Language.CurrentLanguage.equals(Language.English)) {
	// // String suffixOfDay = getDayOfMonthSuffix(d.getDate());
	// sdf = new SimpleDateFormat("dd-MM-yyyy");
	// } else {
	// sdf = new SimpleDateFormat("yyyy年MM月dd日");
	// }
	// return sdf.format(d);
	//
	// }

	private static String getDayOfMonthSuffix(final int n) {
		if (n < 1 || n > 31) {
			throw new IllegalArgumentException("illegal day of month: " + n);
		}
		if (n >= 11 && n <= 13) {
			return "th";
		}
		switch (n % 10) {
		case 1:
			return "st";
		case 2:
			return "nd";
		case 3:
			return "rd";
		default:
			return "th";
		}
	}

	/*
	 * public static void alert(Context context, int msgId,
	 * DialogInterface.OnClickListener l) { alert(context,
	 * context.getString(msgId), l); }
	 */

	/*
	 * public static void alert(Context context, String message,
	 * DialogInterface.OnClickListener l) { new AlertDialog.Builder(context)
	 * .setCancelable(false) .setTitle(null) .setMessage(message)
	 * .setPositiveButton(R.string.common_ok, l) .create() .show(); }
	 */

	/**
	 * 解压缩功能. 将zipFile文件解压到folderPath目录下.
	 * 
	 * @throws Exception
	 */
	public static int unZipFile(File zipFile, String folderPath)
			throws ZipException, IOException {
		ZipFile zfile = new ZipFile(zipFile);
		Enumeration<? extends ZipEntry> zList = zfile.entries();
		ZipEntry ze = null;
		byte[] buf = new byte[1024];
		while (zList.hasMoreElements()) {
			ze = (ZipEntry) zList.nextElement();
			if (ze.isDirectory()) {
				// Log.d("unZipFile", "ze.getName() = "+ze.getName());
				String dirstr = folderPath + ze.getName();
				// dirstr.trim();
				dirstr = new String(dirstr.getBytes("8859_1"), "UTF-8");
				// Log.d("unZipFile", "str = "+dirstr);
				File f = new File(dirstr);
				f.mkdir();
				continue;
			}
			// Log.d("unZipFile", "ze.getName() = "+ze.getName());
			OutputStream os = new BufferedOutputStream(new FileOutputStream(
					getRealFileName(folderPath, ze.getName())));
			InputStream is = new BufferedInputStream(zfile.getInputStream(ze));
			int readLen = 0;
			while ((readLen = is.read(buf, 0, 1024)) != -1) {
				os.write(buf, 0, readLen);
			}
			is.close();
			os.close();
		}
		zfile.close();
		Log.d("unZipFile", "unZip successful.");
		return 0;
	}

	/**
	 * 给定根目录，返回一个相对路径所对应的实际文件名.
	 * 
	 * @param baseDir
	 *            指定根目录
	 * @param absFileName
	 *            相对路径名，来自于ZipEntry中的name
	 * @return java.io.File 实际的文件
	 */
	public static File getRealFileName(String baseDir, String absFileName) {
		String[] dirs = absFileName.split("/");
		File ret = new File(baseDir);
		String substr = null;
		if (dirs.length > 1) {
			for (int i = 0; i < dirs.length - 1; i++) {
				substr = dirs[i];
				try {
					// substr.trim();
					substr = new String(substr.getBytes("8859_1"), "GB2312");

				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				ret = new File(ret, substr);

			}
			Log.d("unZipFile", "1ret = " + ret);
			if (!ret.exists())
				ret.mkdirs();
			substr = dirs[dirs.length - 1];
			try {
				// substr.trim();
				substr = new String(substr.getBytes("8859_1"), "GB2312");
				Log.d("unZipFile", "substr = " + substr);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			ret = new File(ret, substr);
			Log.d("unZipFile", "2ret = " + ret);
			return ret;
		}
		return ret;
	}

	/*
	 * public static void showConnectNetWorkExceptionDialog(Looper loop, final
	 * Context context, final DialogInterface.OnClickListener onOkClick) { new
	 * Handler(loop).post(new Runnable() {
	 * 
	 * @Override public void run() { new
	 * AlertDialog.Builder(context).setCancelable
	 * (false).setTitle(R.string.tip_network_error_title)
	 * .setMessage(R.string.tip_network_exception_content
	 * ).setPositiveButton(R.string.common_ok, onOkClick).create().show(); } });
	 * } public static Dialog showConnectNetworkExceptionDialog(final Context
	 * context, final DialogInterface.OnClickListener onOkClick) { AlertDialog
	 * alertDialog=new
	 * AlertDialog.Builder(context).setCancelable(false).setTitle
	 * (R.string.tip_network_error_title)
	 * .setMessage(R.string.tip_network_exception_content
	 * ).setPositiveButton(R.string.common_ok, onOkClick).create();
	 * alertDialog.show(); return alertDialog; }
	 */

	public static boolean isNetworkAvailable(Context context) {
		ConnectivityManager cm = (ConnectivityManager) context
				.getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo netInfo = cm.getActiveNetworkInfo();
		if (netInfo != null && netInfo.isConnectedOrConnecting()) {
			return true;
		}
		return false;
	}

	public static boolean isHighResolutionDevice(Context context) {
		int width = getScreenWidth(context);
		int height = getScreenHeight(context);
		if (width > height) {
			// Landscape
			return height > 480;
		} else {
			// Portrait
			return width > 480;
		}

	}

	public static boolean isGPSAvailable(Context context) {
		boolean available = false;
		PackageManager pm = context.getPackageManager();
		if (pm.hasSystemFeature(PackageManager.FEATURE_LOCATION)) {
			LocationManager lm = (LocationManager) context
					.getSystemService(Context.LOCATION_SERVICE);
			available = lm.isProviderEnabled(LocationManager.GPS_PROVIDER)
					&& lm.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
		}
		return available;
	}

	public static int getMetricsWidth(Context context) {

		DisplayMetrics dm = new DisplayMetrics();
		((Activity) context).getWindowManager().getDefaultDisplay()
				.getMetrics(dm);
		int width = dm.widthPixels;
		return width;
	}

	public static int getMetricsHeight(Context context) {
		DisplayMetrics dm = new DisplayMetrics();
		((Activity) context).getWindowManager().getDefaultDisplay()
				.getMetrics(dm);
		int height = dm.heightPixels;
		return height;
	}

	/*
	 * public static void registerServerWithPushMessage(final
	 * MusicholicApplication application) { // new Thread(new Runnable() { //
	 * @Override // public void run() { try{ // final String regId =
	 * GCMManager.getRegistrationId(); // if(regId != null){ // String language
	 * = application.getSettingService().getLanguage().toString(); // boolean
	 * registered =
	 * GtServerUtilities.registerGtHkServer(application.getApplicationContext(),
	 * regId, language); // Log.e(TAG,
	 * "startByGtHKType>>>registered="+registered); // } String language =
	 * application.getSettingService().getLanguage().toString();
	 * GCMManager.startByGtHKType(language); } catch(Exception e){ Log.e(TAG,
	 * "registerServerWithPushMessage>>>e="+e.toString()); } // } // }).start();
	 * }
	 */

	/*
	 * public static void registerServerWithPushMessageSync(final
	 * YouthApplication application) { try { String language =
	 * application.getSettingService().getLanguage().toString();
	 * GCMManager.startByGtHKType(language, null, true); } catch(Exception e) {
	 * e.printStackTrace(); } }
	 */

	public static String getDeviceModel() {
		return Build.MODEL;
	}

	public static boolean isEnableAccountsBackgroundData(Context context) {
		// boolean enabled = false;
		// ConnectivityManager cm = (ConnectivityManager)
		// context.getSystemService(Context.CONNECTIVITY_SERVICE);
		// if(getAPILevel(context) >= 14) {
		// NetworkInfo networkInfo = cm.getActiveNetworkInfo();
		// enabled = networkInfo != null && networkInfo.isConnected();
		// }
		// else {
		// enabled = cm.getBackgroundDataSetting();
		// }
		// return enabled;
		return true;
	}

	public static void hideSoftKeyboard(EditText editText) {
		final InputMethodManager imm = (InputMethodManager) editText
				.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
		imm.hideSoftInputFromWindow(editText.getWindowToken(), 0);
	}

	public static void showSoftKeyboard(EditText mStatusInput) {
		InputMethodManager im = (InputMethodManager) mStatusInput.getContext()
				.getSystemService(Context.INPUT_METHOD_SERVICE);
		im.showSoftInput(mStatusInput, InputMethodManager.SHOW_FORCED);
	}

	/**
	 * 轉換成時間格式，如：05:20
	 * 
	 * @param milliseconds
	 *            毫秒
	 * @return 時間格式字符串
	 */
	public static String transformTimeFormat(long millseconds) {
		return transformTimeFormat(millseconds, false);
	}

	/**
	 * 轉換成時間格式，如：1:05:20
	 * 
	 * @param milliseconds
	 *            毫秒
	 * @param withHours
	 *            是否包含小時
	 * @return 時間格式字符串
	 */
	public static String transformTimeFormat(long milliseconds,
			boolean withHours) {
		String retValue = withHours ? "0:00" : "0:0:00";
		if (milliseconds > 0) {
			long allSeconds = milliseconds / 1000;
			long allMinutes = allSeconds / 60;
			long allHours = allMinutes / 60;
			int seconds = (int) (allSeconds % 60);
			int minutes = (int) (allMinutes % 60);
			final String formater = seconds < 10 ? "%s%d:0%d" : "%s%d:%d";
			retValue = String.format(formater, withHours ? (allHours + ":")
					: "", minutes, seconds);
		}
		return retValue;
	}

	public static String getIMEI(Context context) {
		TelephonyManager telephonyManager = (TelephonyManager) context
				.getSystemService(Context.TELEPHONY_SERVICE);
		return telephonyManager.getDeviceId();
	}

	/**
	 * 去掉str中的空白字符，如空格，换行符，制表符等等
	 * 
	 * @param str
	 * @return
	 */
	public static String replaceBlank(String str) {
		String dest = "";
		if (str != null) {
			Pattern p = Pattern.compile("\\s*|\t|\r|\n");
			Matcher m = p.matcher(str);
			dest = m.replaceAll("");
		}
		return dest;
	}

	public static String trim(String str) {
		String dest = "";
		if (str != null) {
			dest = str.trim();
		}
		return dest;
	}

	public static StringBuffer getFileContentTextFromAssets(Context context,
			String filePathUnderAssets) {
		StringBuffer content = new StringBuffer();
		if (context != null && filePathUnderAssets != null) {
			InputStream inputStream = null;
			InputStreamReader inputStreamReader = null;
			BufferedReader bufferedReader = null;
			try {
				inputStream = context.getAssets().open(filePathUnderAssets);
				inputStreamReader = new InputStreamReader(inputStream);
				bufferedReader = new BufferedReader(inputStreamReader);
				String line = null;
				while ((line = bufferedReader.readLine()) != null) {
					content.append(line);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				CLFileUtil.closeIOStream(bufferedReader);
				CLFileUtil.closeIOStream(inputStreamReader);
				CLFileUtil.closeIOStream(inputStream);
			}
		}
		return content;
	}

	public static void clearWebViewCache(Context context) {
		// File file = CacheManager.getCacheFileBaseDir();
		// if (file != null && file.exists() && file.isDirectory()) {
		// for (File item : file.listFiles()) {
		// item.delete();
		// }
		// file.delete();
		// }

		// context.deleteDatabase("webview.db");
		// context.deleteDatabase("webviewCache.db");

		clearCacheFolder(context.getCacheDir(), System.currentTimeMillis());
	}

	/**
	 * Clear the cache folder before time numDays
	 * 
	 * @param dir
	 *            Cache folder, should be context.getCacheDir().
	 * @param numDays
	 *            The time milliseconds before cache would be clear. eg:
	 *            System.currentTimeMillis().
	 * @return
	 */
	public static int clearCacheFolder(File dir, long numDays) {
		int deletedFiles = 0;
		if (dir != null && dir.isDirectory()) {
			try {
				for (File child : dir.listFiles()) {
					if (child.isDirectory()) {
						deletedFiles += clearCacheFolder(child, numDays);
					}
					if (child.lastModified() < numDays) {
						if (child.delete()) {
							deletedFiles++;
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return deletedFiles;
	}

	/**
	 * 調用此方法可以設置Developer Options中的Don't Keep
	 * Activities為false，以防止切換其他Activity時銷毀掉當前的Activity.<br/>
	 * 注：Android 4.2以上需要 android.permission.WRITE_SECURE_SETTINGS 權限.<br/>
	 * <br/>
	 * <b>經測試，此方法需要開啟 android.permission.WRITE_SECURE_SETTINGS
	 * 權限，但此權限僅供系統的app使用，故此方法無效!</b>
	 * 
	 * @param context
	 * @return 是否設置成功（不同的SDK用的方法不同）
	 */
	@Deprecated
	public static boolean keepActivities(Context context) {
		boolean successful = false;

		// For Android SDK 4.2+
		// if(getAPILevel(context) >= 17) {
		// successful = Settings.Global.putInt(context.getContentResolver(),
		// Settings.Global.ALWAYS_FINISH_ACTIVITIES,
		// 0);
		// }
		// else {
		// successful = Settings.System.putInt(context.getContentResolver(),
		// Settings.System.ALWAYS_FINISH_ACTIVITIES,
		// 0);
		// }

		// For Android SDK 4.2-
		// successful = Settings.System.putInt(context.getContentResolver(),
		// Settings.System.ALWAYS_FINISH_ACTIVITIES,
		// 0);

		Log.d(TAG, "keepActivities >> " + successful);
		return successful;
	}

	public static boolean isBelow480WidthDevice(Context context) {
		if (isBelow480WidthDevice == null) {
			isBelow480WidthDevice = getScreenWidth(context) <= 480;
		}
		return isBelow480WidthDevice;
	}

	public static void removeWebViewZoomControlBar(WebView webview) {
		if (webview == null || webview.getContext() == null) {
			return;
		}
		Class<?> classType;
		Field field;
		try {
			int apiLevel = getAPILevel(webview.getContext());
			if (apiLevel >= 11) {
				classType = WebSettings.class;
				Method method = classType.getMethod("setDisplayZoomControls",
						boolean.class);
				method.invoke(webview.getSettings(), false);
			} else {
				classType = WebView.class;
				field = classType.getDeclaredField("mZoomButtonsController");
				field.setAccessible(true);
				ZoomButtonsController mZoomButtonsController = new ZoomButtonsController(
						webview);
				mZoomButtonsController.getZoomControls().setVisibility(
						View.GONE);
				try {
					field.set(webview, mZoomButtonsController);
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
			}
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Context getMainContext(Context context) {
		if (context instanceof Activity) {
			Activity acitvity = (Activity) context;
			while (acitvity.getParent() != null) {
				acitvity = acitvity.getParent();
			}
			return acitvity;
		} else {
			return context;
		}
	}

	public static String toMd5(byte[] bytes) {
		try {
			MessageDigest algorithm = MessageDigest.getInstance("MD5");
			algorithm.reset();
			algorithm.update(bytes);
			return toHexString(algorithm.digest(), "");
		} catch (NoSuchAlgorithmException e) {
			Log.e("he--------------------------------ji", "toMd5(): " + e);
			throw new RuntimeException(e);
		}
	}

	public static String toHexString(byte[] bytes, String separator) {
		StringBuilder hexString = new StringBuilder();
		for (byte b : bytes) {
			hexString.append(Integer.toHexString(0xFF & b)).append(separator);
		}
		return hexString.toString();
	}

	public static Point getScreenResolution(WindowManager wm) {
		Display display = wm.getDefaultDisplay();
		Point size = new Point();

		try {

			if (android.os.Build.VERSION.SDK_INT < 13) {
				Method mrh = display.getClass().getMethod("getSize",
						Point.class);
				mrh.invoke(display, size);
				return size;
			} else if (android.os.Build.VERSION.SDK_INT == 13) {

				Method mrh = display.getClass().getMethod("getRealHeight");
				size.y = (Integer) mrh.invoke(display);
				Method mrw = display.getClass().getMethod("getRealWidth");
				size.x = (Integer) mrw.invoke(display);

			} else if (android.os.Build.VERSION.SDK_INT > 13
					&& android.os.Build.VERSION.SDK_INT < 17) {

				Method mrh = display.getClass().getMethod("getRawHeight");
				size.y = (Integer) mrh.invoke(display);
				Method mrw = display.getClass().getMethod("getRawWidth");
				size.x = (Integer) mrw.invoke(display);

			} else if (android.os.Build.VERSION.SDK_INT >= 17) {
				Method mrh = display.getClass().getMethod("getRealSize",
						Point.class);
				mrh.invoke(display, size);
			}
		} catch (Exception e) {
			Log.w(TAG, e.toString());

		} finally {
			if (size.x <= 0 && size.y <= 0) {
				DisplayMetrics dm = new DisplayMetrics();
				display.getMetrics(dm);
				size.x = dm.widthPixels;
				size.y = dm.heightPixels;
			}
			Log.i(TAG, "getScreenResolution>>>" + size);
			return size;
		}
	}

	// public static void showCallDialog(final Context context, final String
	// number) {
	// new AlertDialog.Builder(context).setMessage(number)
	// .setNegativeButton(context.getString(R.string.common_call), new
	// DialogInterface.OnClickListener() {
	//
	// @Override
	// public void onClick(DialogInterface dialog, int which) {
	// Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:"
	// + number));
	// intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
	// context.startActivity(intent);
	// }
	// })
	// .setPositiveButton(context.getString(R.string.common_cancel),
	// null).create().show();
	// }

	public static boolean isConnectNetWork(final Context context) {
		boolean result = false;
		ConnectivityManager cm;
		cm = (ConnectivityManager) context
				.getSystemService(Context.CONNECTIVITY_SERVICE);

		boolean isWifiConnected = cm.getNetworkInfo(
				ConnectivityManager.TYPE_WIFI).getState() == NetworkInfo.State.CONNECTED ? true
				: false;
		boolean isGprsConnected = cm.getNetworkInfo(
				ConnectivityManager.TYPE_MOBILE).getState() == NetworkInfo.State.CONNECTED ? true
				: false;
		// Log.d(TAG, "wifi connected:" + isWifiConnected + " gps connected:" +
		// isGprsConne cted);
		result = isWifiConnected || isGprsConnected ? true : false;
		if (!result) {
			new AlertDialog.Builder(context).setCancelable(false)
					.setTitle(R.string.app_name).setMessage("网络连接失败")
					.setPositiveButton("是的", null).create().show();
		}
		return result;
	}

	public static int readPictureDegree(String path) {
		int degree = 0;
		try {
			ExifInterface exifInterface = new ExifInterface(path);
			int orientation = exifInterface.getAttributeInt(
					ExifInterface.TAG_ORIENTATION,
					ExifInterface.ORIENTATION_NORMAL);
			switch (orientation) {
			case ExifInterface.ORIENTATION_ROTATE_90:
				degree = 90;
				break;
			case ExifInterface.ORIENTATION_ROTATE_180:
				degree = 180;
				break;
			case ExifInterface.ORIENTATION_ROTATE_270:
				degree = 270;
				break;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return degree;
	}

	public static Bitmap getResizedImage(String url, int targetWidth,
			int targetHeight) {

		Bitmap bm = null;
		BitmapFactory.Options options = new BitmapFactory.Options();
		options.inJustDecodeBounds = true;
		BitmapFactory.decodeFile(url, options);
		int width = options.outWidth;
		int height = options.outHeight;
		CLLog.i("width", "getResizedImage width ============== " + width);
		CLLog.i("width", "getResizedImage height ============== " + height);

		if (width > targetWidth || height > targetHeight) {

			options = new BitmapFactory.Options();

			// 编码后bitmap的宽高,bitmap除以屏幕宽度得到压缩比

			int widthRatio = (int) FloatMath.ceil(width / (float) targetWidth);
			int heightRatio = (int) FloatMath.ceil(height
					/ (float) targetHeight);

			if (widthRatio > 1 || heightRatio > 1) {
				if (widthRatio > heightRatio) {
					// 压缩到原来的(1/widthRatios)
					options.inSampleSize = widthRatio;
				} else {
					options.inSampleSize = heightRatio;
				}
			}
			CLLog.i("width", "getResizedImage widthRatio ============== "
					+ widthRatio);
			CLLog.i("width", "getResizedImage heightRatio ============== "
					+ heightRatio);

			options.inJustDecodeBounds = false;
			bm = BitmapFactory.decodeFile(url, options);
		} else {
			bm = BitmapFactory.decodeFile(url);
		}

		return bm;
	}

	public static Bitmap rotaingImageView(int angle, Bitmap bitmap) {
		if (bitmap == null) {
			return null;
		}
		// 旋转图片 动作
		Matrix matrix = new Matrix();
		;
		matrix.postRotate(angle);
		// 创建新的图片
		Bitmap resizedBitmap = Bitmap.createBitmap(bitmap, 0, 0,
				bitmap.getWidth(), bitmap.getHeight(), matrix, true);
		return resizedBitmap;
	}
}
