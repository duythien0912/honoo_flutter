package com.example.honoo

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.Intent
import java.io.File
import androidx.core.content.FileProvider



class MainActivity: FlutterActivity() {
  private var shareChannel = "channel:honoo.share/share"
  override fun onCreate(savedInstanceState: Bundle?) {

    MethodChannel(this.flutterView,shareChannel).setMethodCallHandler { call, result ->
      if (call.method == "share") {



      } else {
        result.notImplemented()
      }

    }
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }

    private fun shareFile(path: String) {
    val imageFile = File(this.applicationContext.cacheDir, path)
    val contentUri = FileProvider.getUriForFile(this, "com.example.honoo", imageFile)
    val shareIntent = Intent(Intent.ACTION_SEND)
    shareIntent.type = "image/jpg"
    shareIntent.putExtra(Intent.EXTRA_STREAM, contentUri)
    this.startActivity(Intent.createChooser(shareIntent, "Share image using"))
  }
}


