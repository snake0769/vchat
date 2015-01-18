package com.snake.vchat.db;

import com.snake.vchat.app.VChatApplication;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;

public class SqliteHelper extends SQLiteOpenHelper {
	private static final String DB_NAME = "utils.db";
	private static final int VERSION = 1;
	private Context mContext;
	private static SqliteHelper mInstance;

	private SqliteHelper(Context context, String name, CursorFactory factory,
			int version) {
		super(context, name, factory, version);
		mContext = context;
	}

	private SqliteHelper(Context context) {
		super(context, DB_NAME, null, VERSION);
		mContext = context;
	}
	
	public static SqliteHelper getInstance(){
		if(mInstance==null)
			mInstance = new SqliteHelper(VChatApplication.getInstance());
		return mInstance;
	}


	

	@Override
	public void onCreate(SQLiteDatabase db) {
		try{
		db.execSQL(MessageDao.CREATE_TABLE);
		}catch(Exception e){
			e.printStackTrace();
		}

	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
	}

}
