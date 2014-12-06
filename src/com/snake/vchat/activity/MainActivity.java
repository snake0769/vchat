package com.snake.vchat.activity;


import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentTransaction;

import com.snake.vchat.R;
import com.snake.vchat.fragment.LoginFragment;
import com.snake.vchat.manager.UserInfoManager;
import com.snake.vchat.pojo.LoginAO;
import com.snake.vchat.task.LoginTask;
import com.snake.vchat.task.MultiThreadingAsyncTask;

public class MainActivity extends FragmentActivity {
	public static final String TAG = MainActivity.class.getSimpleName();
	
	public static final int MSG_LAUCH = 0x01;
	public final int LAUCH_DELAY = 3 * 1000;

	private Handler mHandler = new Handler(){

		@Override
		public void handleMessage(Message msg) {
			super.handleMessage(msg);
			switch (msg.what) {
			case MSG_LAUCH:
				if(UserInfoManager.getInstance().isLogin()){
					LoginAO loginAO = UserInfoManager.getInstance().getUserInformation();
					LoginTask loginTask = new LoginTask(loginAO, MainActivity.this, true);
					loginTask.executeOnExecutor(MultiThreadingAsyncTask.THREAD_POOL_EXECUTOR);
					//startActivity(new Intent(MainActivity.this, FunctionHostActivity.class));
				}else{
					FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
					LoginFragment loginFragment = new LoginFragment();
					transaction.add(R.id.layout_root, loginFragment, LoginFragment.TAG);
					transaction.show(loginFragment);
					transaction.commitAllowingStateLoss();
				}
				
				break;

			}
		}

	};


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		Message msg = mHandler.obtainMessage(MSG_LAUCH);
		mHandler.sendMessageDelayed(msg, LAUCH_DELAY);
	}


	@Override
	protected void onDestroy() {
		mHandler.removeMessages(MSG_LAUCH);
		super.onDestroy();
	}



}
