import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heroku_dyno_utils/screens/api_key_input.dart';
import 'package:heroku_dyno_utils/ui/app_list.dart';
import 'package:heroku_dyno_utils/ui/loading_widget.dart';
import 'package:heroku_dyno_utils/utils/api_key_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => decideRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingWidget(),
    );
  }

  void decideRoute() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Provider.of<ApiKeyProvider>(context).apiKey == ""
            ? ApiKeyInput(apiKeyProvider: Provider.of<ApiKeyProvider>(context))
            : AppList(
                Provider.of<ApiKeyProvider>(context).apiKey,
              ),
      ),
    );
  }
}
