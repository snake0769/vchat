package com.snake.vchat.app;

import com.snake.vchat.manager.ContactsManager;
import com.snake.vchat.manager.UserInfoManager;

import android.app.Application;

public class VChatApplication extends Application{

	@Override
	public void onCreate() {
		super.onCreate();
		UserInfoManager.getInstance().init(this);
		ContactsManager.getInstance().init(this);
	}
	
}
