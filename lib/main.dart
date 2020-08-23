import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heroku_dyno_utils/screens/SplashScreen.dart';
import 'package:heroku_dyno_utils/utils/api_key_provider.dart';
import 'package:heroku_dyno_utils/utils/preferences.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiKeyProvider apiKeyProvider = ApiKeyProvider();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => apiKeyProvider,
      child: Consumer<ApiKeyProvider>(
        builder: (BuildContext ctx, ApiKeyProvider value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            theme: ThemeData(primarySwatch: Colors.red),
          );
        },
      ),
    );
  }

  Future<void> init() async {
    apiKeyProvider.apiKey = await Preferences.getApikey();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
