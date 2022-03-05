package com.mcgigglepop.blackbox.helpers;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.database.SQLException;
import android.util.Log;

public class DatabaseHelperAccounts {

    public static final String KEY_ROWID = "rid";
    public static final String KEY_ACCOUNT_TYPE = "account_type";
    public static final String KEY_ACCOUNT_NAME = "account_name";
    public static final String KEY_USERNAME = "username";
    public static final String KEY_PASSWORD = "password";
    private static final String DATABASE_NAME = "table";
    private static final String SQLITE_TABLE = "records";
    private static final int DATABASE_VERSION =  1;
    private static final String TAG = "DatabaseHelperAccounts";

    private final Context context;

    private DatabaseHelper dbHelper;
    private SQLiteDatabase db;

    private static final String DATABASE_CREATE =
            "CREATE TABLE if not exists " + SQLITE_TABLE + " (" +
                    KEY_ROWID + " integer PRIMARY KEY autoincrement," +
                    KEY_ACCOUNT_TYPE + "," +
                    KEY_ACCOUNT_NAME + "," +
                    KEY_USERNAME + "," +
                    KEY_PASSWORD + "," + ");";

    private static class DatabaseHelper extends SQLiteOpenHelper {

        DatabaseHelper(Context context) {
            super(context, DATABASE_NAME, null, DATABASE_VERSION);
        }

        @Override
        public void onCreate(SQLiteDatabase db) {
            db.execSQL(DATABASE_CREATE);
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

    public long createAccount(String account_type, String account_name,
                              String username, String password) {

        ContentValues initialValues = new ContentValues();
        initialValues.put(KEY_ACCOUNT_TYPE, account_type);
        initialValues.put(KEY_ACCOUNT_NAME, account_name);
        initialValues.put(KEY_USERNAME, username);
        initialValues.put(KEY_PASSWORD, password);

        return db.insert(SQLITE_TABLE, null, initialValues);
    }

    public boolean deleteAllAccounts() {
        int doneDelete = 0;
        doneDelete = db.delete(SQLITE_TABLE, null , null);
        Log.w(TAG, Integer.toString(doneDelete));
        return doneDelete > 0;
    }

    public Cursor fetchAccountsByName(String inputText) throws SQLException {
        Log.w(TAG, inputText);
        Cursor mCursor = null;
        if (inputText == null  ||  inputText.length () == 0)  {
            mCursor = db.query(SQLITE_TABLE, new String[] {KEY_ROWID,
                            KEY_ACCOUNT_TYPE, KEY_ACCOUNT_NAME, KEY_USERNAME, KEY_PASSWORD},
                    null, null, null, null, null);

        }
        else {
            mCursor = db.query(true, SQLITE_TABLE, new String[] {KEY_ROWID,
                            KEY_ACCOUNT_TYPE, KEY_ACCOUNT_NAME, KEY_USERNAME, KEY_PASSWORD},
                    KEY_ACCOUNT_NAME + " like '%" + inputText + "%'", null,
                    null, null, null, null);
        }
        if (mCursor != null) {
            mCursor.moveToFirst();
        }
        return mCursor;
    }
}
