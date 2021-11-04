import 'package:get/get.dart';

abstract class AbstractController<S extends ViewState, R extends ViewReference, I extends ViewInput> extends GetxController {
  late S vState;

  late R vReference;

  late I vInput;



  void init({dynamic data}) {
  }

  void changeProgressBarShow(bool progressDialogShow) {
    vState.progressDialogShow = progressDialogShow;
    update();
  }
}

/// [ViewState] is data class that you put your presentation logic data.
abstract class ViewState {
  bool progressDialogShow = false;

  void reset() {
    progressDialogShow = false;
  }
}

/// [ViewReference] is data class that you put your reference data. Usually you
/// get reference data from API or database.
abstract class ViewReference {
  void reset() {}
}

/// [ViewInput] is data class that you put your every thing user input / key in.
abstract class ViewInput {
  void reset() {}
}
