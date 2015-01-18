package com.snake.vchat.fragment;

import java.io.ByteArrayInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smackx.packet.VCard;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.gt.cl.http.CLConnectionException;
import com.gt.cl.http.CLInvalidNetworkException;
import com.snake.vchat.R;
import com.snake.vchat.activity.ChatActivity;
import com.snake.vchat.manager.ContactsManager;
import com.snake.vchat.manager.XmppConnectionManager;
import com.snake.vchat.pojo.PhoneContactAO;
import com.snake.vchat.pojo.UserAO;
import com.snake.vchat.task.MultiThreadingAsyncTask;
import com.snake.vchat.util.Util;

public class ContactsFragment extends BaseFragment{
	public static final String TAG = ContactsFragment.class.getSimpleName();
	
	private ListView mContacts;
	private List<UserAO> mUsers = new ArrayList<UserAO>();
	private ArrayList<Bitmap> avatarList = new ArrayList<Bitmap>();
	private XMPPConnection mConnection;
	
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);
		globalView = inflater.inflate(R.layout.fragment_contacts, null);
		findViews();
		init();
		return globalView;
	}

	
	@Override
	protected void findViews() {
		mContacts = (ListView) findViewById(R.id.lv_contacts);
		mContacts.setAdapter(contactsAdapter);
		mContacts.setOnItemClickListener(onItemClickListener);
	}

	
	@Override
	protected void init() {
		mConnection = XmppConnectionManager.getInstance().getConnection();
		
		new MultiThreadingAsyncTask<Void, Void, Void>(getActivity()) {

			@Override
			protected Void doInBackground(Void params)
					throws CLInvalidNetworkException, CLConnectionException {
				mUsers = ContactsManager.getInstance().getUsers();
				return null;
			}

			@Override
			protected void doOnSuccess(Void result) {
				contactsAdapter.notifyDataSetChanged();
			}
		}.executeOnExecutor(MultiThreadingAsyncTask.THREAD_POOL_EXECUTOR);
	}
	
	
	private OnItemClickListener onItemClickListener = new OnItemClickListener() {

		@Override
		public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
				long arg3) {
			Intent intent = new Intent(getActivity(), ChatActivity.class);
			intent.putExtra(ChatActivity.USER, mUsers.get(arg2));
			startActivity(intent);
		}
	};
	
	
	private BaseAdapter contactsAdapter  = new BaseAdapter() {
		
		class ViewHolder{
			public ImageView avatar;
			public TextView name;
		}
		
		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			ViewHolder viewholder = new ViewHolder();
			if(convertView == null){
				convertView = LayoutInflater.from(getActivity()).inflate(R.layout.item_contacts, null);
				viewholder.avatar = (ImageView) convertView.findViewById(R.id.iv_avatar);
				viewholder.name = (TextView) convertView.findViewById(R.id.tv_name);
				convertView.setTag(viewholder);
			}else{
				viewholder = (ViewHolder) convertView.getTag();
			}
			
			//显示头像
			VCard vcard = new VCard();
			try {
				vcard.load(mConnection, mUsers.get(position).jid);
			} catch (XMPPException e) {
				e.printStackTrace();
			}
			byte[] photo_data = vcard.getAvatar();
			if(photo_data !=null){
				Bitmap bmp = BitmapFactory.decodeStream(new ByteArrayInputStream(photo_data));
				avatarList.add(bmp);
				viewholder.avatar.setImageBitmap(bmp);
			}
			
			//显示名字
			viewholder.name.setText(mUsers.get(position).name);
			
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
			return mUsers.size();
		}
	};

	@Override
	public void onDestroyView() {
		super.onDestroyView();
		Util.recycleBitmaps(avatarList);
	}

	
	
}
