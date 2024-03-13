import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  bool is_on_last_page = false;
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                is_on_last_page = (value == 2);
              });
            },
            controller: _controller,
            children: [
              Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Lottie.asset(
                            'assets/robot.json',
                            height: height - (height / 4),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, 0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Chat Master is a revolutionary chat app featuring ChatGPT and Gemini chat bots.',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Lottie.asset(
                            'assets/chatgpt.json',
                            height: height - (height / 6),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, 0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Offering a seamless blend of ChatGPT\'s natural language understanding',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Lottie.asset(
                            'assets/gemini.json',
                            height: height - (height / 6),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, -10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                              'Offering a seamless blend of Google Gemini\'s natural language and Image understanding',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              alignment: Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  !is_on_last_page
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              _controller.jumpToPage(2);
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(48)),
                            child: Center(
                              child: Icon(
                                Icons.skip_next_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ))
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              _controller.jumpToPage(2 - 1);
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(48)),
                            child: Center(
                              child: Icon(Icons.navigate_before_outlined,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  weight: 3),
                            ),
                          )),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                  ),
                  !is_on_last_page
                      ? TextButton(
                          onPressed: () {
                            _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(48)),
                            child: Center(
                              child: Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                              ),
                            ),
                          ))
                      : TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.circular(48)),
                            child: Center(
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                            ),
                          )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
