package tech.coolmathgames.wear_bridge

import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import androidx.wear.remote.interactions.RemoteActivityHelper
import com.google.common.util.concurrent.FutureCallback
import com.google.common.util.concurrent.Futures

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.guava.await

/** WearBridgePlugin */
class WearBridgePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var binding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wear_bridge")
    channel.setMethodCallHandler(this)
    binding = flutterPluginBinding
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "isWatch") {
      val isWatch = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT_WATCH) {
        binding.applicationContext.packageManager.hasSystemFeature(PackageManager.FEATURE_WATCH)
      } else {
        false
      }
      result.success(isWatch)
    } else if (call.method == "openUrl") {
      val remoteActivityHelper = RemoteActivityHelper(binding.applicationContext)
      val future = remoteActivityHelper.startRemoteActivity(
        Intent(Intent.ACTION_VIEW)
          .addCategory(Intent.CATEGORY_BROWSABLE)
          .setData(Uri.parse(call.arguments as String)),
      )
      Futures.addCallback(
        future,
        object : FutureCallback<Void> {
          override fun onSuccess(_result: Void?) {
            result.success(null)
          }
          override fun onFailure(t: Throwable) {
            result.error(t.javaClass.name, t.message, t.stackTraceToString())
          }
        },
        ContextCompat.getMainExecutor(binding.applicationContext)
      )
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
