package com.snake.vchat.activity;

import java.util.ArrayList;
import java.util.LinkedList;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.gt.cl.http.CLConnectionException;
import com.gt.cl.http.CLInvalidNetworkException;
import com.snake.vchat.R;
import com.snake.vchat.app.Constants;
import com.snake.vchat.component.HorizontalListView;
import com.snake.vchat.component.TextViewVertical;
import com.snake.vchat.manager.MessageManager;
import com.snake.vchat.pojo.MessageAO;
import com.snake.vchat.pojo.UserAO;
import com.snake.vchat.task.MultiThreadingAsyncTask;

public class ChatActivity extends BaseActivity{
	public static final String TAG = ChatActivity.class.getSimpleName();
	
	public static final String USER = "user";

	private UserAO mUser;
	private HorizontalListView mChat;
	private LinkedList<MessageAO> messageList = new LinkedList<MessageAO>();
	private ArrayList<Bitmap> avatarList = new ArrayList<Bitmap>();
	private EditText mInputBox;
	private TextView mOperation;
	private MessageManager messageManager;
	private MyReceiver mRecevier;
	private IntentFilter intentFilter;
	
/*	private Handler mHandler = new Handler(){

		@Override
		public void handleMessage(Message msg) {
			switch(msg.what){
			case Constants.MSG_NEWMESSAGE:
				messageList.addAll(messageManager.loadMessage(mUser.jid));
				break;
			}
			super.handleMessage(msg);
		}
		
	};*/
	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.activity_chat);
		getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE,R.layout.title);
		findViews();
		init();
	}
	
	
	@Override
	protected void onResume() {
		super.onResume();
		getRecentMessage();
		registerReceiver(mRecevier, intentFilter);
	}


	@Override
	protected void onPause() {
		super.onPause();
		unregisterReceiver(mRecevier);
	}


	@Override
	protected void findViews() {
		mChat = (HorizontalListView) findViewById(R.id.lv_chat);
		mInputBox = (EditText) findViewById(R.id.et_message);
		mOperation = (TextView) findViewById(R.id.tv_operation);
	}


	@Override
	protected void init() {
		mUser = getIntent().getParcelableExtra(USER);
		messageManager = MessageManager.getInstance();
		mOperation.setOnClickListener(onClickListener);
		mChat.setAdapter(messageAdapter);
		
		mRecevier = new MyReceiver();
		intentFilter = new IntentFilter();
		intentFilter.addAction(Constants.ACTION_NEWMESSAGE);
	}


	private OnClickListener onClickListener = new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			switch(v.getId()){
			case R.id.tv_operation:
				break;
			}
		}
	};
	
	
	/**
	 * 获取最近的聊天记录
	 */
	private void getRecentMessage(){
		new MultiThreadingAsyncTask<Void, Void, Void>(this) {

			@Override
			protected Void doInBackground(Void params)
					throws CLInvalidNetworkException, CLConnectionException {
				messageList = (LinkedList<MessageAO>) MessageManager.getInstance().loadMessage(mUser.jid);
				return null;
			}

			@Override
			protected void doOnSuccess(Void result) {
			}
		}.executeOnExecutor(MultiThreadingAsyncTask.THREAD_POOL_EXECUTOR);
	}
	
	
	private BaseAdapter messageAdapter  = new BaseAdapter() {

		class ViewHolder{
			public ImageView avatar;
			public TextViewVertical content;
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			ViewHolder viewholder = new ViewHolder();
			if(convertView == null){
				convertView = LayoutInflater.from(ChatActivity.this).inflate(R.layout.item_chat_other, null);
				//viewholder.avatar = (ImageView) convertView.findViewById(R.id.iv_avatar);
				viewholder.content = (TextViewVertical) convertView.findViewById(R.id.tv_content);
				convertView.setTag(viewholder);
			}else{
				viewholder = (ViewHolder) convertView.getTag();
			}

			viewholder.content.setText(messageList.get(position).content);

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
			return messageList.size();
		}
	};


	/**
	 * 专门接收新消息的广播receiver
	 * @author Administrator
	 */
	public class MyReceiver extends BroadcastReceiver{

		@Override
		public void onReceive(Context context, Intent intent) {
			//取出最新收到的聊天消息
			String user = intent.getStringExtra(USER);
			messageList.add(messageManager.getNewMessage(user));
			messageAdapter.notifyDataSetChanged();
		}
		
	}

}
