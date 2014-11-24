package com.snake.vchat.manager;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import android.content.ContentResolver;
import android.content.ContentUris;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.provider.ContactsContract;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.provider.ContactsContract.CommonDataKinds.Photo;
import android.text.TextUtils;

import com.snake.vchat.R;

public class ContactsManager extends BaseManager{

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

	public class Contact{
		public long id;
		public String phone;
		public String name;
		public long photo_id;
		public byte[] photo_data;

	}

	private static ContactsManager mInstance;

	private ContactsManager(){
	}

	public static ContactsManager getInstance(){
		if(mInstance == null)
			mInstance = new ContactsManager();
		return mInstance;
	}

	
	/**得到手机通讯录联系人信息**/  
	public ArrayList<Contact> getPhoneContacts() {  
		ContentResolver resolver = mContext.getContentResolver();  
		ArrayList<Contact> contacts = new ArrayList<Contact>();

		// 获取手机联系人  
		Cursor phoneCursor = resolver.query(Phone.CONTENT_URI,PHONES_PROJECTION, null, null, null);  

		if (phoneCursor != null) {  
			while (phoneCursor.moveToNext()) {  

				//得到手机号码  
				String phoneNumber = phoneCursor.getString(PHONES_NUMBER_INDEX);  
				//当手机号码为空的或者为空字段 跳过当前循环  
				if (TextUtils.isEmpty(phoneNumber))  
					continue;  

				Contact contact = new Contact();
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

}
