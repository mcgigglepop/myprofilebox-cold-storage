package com.mcgigglepop.blackbox.helpers;

import android.content.Context;
import android.content.SharedPreferences;

public class SharedPreferenceManager {
    SharedPreferences preference;
    SharedPreferences.Editor editor;
    Context _context;

    int PRIVATE_MODE = 0;
    private static final String PREF_NAME = "onboarding";
    private static final String IS_FIRST_TIME_LAUNCH = "isFirstTimeOnboarding";
    private static final String IS_REGISTERED = "isRegistered";

    public SharedPreferenceManager(Context context){
        this._context = context;
        preference = _context.getSharedPreferences(PREF_NAME, PRIVATE_MODE);
        editor = preference.edit();
    }

    public void setFirstTimeLaunch(boolean isFirstTimeLaunch){
        editor.putBoolean(IS_FIRST_TIME_LAUNCH, isFirstTimeLaunch);
        editor.commit();
    }

    public boolean getFirstTimeLaunch(){
        return preference.getBoolean(IS_FIRST_TIME_LAUNCH, true);
    }

    public void setRegistered(boolean isRegistered){
        editor.putBoolean(IS_REGISTERED, isRegistered);
        editor.commit();
    }

    public boolean getRegistered(){
        return preference.getBoolean(IS_REGISTERED, false);
    }
}
