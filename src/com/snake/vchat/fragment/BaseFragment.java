package com.snake.vchat.fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

abstract public class BaseFragment extends Fragment{
	
	protected View globalView;
	
	
	@Override
	public View onCreateView(LayoutInflater inflater,
			ViewGroup container, Bundle savedInstanceState) {
		return super.onCreateView(inflater, container, savedInstanceState);
		
	}


	protected View findViewById(int id){
		return globalView.findViewById(id);
	}
	
	
	abstract protected void findViews();
	
	abstract protected void init();
}
