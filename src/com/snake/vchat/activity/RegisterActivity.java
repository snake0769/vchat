package com.snake.vchat.activity;

import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;

import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;

import com.snake.vchat.R;
import com.snake.vchat.manager.XmppConnectionManager;
import com.snake.vchat.task.RegisterTask;

public class RegisterActivity extends BaseActivity{
	public static final String TAG = RegisterActivity.class.getSimpleName();

	private EditText mUsername;
	private EditText mPassword;
	private EditText mConfirmPassword;
	private Button mSubmit;
	private XMPPConnection mConnection;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.activity_register);
		getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE,R.layout.title);
		findViews();
		init();
	}


	@Override
	protected void findViews() {
		mUsername = (EditText) findViewById(R.id.et_username);
		mPassword = (EditText) findViewById(R.id.et_password);
		mConfirmPassword = (EditText) findViewById(R.id.et_confirmPassword);
		mSubmit = (Button) findViewById(R.id.bt_submit);
	}


	@Override
	protected void init() {
		mSubmit.setOnClickListener(onClickListener);
		mConnection = XmppConnectionManager.getInstance().getConnection();
	}


	private OnClickListener onClickListener = new OnClickListener(){

		@Override
		public void onClick(View v) {
			switch (v.getId()) {
			case R.id.bt_submit:
					RegisterTask registerTask  = new Register();

				break;
			}
		}

	};

	
	/**
	 * 注册
	 */
	private void register(){
		
	}
}
