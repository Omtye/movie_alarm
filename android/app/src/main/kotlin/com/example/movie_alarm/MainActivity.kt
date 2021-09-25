package com.example.movie_alarm

import io.flutter.embedding.android.FlutterActivity
import android.app.KeyguardManager
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true)
            setTurnScreenOn(true)
            window.addFlags(WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON)
        } else {
            window.addFlags(
                    WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED    // deprecated api 27
                            or WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD     // deprecated api 26
                            or WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON   // deprecated api 27
                            or WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON
            )
        }
        val keyguardMgr = getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            keyguardMgr.requestDismissKeyguard(this, null)
        }
    }
    //우선 주석처리
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
//            setShowWhenLocked(true)
//            setTurnScreenOn(true)
//            val keyguardManager = getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
//            keyguardManager.requestDismissKeyguard(this, null)
//        } else {
//            this.window.addFlags(WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD or
//                    WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
//                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON)
//        }
//    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
