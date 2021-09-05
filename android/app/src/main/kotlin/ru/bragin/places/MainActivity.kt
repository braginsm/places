package ru.bragin.places

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setApiKey("dbffa052-8890-4d2c-bbb8-9732fbe5f6b9")
    super.configureFlutterEngine(flutterEngine)
  }
}
