import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/theme.dart';
import 'features/auth/presentation/pages/agree_to_terms_page.dart';
import 'firebase_options.dart';
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Whatsapp Clone',
      home: const SafeArea(child: AgreeToTermsPage()),
      theme: ThemeData(
        textTheme: textTheme(),
      ),
    );
  }
}
