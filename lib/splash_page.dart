

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mohan_quizzes/services/local_storage_service.dart';
import 'package:mohan_quizzes/services/utils/constants.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashPage({
    Key? key,
    required this.onInitializationComplete,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      _setup().then(
        (_) => widget.onInitializationComplete(),
      );
    });
  }

  Future<void> _setup() async {
    await Get.putAsync(() => LocalStorageService().init());

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor:appSecondaryColor,
        body: Container(
          decoration: const BoxDecoration(
            color: appSecondaryColor,
          ),
          child: Center(
            child: Text('Quiz App',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w600),)
          ),
        ),
      ),
    );
  }
}
