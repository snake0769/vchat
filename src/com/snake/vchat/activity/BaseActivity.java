package com.snake.vchat.activity;

import android.app.Activity;
import android.os.Bundle;

abstract public class BaseActivity extends Activity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
	}

	abstract protected void findViews();
	
	abstract protected void init();
	
}
