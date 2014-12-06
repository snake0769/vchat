package com.snake.vchat.activity;


import java.util.ArrayList;
import java.util.List;

import android.content.DialogInterface.OnClickListener;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.View;
import android.view.Window;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;

import com.snake.vchat.R;
import com.snake.vchat.fragment.ContactsFragment;
import com.snake.vchat.fragment.ConversationFragment;

public class FunctionHostActivity extends FragmentActivity{
public static final String TAG = FunctionHostActivity.class.getSimpleName();

private final int PAGE_CONVERSATION = 0;
private final int PAGE_CONTACTS = 1;
	
private ViewPager mRoot;
private RadioGroup mFuction;
private RadioButton mConversationBtn;
private RadioButton mContactsBtn;
private List<Fragment> mPageList = new ArrayList<Fragment>();
private ConversationFragment mConversation;
private ContactsFragment mContacts;

	@Override
	protected void onCreate(Bundle arg0) {
		super.onCreate(arg0);
		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.activity_functionhost);
		getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE,R.layout.title);
		
		findViews();
		init();
	}
	
	
	private void findViews(){
		mRoot = (ViewPager) findViewById(R.id.vp_root);
		mFuction = (RadioGroup) findViewById(R.id.rg_function);
		mConversationBtn = (RadioButton) findViewById(R.id.rb_conversation);
		mContactsBtn = (RadioButton) findViewById(R.id.rb_contacts);
	}
	
	
	private void init(){
		//初始化页面
		mConversation = new ConversationFragment();
		mContacts = new ContactsFragment();
		mPageList.add(mConversation);
		mPageList.add(mContacts);
		TopTabPageAdapter topTabPageAdapter = new TopTabPageAdapter(getSupportFragmentManager());
		topTabPageAdapter.setList(mPageList);
		mRoot.setAdapter(topTabPageAdapter);
		mRoot.setOnPageChangeListener(onPageChangeListener);
		/*mConversationBtn.setOnClickListener(onClickListener);
		mContactsBtn.setOnClickListener(onClickListener);*/
		mFuction.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			
			@Override
			public void onCheckedChanged(RadioGroup group, int checkedId) {
				switch(checkedId){
				case R.id.rb_conversation:
					mRoot.setCurrentItem(PAGE_CONVERSATION);
					break;
				case R.id.rb_contacts:
					mRoot.setCurrentItem(PAGE_CONTACTS);
					break;
				}
			}
			
		});
		
	}
	
	
	private View.OnClickListener onClickListener = new View.OnClickListener(){

		@Override
		public void onClick(View v) {
			switch(v.getId()){
			case R.id.rb_contacts:
				mRoot.setCurrentItem(PAGE_CONTACTS);
				break;
			case R.id.rb_conversation:
				mRoot.setCurrentItem(PAGE_CONVERSATION);
				break;
			}
			
		}
		
	};
	
	
	private OnPageChangeListener onPageChangeListener = new OnPageChangeListener() {
		
		@Override
		public void onPageSelected(int arg0) {
			switch (arg0) {
			case 0:
				mConversationBtn.setChecked(true);
				break;
			case 1:
				mContactsBtn.setChecked(true);
				break;
			}
		}
		
		@Override
		public void onPageScrolled(int arg0, float arg1, int arg2) {
		}
		
		@Override
		public void onPageScrollStateChanged(int arg0) {
		}
	};
	
	
	private class TopTabPageAdapter extends FragmentStatePagerAdapter{

		private List<Fragment> mFragmentList = new ArrayList<Fragment>(); 
		public TopTabPageAdapter(FragmentManager fm) {
			super(fm);
		}

		public void setList(List<Fragment> pageList){
			this.mFragmentList = pageList;
		}

		@Override
		public Fragment getItem(int arg0) {
			return mFragmentList.get(arg0);
		}

		@Override
		public int getCount() {
			return mFragmentList.size();
		}

		@Override
		public int getItemPosition(Object object) {
			return POSITION_NONE;
		}
	}

}
