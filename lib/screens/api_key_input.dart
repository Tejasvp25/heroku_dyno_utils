import 'package:flutter/material.dart';
import 'package:heroku_dyno_utils/utils/api_key_provider.dart';

class ApiKeyInput extends StatefulWidget {
  ApiKeyInput({
    Key key,
    @required this.apiKeyProvider,
  }) : super(key: key);

  final ApiKeyProvider apiKeyProvider;

  @override
  _ApiKeyInputState createState() => _ApiKeyInputState();
}

class _ApiKeyInputState extends State<ApiKeyInput> {
  final TextEditingController textController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heroku Dyno Utils"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: textController,
            ),
          ),
          RaisedButton(
            child: Text("Set Api Key"),
            onPressed: () {
              if (textController.text != "") {
                widget.apiKeyProvider.apiKey = textController.text;
              }
            },
          ),
          Container(
            child: Text(
              "API KEY CAN BE FOUND IN\nhttps://dashboard.heroku.com/account",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }
}
