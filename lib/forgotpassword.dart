import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FOrgotpass extends StatefulWidget {
  const FOrgotpass({Key? key});

  @override
  State<FOrgotpass> createState() => _FOrgotpassState();
}

class _FOrgotpassState extends State<FOrgotpass> {
  TextEditingController email = TextEditingController();
  String errorText = '';
  bool isLoading = false;

  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
      errorText = '';
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            icon: const Icon(
              Icons.email,
              size: 100,
              color: Color.fromARGB(255, 45, 67, 78),
            ),
            content: const Text(
              'Check your Email. We have sent you a reset link',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorText = e.message ?? 'An error occurred';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(screenWidth > 600 ? 80 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back))
                ],
              ),
              Center(
                child: Image.asset(
                  'lib/x.png',
                  width: screenWidth > 600 ? 250 : 150,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Please Enter your Email To Reset your Password',
                style: TextStyle(
                  fontSize: screenWidth > 600 ? 30 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter Your Email',
                  fillColor: Color.fromARGB(255, 98, 97, 97),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: screenWidth > 600 ? 500 : double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () => resetPassword(),
                  child: isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth > 600 ? 20 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 40, 128, 172),
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
              Text(
                '$errorText',
                style: TextStyle(color: Colors.red, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
