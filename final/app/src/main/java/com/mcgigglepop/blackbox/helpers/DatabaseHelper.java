package com.mcgigglepop.blackbox.helpers;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DatabaseHelper extends SQLiteOpenHelper {

    private static final String DATABASE_NAME = "table.db";
    private static final int DATABASE_VERSION =  1;
    private final Context context;
    private static final String DATABASE_PATH = "/data/data/com.mcgigglepop.blackbox/databases/";
    private static final String USER_TABLE = "user";

    SQLiteDatabase db;

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {

    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {

    }
}
