package com.snake.vchat.pojo;

public class MessageAO extends BaseAO{
	public static final int ERROR = -1;
	public static final int SUCCESS = 1;
	
	public String from;
	public String to;
	public String time;
	public String content;
	public int type;
}
