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
		/*db.execSQL(ZoneDao.CREATE_TABLE);
		db.execSQL(ZoneDao.CREATE_TABLE_DEF);
		db.execSQL(ShopTypeDao.CREATE_TABLE);
		ZoneDao.getInstance().makeDefaultZones(db);*/
		}catch(Exception e){
			e.printStackTrace();
		}

	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		/*db.execSQL(AdverImageDao.ADD_NEW_COLUMN_TABLE);
		db.execSQL(AdverImageTempDao.ADD_NEW_COLUMN_TABLE);
		db.execSQL(UpdateAdverinfoDBO.ADD_NEW_COLUMN_TABLE);*/
	}

}
