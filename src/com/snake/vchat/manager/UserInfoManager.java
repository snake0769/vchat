package com.snake.vchat.manager;

import android.content.Context;
import android.content.SharedPreferences;

public class UserInfoManager extends BaseManager{
	public static final String TAG = "UserInfoManager";
	
	private final String SP_USER_INFORMATION = "userinformation";
	private final String SP_USER_INFORMATION_LOGIN = "isLogin";
	
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
	
	
}
