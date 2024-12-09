import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService extends GetxService {

  Future<LocalStorageService> init() async {
    return this;
  }


  Future<void> saveProgress(int questionIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quiz_progress', questionIndex);
  }

  Future<int> getProgress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('quiz_progress') ?? 0;
  }
}
