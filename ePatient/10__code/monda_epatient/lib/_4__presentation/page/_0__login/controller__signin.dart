import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_0__infra/util/abstract_controller.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_0__infra/util/util__alert.dart';
import 'package:monda_epatient/_1__model/user.dart';
import 'package:monda_epatient/_3__service/service__account.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInController extends AbstractController<_ViewState, _ViewReference, _ViewInput> {
  static SignInController get instance => Get.find();

  SignInController() {
    vState = _ViewState();
    vReference = _ViewReference();
    vInput = _ViewInput();
  }

  @override
  init({dynamic data}) {
    vState.reset();
    vReference.reset();
    vInput.reset();
  }

  void login() async {
    String username = vInput.loginForm.control('username').value;
    String password = vInput.loginForm.control('password').value;

    changeProgressBarShow(true);

    StatusWrapper<Status, User, String> statusWrapper = await AccountService.instance.login(username: username, password: password);

    switch (statusWrapper.status) {
      case Status.SUCCESS: {
        changeProgressBarShow(false);
        RouteNavigator.gotoHomePage();
        break;
      }
      case Status.ERROR: {
        AlertUtil.showMessage(statusWrapper.error != null ? statusWrapper.error.toString() : TextString.label__error);
        changeProgressBarShow(false);
        break;
      }
      default: {
        changeProgressBarShow(false);
        break;
      }
    }
  }
}

class _ViewState extends ViewState {}

class _ViewReference extends ViewReference {}

class _ViewInput extends ViewInput {
  final loginForm = FormGroup({
    'username': FormControl(validators: [Validators.required]),
    'password': FormControl(validators: [Validators.required]),
  });

  @override
  void reset() {
    this.loginForm.reset(value: {
      'username':'patient1',
      'password':'12341234'
    });
  }
}
