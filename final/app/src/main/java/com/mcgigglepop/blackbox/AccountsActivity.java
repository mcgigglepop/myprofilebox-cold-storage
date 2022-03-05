package com.mcgigglepop.blackbox;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.SimpleCursorAdapter;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;
import com.mcgigglepop.blackbox.helpers.DatabaseHelperAccounts;

public class AccountsActivity extends AppCompatActivity {
    private DatabaseHelperAccounts dbHelper;
    private SimpleCursorAdapter dataAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_accounts);

        dbHelper = new DatabaseHelperAccounts(this);
        dbHelper.open();


    }
}