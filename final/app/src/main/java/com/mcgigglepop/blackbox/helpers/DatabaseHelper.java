package com.mcgigglepop.blackbox.helpers;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class DatabaseHelper extends SQLiteOpenHelper {

    private static final String DATABASE_NAME = "table.db";
    private static final int DATABASE_VERSION =  1;
    private final Context context;
    private static final String DATABASE_PATH = "/data/data/com.mcgigglepop.blackbox/databases/";
    private static final String USER_TABLE = "user";

    SQLiteDatabase db;

    public DatabaseHelper(Context context){
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
        this.context = context;
        createDb();
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {

    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {

    }

    public void createDb(){
        boolean dbExist = checkDbExist();
        if(!dbExist){
            this.getReadableDatabase();
            copyDatabase();
        }
    }

    private boolean checkDbExist(){
        SQLiteDatabase sqLiteDatabase = null;
        try{
            String path = DATABASE_PATH + DATABASE_NAME;
            sqLiteDatabase = SQLiteDatabase.openDatabase(path, null, SQLiteDatabase.OPEN_READONLY);
        } catch(Exception e){

        }
        if(sqLiteDatabase != null){
            sqLiteDatabase.close();
            return true;
        }
        return false;
    }

    private void copyDatabase(){
        try{
            InputStream inputStream = context.getAssets().open(DATABASE_NAME);
            String outFileName = DATABASE_PATH + DATABASE_NAME;
            OutputStream outputStream = new FileOutputStream(outFileName);

            byte[] b = new byte[1024];
            int length;

            while((length = inputStream.read(b)) > 0){
                outputStream.write(b, 0, length);
            }

            outputStream.flush();
            outputStream.close();
            inputStream.close();

        }catch(IOException e){
            e.printStackTrace();
        }
    }

    private SQLiteDatabase openDatabase(){
        String path = DATABASE_PATH + DATABASE_NAME;
        db = SQLiteDatabase.openDatabase(path, null, SQLiteDatabase.OPEN_READWRITE);
        return db;
    }

    public void close(){
        if(db != null){
            db.close();
        }
    }

    public void setPassword(String password){
        db = openDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put("username", "admin");
        contentValues.put("password", password);
        db.insert(USER_TABLE, null, contentValues);

        close();
    }

    public boolean checkPassword(String password){
        String username = "admin";
        db = openDatabase();
        String selection = "username = ? and password = ?";
        String[] selectionArgs = {username, password};
        Cursor cursor = db.query(USER_TABLE, null, selection, selectionArgs, null, null, null);
        int count = cursor.getCount();
        cursor.close();

        close();

        if(count > 0){
            return true;
        }else{
            return false;
        }
    }
}
