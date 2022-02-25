package com.mcgigglepop.blackbox.helpers;

import android.content.Context;
import android.content.SharedPreferences;

public class SharedPreferenceHelper {
    SharedPreferences preference;
    SharedPreferences.Editor editor;
    Context _context;

    int PRIVATE_MODE = 0;
    private static final String PREF_NAME = "onboarding";
    private static final String IS_FIRST_TIME_LAUNCH = "isFirstTimeOnboarding";
    private static final String IS_REGISTERED = "isRegistered";

    public SharedPreferenceHelper(Context context){
        this._context = context;
        preference = _context.getSharedPreferences(PREF_NAME, PRIVATE_MODE);
        editor = preference.edit();
    }
}
