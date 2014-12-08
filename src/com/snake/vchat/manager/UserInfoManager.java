package com.snake.vchat.manager;


import com.snake.vchat.pojo.LoginAO;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

public class UserInfoManager extends BaseManager{
	public static final String TAG = UserInfoManager.class.getSimpleName();
	
	private final String SP_USER_INFORMATION = "userinformation";
	private final String SP_USER_INFORMATION_LOGIN = "user.isLogin";
	private final String SP_USER_INFORMATION_USERNAME = "user.username";
	private final String SP_USER_INFORMATION_PASSWORD = "user.password";
	private final String SP_USER_INFORMATION_NICKNAME = "user.nickname";
	private final String SP_USER_INFORMATION_EMAIL = "user.email";
	private final String SP_USER_INFORMATION_REMARK = "user.remark";
	private final String SP_USER_INFORMATION_AVATARURL = "user.avatarUrl";
	
	private static UserInfoManager mInstance;
	
	private UserInfoManager(){
	}
	
	public static UserInfoManager getInstance(){
		if(mInstance == null)
			mInstance = new UserInfoManager();
		return mInstance;
	}
	
	
	
	public boolean isLogin(){
		SharedPreferences sp = mContext.getSharedPreferences(SP_USER_INFORMATION,Context.MODE_PRIVATE );
		return sp.getBoolean(SP_USER_INFORMATION_LOGIN, false);
	}
	
	
	public void updateUserInformation(LoginAO ao) {
		SharedPreferences sp = mContext.getSharedPreferences(SP_USER_INFORMATION,Context.MODE_PRIVATE);
		Editor editor = sp.edit();
		editor.putString(SP_USER_INFORMATION_USERNAME, ao.username);
		editor.putString(SP_USER_INFORMATION_PASSWORD, ao.password);
		editor.putString(SP_USER_INFORMATION_NICKNAME, ao.name);
		editor.putString(SP_USER_INFORMATION_EMAIL, ao.email);
		editor.putString(SP_USER_INFORMATION_REMARK, ao.remark);
		editor.putString(SP_USER_INFORMATION_AVATARURL, ao.avatarUrl);
		editor.putBoolean(SP_USER_INFORMATION_LOGIN, true);
		editor.commit();
	}
	
	
	public LoginAO getUserInformation() {
		SharedPreferences sp = mContext.getSharedPreferences(SP_USER_INFORMATION,Context.MODE_PRIVATE);
		LoginAO ao = new LoginAO();
		ao.username = sp.getString(SP_USER_INFORMATION_USERNAME, "");
		ao.password = sp.getString(SP_USER_INFORMATION_PASSWORD, "");
		ao.name = sp.getString(SP_USER_INFORMATION_NICKNAME, "");
		ao.email = sp.getString(SP_USER_INFORMATION_EMAIL, "");
		ao.remark = sp.getString(SP_USER_INFORMATION_REMARK, "");
		ao.avatarUrl = sp.getString(SP_USER_INFORMATION_AVATARURL, "");
		return ao;
	}
	
}
