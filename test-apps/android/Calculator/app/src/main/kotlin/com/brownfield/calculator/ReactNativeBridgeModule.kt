package com.brownfield.calculator

import android.app.Activity
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

class ReactNativeBridgeModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "ReactNativeBridge"
    }

    @ReactMethod
    fun dismiss() {
        val activity: Activity? = currentActivity
        activity?.runOnUiThread {
            activity.finish()
        }
    }
}
