import 'package:cli/widgets/chat_input_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';

class SectionTextInput extends StatefulWidget {
  const SectionTextInput({super.key});

  @override
  State<SectionTextInput> createState() => _SectionTextInputState();
}

class _SectionTextInputState extends State<SectionTextInput> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText, result;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (searchedText != null)
          MaterialButton(
              color: const Color.fromARGB(255, 0, 0, 0),
              onPressed: () {
                setState(() {
                  searchedText = null;
                  result = null;
                });
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(image: AssetImage('assets/man (2.png')),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' $searchedText',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              )),
        Expanded(
            child: loading
                ? Lottie.asset('assets/lottie/ai.json')
                : result != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Markdown(data: result!),
                      )
                    : const Center(
                        child: Text(
                        'Ask Anything',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
        ChatInputBox(
          controller: controller,
          onSend: () {
            if (controller.text.isNotEmpty) {
              searchedText = controller.text;
              controller.clear();
              loading = true;

              gemini.text(searchedText!).then((value) {
                result = value?.content?.parts?.last.text;
                loading = false;
              });
            }
          },
        ),
      ],
    );
  }
}
