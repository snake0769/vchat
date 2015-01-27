package com.snake.vchat.activity;

import java.util.ArrayList;
import java.util.LinkedList;

import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.ChatManager;
import org.jivesoftware.smack.ChatManagerListener;
import org.jivesoftware.smack.MessageListener;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.packet.Message;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
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
import com.snake.vchat.manager.XmppConnectionManager;
import com.snake.vchat.pojo.MessageAO;
import com.snake.vchat.pojo.UserAO;
import com.snake.vchat.task.MultiThreadingAsyncTask;

public class ChatActivity extends BaseActivity{
	public static final String TAG = ChatActivity.class.getSimpleName();

	public static final String USER = "user";

	private UserAO mUser;
	private HorizontalListView mChatList;
	private LinkedList<MessageAO> messageList = new LinkedList<MessageAO>();
	private ArrayList<Bitmap> avatarList = new ArrayList<Bitmap>();
	private EditText mInputBox;
	private TextView mOperation;
	private MessageManager messageManager;
	private MyReceiver mRecevier;
	private IntentFilter intentFilter;
	private XMPPConnection mConnection;
	private ChatManager chatManager;
	private Chat mChat;

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
		//getRecentMessage();
		registerReceiver(mRecevier, intentFilter);
	}


	@Override
	protected void onPause() {
		super.onPause();
		unregisterReceiver(mRecevier);
	}


	@Override
	protected void findViews() {
		mChatList = (HorizontalListView) findViewById(R.id.lv_chat);
		mInputBox = (EditText) findViewById(R.id.et_message);
		mOperation = (TextView) findViewById(R.id.tv_operation);
	}


	@Override
	protected void init() {
		mUser = getIntent().getParcelableExtra(USER);
		messageManager = MessageManager.getInstance();
		mOperation.setOnClickListener(onClickListener);
		mInputBox.addTextChangedListener(inputWatcher);
		mChatList.setAdapter(messageAdapter);

		mRecevier = new MyReceiver();
		intentFilter = new IntentFilter();
		intentFilter.addAction(Constants.ACTION_NEWMESSAGE);

		//添加聊天监听
		mConnection = XmppConnectionManager.getInstance().getConnection();
		chatManager = mConnection.getChatManager();
		mChat = chatManager.createChat(mUser.jid, messageListener);
	}


	private OnClickListener onClickListener = new OnClickListener() {

		@Override
		public void onClick(View v) {
			switch(v.getId()){
			case R.id.tv_operation:
				try {
					String msgText = mInputBox.getText().toString();
					if(msgText.equals("cc")){
						messageList.clear();
						messageAdapter.notifyDataSetChanged();
						return;
					}
					mChat.sendMessage(msgText);
					MessageAO newMsg = new MessageAO();
					newMsg.from = "me";
					newMsg.to = mUser.jid;
					newMsg.content = msgText;
					messageList.add(newMsg);
					messageAdapter.notifyDataSetChanged();
					MessageManager.getInstance().saveMessage(newMsg);
				} catch (XMPPException e) {
					e.printStackTrace();
				}
				break;
			}
		}
	};


	private TextWatcher inputWatcher = new TextWatcher() {

		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
		}

		@Override
		public void beforeTextChanged(CharSequence s, int start, int count,
				int after) {
		}

		@Override
		public void afterTextChanged(Editable s) {
			if(s.toString().equals(""))
				mOperation.setEnabled(false);
			else{
				mOperation.setEnabled(true);
			}
		}
	};


	/**
	 * 聊天消息监听
	 */
	private MessageListener messageListener = new MessageListener() {
		/** 
		 * 处理设置该listener后到来的消息
		 */
		@Override
		public void processMessage(Chat arg0,org.jivesoftware.smack.packet.Message arg1) {
			Log.i(TAG, arg1.getBody());
			MessageAO newMsg = new MessageAO();
			newMsg.from = arg1.getFrom();
			newMsg.to = "me";
			newMsg.content = arg1.getBody();
			messageList.add(newMsg);
			messageAdapter.notifyDataSetChanged();
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
			if(messageList.get(position).from.equals("me"))
				convertView = LayoutInflater.from(ChatActivity.this).inflate(R.layout.item_chat_me, null);
			else
				convertView = LayoutInflater.from(ChatActivity.this).inflate(R.layout.item_chat_other, null);
			viewholder.content = (TextViewVertical) convertView.findViewById(R.id.tv_content);
			convertView.setTag(viewholder);

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
			/*String user = intent.getStringExtra(USER);
			if(mChat == null){
				messageList.add(messageManager.getNewMessage(user));
				messageAdapter.notifyDataSetChanged();
			}*/
		}

	}

}
