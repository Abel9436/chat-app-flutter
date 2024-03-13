import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:cli/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  late ChatGpt chatGpt =
      ChatGpt(apiKey: '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');
  bool muser = true;
  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    muser = user!.emailVerified;
  }

  Future<void> _sendVerificationEmail() async {
    try {
      if (!muser) {
        final user = _auth.currentUser!;
        await user.sendEmailVerification();
        await user.reload();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'Verification email sent!',
        )));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  @override
  Widget build(BuildContext context) => muser
      ? ChatCompletionPage(
          chatGpt: chatGpt,
        )
      : Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _sendVerificationEmail();
                          },
                          icon: Icon(Icons.arrow_back))
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  if (user != null && !user!.emailVerified)
                    Text("Verification email sent to ${user!.email}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Container(
                      child: Lottie.asset('assets/sendmail.json'),
                    ),
                  ),
                  if (user != null && user!.emailVerified)
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Container(
                        child: Lottie.asset('assets/emailverified.json'),
                      ),
                    ),
                  TextButton(
                    onPressed: () => _sendVerificationEmail(),
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.black),
                          child: Center(
                              child: Text(
                            'Resend Verification Email',
                            style: TextStyle(color: Colors.white),
                          ))),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
}
