package com.snake.vchat.app;

public class Constants {
	
	/**服务器配置*/
	public static final String XMPP_HOST = "192.168.1.123";// 地址
	public static final int XMPP_PORT = 5222;// 端口
	public static final String XMPP_SERVER_NAME = "192.168.1.123";// 服务器名
	
	/**其他*/
	public static final String ERROR_FILE_NAME_PREFIX = "err";
	public static final String PACKAGE_NAME = "com.snake.vchat";
	public static final String ACTION = PACKAGE_NAME + ".Action";
	
	/**精确到毫秒*/
	public static final String MS_FORMART = "yyyy-MM-dd HH:mm:ss SSS";

	/**广播消息*/
	public static final String ACTION_NEWMESSAGE = ACTION+".NewMessage";

}
