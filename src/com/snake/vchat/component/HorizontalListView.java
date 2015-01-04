/*
 * HorizontalListView.java v1.5
 *
 * 
 * The MIT License
 * Copyright (c) 2011 Paul Soucy (paul@dev-smart.com)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */
package com.snake.vchat.component;

import java.util.LinkedList;
import java.util.Queue;

import android.content.Context;
import android.database.DataSetObserver;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.GestureDetector;
import android.view.GestureDetector.OnGestureListener;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewParent;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.Scroller;

public class HorizontalListView extends AdapterView<ListAdapter> {

    public boolean mAlwaysOverrideTouch = true;
    protected ListAdapter mAdapter;
    private int mLeftViewIndex = -1;
    private int mRightViewIndex = 0;
    protected int mCurrentX;
    protected int mNextX;
    private int mSelecetdItemPosition = 0;
    private int mLastSelectedItemPosition =0;
    private View mLastSeletedItem;
    private int mMaxX = Integer.MAX_VALUE;
    
    private int mDisplayOffset = 0;//每个Item的X显示偏移量
    protected Scroller mScroller;
    private GestureDetector mGesture;
    private Queue<View> mRemovedViewQueue = new LinkedList<View>();
    private OnItemSelectedListener mOnItemSelected;
    private OnItemClickListener mOnItemClicked;
    private OnItemLongClickListener mOnItemLongClicked;
    private OnItemSelectedCancelListener mOnItemSelectedCancel;
    private boolean mDataChanged = false;
    
    private float x;
	private float y;


    public HorizontalListView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initView();
    }
    
    public interface OnItemSelectedCancelListener {

        boolean onItemSelectedCancel(AdapterView<?> parent, View view, int position, long id);
    }

    private synchronized void initView() {
        mLeftViewIndex = -1;
        mRightViewIndex = 0;
        mDisplayOffset = 0;
        mCurrentX = 0;
        mNextX = 0;
        mSelecetdItemPosition = 0;
        mMaxX = Integer.MAX_VALUE;
        mScroller = new Scroller(getContext());
        mGesture = new GestureDetector(getContext(), mOnGesture);
    }

    @Override
    public void setOnItemSelectedListener(AdapterView.OnItemSelectedListener listener) {
        mOnItemSelected = listener;
    }
    
    public void setOnItemSelectedCancelListener(OnItemSelectedCancelListener listener) {
    	mOnItemSelectedCancel = listener;
    }

    @Override
    public void setOnItemClickListener(AdapterView.OnItemClickListener listener){
        mOnItemClicked = listener;
    }

    @Override
    public void setOnItemLongClickListener(AdapterView.OnItemLongClickListener listener) {
        mOnItemLongClicked = listener;
    }

    
    /**
     * 数据观察者，Adapter数据发生变化时，相应执行下面操作
     */
    private DataSetObserver mDataObserver = new DataSetObserver() {

        @Override
        public void onChanged() {
            synchronized(HorizontalListView.this){
                mDataChanged = true;
            }
            invalidate();
            requestLayout();
        }

        @Override
        public void onInvalidated() {
            reset();
            invalidate();
            requestLayout();
        }

    };

    @Override
    public ListAdapter getAdapter() {
        return mAdapter;
    }

    @Override
    public View getSelectedView() {
        return null;
    }
    
    public int getSelectedItemPosition(){
    	return this.mSelecetdItemPosition;
    }

    @Override
    public void setAdapter(ListAdapter adapter) {
        if(mAdapter != null) {
            mAdapter.unregisterDataSetObserver(mDataObserver);
        }
        mAdapter = adapter;
        mAdapter.registerDataSetObserver(mDataObserver);
        reset();
    }
    
    


    private synchronized void reset(){
        initView();
        removeAllViewsInLayout();
        requestLayout();
    }

    
    public void setSelection(int position) {
    	mSelecetdItemPosition = position;
    	View child = getChildAt(position);	
    	if(mOnItemSelected != null){
        	if(mLastSelectedItemPosition != mSelecetdItemPosition){
        		if(mOnItemSelectedCancel!=null)
        			mOnItemSelectedCancel.onItemSelectedCancel(HorizontalListView.this, mLastSeletedItem, mLastSelectedItemPosition, mAdapter.getItemId( mLastSelectedItemPosition ));
        		mOnItemSelected.onItemSelected(HorizontalListView.this, child, mSelecetdItemPosition, mAdapter.getItemId( mSelecetdItemPosition ));
        		mLastSelectedItemPosition = mSelecetdItemPosition;
        		mLastSeletedItem = child;
        	}
            
        }
    }

    private void addAndMeasureChild(final View child, int viewPos) {
        LayoutParams params = child.getLayoutParams();
        if(params == null) {
            params = new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT);
        }

        addViewInLayout(child, viewPos, params, true);
        /*child.measure(MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.AT_MOST),
                MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.AT_MOST));*/
        child.measure(MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.AT_MOST),
                MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.AT_MOST));

    }



    @Override
    protected synchronized void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);

        if(mAdapter == null){
            return;
        }

        if(mDataChanged){
            int oldCurrentX = mCurrentX;
            initView();
            removeAllViewsInLayout();
            mNextX = oldCurrentX;
            mDataChanged = false;
        }

        if(mScroller.computeScrollOffset()){
            int scrollx = mScroller.getCurrX();
            mNextX = scrollx;
        }

        if(mNextX <= 0){
            mNextX = 0;
            mScroller.forceFinished(true);
        }
        if(mNextX >= mMaxX) {
            mNextX = mMaxX;
            mScroller.forceFinished(true);
        }

        int dx = mCurrentX - mNextX;

        removeNonVisibleItems(dx);
        fillList(dx);
        positionItems(dx);

        mCurrentX = mNextX;

        if(!mScroller.isFinished()){
            post(new Runnable(){
                @Override
                public void run() {
                    requestLayout();
                }
            });

        }
    }

    
    /**
     * 横向填充列表
     * @param dx
     */
    private void fillList(final int dx) {
        int edge = 0;
        View child = getChildAt(getChildCount()-1);
        if(child != null) {
            edge = child.getRight();
        }
        fillListRight(edge, dx);

        edge = 0;
        child = getChildAt(0);
        if(child != null) {
            edge = child.getLeft();
        }
        fillListLeft(edge, dx);


    }

    /**
     * 往右填充一个Item到List
     * @param rightEdge
     * @param dx
     */
    private void fillListRight(int rightEdge, final int dx) {
        while(rightEdge + dx < getWidth() && mRightViewIndex < mAdapter.getCount()) {

            View child = mAdapter.getView(mRightViewIndex, mRemovedViewQueue.poll(), this);
            addAndMeasureChild(child, -1);
            rightEdge += child.getMeasuredWidth();

            if(mRightViewIndex == mAdapter.getCount()-1) {
                mMaxX = mCurrentX + rightEdge - getWidth();
            }

            if (mMaxX < 0) {
                mMaxX = 0;
            }
            mRightViewIndex++;
        }

    }

    /**
     * 往左填充一个Item到List
     * @param leftEdge
     * @param dx
     */
    private void fillListLeft(int leftEdge, final int dx) {
        while(leftEdge + dx > 0 && mLeftViewIndex >= 0) {
            View child = mAdapter.getView(mLeftViewIndex, mRemovedViewQueue.poll(), this);
            addAndMeasureChild(child, 0);
            leftEdge -= child.getMeasuredWidth();
            mLeftViewIndex--;
            mDisplayOffset -= child.getMeasuredWidth();
        }
    }

    private void removeNonVisibleItems(final int dx) {
        View child = getChildAt(0);
        while(child != null && child.getRight() + dx <= 0) {
            mDisplayOffset += child.getMeasuredWidth();
            mRemovedViewQueue.offer(child);
            removeViewInLayout(child);
            mLeftViewIndex++;
            child = getChildAt(0);

        }

        child = getChildAt(getChildCount()-1);
        while(child != null && child.getLeft() + dx >= getWidth()) {
            mRemovedViewQueue.offer(child);
            removeViewInLayout(child);
            mRightViewIndex--;
            child = getChildAt(getChildCount()-1);
        }
    }

    
    /**
     * 定位各个Item（X坐标）
     * @param dx
     */
    private void positionItems(final int dx) {
        if(getChildCount() > 0){
            mDisplayOffset += dx;
            int left = mDisplayOffset;
            for(int i=0;i<getChildCount();i++){
                View child = getChildAt(i);
                int childWidth = child.getMeasuredWidth();
                child.layout(left, 0, left + childWidth, child.getMeasuredHeight());
                left += childWidth + child.getPaddingRight();
            }
        }
    }

    public synchronized void scrollTo(int x) {
        mScroller.startScroll(mNextX, 0, x - mNextX, 0);
        requestLayout();
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent ev) {
    	//分开什么时候parent事件有效，什么时候child事件有效  
    			ViewParent mViewParent = this.getParent();
    			final int action = ev.getAction();
    			switch (action) {
    			case MotionEvent.ACTION_DOWN:
    				x = ev.getX();
    				y = ev.getY();
    				mViewParent.requestDisallowInterceptTouchEvent(true);
    				break;
    			case MotionEvent.ACTION_MOVE:
    				if (Math.abs(ev.getX() - x) > 10)
    					mViewParent.requestDisallowInterceptTouchEvent(true);
    				else if (Math.abs(ev.getY() - y) > 10)
    					mViewParent.requestDisallowInterceptTouchEvent(false);
    				break;
    			case MotionEvent.ACTION_UP:
    			case MotionEvent.ACTION_CANCEL:
    				mViewParent.requestDisallowInterceptTouchEvent(false);
    				break;
    			}
    			
        boolean handled = super.dispatchTouchEvent(ev);
        handled |= mGesture.onTouchEvent(ev);
        return handled;
    }

    protected boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX,
                float velocityY) {
        synchronized(HorizontalListView.this){
            mScroller.fling(mNextX, 0, (int)-velocityX, 0, 0, mMaxX, 0, 0);
        }
        requestLayout();

        return true;
    }

    protected boolean onDown(MotionEvent e) {
        mScroller.forceFinished(true);
        return true;
    }

    private OnGestureListener mOnGesture = new GestureDetector.SimpleOnGestureListener() {

        @Override
        public boolean onDown(MotionEvent e) {
            return HorizontalListView.this.onDown(e);
        }

        @Override
        public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX,
                float velocityY) {
            return HorizontalListView.this.onFling(e1, e2, velocityX, velocityY);
        }

        @Override
        public boolean onScroll(MotionEvent e1, MotionEvent e2,
                float distanceX, float distanceY) {

            synchronized(HorizontalListView.this){
                mNextX += (int)distanceX;
            }
            requestLayout();

            return true;
        }

        @Override
        public boolean onSingleTapConfirmed(MotionEvent e) {
        	if(mLastSeletedItem==null)
        		mLastSeletedItem = getChildAt(0);
            for(int i=0;i<getChildCount();i++){
                View child = getChildAt(i);
                if (isEventWithinView(e, child)) {
                    if(mOnItemClicked != null){
                        mOnItemClicked.onItemClick(HorizontalListView.this, child, mLeftViewIndex + 1 + i, mAdapter.getItemId( mLeftViewIndex + 1 + i ));
                    }
                    if(mOnItemSelected != null){
                    	
                    	/*if(getFirstVisiblePosition() <= mSelecetdItemPosition && getLastVisiblePosition() >= mSelecetdItemPosition){
                    		if(mOnItemSelectedCancel!=null)
                    			mOnItemSelectedCancel.onItemSelectedCancel(HorizontalListView.this, child, mSelecetdItemPosition, mAdapter.getItemId( mSelecetdItemPosition ));
                    	}*/
                    	mSelecetdItemPosition = mLeftViewIndex + 1 + i;
                    	if(mLastSelectedItemPosition != mSelecetdItemPosition){
                    		if(mOnItemSelectedCancel!=null)
                    			mOnItemSelectedCancel.onItemSelectedCancel(HorizontalListView.this, mLastSeletedItem, mLastSelectedItemPosition, mAdapter.getItemId( mLastSelectedItemPosition ));
                    		mOnItemSelected.onItemSelected(HorizontalListView.this, child, mLeftViewIndex + 1 + i, mAdapter.getItemId( mLeftViewIndex + 1 + i ));
                    		mLastSelectedItemPosition = mSelecetdItemPosition;
                    		mLastSeletedItem = child;
                    	}
                        
                    }
                    break;
                }

            }
            return true;
        }

        @Override
        public void onLongPress(MotionEvent e) {
            int childCount = getChildCount();
            for (int i = 0; i < childCount; i++) {
                View child = getChildAt(i);
                if (isEventWithinView(e, child)) {
                    if (mOnItemLongClicked != null) {
                        mOnItemLongClicked.onItemLongClick(HorizontalListView.this, child, mLeftViewIndex + 1 + i, mAdapter.getItemId(mLeftViewIndex + 1 + i));
                    }
                    break;
                }

            }
        }

        private boolean isEventWithinView(MotionEvent e, View child) {
            Rect viewRect = new Rect();
            int[] childPosition = new int[2];
            child.getLocationOnScreen(childPosition);
            int left = childPosition[0];
            int right = left + child.getWidth();
            int top = childPosition[1];
            int bottom = top + child.getHeight();
            viewRect.set(left, top, right, bottom);
            return viewRect.contains((int) e.getRawX(), (int) e.getRawY());
        }
    };




}