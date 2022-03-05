package com.mcgigglepop.blackbox.helpers;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

public class DatabaseHelperAccounts {
    public static final String KEY_ROWID = "_id";
    public static final String KEY_ACCOUNT_TYPE = "atype";
    public static final String KEY_ACCOUNT_NAME = "aname";
    public static final String KEY_USERNAME = "username";
    public static final String KEY_PASSWORD = "password";
    private static final String DATABASE_NAME = "table";
    private static final String SQLITE_TABLE = "records";

    private final Context context;

    private DatabaseHelper dbHelper;
    private SQLiteDatabase db;
}
