package com.mcgigglepop.blackbox.helpers;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.database.SQLException;

public class DatabaseHelperAccounts {

    public static final String KEY_ROWID = "_id";
    public static final String KEY_ACCOUNT_TYPE = "atype";
    public static final String KEY_ACCOUNT_NAME = "aname";
    public static final String KEY_USERNAME = "username";
    public static final String KEY_PASSWORD = "password";
    private static final String DATABASE_NAME = "table";
    private static final String SQLITE_TABLE = "records";
    private static final int DATABASE_VERSION =  1;
    private static final String TAG = "DatabaseHelperAccounts";

    private final Context context;

    private DatabaseHelper dbHelper;
    private SQLiteDatabase db;

    private static class DatabaseHelper extends SQLiteOpenHelper {

        DatabaseHelper(Context context) {
            super(context, DATABASE_NAME, null, DATABASE_VERSION);
        }

        @Override
        public void onCreate(SQLiteDatabase db) {
        }

        @Override
        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            onCreate(db);
        }
    }

    public DatabaseHelperAccounts(Context context) {
        this.context = context;
    }

    public DatabaseHelperAccounts open() throws SQLException {
        dbHelper = new DatabaseHelper(context);
        db = dbHelper.getWritableDatabase();
        return this;
    }

    public void close() {
        if (dbHelper != null) {
            dbHelper.close();
        }
    }
}
