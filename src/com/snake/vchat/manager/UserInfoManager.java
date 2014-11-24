package com.snake.vchat.manager;

import android.content.Context;
import android.content.SharedPreferences;

public class UserInfoManager {
	public static final String TAG = "UserInfoManager";
	
	private final String SP_USER_INFORMATION = "userinformation";
	private final String SP_USER_INFORMATION_LOGIN = "isLogin";
	
	private static UserInfoManager mInstance;
	private Context mContext;
	
	private UserInfoManager(){
	}
	
	public static UserInfoManager getInstance(){
		if(mInstance == null)
			mInstance = new UserInfoManager();
		return mInstance;
	}
	
	public void init(Context context){
		mContext = context;
	}
	
	public boolean isLogin(){
		SharedPreferences sp = mContext.getSharedPreferences(SP_USER_INFORMATION,Context.MODE_PRIVATE );
		return sp.getBoolean(SP_USER_INFORMATION_LOGIN, false);
	}
	
	
}
