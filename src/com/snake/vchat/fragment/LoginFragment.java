package com.snake.vchat.fragment;

import android.os.Bundle;
import android.os.Looper;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.snake.vchat.R;
import com.snake.vchat.pojo.LoginAO;
import com.snake.vchat.task.LoginTask;
import com.snake.vchat.task.MultiThreadingAsyncTask;


public class LoginFragment extends BaseFragment{
	public static final String TAG = LoginFragment.class.getSimpleName();
	
	private static final String ERR_NOCONTENT = "用户名或密码不能为空";
	
	private EditText mUsername;
	private EditText mPassword;
	private Button mLogin;
	private LoginAO mLoginAO = new LoginAO();
	
	
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		globalView = inflater.inflate(R.layout.fragment_login, null);

		findViews();
		init();

		return globalView;
	}


	protected void findViews() {
		mUsername = (EditText) findViewById(R.id.et_username);
		mPassword = (EditText) findViewById(R.id.et_password);
		mLogin = (Button) findViewById(R.id.bt_login);
	}


	protected void init() {
		mLogin.setOnClickListener(onClickListener);
	}


	private OnClickListener onClickListener = new OnClickListener() {

		@Override
		public void onClick(View v) {
			switch(v.getId()){
			case R.id.bt_login:
				mLoginAO.username = mUsername.getText().toString().trim();
				mLoginAO.password = mPassword.getText().toString().trim();
				if(confirm()){
					LoginTask loginTask = new LoginTask(mLoginAO, getActivity(), true);
					loginTask.executeOnExecutor(MultiThreadingAsyncTask.THREAD_POOL_EXECUTOR);
				}
				break;
			}

		}
	};


	/**验证输入的用户名或密码
	 * @return true验证成功，false验证失败
	 */
	private boolean confirm(){
		if(mLoginAO.username.length()>0 && mLoginAO.password.length()>0)
			return true;
		else{
			Looper.prepare();
			Toast.makeText(getActivity(), ERR_NOCONTENT, Toast.LENGTH_SHORT).show();
			Looper.loop();
			return false;
		}

	}


	@Override
	public void onDestroyView() {
		super.onDestroyView();
	}



}
