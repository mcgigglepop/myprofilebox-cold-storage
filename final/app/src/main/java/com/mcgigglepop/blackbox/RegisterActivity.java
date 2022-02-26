package com.mcgigglepop.blackbox;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.mcgigglepop.blackbox.helpers.CustomEditText;
import com.mcgigglepop.blackbox.helpers.DatabaseHelper;
import com.mcgigglepop.blackbox.helpers.SharedPreferenceManager;

public class RegisterActivity extends AppCompatActivity {
    Button registerButton;
    DatabaseHelper databaseHelper;
    private SharedPreferenceManager prefManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        prefManager = new SharedPreferenceManager(this);
        super.onCreate(savedInstanceState);

        if (prefManager.getRegistered()) {
            startActivity(new Intent(RegisterActivity.this, AccountsActivity.class));
            finish();
        }

        setContentView(R.layout.activity_register);

        final CustomEditText editTextRegister = findViewById(R.id.edit_text_register);

        registerButton = (Button) findViewById(R.id.register_button);
        databaseHelper = new DatabaseHelper(RegisterActivity.this);

        registerButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(editTextRegister.getText().toString().length() != 6){
                    Toast.makeText(RegisterActivity.this, "Passcode must be 6 characters", Toast.LENGTH_LONG).show();
                }else{
                    prefManager.setRegistered(true);
                    databaseHelper.setPassword(editTextRegister.getText().toString());
                    startActivity(new Intent(RegisterActivity.this, AccountsActivity.class));
                    finish();
                }
            }
        });
    }
}