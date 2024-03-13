import 'package:cli/Gemini.dart';
import 'package:cli/aboutus.dart';
import 'package:cli/contact_me.dart';
import 'package:cli/forgotpassword.dart';
import 'package:cli/main.dart';
import 'package:cli/intro.dart';
import 'package:cli/verify_email.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cli/login.dart';
import 'package:cli/home.dart';
import 'package:cli/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(
      apiKey: 'API_KEY', enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ChatGpt chatGpt =
      ChatGpt(apiKey: 'API_KEY');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Intro(),
      initialRoute: '/',
      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        '/home': (context) => ChatCompletionPage(chatGpt: chatGpt),
        '/Forgotpassword': (context) => const FOrgotpass(),
        '/contact': (context) => const Contact(),
        '/verify': (context) => const VerifyEmailPage(),
        '/aboutus': (context) => const Aboutus(),
        '/gemini': (context) => const MyGemini()
      },
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key, required this.chatGpt});
  final ChatGpt chatGpt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const VerifyEmailPage();
          } else {
            return const Intro();
          }
        },
      ),
    );
  }
}
