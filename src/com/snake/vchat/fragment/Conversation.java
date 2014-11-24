package com.snake.vchat.fragment;

import java.io.ByteArrayInputStream;
import java.util.ArrayList;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.gt.cl.http.CLConnectionException;
import com.gt.cl.http.CLInvalidNetworkException;
import com.snake.vchat.R;
import com.snake.vchat.manager.ContactsManager;
import com.snake.vchat.manager.ContactsManager.Contact;
import com.snake.vchat.util.MultiThreadingAsyncTask;

public class Conversation extends BaseFragment{
	private ListView mConversation;
	private ArrayList<Contact> conversationList = new ArrayList<Contact>();
	private ArrayList<Bitmap> avatarList = new ArrayList<Bitmap>();
	
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);
		globalView = inflater.inflate(R.layout.fragment_conversation, null);
		findViews();
		init();
		return globalView;
	}

	
	@Override
	protected void findViews() {
		mConversation = (ListView) findViewById(R.id.lv_conversation);
		mConversation.setAdapter(conversationAdapter);
	}

	
	@Override
	protected void init() {
		new MultiThreadingAsyncTask<Void, Void, Void>(getActivity()) {

			@Override
			protected Void doInBackground(Void params)
					throws CLInvalidNetworkException, CLConnectionException {
				conversationList = ContactsManager.getInstance().getPhoneContacts();
				return null;
			}

			@Override
			protected void doOnSuccess(Void result) {
				conversationAdapter.notifyDataSetChanged();
			}
		}.executeOnExecutor(MultiThreadingAsyncTask.THREAD_POOL_EXECUTOR);
	}
	
	
	private BaseAdapter conversationAdapter  = new BaseAdapter() {
		
		class ViewHolder{
			public ImageView avatar;
			public TextView name;
			public TextView lastRecord;
		}
		
		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			ViewHolder viewholder = new ViewHolder();
			if(convertView == null){
				convertView = LayoutInflater.from(getActivity()).inflate(R.layout.item_conversation, null);
				viewholder.avatar = (ImageView) convertView.findViewById(R.id.iv_avatar);
				viewholder.name = (TextView) convertView.findViewById(R.id.tv_name);
				viewholder.lastRecord = (TextView) convertView.findViewById(R.id.tv_lastRecord);
				convertView.setTag(viewholder);
			}else{
				viewholder = (ViewHolder) convertView.getTag();
			}
			
			//显示头像
			ByteArrayInputStream is = new ByteArrayInputStream(conversationList.get(position).photo_data);
			Bitmap bmp = BitmapFactory.decodeStream(is);
			avatarList.add(bmp);
			viewholder.avatar.setImageBitmap(bmp);
			
			//显示名字
			viewholder.name.setText(conversationList.get(position).name);
			
			/*//显示最后记录
			viewholder.lastRecord.setText(conversationList.get(position).name);*/
			
			return convertView;
		}
		
		@Override
		public long getItemId(int position) {
			return 0;
		}
		
		@Override
		public Object getItem(int position) {
			return null;
		}
		
		@Override
		public int getCount() {
			return conversationList.size();
		}
	};
}
