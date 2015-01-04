package com.snake.vchat.app;

import org.jivesoftware.smack.SmackAndroid;

import android.app.Application;

import com.snake.vchat.manager.ContactsManager;
import com.snake.vchat.manager.UserInfoManager;
import com.snake.vchat.manager.XmppConnectionManager;
import comsnake.vchat.throwable.CrashHandler;

public class VChatApplication extends Application{

	private static VChatApplication mInstance;

	public static VChatApplication getInstance(){
		return mInstance;
	}
	
	@Override
	public void onCreate() {
		super.onCreate();
		// 处理全局不可捕捉异常
		CrashHandler crashHandler = CrashHandler.getInstance();
		crashHandler.init(getApplicationContext());
		// 初始化VChatApplication实例
		initInstance();
		//aSmack 初始化
		SmackAndroid.init(this);
		XmppConnectionManager.getInstance().init();
		UserInfoManager.getInstance().init(this);
		ContactsManager.getInstance().init(this);
	}

	
	public void initInstance() {
		if (mInstance == null) {
			mInstance = this;
		}
	}

}
