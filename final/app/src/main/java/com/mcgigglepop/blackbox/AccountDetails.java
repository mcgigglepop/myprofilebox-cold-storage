package com.mcgigglepop.blackbox;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

public class AccountDetails extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_account_details);
        Bundle b = getIntent().getExtras();
        String account_type = "";
        String account_name= "";
        String username = "";
        String password = "";
        TextView account_type_textview, account_name_textview, username_textview, password_textview;


        if(b != null) {
            account_name = b.getString("account_name");
            account_type = b.getString("account_type");
            username = b.getString("username");
            password = b.getString("password");
        }
        account_type_textview = (TextView) findViewById(R.id.account_type_textview);
        account_name_textview = (TextView) findViewById(R.id.account_name_textview);
        username_textview = (TextView) findViewById(R.id.username_textview);
        password_textview = (TextView) findViewById(R.id.password_textview);

        account_name_textview.setText(account_name);
        account_type_textview.setText(account_type);
        username_textview.setText(username);
        password_textview.setText(password);

    }

    public void onPause() {
        super.onPause();
        finish();
    }
}
