package com.snake.vchat.fragment;



import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;

import com.snake.vchat.R;
import com.snake.vchat.activity.FunctionHostActivity;


public class LoginFragment extends BaseFragment{

	private EditText mPhone;
	private EditText mPassword;
	private Button mLogin;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		globalView = inflater.inflate(R.layout.fragment_login, null);

		findViews();
		init();

		return globalView;
	}


	protected void findViews() {
		mPhone = (EditText) findViewById(R.id.et_phone);
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
				login();
				break;
			}

		}
	};
	
	
	private void login(){
		if(confirm())
			startActivity(new Intent(getActivity(), FunctionHostActivity.class));
	};

	
	private boolean confirm(){
		if(mPhone.getText().toString().trim().length()>0 && mPassword.getText().toString().trim().length()>0)
			return true;
		else
			return false;

	}

	
	@Override
	public void onDestroyView() {
		super.onDestroyView();
	}



}
