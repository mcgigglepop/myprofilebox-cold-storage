package com.mcgigglepop.myprofilebox;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

public class RegisterActivity extends AppCompatActivity {
    DatabaseHelper databaseHelper;
    Button registerButton;
    private PreferenceManager prefManager;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        prefManager = new PreferenceManager(this);
        if (prefManager.isRegistered()) {
            startActivity(new Intent(RegisterActivity.this, HomePage.class));
            finish();
        }

        setContentView(R.layout.activity_register);

        final PinEntryEditText txtPinRegister = (PinEntryEditText) findViewById(R.id.txt_pin_register);

        databaseHelper = new DatabaseHelper(RegisterActivity.this);
        registerButton = (Button) findViewById(R.id.register_button);

        registerButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(txtPinRegister.getText().toString().length() !=6){
                    Toast.makeText(RegisterActivity.this, "Passcode must be 6 characters", Toast.LENGTH_LONG).show();
                }else{
                    prefManager.setRegistered(true);
                    databaseHelper.setPassword(txtPinRegister.getText().toString());
                    Intent intent = new Intent(RegisterActivity.this, HomePage.class);
                    startActivity(intent);
                    finish();
                }
            }
        });
    }
}