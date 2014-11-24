package com.snake.vchat.fragment;

import android.app.Fragment;
import android.view.View;

public class BaseFragment extends Fragment{
	public  final String TAG = getClass().getName();
	protected View globalView;
	
	
	protected View findViewById(int id){
		return globalView.findViewById(id);
	}
	
	
	protected void findViews(){
		
	}
	
	
	protected void init(){
		
	}
}
