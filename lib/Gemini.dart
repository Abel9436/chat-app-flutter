import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:cli/aboutus.dart';
import 'package:cli/contact_me.dart';
import 'package:cli/forgotpassword.dart';
import 'package:cli/home.dart';
import 'package:cli/login.dart';
import 'package:cli/sections/text_and_image.dart';
import 'package:cli/sections/text_only.dart';
import 'package:cli/signup.dart';
import 'package:cli/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MyGemini extends StatelessWidget {
  const MyGemini({super.key});

  @override
  Widget build(BuildContext context) {
    late ChatGpt chatGpt =
        ChatGpt(apiKey: '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');
    return MaterialApp(
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
      title: 'Google Gemini',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 0, 0)),
          cardTheme: CardTheme(color: const Color.fromARGB(255, 0, 0, 0))),
      home: const MyHomePage(),
    );
  }
}

class SectionItem {
  final int index;
  final String title;
  final Widget widget;

  SectionItem(this.index, this.title, this.widget);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItem = 0;
  late ChatGpt chatGpt =
      ChatGpt(apiKey: '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');
  final _sections = <SectionItem>[
    SectionItem(0, 'Text and Image Prompt', const SectionTextAndImageInput()),
    SectionItem(1, 'Google Gemini Text Only', const SectionTextInput()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        surfaceTintColor: Colors.white,
        width: MediaQuery.of(context).size.width / 1.3,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      height: 60,
                      width: 60,
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/man (2).png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ])
                ],
              ),
              decoration: const BoxDecoration(color: Colors.black),
            ),
            const SizedBox(
              height: 18,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const ListTile(
                leading: Icon(Icons.home),
                title: Text('H O M E'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gemini');
              },
              child: const ListTile(
                leading: Icon(Icons.star_border_outlined),
                title: Text('G E M I N I'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/aboutus');
              },
              child: const ListTile(
                leading: Icon(Icons.padding),
                title: Text('A B O U T U S'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/contact');
              },
              child: const ListTile(
                leading: Icon(Icons.contact_support),
                title: Text('C O N T A C T U S'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Share.share('com.example.cli');
              },
              child: const ListTile(
                leading: Icon(Icons.share),
                title: Text('S H A R E'),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2 - 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: const ListTile(
                        leading: Icon(
                          Icons.logout_outlined,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        title: Text(
                          'L O G O U T',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                    _selectedItem == 0
                        ? 'Google Gemini Text and Image'
                        : _sections[_selectedItem].title,
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            iconSize: 30,
            iconColor: Color.fromARGB(255, 255, 255, 255),
            initialValue: _selectedItem,
            onSelected: (value) => setState(() => _selectedItem = value),
            itemBuilder: (context) => _sections.map((e) {
              return PopupMenuItem<int>(value: e.index, child: Text(e.title));
            }).toList(),
            child: const Icon(Icons.more_vert_rounded),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedItem,
        children: _sections.map((e) => e.widget).toList(),
      ),
    );
  }
}
