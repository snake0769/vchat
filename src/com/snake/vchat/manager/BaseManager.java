package com.snake.vchat.manager;

import android.content.Context;

abstract public class BaseManager {
	
	public  final String TAG = getClass().getName();
	
	protected Context mContext;
	
	public void init(Context context){
		mContext = context;
	}
	
}
