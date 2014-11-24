package com.snake.vchat.activity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.FragmentActivity;

import com.snake.vchat.R;

public class MainActivity extends FragmentActivity {
	
	public static final int MSG_LAUCH = 0x01;
	public final int LAUCH_DELAY = 3 * 1000;

	private Handler mHandler = new Handler(){

		@Override
		public void handleMessage(Message msg) {
			super.handleMessage(msg);
			switch (msg.what) {
			case MSG_LAUCH:
				startActivity(new Intent(MainActivity.this, FunctionHostActivity.class));
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
