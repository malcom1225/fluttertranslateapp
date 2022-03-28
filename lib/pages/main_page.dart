import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final translator = GoogleTranslator();

  late bool _isTranslate = false;
  late String _input = "";
  late String _result = "";

  void _translate(input) async {
    Translation translation = await translator.translate(input);
    String lang = translation.sourceLanguage.code;
    var result = await translator.translate(input, from: lang, to: "en");
    _result = result.text;
    debugPrint(_result);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Translator"),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Center(
                child: SizedBox(
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          _input = value;
                        },
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.book_sharp),
                          hintText: 'type something',
                          labelText: 'Input ',
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  _isTranslate = true;
                                  _translate(_input);
                                  setState(() {});
                                },
                                child: const Text("Translate")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.teal),
                                onPressed: () {
                                  _isTranslate = false;
                                  setState(() {});
                                },
                                child: const Text("clear")),
                          ],
                        ),
                      ),
                      Text(_isTranslate ? _result : "waiting for new text",
                          style: const TextStyle(
                              color: Colors.pink, fontSize: 30)),
                    ],
                  ),
                ),
              ),
            )));
  }
}
