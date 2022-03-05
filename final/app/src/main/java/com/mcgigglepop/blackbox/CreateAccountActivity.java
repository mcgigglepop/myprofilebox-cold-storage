package com.mcgigglepop.blackbox;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.mcgigglepop.blackbox.helpers.DatabaseHelperAccounts;

public class CreateAccountActivity extends AppCompatActivity {
    Button confirm_account;
    EditText account_type, account_name, username, password;
    private DatabaseHelperAccounts dbHelper;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_account);

        dbHelper = new DatabaseHelperAccounts(this);
        dbHelper.open();

        confirm_account = (Button) findViewById(R.id.confirm_create_account_button);

        account_type = (EditText) findViewById(R.id.account_type_edittext);
        account_name = (EditText) findViewById(R.id.account_name_edittext);
        username = (EditText) findViewById(R.id.account_username_edittext);
        password = (EditText) findViewById(R.id.account_password_edittext);

        confirm_account.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(account_type.getText().toString().length() <= 0){
                    Toast.makeText(CreateAccountActivity.this, "Account Type must not be empty", Toast.LENGTH_LONG).show();
                }
                else if(account_name.getText().toString().length() <= 0){
                    Toast.makeText(CreateAccountActivity.this, "Account Name must not be empty", Toast.LENGTH_LONG).show();
                }
                else if(username.getText().toString().length() <= 0){
                    Toast.makeText(CreateAccountActivity.this, "Username must not be empty", Toast.LENGTH_LONG).show();
                }
                else if(password.getText().toString().length() <= 0){
                    Toast.makeText(CreateAccountActivity.this, "Password must not be empty", Toast.LENGTH_LONG).show();
                }else{
                    //write to database and finish
                    dbHelper.createAccount(account_type.getText().toString(), account_name.getText().toString(), username.getText().toString(), password.getText().toString());
                    finish();
                }
            }
        });
    }
}