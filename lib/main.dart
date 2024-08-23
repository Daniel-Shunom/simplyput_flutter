import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'src/frontend/home.dart';
import 'src/frontend/navigation_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:simplyputapp/src/frontend/onboarding_screens/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAPwDazoMJq3VZhRiKzXaE8QC025vTUBtg",
            appId: "1:101001326959:web:d4b9817a39c8d67f07389a",
            messagingSenderId: "101001326959",
            projectId: "simplyput-flutter"));
  } else {
    Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationMenu(),
    );
  }
}

//void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  //final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  //await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  //runApp(NavigationMenu());
//}
