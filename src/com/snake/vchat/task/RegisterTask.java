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
import com.snake.vchat.manager.UserInfoManager;
import com.snake.vchat.manager.XmppConnectionManager;
import com.snake.vchat.pojo.LoginAO;

public class RegisterTask extends MultiThreadingAsyncTask<Void, Void, Void>{

	public static final String TAG = RegisterTask.class.getSimpleName();
	
	private static final String ERR_SERVER_NO_RESPOND = "服务器未响应";
	
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
	 * @param loginAO 登录信息
	 * @param context activity上下文，用于执行UI线程操作
	 */
	private void init(LoginAO loginAO, Activity context){
		mConnection = XmppConnectionManager.getInstance().getConnection();
		mContext = context;
		mLoginAO = loginAO;
	}

	
	/**
	 * 异步登录
	 * */
	@Override
	protected Void doInBackground(Void params)
			throws CLInvalidNetworkException, CLConnectionException {
		try {
			if(!mConnection.isConnected())
				mConnection.connect();
			register();
		} catch (XMPPException e) {
			e.printStackTrace();
			Looper.prepare();
			Toast.makeText(mContext, ERR_SERVER_NO_RESPOND, Toast.LENGTH_SHORT).show();
			Looper.loop();
		}
		return null;
	}

	
	/**
	 * 登录完成后UI线程执行
	 * */
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
	
	
	/**
	 * 注册
	 */
	private void register(){
		if (mConnection == null)  
	        return;  
	    Registration reg = new Registration();  
	    reg.setType(IQ.Type.SET);  
	    reg.setTo(mConnection.getServiceName());  
	    reg.setUsername(mLoginAO.username);// 注意这里createAccount注册时，参数是username，不是jid，是“@”前面的部分。  
	    reg.setPassword(mLoginAO.password);  
	    reg.addAttribute("android", "vchat_createUser_android");// 这边addAttribute不能为空，否则出错。所以做个标志是android手机创建的吧！！！！！  
	    PacketFilter filter = new AndFilter(new PacketIDFilter(  
	            reg.getPacketID()), new PacketTypeFilter(IQ.class));  
	    PacketCollector collector = mConnection.getServiceName().createPacketCollector(filter);  
	    ClientConServer.connection.sendPacket(reg);  
	    IQ result = (IQ) collector.nextResult(SmackConfiguration  
	            .getPacketReplyTimeout());  
	    // Stop queuing results  
	    collector.cancel();// 停止请求results（是否成功的结果）  
	    if (result == null) {  
	        Log.e("RegistActivity", "No response from server.");  
	        return "0";  
	    } else if (result.getType() == IQ.Type.RESULT) {  
	        return "1";  
	    } else { // if (result.getType() == IQ.Type.ERROR)  
	        if (result.getError().toString().equalsIgnoreCase("conflict(409)")) {  
	            Log.e("RegistActivity", "IQ.Type.ERROR: "  
	                    + result.getError().toString());  
	            return "2";  
	        } else {  
	            Log.e("RegistActivity", "IQ.Type.ERROR: "  
	                    + result.getError().toString());  
	            return "3";  
	        }  
	    }  
	}
	
}
