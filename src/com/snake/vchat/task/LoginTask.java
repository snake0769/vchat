package com.snake.vchat.task;

import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smackx.packet.VCard;

import android.app.Activity;
import android.content.Intent;
import android.os.Looper;
import android.widget.Toast;

import com.gt.cl.http.CLConnectionException;
import com.gt.cl.http.CLInvalidNetworkException;
import com.snake.vchat.activity.FunctionHostActivity;
import com.snake.vchat.manager.UserInfoManager;
import com.snake.vchat.manager.XmppConnectionManager;
import com.snake.vchat.pojo.LoginAO;

public class LoginTask extends MultiThreadingAsyncTask<Void, Void, Void>{

	public static final String TAG = LoginTask.class.getSimpleName();
	
	private static final String ERR_AUTHORITY = "用户名或密码错误";
	
	private XMPPConnection mConnection;
	private Activity mContext;
	private LoginAO mLoginAO;
	
	public LoginTask(LoginAO loginAO, Activity context) {
		super(context);
		init(loginAO, context);
	}

	public LoginTask(LoginAO loginAO, Activity context, boolean isShowLoading,
			boolean canClosLoading) {
		super(context, isShowLoading, canClosLoading);
		init(loginAO, context);
	}

	public LoginTask(LoginAO loginAO, Activity context, boolean isShowLoading) {
		super(context, isShowLoading);
		init(loginAO, context);
	}
	
	
	/** 初始化
	 * @param loginAO 登录信息
	 * @param context activity上下文，用于执行UI线程操作
	 */
	private void init(LoginAO loginAO, Activity context){
		mConnection = XmppConnectionManager.getInstance().getConnection();
		mContext = context;
		mLoginAO = loginAO;
	}

	
	/**异步登录*/
	@Override
	protected Void doInBackground(Void params)
			throws CLInvalidNetworkException, CLConnectionException {
		try {
			if(!mConnection.isConnected())
				mConnection.connect();
			mConnection.login(mLoginAO.username, mLoginAO.password);
		} catch (XMPPException e) {
			e.printStackTrace();
			Looper.prepare();
			Toast.makeText(mContext, ERR_AUTHORITY, Toast.LENGTH_SHORT).show();
			Looper.loop();
		}
		return null;
	}

	
	/**登录完成后UI线程执行*/
	@Override
	protected void doOnSuccess(Void result) {
		VCard vcard = new VCard();
		try {
			vcard.load(mConnection);
			mLoginAO.nickname = vcard.getNickName();
			mLoginAO.email = vcard.getEmailHome();
		} catch (XMPPException e) {
			e.printStackTrace();
		}
		UserInfoManager.getInstance().updateUserInformation(mLoginAO);
		mContext.startActivity(new Intent(mContext, FunctionHostActivity.class));
	}
	
	
}
