import 'package:get/get.dart';

abstract class AbstractController extends GetxController {
  void reset({bool doUpdate = true});

  void init() {
  }
}