package com.udla.chaira

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.plugins.flutter_chaira.FlutterChairaPlugin
import com.udla.chaira.MainActivity

class HandleCallback: Activity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState?: Bundle())
    val intent = this.getIntent()
    val uri = intent.getData()
    val code = uri.getQueryParameter("code")
    val error = uri.getQueryParameter("error")
    FlutterChairaPlugin.resolveResponseType(code, error)
    val openMainActivity = Intent(this@HandleCallback, MainActivity::class.java)
    openMainActivity.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT)
    startActivityIfNeeded(openMainActivity, 0)
    this.finish()
  }
}