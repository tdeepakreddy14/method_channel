package com.example.watchlist;


import android.app.Application;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MyApplication extends Application {
    private FlutterEngine flutterEngine;

    @Override
    public void onCreate() {
        super.onCreate();
        flutterEngine = new FlutterEngine(this);
        // Initialize plugins if needed
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    public FlutterEngine getFlutterEngine() {
        return flutterEngine;
    }
}
