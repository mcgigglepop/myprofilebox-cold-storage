package com.mcgigglepop.blackbox;

import androidx.appcompat.app.AppCompatActivity;

import android.database.Cursor;
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
    }
}