package com.mcgigglepop.blackbox;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;

public class AccountDetails extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_account_details);
        Bundle b = getIntent().getExtras();
        String account_type, account_name, username, password = "";

        if(b != null) {
            account_name = b.getString("account_name");
            account_type = b.getString("account_type");
            username = b.getString("username");
            password = b.getString("password");
        }

    }
}
