import 'package:get/get.dart';

abstract class AbstractController extends GetxController {
  void init() {
    // Never call update() here
  }

  void reset() {
    // You can call update() here
  }
}
