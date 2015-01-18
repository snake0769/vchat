package com.snake.vchat.db;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.snake.vchat.pojo.MessageAO;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

public class MessageDao {
	public static final String TABLE_NAME = "message";
	public static final String TABLE_NAME_DEF = "message_def";
	public static final String FIELD_ID = "id";
	public static final String FIELD_CONTENT = "content";
	public static final String FIELD_FROM = "send_from";
	public static final String FIELD_TO = "send_to";
	public static final String FIELD_TIME = "time";
	public static final String FIELD_TYPE = "type";
	private static MessageDao mInstance;


	public static final String CREATE_TABLE = "CREATE TABLE IF NOT EXISTS "
			+ TABLE_NAME + " (" + FIELD_ID
			+ " integer PRIMARY KEY AUTOINCREMENT, " + FIELD_CONTENT + " CHAR,"
			+ FIELD_FROM + " CHAR," + FIELD_TO + " CHAR," + FIELD_TIME + " CHAR," 
			+ FIELD_TYPE + " CHAR)";
	
	
	//public static final String ADD_NEW_COLUMN_TABLE = "ALTER TABLE `"+ TABLE_NAME +"` ADD `"+ FIELD_ADV_ID + "` CHAR NULL ;";
	private SqliteHelper helper;

	private MessageDao() {
		helper = SqliteHelper.getInstance();
	}

	public static MessageDao getInstance() {
		if (mInstance == null) {
			mInstance = new MessageDao();
		}
		return mInstance;
	}

	
	/**
	 * 保存聊天消息
	 * @param list
	 */
	public synchronized void putMessage(MessageAO message) {
		if (message == null) {
			return;
		}
		SQLiteDatabase db = helper.getWritableDatabase();
		synchronized (db) {
			db.beginTransaction();
			try {
					ContentValues values = createValues(message);
					db.insert(TABLE_NAME, null, values);
				db.setTransactionSuccessful();
			} catch(Exception e){
				e.printStackTrace();
			}
			finally {
				db.endTransaction();
				//db.close();
			}
		}
		
	}
	
	
	/**
	 * 保存聊天消息
	 * @param list
	 */
	public synchronized void putMessage(List<MessageAO> list) {
		if (list == null) {
			return;
		}
		SQLiteDatabase db = helper.getWritableDatabase();
		synchronized (db) {
			db.beginTransaction();
			try {
				for (MessageAO MessageAO : list) {
					ContentValues values = createValues(MessageAO);
					// db.replace(TABLE_NAME, null, values);
					db.insert(TABLE_NAME, null, values);
				}
				db.setTransactionSuccessful();
			} catch(Exception e){
				e.printStackTrace();
			}
			finally {
				db.endTransaction();
				//db.close();
			}
		}
		
	}
	
	
	/**
	 * 移除所有聊天消息
	 * @return
	 */
	public synchronized int clearMessages() {
		SQLiteDatabase db = helper.getWritableDatabase();
		int count = db.delete(TABLE_NAME, null, null);
		Log.i("MessageDao", "count >>> " + count);
		//db.close();
		return count;
	}

	
	
	/**
	 *  读取指定的聊天消息
	 * @param target 聊天对象
	 * @return
	 */
	public LinkedList<MessageAO> getMessage(String target) {
		SQLiteDatabase db = helper.getWritableDatabase();
		LinkedList<MessageAO> list = new LinkedList<MessageAO>();
		synchronized (db) {
			Cursor cursor = db.query(TABLE_NAME, null, FIELD_FROM+"=? OR " + FIELD_TO+"=?", new String[]{target,target}, null, null,
					FIELD_ID + " asc");
			if (cursor != null && cursor.getCount() > 0) {
				while (cursor.moveToNext()) {
					MessageAO ao = createMessage(cursor);
					list.add(ao);
				}
			}
			//db.close();
		}
		
		return list;
	}

	

	/**
	 * 从cursor创建MessageAO对象实例
	 * @param cursor
	 * @return
	 */
	private MessageAO createMessage(Cursor cursor) {
		MessageAO ao = new MessageAO();
		ao.content = cursor.getString(cursor.getColumnIndex(FIELD_CONTENT));
		ao.from = cursor.getString(cursor.getColumnIndex(FIELD_FROM));
		ao.to = cursor.getString(cursor.getColumnIndex(FIELD_TO));
		ao.time = cursor.getString(cursor.getColumnIndex(FIELD_TIME));
		ao.type = Integer.valueOf(cursor.getString(cursor.getColumnIndex(FIELD_TYPE)));
		return ao;
	}

	
	
	/**
	 * 从MessageAO对象实例创建ContentValues
	 * @param ao
	 * @return
	 */
	private ContentValues createValues(MessageAO ao) {
		ContentValues values = new ContentValues();
		values.put(FIELD_CONTENT, ao.content);
		values.put(FIELD_FROM, ao.from);
		values.put(FIELD_TO, ao.to);
		values.put(FIELD_TIME, ao.time);
		values.put(FIELD_TYPE, ao.type);
		return values;
	}
	
	
}
