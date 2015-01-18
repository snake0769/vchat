package com.snake.vchat.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.jivesoftware.smack.PacketListener;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.filter.MessageTypeFilter;
import org.jivesoftware.smack.packet.Message;
import org.jivesoftware.smack.packet.Packet;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;

import com.snake.vchat.activity.ChatActivity;
import com.snake.vchat.app.Constants;
import com.snake.vchat.manager.MessageManager;
import com.snake.vchat.manager.XmppConnectionManager;
import com.snake.vchat.pojo.MessageAO;
import com.snake.vchat.util.DateUtil;

/**
 * 
 * 聊天服务.
 * 
 * @author shimiso
 */
public class ChatService extends Service {
	private Context context;
	private NotificationManager notificationManager;
	private List<Handler> targetHandlers = new ArrayList<Handler>();

	@Override
	public void onCreate() {
		context = this;
		super.onCreate();
		initChatManager();
	}

	@Override
	public int onStartCommand(Intent intent, int flags, int startId) {
		return super.onStartCommand(intent, flags, startId);
	}

	@Override
	public IBinder onBind(Intent intent) {
		return null;
	}

	@Override
	public void onDestroy() {
		super.onDestroy();
	}

	
	private void initChatManager() {
		notificationManager = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
		XMPPConnection conn = XmppConnectionManager.getInstance().getConnection();
		conn.addPacketListener(pListener, new MessageTypeFilter(Message.Type.chat));
	}

	
	
	/**
	 * 监听接收消息
	 */
	PacketListener pListener = new PacketListener() {

		@Override
		public void processPacket(Packet arg0) {
			Message message = (Message) arg0;
			if (message != null && message.getBody() != null
					&& !message.getBody().equals("null")) {
				MessageAO msg = new MessageAO();
				// String time = (String)
				// message.getProperty(MessageAO.KEY_TIME);
				String time = DateUtil.date2Str(Calendar.getInstance(),
						Constants.MS_FORMART);
				msg.time = time;
				msg.content = message.getBody();
				if (Message.Type.error == message.getType()) {
					msg.type = MessageAO.ERROR;
				} else {
					msg.type = MessageAO.SUCCESS;
				}
				String from = message.getFrom().split("/")[0];
				msg.from = from;


				// 历史记录
				MessageAO newMessage = new MessageAO();
				newMessage.to = "me";
				newMessage.from = from;
				newMessage.content = message.getBody();
				newMessage.time = time;
				MessageManager.getInstance().saveMessage(newMessage);
				
				//发送新消息广播
				Intent intent = new Intent();
				intent.setAction(Constants.ACTION_NEWMESSAGE);
				intent.putExtra(ChatActivity.USER, newMessage.from);
				sendBroadcast(intent);

			}

		}

	};
	

	/**
	 * 
	 * 发出Notification的method.
	 * 
	 * @param iconId
	 *            图标
	 * @param contentTitle
	 *            标题
	 * @param contentText
	 *            你内容
	 * @param activity
	 * @author shimiso
	 * @update 2012-5-14 下午12:01:55
	 */
	private void setNotiType(int iconId, String contentTitle,
			String contentText, Class activity, String from) {

		/*
		 * 创建新的Intent，作为点击Notification留言条时， 会运行的Activity
		 */
		Intent notifyIntent = new Intent(this, activity);
		notifyIntent.putExtra("to", from);
		// notifyIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

		/* 创建PendingIntent作为设置递延运行的Activity */
		PendingIntent appIntent = PendingIntent.getActivity(this, 0,
				notifyIntent, 0);

		/* 创建Notication，并设置相关参数 */
		Notification myNoti = new Notification();
		// 点击自动消失
		myNoti.flags = Notification.FLAG_AUTO_CANCEL;
		/* 设置statusbar显示的icon */
		myNoti.icon = iconId;
		/* 设置statusbar显示的文字信息 */
		myNoti.tickerText = contentTitle;
		/* 设置notification发生时同时发出默认声音 */
		myNoti.defaults = Notification.DEFAULT_SOUND;
		/* 设置Notification留言条的参数 */
		myNoti.setLatestEventInfo(this, contentTitle, contentText, appIntent);
		/* 送出Notification */
		notificationManager.notify(0, myNoti);
	}
	
	
}
