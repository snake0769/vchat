package com.snake.vchat.pojo;

import org.jivesoftware.smack.packet.RosterPacket;

import android.os.Parcel;
import android.os.Parcelable;

/**
 * intent可以携带传递Parcel数据，需要实现三个方法 . 1、describeContents()返回0就可以.
 * 2、将需要的数据写入Parcel中，框架调用这个方法传递数据. 3、重写外部类反序列化该类时调用的方法.
 * 
 * @author wangdan
 * 
 */
public class UserAO extends BaseAO implements Parcelable {

	/**
	 * 将user保存在intent中时的key
	 */
	public static final String userKey = "lovesong_user";

	public String name;
	public String JID;
	public static RosterPacket.ItemType type;
	public String status;
	public String from;
	public String groupName;
	/** 用户状态对应的图片*/
	private int imgId;
	/**group的size */
	private int size;
	private boolean available;


	@Override
	public int describeContents() {
		return 0;
	}

	@Override
	public void writeToParcel(Parcel dest, int flags) {
		dest.writeString(JID);
		dest.writeString(name);
		dest.writeString(from);
		dest.writeString(status);
		dest.writeInt(available ? 1 : 0);
	}

	public static final Parcelable.Creator<UserAO> CREATOR = new Parcelable.Creator<UserAO>() {

		@Override
		public UserAO createFromParcel(Parcel source) {
			UserAO u = new UserAO();
			u.JID = source.readString();
			u.name = source.readString();
			u.from = source.readString();
			u.status = source.readString();
			u.available = source.readInt() == 1 ? true : false;
			return u;
		}

		@Override
		public UserAO[] newArray(int size) {
			return new UserAO[size];
		}

	};

	public UserAO clone() {
		UserAO user = new UserAO();
		user.available = available;
		user.from = from;
		user.groupName = groupName;
		user.imgId = imgId;
		user.JID = JID;
		user.name = name;
		user.size = size;
		user.status = status;
		return user;
	}

}
