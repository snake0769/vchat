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
import com.snake.vchat.app.Constants;
import com.snake.vchat.manager.XmppConnectionManager;
import com.snake.vchat.pojo.LoginAO;
import com.snake.vchat.task.MultiThreadingAsyncTask;
import com.snake.vchat.task.RegisterTask;

public class RegisterActivity extends BaseActivity{
	public static final String TAG = RegisterActivity.class.getSimpleName();

	private EditText mUsername;
	private EditText mPassword;
	private EditText mConfirmPassword;
	private EditText mNickname;
	private Button mSubmit;


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
		mNickname = (EditText) findViewById(R.id.et_nickname);
		mSubmit = (Button) findViewById(R.id.bt_submit);
	}


	@Override
	protected void init() {
		mSubmit.setOnClickListener(onClickListener);
	}


	private OnClickListener onClickListener = new OnClickListener(){
		@Override
		public void onClick(View v) {
			switch (v.getId()) {
			case R.id.bt_submit:
				if(confirm()){
					LoginAO loginAO = new LoginAO();
					loginAO.username = mUsername.getText().toString().trim();
					loginAO.password = mPassword.getText().toString().trim();
					loginAO.nickname = mNickname.getText().toString().trim();
					loginAO.jid = loginAO.username + "@" +Constants.XMPP_SERVER_NAME;
					RegisterTask registerTask  = new RegisterTask(loginAO, RegisterActivity.this, true);
					registerTask.executeOnExecutor(MultiThreadingAsyncTask.THREAD_POOL_EXECUTOR);
				}
				break;
			}
		}

	};


	/**
	 * 验证注册信息
	 */
	private boolean confirm(){
		if(mPassword.getText().toString().trim().equals(
				mConfirmPassword.getText().toString().trim()))
			return true;
		else
			return false;
	}
}
