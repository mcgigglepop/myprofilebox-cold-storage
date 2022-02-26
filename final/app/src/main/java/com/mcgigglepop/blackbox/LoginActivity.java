package com.mcgigglepop.blackbox;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.Toast;

import com.mcgigglepop.blackbox.helpers.CustomEditText;
import com.mcgigglepop.blackbox.helpers.DatabaseHelper;

public class LoginActivity extends AppCompatActivity {
    DatabaseHelper databaseHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        databaseHelper = new DatabaseHelper(LoginActivity.this);

        final CustomEditText editTextLogin =  findViewById(R.id.edit_text_login);
        editTextLogin.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                if (databaseHelper.checkPassword(s.toString())) {
                    Intent intent = new Intent(LoginActivity.this, AccountsActivity.class);
                    startActivity(intent);
                    finish();
                } else{
                    Toast.makeText(LoginActivity.this, "Incorrect Passcode", Toast.LENGTH_SHORT).show();
                    editTextLogin.setText(null);
                }
            }
        });
    }
}