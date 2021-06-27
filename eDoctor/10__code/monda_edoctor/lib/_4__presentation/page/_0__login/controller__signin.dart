
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_0__infra/util/abstract_controller.dart';
import 'package:monda_edoctor/_0__infra/util/status_wrapper.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/User.dart';
import 'package:monda_edoctor/_3__service/service__account.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInController extends AbstractController {
  SignInController.newInstance();

  static SignInController get instance => Get.find();

  final loginForm = FormGroup({
    'username': FormControl(validators: [Validators.required]),
    'password': FormControl(validators: [Validators.required]),
  });

  bool progressDialogShow = false;

  @override
  void onInit() {
    super.onInit();
    reset(doUpdate: false);
  }

  @override
  void reset({bool doUpdate = true}) {
    this.progressDialogShow = false;
    this.loginForm.reset(value: {
      'username':'sachini410',
      'password':'123456789'
    });

    if(doUpdate) update();
  }

  void login() async {
    String username = loginForm.control('username').value;
    String password = loginForm.control('password').value;

    _changeProgressBarShow(true);

    StatusWrapper<LoginStatus, User, String> statusWrapper = await AccountService.instance.login(username: username, password: password);

    switch (statusWrapper.status) {
      case LoginStatus.SUCCESS:
        {
          _changeProgressBarShow(false);
          RouteNavigator.gotoHomePage();
          break;
        }
      case LoginStatus.ERROR:
        {
          AlertUtil.showMessage(statusWrapper.data != null ? statusWrapper.error.toString() : TextString.label__error);
          _changeProgressBarShow(false);
          break;
        }
      default:
        {
          _changeProgressBarShow(false);
          break;
        }
    }
  }

  void _changeProgressBarShow(bool progressDialogShow) {
    this.progressDialogShow = progressDialogShow;
    update();
  }
}
