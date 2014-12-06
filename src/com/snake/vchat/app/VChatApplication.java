package com.snake.vchat.app;

import org.jivesoftware.smack.SmackAndroid;

import com.snake.vchat.manager.ContactsManager;
import com.snake.vchat.manager.UserInfoManager;
import com.snake.vchat.manager.XmppConnectionManager;

import comsnake.vchat.throwable.CrashHandler;

import android.app.Application;

public class VChatApplication extends Application{

	private static VChatApplication mInstance;

	@Override
	public void onCreate() {
		super.onCreate();
		// 处理全局不可捕捉异常
		CrashHandler crashHandler = CrashHandler.getInstance();
		crashHandler.init(getApplicationContext());
		//aSmack 初始化
		SmackAndroid.init(this);
		XmppConnectionManager.getInstance().init();
		UserInfoManager.getInstance().init(this);
		ContactsManager.getInstance().init(this);
	}


}
