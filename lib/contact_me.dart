import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
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
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Lottie.asset('assets/contactus.json'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextButton(
                          onPressed: () {
                            launchUrl(Uri.parse('mailto:abelbk06@gmail.com'));
                          },
                          child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black,
                              ),
                              child: Center(
                                child: Text("Contact me",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                              )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
