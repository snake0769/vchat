package com.snake.vchat.task;

import org.jivesoftware.smack.PacketCollector;
import org.jivesoftware.smack.SmackConfiguration;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.filter.AndFilter;
import org.jivesoftware.smack.filter.PacketFilter;
import org.jivesoftware.smack.filter.PacketIDFilter;
import org.jivesoftware.smack.filter.PacketTypeFilter;
import org.jivesoftware.smack.packet.IQ;
import org.jivesoftware.smack.packet.Registration;
import org.jivesoftware.smackx.packet.VCard;

import android.app.Activity;
import android.content.Intent;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;

import com.gt.cl.http.CLConnectionException;
import com.gt.cl.http.CLInvalidNetworkException;
import com.snake.vchat.activity.FunctionHostActivity;
import com.snake.vchat.app.Constants;
import com.snake.vchat.manager.UserInfoManager;
import com.snake.vchat.manager.XmppConnectionManager;
import com.snake.vchat.pojo.LoginAO;
import comsnake.vchat.throwable.ErrDescription;

public class RegisterTask extends MultiThreadingAsyncTask<Void, Void, Exception>{

	public static final String TAG = RegisterTask.class.getSimpleName();

	private XMPPConnection mConnection;
	private Activity mContext;
	private LoginAO mLoginAO;

	public RegisterTask(LoginAO loginAO, Activity context) {
		super(context);
		init(loginAO, context);
	}

	public RegisterTask(LoginAO loginAO, Activity context, boolean isShowLoading,
			boolean canClosLoading) {
		super(context, isShowLoading, canClosLoading);
		init(loginAO, context);
	}

	public RegisterTask(LoginAO loginAO, Activity context, boolean isShowLoading) {
		super(context, isShowLoading);
		init(loginAO, context);
	}


	/**
	 *  初始化
	 * @param loginAO 注册信息
	 * @param context activity上下文，用于执行UI线程操作
	 */
	private void init(LoginAO loginAO, Activity context){
		mConnection = XmppConnectionManager.getInstance().getConnection();
		mContext = context;
		mLoginAO = loginAO;
	}


	/**
	 * 异步注册
	 * @throws XMPPException 
	 * */
	@Override
	protected Exception doInBackground(Void params)
			throws CLInvalidNetworkException, CLConnectionException {
		try {
			if(!mConnection.isConnected())
				mConnection.connect();
			register();
		} catch (XMPPException e) {
			return e;
		}
		return null;
	}


	/**
	 * 注册完成后UI线程执行
	 * */
	@Override
	protected void doOnSuccess(Exception result) {
		if(result == null){
			Toast.makeText(mContext, ErrDescription.SUC_REGITSER, Toast.LENGTH_SHORT).show();
			mContext.finish();
		}
	}


	/**
	 * 注册
	 * @throws XMPPException 
	 */
	private void register() throws XMPPException{
		if (mConnection == null)  
			setErrorMsg(ErrDescription.ERR_CONNECTION_INVALID);  
		Registration reg = new Registration();  
		reg.setType(IQ.Type.SET);  
		reg.setTo(mConnection.getServiceName());  
		reg.setUsername(mLoginAO.username);// 注意这里createAccount注册时，参数是username，不是jid，是“@”前面的部分。  
		reg.setPassword(mLoginAO.password);  
		reg.addAttribute("android", "vchat_createUser_android");// 这边addAttribute不能为空，否则出错。所以做个标志是android手机创建的吧！！！！！  
		PacketFilter filter = new AndFilter(new PacketIDFilter(  
				reg.getPacketID()), new PacketTypeFilter(IQ.class));  
		PacketCollector collector = mConnection.createPacketCollector(filter); 
		mConnection.sendPacket(reg);
		IQ result = (IQ) collector.nextResult(SmackConfiguration  
				.getPacketReplyTimeout());  
		// Stop queuing results  
		collector.cancel();// 停止请求results（是否成功的结果）  

		if (result == null) {  
			throw new XMPPException(ErrDescription.ERR_SERVER_NO_RESPOND);
		} 
		else if (result.getType() == IQ.Type.ERROR) {  
			if (result.getError().toString().equalsIgnoreCase("conflict(409)")) {  
				Log.e("RegistActivity", "IQ.Type.ERROR: "  + result.getError().toString());  
				throw new XMPPException(ErrDescription.ERR_ACCOUNT_EXITED);
			} else {  
				Log.e("RegistActivity", "IQ.Type.ERROR: "  + result.getError().toString());  
				throw new XMPPException(ErrDescription.ERR_REGISTER_FAILED);
			} 
		}

		//设置用户信息
		mConnection.login(mLoginAO.username, mLoginAO.password);
		VCard vCard = new VCard();
		vCard.load(mConnection);
		vCard.setNickName(mLoginAO.nickname);
		vCard.save(mConnection);
		mConnection.disconnect();
	}

	
	/** 
	 * 异常处理
	 */
	@Override
	protected boolean handleException(Exception ex) {
		Toast.makeText(getContext(),ex.getMessage(),Toast.LENGTH_LONG).show();
		return true;
	}

	
	
}
