import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mohan_quizzes/services/utils/constants.dart';
import 'package:mohan_quizzes/splash_page.dart';
import 'package:mohan_quizzes/views/home_page.dart';
import 'controllers/quiz_controller.dart';
import 'views/quiz_page.dart';
import 'views/result_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    SplashPage(
      onInitializationComplete: () async {
        runApp(
          MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JosefinSans',
        useMaterial3: true,
        primarySwatch: appMaterialColor,
        scaffoldBackgroundColor: scaffoldColor,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/quiz', page: () => QuizPage()),
        GetPage(name: '/results', page: () => ResultPage()),
      ],
    );
  }
}
