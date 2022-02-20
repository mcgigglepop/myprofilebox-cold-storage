package com.mcgigglepop.myprofilebox;

import android.content.Context;
import android.content.SharedPreferences;

public class PreferenceManager {
    SharedPreferences preference;
    SharedPreferences.Editor editor;
    Context _context;

    int PRIVATE_MODE = 0;

    private static final String PREF_NAME = "onboarding";
    private static final String IS_FIRST_TIME_LAUNCH = "isFirstTimeOnboarding";

    public PreferenceManager(Context context){
        this._context = context;
        preference = _context.getSharedPreferences(PREF_NAME, PRIVATE_MODE);
        editor = preference.edit();
    }

    public void setFirstTimeLaunch(boolean isFirstTime){
        editor.putBoolean(IS_FIRST_TIME_LAUNCH, isFirstTime);
        editor.commit();
    }

    public boolean isFirstTimeLaunch(){
        return preference.getBoolean(IS_FIRST_TIME_LAUNCH, true);
    }
}
