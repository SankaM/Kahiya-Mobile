import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_0__infra/util/abstract_controller.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_0__infra/util/util__alert.dart';
import 'package:monda_epatient/_1__model/user.dart';
import 'package:monda_epatient/_3__service/service__account.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpController extends AbstractController<_ViewState, _ViewReference, _ViewInput> {
  static SignUpController get instance => Get.find();

  SignUpController() {
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

  void signup() async {
    String email = vInput.signUpForm.control('email').value;
    String username = vInput.signUpForm.control('username').value;
    String password = vInput.signUpForm.control('password').value;

    changeProgressBarShow(true);

    StatusWrapper<Status, User, String> statusWrapper = await AccountService.instance.signup(email: email, username: username, password: password);

    switch (statusWrapper.status) {
      case Status.SUCCESS: {
        changeProgressBarShow(false);
        AlertUtil.showMessage(statusWrapper.error != null ? statusWrapper.error.toString() : TextString.label__successfully_signup);
        RouteNavigator.gotoSignInPage();
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

class _ViewState extends ViewState {
  @override
  void reset() {
    progressDialogShow = false;
  }
}

class _ViewReference extends ViewReference {}

class _ViewInput extends ViewInput {
  final signUpForm = FormGroup({
    'email': FormControl(validators: [Validators.required, Validators.email]),
    'username': FormControl(validators: [Validators.required]),
    'password': FormControl(validators: [Validators.required]),
  });

  @override
  void reset() {
    this.signUpForm.reset(value: {
      'email': '',
      'username': '',
      'password': ''
    });
  }
}
