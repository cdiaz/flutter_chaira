package io.flutter.plugins.flutter_chaira

import android.app.Activity
import android.net.Uri
import android.support.customtabs.CustomTabsIntent
import android.content.Intent

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterChairaPlugin private constructor(private val registrar: Registrar) : MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_chaira")
      channel.setMethodCallHandler(FlutterChairaPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "bundleIdentifier") {
      result.success(registrar.context().getPackageName());
    } else if ( call.method == "showUrl") {
      handleShowUrl(call, result)
    } else {
      result.notImplemented()
    }
  }

  private fun handleShowUrl(call: MethodCall, result: Result) {
    @SuppressWarnings("unchecked")
    val arguments = call.arguments as Map<String, Object>
    val url = arguments["url"] as String
    val activity = registrar.activity()
    if (activity != null) {
      val builder: CustomTabsIntent.Builder = CustomTabsIntent.Builder()
      val customTabsIntent: CustomTabsIntent = builder.build()
      customTabsIntent.intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
      customTabsIntent.launchUrl(activity, Uri.parse(url))
    }
  }
}
