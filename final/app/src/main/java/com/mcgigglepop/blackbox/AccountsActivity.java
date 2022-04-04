package com.mcgigglepop.blackbox;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FilterQueryProvider;
import android.widget.ListView;
import android.widget.SimpleCursorAdapter;
import android.widget.Toast;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;
import com.mcgigglepop.blackbox.helpers.AESUtils;
import com.mcgigglepop.blackbox.helpers.DatabaseHelperAccounts;

public class AccountsActivity extends AppCompatActivity {
    private DatabaseHelperAccounts dbHelper;
    private SimpleCursorAdapter dataAdapter;
    Button createAccountButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_accounts);

        dbHelper = new DatabaseHelperAccounts(this);
        dbHelper.open();

        displayListView();
    }

    private void displayListView(){
        Cursor cursor = dbHelper.fetchAllAccounts();

        String[] columns = new String[] {
                DatabaseHelperAccounts.KEY_ACCOUNT_TYPE,
                DatabaseHelperAccounts.KEY_ACCOUNT_NAME,
                DatabaseHelperAccounts.KEY_USERNAME
        };

        int[] bound_fields = new int[] {
                R.id.account_type,
                R.id.account_name,
                R.id.username
        };

        dataAdapter = new SimpleCursorAdapter(
                this, R.layout.accounts_info,
                cursor,
                columns,
                bound_fields,
                0);

        ListView listView = (ListView) findViewById(R.id.listView1);
        listView.setAdapter(dataAdapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> listView, View view,
                                    int position, long id) {
                Cursor cursor = (Cursor) listView.getItemAtPosition(position);

                String account_type = cursor.getString(cursor.getColumnIndexOrThrow("account_type"));
                String account_name = cursor.getString(cursor.getColumnIndexOrThrow("account_name"));
                String username = cursor.getString(cursor.getColumnIndexOrThrow("username"));
                String password = cursor.getString(cursor.getColumnIndexOrThrow("password"));

                String decrypted = "";
                try {
                    decrypted = AESUtils.decrypt(password);
                } catch (Exception e){
                    e.printStackTrace();
                }

                Intent intent = new Intent(AccountsActivity.this, AccountDetails.class);
                Bundle b = new Bundle();
                b.putString("account_type", account_type);
                b.putString("account_name", account_name);
                b.putString("username", username);
                b.putString("password", decrypted);
                intent.putExtras(b); //Put your id to your next Intent
                startActivity(intent);
            }
        });

        EditText myFilter = (EditText) findViewById(R.id.myFilter);
        myFilter.addTextChangedListener(new TextWatcher() {

            public void afterTextChanged(Editable s) {
            }

            public void beforeTextChanged(CharSequence s, int start,
                                          int count, int after) {
            }

            public void onTextChanged(CharSequence s, int start,
                                      int before, int count) {
                dataAdapter.getFilter().filter(s.toString());
            }
        });

        dataAdapter.setFilterQueryProvider(new FilterQueryProvider() {
            public Cursor runQuery(CharSequence constraint) {
                return dbHelper.fetchAccountsByName(constraint.toString());
            }
        });

        createAccountButton = (Button) findViewById(R.id.create_account_button);
        createAccountButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(AccountsActivity.this, CreateAccountActivity.class));
            }
        });

    }

    public void onResume() {
        super.onResume();
        displayListView();
    }

}