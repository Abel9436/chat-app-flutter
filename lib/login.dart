import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late ChatGpt chatGpt;
  bool showpassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  String errorText = '';
  String fullname = '';

  Future<String> login() async {
    setState(() {
      isLoading = true;
      errorText = '';
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      var userinfo =
          await FirebaseFirestore.instance.collection('User').doc().get();

      if (userinfo.exists) {
        setState(() {
          fullname = userinfo.get('Fullname');
        });
      }

      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorText = e.message ?? 'An error occurred';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    return fullname;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(screenWidth > 600 ? 80 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'lib/x.png',
                    width: screenWidth > 600 ? 250 : 150,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Center(
                  child: Text(
                    'W e l c o m e B a c k' + '\u{270C}',
                    style: TextStyle(
                        fontSize: screenWidth > 600 ? 30 : 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    'L o g i n',
                    style: TextStyle(
                        fontSize: screenWidth > 600 ? 37 : 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Username',
                    style: TextStyle(
                        fontSize: screenWidth > 600 ? 25 : 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter username',
                    fillColor: Color.fromARGB(255, 252, 252, 252),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                Text('Password',
                    style: TextStyle(
                        fontSize: screenWidth > 600 ? 25 : 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: password,
                  obscureText: showpassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: TextButton(
                      onPressed: () {
                        setState(() {
                          showpassword = !showpassword;
                        });
                      },
                      child: Icon(showpassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    hintText: 'Enter password',
                    fillColor: Color.fromARGB(255, 252, 252, 252),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  errorText,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: screenWidth > 600 ? 16 : 12,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Forgotpassword');
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                            fontSize: screenWidth > 600 ? 15 : 12,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 70, 66, 66)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: screenWidth > 600 ? 500 : double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : () => login(),
                    child: isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))
                        : Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth > 600 ? 20 : 16,
                                fontWeight: FontWeight.bold),
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Don't you have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth > 600 ? 15 : 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
