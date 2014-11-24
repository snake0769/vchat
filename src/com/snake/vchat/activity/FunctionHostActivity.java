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
	
private ViewPager mVP_Root;
private RadioGroup mRG_Fuction;
private RadioButton mRB_Conversation;
private RadioButton mRB_Contacts;

	@Override
	protected void onCreate(Bundle arg0) {
		super.onCreate(arg0);
		setContentView(R.layout.activity_functionhost);
		
		findViews();
		init();
	}
	
	private void findViews(){
		mVP_Root = (ViewPager) findViewById(R.id.vp_root);
		mRG_Fuction = (RadioGroup) findViewById(R.id.rg_function);
		mRB_Conversation = (RadioButton) findViewById(R.id.rb_conversation);
		mRB_Contacts = (RadioButton) findViewById(R.id.rb_contacts);
	}
	
	private void init(){
		mRG_Fuction.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			
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
