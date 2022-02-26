package com.mcgigglepop.blackbox;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

import com.mcgigglepop.blackbox.helpers.DatabaseHelper;

public class LoginActivity extends AppCompatActivity {
    DatabaseHelper databaseHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        databaseHelper = new DatabaseHelper(LoginActivity.this);
    }
}