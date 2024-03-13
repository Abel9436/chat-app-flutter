import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:cli/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

class ChatCompletionPage extends StatefulWidget {
  final ChatGpt chatGpt;

  const ChatCompletionPage({Key? key, required this.chatGpt});

  @override
  State<ChatCompletionPage> createState() => _ChatCompletionPageState();
}

class _ChatCompletionPageState extends State<ChatCompletionPage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  late bool loading;
  String Useremail = '';
  String an = '';
  final testPrompt =
      'Which Disney character famously leaves a glass slipper behind at a royal ball?';

  final List<QuestionAnswer> questionAnswers = [];

  late TextEditingController textEditingController;

  StreamSubscription<CompletionResponse>? streamSubscription;
  StreamSubscription<StreamCompletionResponse>? chatStreamSubscription;
  Future<void> get() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await chatCollection
              .where('userEmail', isEqualTo: currentUser!.email)
              .orderBy('timestamp', descending: true)
              .get();
      print('email fetched');
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          Useremail = querySnapshot.docs.first.data()['userEmail'] as String;
        });
      }
    } catch (error) {
      print("Error fetching user email: $error");
    }
  }

  Future<void> saveChatToFirebase(String q, String a) async {
    if (currentUser == null) {
      print('Current user is null');
      return;
    }

    if (q.isEmpty || a.isEmpty) {
      print('Question or answer missing');
      return;
    }

    try {
      await chatCollection.add({
        'userEmail': currentUser!.email,
        'question': q,
        'answer': a.toString(), // Convert StringBuffer to String
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Chat saved to Firebase');
    } catch (e) {
      print('Error saving chat to Firebase: $e');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    return await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser!.email)
        .get();
  }

  CollectionReference<Map<String, dynamic>> get chatCollection =>
      FirebaseFirestore.instance.collection('chats');

  @override
  void initState() {
    get();
    textEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();

    chatStreamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    _copy(String str) {
      final value = ClipboardData(text: str);
      Clipboard.setData(value);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Text Copied'),
      ));
    }

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
                      Useremail,
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
              height: height / 2 - 30,
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Center(
          child: Text(
            "Chat GPT 4",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Lottie.asset('assets/error2.json'),
            );
          } else {
            if (snapshot.hasData) {
              ///Map<String, dynamic>? user = snapshot.data!.data();

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DefaultTextStyle(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: false,
                        totalRepeatCount: 5,
                        animatedTexts: [
                          TyperAnimatedText(
                            'If You Want To Lift Your Self Up Lift Up Someone Else',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: questionAnswers.length,
                        itemBuilder: (context, index) {
                          final questionAnswer = questionAnswers[index];
                          final answer =
                              questionAnswer.answer.toString().trim();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(48),
                                      ),
                                      child: const Image(
                                        image: AssetImage('assets/man (2).png'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color.fromARGB(
                                        255, 188, 188, 188),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      '${questionAnswer.question}',
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 103, 103, 103),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/ro.png'),
                                    ),
                                  ],
                                ),
                              ),
                              if (answer.isEmpty && loading)
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: const Color.fromARGB(
                                              255, 188, 188, 188),
                                        ),
                                        child: DefaultTextStyle(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: AnimatedTextKit(
                                              repeatForever: false,
                                              totalRepeatCount: 1,
                                              animatedTexts: [
                                                if (index ==
                                                    questionAnswers.length - 1)
                                                  TyperAnimatedText(answer,
                                                      speed: const Duration(
                                                          milliseconds: 10)),
                                                if (index !=
                                                    questionAnswers.length - 1)
                                                  TyperAnimatedText(answer,
                                                      speed: const Duration(
                                                          microseconds: 0)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              alignment: Alignment.bottomRight,
                                              onPressed: () {
                                                _copy(answer);
                                              },
                                              icon: const Icon(
                                                Icons.copy,
                                                color: Colors.black,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                            child: TextFormField(
                              maxLines: null,
                              minLines: null,
                              expands: true,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              controller: textEditingController,
                              decoration: const InputDecoration(
                                hintText: 'Ask Any Question..',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10,
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              onFieldSubmitted: (_) async {
                                final q = textEditingController.text;
                                QuestionAnswer questionAnswer;
                                String a;

                                setState(() {
                                  questionAnswer = questionAnswers.last;

                                  a = questionAnswer.answer.toString().trim();
                                  print(a);
                                  _sendChatMessage();

                                  // Save chat to Firebase
                                  ///saveChatToFirebase(q, an);
                                  //fetchChatsFromFirebase();
                                });

                                // Fetch chats from Firebase
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 55,
                          width: 60,
                          child: ClipOval(
                            child: Material(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              child: InkWell(
                                onTap: _sendChatMessage,
                                child: const SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
            return Container();
          }
        },
      ),
    );
  }

  Future<void> fetchChatsFromFirebase() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await chatCollection
              .where('userEmail', isEqualTo: currentUser!.email)
              .orderBy('timestamp', descending: true)
              .get();

      final List<QuestionAnswer> fetchedChats = querySnapshot.docs
          .map((doc) => QuestionAnswer(
                question: doc['question'] ?? '',
                answer: StringBuffer(doc['answer'] ?? ''),
              ))
          .toList();

      setState(() {
        questionAnswers.clear();

        questionAnswers.addAll(fetchedChats.reversed);
      });
    } catch (error) {
      print("Error fetching chats from Firebase: $error");
    }
  }

  _sendChatMessage() async {
    final question = textEditingController.text;
    setState(() {
      textEditingController.clear();
      loading = true;
      questionAnswers.add(
        QuestionAnswer(
          question: question,
          answer: StringBuffer(),
        ),
      );
    });
    final testRequest = ChatCompletionRequest(
        stream: true,
        maxTokens: 4000,
        messages: [
          Message(
            role: Role.user.name,
            content: question,
          )
        ],
        model: ChatGptModel.gpt35Turbo0301);
    await _chatStreamResponse(testRequest);

    setState(() => loading = false);
  }

  _chatStreamResponse(ChatCompletionRequest request) async {
    try {
      // Cancel the previous subscription if it exists
      chatStreamSubscription?.cancel();

      final stream = await widget.chatGpt.createChatCompletionStream(request);
      chatStreamSubscription = stream?.listen(
        (event) {
          setState(() {
            if (event.streamMessageEnd) {
              chatStreamSubscription?.cancel();
            } else {
              questionAnswers.last.answer.write(
                event.choices?.first.delta?.content,
              );
              setState(() {
                an = questionAnswers.last.answer.toString();
              });
            }
          });
        },
      );
    } catch (error) {
      setState(() {
        loading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('An Error Occured')));
      });
      print("Error occurred: $error");
    }
  }
}

class QuestionAnswer {
  final String question;
  final StringBuffer answer;

  QuestionAnswer({
    required this.question,
    required this.answer,
  });

  QuestionAnswer copyWith({
    String? newQuestion,
    StringBuffer? newAnswer,
  }) {
    return QuestionAnswer(
      question: newQuestion ?? question,
      answer: newAnswer ?? answer,
    );
  }
}
