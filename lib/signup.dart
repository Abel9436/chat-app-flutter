import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool showpassword = true;
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  void signup() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Center(child: CircularProgressIndicator()),
        );
      },
    );

    if (fullname.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        password.text == confirm_password.text) {
      try {
        CollectionReference Users =
            FirebaseFirestore.instance.collection('User');
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              icon: Icon(
                Icons.email,
                size: 100,
                color: Color.fromARGB(255, 45, 67, 78),
              ),
              content: Text(
                'Check your Email . We Have Sent you aVerification  link  You have 3 minutes to verify !',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/verify');
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

        await Users.add({
          'Fullname': fullname.text.trim(),
          'Email': email.text.trim(),
        });

        Navigator.pop(context); // Close the loading dialog
      } catch (e) {
        Navigator.pop(context); // Close the loading dialog
        print("Error during signup: $e");
        // Handle signup error if needed
      }
    } else {
      Navigator.pop(context); // Close the loading dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                    'W E L C O M E !  ' + '\u{270B}',
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 30 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'S I G N U P',
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 37 : 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: fullname,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.man),
                    hintText: 'Enter Your Full name',
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
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter Your Email',
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
                      child: Icon(Icons.remove_red_eye_sharp),
                    ),
                    hintText: 'Enter Password',
                    fillColor: Color.fromARGB(255, 252, 252, 252),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: confirm_password,
                  obscureText: showpassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: TextButton(
                      onPressed: () {
                        setState(() {
                          showpassword = !showpassword;
                        });
                      },
                      child: Icon(Icons.remove_red_eye_sharp),
                    ),
                    hintText: 'Confirm Password',
                    fillColor: Color.fromARGB(255, 252, 252, 252),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: screenWidth > 600 ? 500 : double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      signup();
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth > 600 ? 20 : 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                    Text("Do you have an account ? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth > 600 ? 15 : 12,
                          fontWeight: FontWeight.bold,
                        ),
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
