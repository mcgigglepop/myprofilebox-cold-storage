package com.mcgigglepop.blackbox.helpers;

import android.content.res.ColorStateList;
import android.graphics.Color;
import android.graphics.Paint;

public class CustomEditText extends androidx.appcompat.widget.AppCompatEditText{

    public static final String XML_NAMESPACE_ANDROID = "http://schemas.android.com/apk/res/android";
    private float mSpace = 24; //24 dp by default, space between the lines
    private float mCharSize;
    private float mNumChars = 6;
    private float mLineSpacing = 8; //8dp by default, height of the text from our lines
    private int mMaxLength = 6;
    private OnClickListener mClickListener;
    private float mLineStroke = 1; //1dp by default
    private float mLineStrokeSelected = 2; //2dp by default
    private Paint mLinesPaint;

    int[][] mStates = new int[][]{
            new int[]{android.R.attr.state_selected}, // selected
            new int[]{android.R.attr.state_focused}, // focused
            new int[]{-android.R.attr.state_focused}, // unfocused
    };

    int[] mColors = new int[]{
            Color.GREEN,
            Color.BLACK,
            Color.GRAY
    };

    ColorStateList mColorStates = new ColorStateList(mStates, mColors);
}
