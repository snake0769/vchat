package com.snake.vchat.manager;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jivesoftware.smack.RosterEntry;
import org.jivesoftware.smack.XMPPConnection;

import android.content.ContentResolver;
import android.content.ContentUris;
import android.database.Cursor;
import android.net.Uri;
import android.provider.ContactsContract;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.provider.ContactsContract.CommonDataKinds.Photo;
import android.text.TextUtils;

import com.snake.vchat.pojo.PhoneContactAO;
import com.snake.vchat.pojo.UserAO;

public class ContactsManager extends BaseManager{
	public static final String TAG = ContactsManager.class.getSimpleName();
	
	/**获取库Phon表字段**/  
	private static final String[] PHONES_PROJECTION = new String[] {  
		Phone.DISPLAY_NAME, Phone.NUMBER, Photo.PHOTO_ID,Phone.CONTACT_ID };  
	/**联系人显示名称**/  
	private static final int PHONES_DISPLAY_NAME_INDEX = 0;  
	/**电话号码**/  
	private static final int PHONES_NUMBER_INDEX = 1;  
	/**头像ID**/  
	private static final int PHONES_PHOTO_ID_INDEX = 2;  
	/**联系人的ID**/  
	private static final int PHONES_CONTACT_ID_INDEX = 3;  

	private List<UserAO> mContacts = new ArrayList<UserAO>();


	private static ContactsManager mInstance;

	private ContactsManager(){
	}

	public static ContactsManager getInstance(){
		if(mInstance == null)
			mInstance = new ContactsManager();
		return mInstance;
	}

	
	/**
	 * 获取手机通讯录
	 * @return
	 */
	public ArrayList<PhoneContactAO> getPhoneContacts() {  
		ContentResolver resolver = mContext.getContentResolver();  
		ArrayList<PhoneContactAO> contacts = new ArrayList<PhoneContactAO>();

		// 获取手机联系人  
		Cursor phoneCursor = resolver.query(Phone.CONTENT_URI,PHONES_PROJECTION, null, null, null);  

		if (phoneCursor != null) {  
			while (phoneCursor.moveToNext()) {  

				//得到手机号码  
				String phoneNumber = phoneCursor.getString(PHONES_NUMBER_INDEX);  
				//当手机号码为空的或者为空字段 跳过当前循环  
				if (TextUtils.isEmpty(phoneNumber))  
					continue;  

				PhoneContactAO contact = new PhoneContactAO();
				//得到联系人名称  
				contact.name = phoneCursor.getString(PHONES_DISPLAY_NAME_INDEX);  
				//得到联系人ID  
				contact.id = phoneCursor.getLong(PHONES_CONTACT_ID_INDEX);  
				//得到联系人头像ID  
				contact.photo_id = phoneCursor.getLong(PHONES_PHOTO_ID_INDEX);  
				//得到联系人头像Bitamp  
				//photoid 大于0 表示联系人有头像 如果没有给此人设置头像则给他一个默认的  
				if(contact.photo_id > 0 ) {  
					Uri uri =ContentUris.withAppendedId(ContactsContract.Contacts.CONTENT_URI,contact.id);  
					InputStream input = ContactsContract.Contacts.openContactPhotoInputStream(resolver, uri);  
					try {
						input.read(contact.photo_data);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}

				contacts.add(contact);
			}  
			phoneCursor.close();  
			
		}  
		return contacts;
	} 

	
	/**
	 * 获得所有联系人列表
	 * @return
	 */
	public List<UserAO> getContacts(XMPPConnection connection) {
		for (RosterEntry entry : connection.getRoster().getEntries()) {
			entry
		}
		
		if (mContacts == null)
			throw new RuntimeException("contacts is null");

		return userList;
	}
	
	
	
	
}
