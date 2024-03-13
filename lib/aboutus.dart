import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  Widget lists(String imgurl, String text, String url) {
    return Center(
      child: TextButton(
        onPressed: () {
          switch (url) {
            case 'insta':
              launchUrl(Uri.parse(
                  'https://www.instagram.com/p/C0QszbxNAXa/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA=='));
            case 'github':
              launchUrl(Uri.parse('https://github.com/Abel9436'));
            case 'telegram':
              launchUrl(Uri.parse('https://t.me/AbelBekele07'));
            case 'youtube':
              launchUrl(Uri.parse('http://www.youtube.com/@AbelBekele07'));
          }
        },
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 224, 224, 224)),
          child: Image(
            image: AssetImage(imgurl),
            height: 50,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ))
                ],
              ),
              SizedBox(
                height: height / 13,
              ),
              Center(
                child: Text('Follow Me On These Platforms',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: height / 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  lists('assets/you.png', 'Follow Me On YouTube', 'youtube'),
                  lists('assets/git.png', 'Follow Me On Github', 'github'),
                  lists('assets/tele.png', 'Follow Me On Telegram', 'telegram'),
                  lists('assets/insta.png', 'Follow Me On Insta', 'insta'),
                ]),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Checkout My Portfolio',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://google.com'));
                },
                child: Lottie.asset(
                  'assets/portfolio.json',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
