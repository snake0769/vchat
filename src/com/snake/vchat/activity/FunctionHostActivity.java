package com.snake.vchat.activity;


import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.ViewPager;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;

import com.snake.vchat.R;

public class FunctionHostActivity extends FragmentActivity{
public static final String TAG = "FunctionHostActivity";
	
private ViewPager mRoot;
private RadioGroup mFuction;
private RadioButton mConversation;
private RadioButton mContacts;

	@Override
	protected void onCreate(Bundle arg0) {
		super.onCreate(arg0);
		setContentView(R.layout.activity_functionhost);
		
		findViews();
		init();
	}
	
	
	private void findViews(){
		mRoot = (ViewPager) findViewById(R.id.vp_root);
		mFuction = (RadioGroup) findViewById(R.id.rg_function);
		mConversation = (RadioButton) findViewById(R.id.rb_conversation);
		mContacts = (RadioButton) findViewById(R.id.rb_contacts);
	}
	
	
	private void init(){
		mFuction.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			
			@Override
			public void onCheckedChanged(RadioGroup group, int checkedId) {
				switch(checkedId){
				case R.id.rb_contacts:
					break;
				case R.id.rb_conversation:
					break;
				}
			}
		});
	}

}
