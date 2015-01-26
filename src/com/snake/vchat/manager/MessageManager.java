package com.snake.vchat.manager;

import java.util.List;

import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.ChatManager;
import org.jivesoftware.smack.ChatManagerListener;

import com.snake.vchat.db.MessageDao;
import com.snake.vchat.pojo.MessageAO;
import com.snake.vchat.service.ChatService;

import android.content.Context;
import android.content.Intent;

public class MessageManager extends BaseManager{
	public static final String TAG = MessageManager.class.getSimpleName();
	
	/**公共消息通知*/
	public static final int MSG_NEWMESSAGE = 1;

	private static MessageManager mInstance;
	private ChatManager chatManager;

	private MessageManager(){

	}

	public static MessageManager getInstance(){
		if(mInstance == null){
			mInstance = new MessageManager();
		}
		return mInstance;
	}

	
	@Override
	public void init(Context context) {
		super.init(context);
	}
	
	
	/**
	 * 开始接收消息
	 */
	public void start(){
		mContext.startService(new Intent(mContext, ChatService.class));
	}


	/**
	 * 保存聊天消息
	 * @param messages
	 */
	public void saveMessage(MessageAO message){
		MessageDao.getInstance().putMessage(message);
	}


	/**
	 * 保存聊天消息
	 * @param messages
	 */
	public void saveMessage(List<MessageAO> messages){
		MessageDao.getInstance().putMessage(messages);
	}
	
	
	/**
	 * 加载指定聊天对象的聊天消息
	 * @param target
	 * @return
	 */
	public List<MessageAO> loadMessage(String target){
		return MessageDao.getInstance().getMessage(target);
	}
	
	
	/**
	 * 加载指定聊天对象的聊天消息
	 * @param target
	 * @return
	 */
	public MessageAO getNewMessage(String target){
		return MessageDao.getInstance().getMessage(target).getLast();
	}


}
