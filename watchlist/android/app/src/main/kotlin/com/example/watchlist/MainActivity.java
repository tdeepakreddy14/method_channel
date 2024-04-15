package com.example.watchlist;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import androidx.appcompat.app.AppCompatActivity;


import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    private static final String CHANNEL = "login_channel";
    private EditText usernameEditText;
    private EditText passwordEditText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        // Initialize UI elements
        usernameEditText = findViewById(R.id.usernameEditText);
        passwordEditText = findViewById(R.id.passwordEditText);
        Button loginButton = findViewById(R.id.loginButton);

        // Set click listener for login button
        loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String username = usernameEditText.getText().toString();
                String password = passwordEditText.getText().toString();

                // Perform login validation
                boolean success = performLogin(username, password);

                // Return result back to Flutter
                Map<String, Object> result = new HashMap<>();
                result.put("success", success);
                FlutterEngine flutterEngine = ((MyApplication) getApplication()).getFlutterEngine();
                MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
                methodChannel.invokeMethod("login", result);
            }
        });
    }

    private boolean performLogin(String username, String password) {
        // Your login logic goes here
        // For demo purposes, let's consider a simple hardcoded check
        return "admin".equals(username) && "password".equals(password);
    }
}
