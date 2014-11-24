package com.snake.vchat.util;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Executor;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

import android.app.Activity;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.DialogInterface.OnKeyListener;
import android.os.AsyncTask;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Window;
import android.widget.Toast;

import com.gt.cl.http.CLConnectionException;
import com.gt.cl.http.CLInvalidNetworkException;
import com.snake.vchat.R;

public abstract class MultiThreadingAsyncTask<Params, Progress, Result> extends
AsyncTask<Params, Progress, Object> {

	private static final String TAG = "MultiThreadingAsyncTask";
	public static final int ASYNCTASK_ERROR = -1;
	public static final int ASYNCTASK_SUCCESS = 1;
	/** 任务重试上限 */
	private static final int RETRY_MAX = 5;
	private static final int RETRY_DELAY = 3*1000;

	private Params p;
	private boolean isShowLoading = true;
	private boolean canCloseLoading = true;
	private Activity context;
	private Dialog progressDialog;

	protected String errorMsg = "后台操作失败";

	private static final int CORE_POOL_SIZE = 5;
	private static final int MAXIMUM_POOL_SIZE = 128;
	private static final int KEEP_ALIVE = 1;

	private static final ThreadFactory sThreadFactory = new ThreadFactory() {
		private final AtomicInteger mCount = new AtomicInteger(1);

		public Thread newThread(Runnable r) {
			return new Thread(r, "AsyncTask #" + mCount.getAndIncrement());
		}
	};

	private static final BlockingQueue<Runnable> sPoolWorkQueue =
			new LinkedBlockingQueue<Runnable>(10);

	/**
	 * An {@link Executor} that can be used to execute tasks in parallel.
	 */
	public static final Executor THREAD_POOL_EXECUTOR
	= new ThreadPoolExecutor(CORE_POOL_SIZE, MAXIMUM_POOL_SIZE, KEEP_ALIVE,
			TimeUnit.SECONDS, sPoolWorkQueue, sThreadFactory);



	public String getErrorMsg() {
		return errorMsg;
	}

	protected void setErrorMsg(){
	}

	public MultiThreadingAsyncTask(Activity context) {
		this(context, false);
	}

	public MultiThreadingAsyncTask(Activity context, boolean isShowLoading) {
		this.context = (Activity) TMTPUtil.getMainContext(context);
		this.isShowLoading = isShowLoading;
	}

	public MultiThreadingAsyncTask(Activity context, boolean isShowLoading,
			boolean canClosLoading) {
		this.context = (Activity) TMTPUtil.getMainContext(context);
		this.isShowLoading = isShowLoading;
		this.canCloseLoading = canClosLoading;
	}

	@Override
	protected void onCancelled() {
		if (isShowLoading && !canCloseLoading) {
			closeLoading();
		}
		super.onCancelled();
	}

	protected Activity getContext() {
		return context;
	}

	@Override
	protected void onPreExecute() {
		super.onPreExecute();
		if (isShowLoading) {
			this.showLoading(canCloseLoading);
		}
	}

	@Override
	protected Object doInBackground(Params... params) {
		Object obj = null;
		p = null;
		if (params != null && params.length > 0) {
			p = params[0];
		}
		//网络任务失败后，重试直到上限
		for(int i=0; i<RETRY_MAX; i++){
			try{
				obj = this.doInBackground(p);
				break;
			}catch(Exception e){
				try {
					if(i < RETRY_MAX -1 
							&& (e instanceof CLConnectionException || e instanceof CLInvalidNetworkException)){
						Log.e(TAG, "Network task failed: " + (i+1) + ", retry task after" + RETRY_DELAY /1000 + "s");
						Thread.sleep(RETRY_DELAY);
						continue;
					}else{
						obj = e;
						break;
					}
				} catch (InterruptedException e1) {
					e1.printStackTrace();
				}
			}
		}
		return obj;
	}

	protected boolean handleException(Exception ex) {
		return true;
	}

	@Override
	protected void onPostExecute(Object result) {
		Log.i(TAG, "result  >>>>   " + result);
		try {
			super.onPostExecute(result);
			if (result != null) {
				if (result instanceof CLInvalidNetworkException) {
					boolean isHandled = this
							.handleException((CLInvalidNetworkException) result);
					if (isHandled) {
						// this.showAlert("网络连接失败");
						/*Toast.makeText(getContext(), getErrorMsg(),
								Toast.LENGTH_LONG).show();*/
					}
					Log.e(TAG, "", (Exception) result);
				} else if (result instanceof CLConnectionException) {
					CLConnectionException connectionException = (CLConnectionException) result;
					boolean isHandled = this
							.handleException(connectionException);
					if (isHandled) {
						/*Toast.makeText(getContext(), getErrorMsg(),
								Toast.LENGTH_LONG).show();*/
					}
					Log.e(TAG, "", (Exception) result);
				} else if (result instanceof Exception) {
					boolean isHandled = this
							.handleException((Exception) result);
					if (!isHandled) {
						Toast.makeText(getContext(),
								((Exception) result).getMessage(),
								Toast.LENGTH_LONG).show();
						// this.showAlert(((Exception) result).getMessage());
					}
					Log.e(TAG, "", (Exception) result);
				} else {
					onFinishHandle();
					doOnSuccess((Result) result);
				}
			} else {
				onFinishHandle();
				doOnSuccess((Result) result);
			}
		} catch (Exception e) {
			Log.e(TAG, "", e);
		} finally {
			if (progressDialog != null) {
				progressDialog.cancel();
			}
		}

	}

	abstract protected Result doInBackground(Params params)
			throws CLInvalidNetworkException, CLConnectionException;

	abstract protected void doOnSuccess(Result result);

	protected void doOnResponseOKButton(String status) {
	}

	private void showLoading(boolean canCloseDialog) {
		if (progressDialog == null) {
			progressDialog = new Dialog(context);
			// progressDialog.setTitle(R.string.app_name);
			// progressDialog.setMessage("加载中");
			progressDialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
			progressDialog.setContentView(R.layout.view_progressdialog);
			progressDialog.getWindow().setBackgroundDrawableResource(
					R.color.transparent);
			// progressDialog.getWindow().setFlags(
			// WindowManager.LayoutParams.FLAG_FULLSCREEN,
			// WindowManager.LayoutParams.FLAG_FULLSCREEN);
			// progressDialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
			progressDialog.setCanceledOnTouchOutside(false);
			progressDialog.setCanceledOnTouchOutside(false);
			if (!canCloseDialog) {
				progressDialog.setOnKeyListener(new OnKeyListener() {
					@Override
					public boolean onKey(DialogInterface dialog, int keyCode,
							KeyEvent event) {
						if (keyCode == KeyEvent.KEYCODE_BACK
								&& event.getRepeatCount() == 0) { // 按下的如果是BACK，同时没有重复
							return true;
						}
						return false;

					}
				});
			}

		}

		progressDialog.show();
	}

	private void closeLoading() {

		if (progressDialog != null) {
			try {
				progressDialog.hide();
				progressDialog.cancel();
				progressDialog = null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}


	protected void onFinishHandle() {
	}
}
