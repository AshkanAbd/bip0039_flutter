import 'package:bip39/bip0039/mnemonic.dart';
import 'package:bip39/bip0039/utils.dart';
import 'package:bip39/bip0039/word_count.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Widget mainWidget;
  Mnemonic? mnemonic;
  String? seed;
  var textFieldController = TextEditingController();

  _MyAppState() {
    mainWidget = menu();
  }

  Widget recoverEntropy() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                color: Colors.black87,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                child: const Text(
                  "Entropy:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  controller: textFieldController,
                  maxLines: 3,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.black87,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                child: const Text(
                  "Phrases:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  mnemonic == null ? "  " : mnemonic!.getPhrases(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.black87,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                child: const Text(
                  "Seed:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  seed == null ? " " : seed!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                width: 170,
                child: MaterialButton(
                  padding: const EdgeInsets.all(20),
                  onPressed: () async {
                    try {
                      mnemonic = await Mnemonic.fromEntropy(fromHex(textFieldController.value.text));
                      seed = toHex(await mnemonic!.getSeed());
                    } catch (e) {
                      seed = "Invalid phrase...";
                    }

                    var widget = recoverEntropy();
                    setState(() {
                      mainWidget = widget;
                    });
                  },
                  color: Colors.black45,
                  textColor: Colors.white,
                  child: const Text("Calculate"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0, bottom: 10),
                width: 170,
                child: MaterialButton(
                  padding: const EdgeInsets.all(20),
                  onPressed: () {
                    setState(() {
                      mainWidget = menu();
                    });
                  },
                  color: Colors.black45,
                  textColor: Colors.white,
                  child: const Text("Back"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget recoverPhrase() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                color: Colors.black87,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                child: const Text(
                  "Phrases:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  controller: textFieldController,
                  maxLines: 3,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.black87,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                child: const Text(
                  "Entropy:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  mnemonic == null ? "  " : toHex(mnemonic!.getEntropy()),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.black87,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                child: const Text(
                  "Seed:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  seed == null ? " " : seed!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                width: 170,
                child: MaterialButton(
                  padding: const EdgeInsets.all(20),
                  onPressed: () async {
                    try {
                      mnemonic = await Mnemonic.fromPhrase(textFieldController.value.text);
                      seed = toHex(await mnemonic!.getSeed());
                    } catch (e) {
                      seed = "Invalid phrase...";
                    }

                    var widget = recoverPhrase();
                    setState(() {
                      mainWidget = widget;
                    });
                  },
                  color: Colors.black45,
                  textColor: Colors.white,
                  child: const Text("Calculate"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0, bottom: 10),
                width: 170,
                child: MaterialButton(
                  padding: const EdgeInsets.all(20),
                  onPressed: () {
                    setState(() {
                      mainWidget = menu();
                    });
                  },
                  color: Colors.black45,
                  textColor: Colors.white,
                  child: const Text("Back"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> generateMnemonic() async {
    mnemonic = await Mnemonic.generate(WordCount.word12());
    seed = toHex(await mnemonic!.getSeed());
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 50, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              color: Colors.black87,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              child: const Text(
                "Phrases:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                mnemonic!.getPhrases(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.black87,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              child: const Text(
                "Entropy:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                toHex(mnemonic!.getEntropy()),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.black87,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              child: const Text(
                "Seed:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                seed!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: 170,
              child: MaterialButton(
                padding: const EdgeInsets.all(20),
                onPressed: () async {
                  var widget = await generateMnemonic();
                  setState(() {
                    mainWidget = widget;
                  });
                },
                color: Colors.black45,
                textColor: Colors.white,
                child: const Text("Regenerate"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0, bottom: 10),
              width: 170,
              child: MaterialButton(
                padding: const EdgeInsets.all(20),
                onPressed: () {
                  setState(() {
                    mainWidget = menu();
                  });
                },
                color: Colors.black45,
                textColor: Colors.white,
                child: const Text("Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menu() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: 170,
            child: MaterialButton(
              padding: const EdgeInsets.all(20),
              color: Colors.black45,
              textColor: Colors.white,
              onPressed: () async {
                var widget = await generateMnemonic();
                setState(() {
                  mainWidget = widget;
                });
              },
              child: const Text(
                "Generate phrases",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: 170,
            child: MaterialButton(
              padding: const EdgeInsets.all(20),
              color: Colors.black45,
              textColor: Colors.white,
              onPressed: () {
                textFieldController.clear();
                mnemonic = null;
                seed = null;
                var widget = recoverPhrase();
                setState(() {
                  mainWidget = widget;
                });
              },
              child: const Text("Recover phrases"),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: 170,
            child: MaterialButton(
              padding: const EdgeInsets.all(20),
              color: Colors.black45,
              textColor: Colors.white,
              onPressed: () {
                textFieldController.clear();
                mnemonic = null;
                seed = null;
                var widget = recoverEntropy();
                setState(() {
                  mainWidget = widget;
                });
              },
              child: const Text("Recover entropy"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BIP 0039 Demo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black, secondaryHeaderColor: Colors.black45),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          shadowColor: Colors.black38,
          title: const Text("BIP 0039 Demo App"),
        ),
        body: mainWidget,
      ),
    );
  }
}
