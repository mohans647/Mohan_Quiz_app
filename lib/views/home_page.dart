import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../services/utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/animation.json',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome to the Quiz App!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Test your knowledge and track your performance.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: appSecondaryColor),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => Get.toNamed('/quiz'),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  decoration: BoxDecoration(
                    color: appSecondaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    "Start Quiz",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
