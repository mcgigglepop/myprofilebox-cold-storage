package com.mcgigglepop.myprofilebox;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class RegisterActivity extends AppCompatActivity {
    DatabaseHelper databaseHelper;
    Button registerButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        final PinEntryEditText txtPinRegister = (PinEntryEditText) findViewById(R.id.txt_pin_register);

        databaseHelper = new DatabaseHelper(RegisterActivity.this);
        registerButton = (Button) findViewById(R.id.register_button);

        registerButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                databaseHelper.setPassword(txtPinRegister.getText().toString());
                Intent intent = new Intent(RegisterActivity.this, HomePage.class);
                startActivity(intent);
            }
        });
    }
}