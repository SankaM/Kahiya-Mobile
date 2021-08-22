
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/config.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_2__datasource/securestorage/secure_storage__user.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__progress_indicator_overlay.dart';
import 'package:monda_edoctor/_4__presentation/page/_5__account/controller__account.dart';
import 'package:monda_edoctor/_4__presentation/page/_5__account/controller__appointment_list.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AccountPage extends AbstractPageWithBackgroundAndContent {
  AccountPage() : super(
    title: 'Account Page',
    backgroundAsset: Asset.png__background04,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
    selectedIndexOfBottomNavigationBar: -1,
  );

  @override
  Widget constructContent(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _contentCustomAppBar(context),
          body: _contentBody(context),
        )),
        GetBuilder<AccountController>(
          builder: (c) {
            return Visibility(
              child: ProgressIndicatorOverlay(text: 'Loading',),
              visible: c.progressDialogShow,
            );
          },
        ),
      ],
    );
  }

  PreferredSize _contentCustomAppBar(BuildContext context) {
    return CustomAppBarBuilder.build(
      context: context,
      preferredSize: Size.fromHeight(ScreenUtil.heightInPercent(17.5)),
      firstLineLabel: Text('', style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL, color: Colors.black),),
      backButtonIcon: Icon(Icons.arrow_back, color: Style.colorPrimary, size: Style.iconSize_2XL,),
      showBackButton: true,
    );
  }

  Widget _contentBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.widthInPercent(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network(UserSecureStorage.instance.user!.imageUrl!, height: ScreenUtil.widthInPercent(30), width: ScreenUtil.widthInPercent(30), fit: BoxFit.cover,),
            ) ,
          ),
          SizedBox(height: ScreenUtil.heightInPercent(4),),
          Text('${UserSecureStorage.instance.user!.name}', style: Style.defaultTextStyle(color: Colors.grey[500]!, fontSize: Style.fontSize_XL, fontWeight: FontWeight.w500), ),
          if(UserSecureStorage.instance.user!.location != null) SizedBox(height: ScreenUtil.heightInPercent(2),),
          if(UserSecureStorage.instance.user!.location != null) Text('${UserSecureStorage.instance.user!.location}', style: Style.defaultTextStyle(color: Colors.grey[500]!, fontSize: Style.fontSize_Default), ),
          SizedBox(height: ScreenUtil.heightInPercent(5),),
          _item(context, label: 'Upcoming Appointment', icon: Icons.people_alt_outlined, onTap: () {
            RouteNavigator.gotoAppointmentPage(type: AppointmentListType.FUTURE);
          }),
          SizedBox(height: ScreenUtil.heightInPercent(1),),
          _item(context, label: 'Past Appointment', icon: Icons.people_alt_outlined, onTap: () {
            RouteNavigator.gotoAppointmentPage(type: AppointmentListType.PAST);
          }),
          SizedBox(height: ScreenUtil.heightInPercent(1),),
          _item(context, label: 'Update Profile', icon: Icons.people_alt_outlined, onTap: () {
            _showChangeProfileDialog(context);
          }),
          SizedBox(height: ScreenUtil.heightInPercent(1),),
          _item(context, label: 'Change Password', icon: Icons.lock_outline, onTap: () {
            _showChangePasswordDialog(context);
          }),
          SizedBox(height: ScreenUtil.heightInPercent(5),),
          _item(context, label: 'Logout', icon: Icons.exit_to_app, onTap: () {
            _showLogoutConfirmationDialog(context);
          }),
          Spacer(),
          Text('${Config.VERSION}', style: Style.defaultTextStyle(color: Colors.grey[400]!, fontSize: Style.fontSize_S),),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, {required IconData icon, required String label, required GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Style.colorPrimary.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(10),),
        ),
        child: ListTile(
          leading: Icon(icon, color: Style.colorPrimary, size: Style.iconSize_Default,),
          title: Text(label, style: Style.defaultTextStyle(color: Style.colorPrimary, fontSize: Style.fontSize_Default, fontWeight: FontWeight.w500),),
          trailing: Icon(Icons.chevron_right, color: Style.colorPrimary, size: Style.iconSize_Default,),
        ),
      )
    );
  }

  void _showChangeProfileDialog(BuildContext context) {
    AccountController.instance.loadDoctorProfile();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _UpdateProfileDialog();
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    AccountController.instance.resetChangePasswordForm();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _ChangePasswordDialog();
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _LogoutDialog();
      },
    );
  }
}

class _UpdateProfileDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    Widget changeButton = TextButton(
      child: Text("Change"),
      onPressed:  () {
        AccountController.instance.updateProfile();
      },
    );

    // set up the AlertDialog
    AlertDialog logoutDialog = AlertDialog(
      title: Text("Update Profile"),
      content: _form(context),
      actions: [
        cancelButton,
        changeButton,
      ],
    );

    return logoutDialog;
  }

  Widget _form(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(20),
      child: ReactiveForm(
        formGroup: AccountController.instance.updateDoctorProfileForm,
        child: ListView(
          children: [
            SizedBox(height: ScreenUtil.heightInPercent(2),),
            _input(context, formControlName: 'name', label: 'Doctor Name'),
            _input(context, formControlName: 'doctorCost', label: 'Doctor Cost'),
          ],
        ),
      ),
    );
  }

  Widget _input(BuildContext context, {required String formControlName, required String label}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil.heightInPercent(1)),
      child: ReactiveTextField(
        formControlName: formControlName,
        validationMessages: (control) => {
          'required': TextString.label__cannot_empty,
        },
        style: Style.defaultTextStyle(color: Style.colorPrimary),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Style.colorPrimary, fontWeight: FontWeight.w400),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Style.colorPrimary)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),
        ),
      ),
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget logoutButton = TextButton(
      child: Text("Logout"),
      onPressed:  () {
        AccountController.instance.logout();
      },
    );

    // set up the AlertDialog
    AlertDialog logoutDialog = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure to logout ?"),
      actions: [
        cancelButton,
        logoutButton,
      ],
    );

    return logoutDialog;
  }
}

class _ChangePasswordDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    Widget changeButton = TextButton(
      child: Text("Change"),
      onPressed:  () {
        AccountController.instance.changePassword();
      },
    );

    // set up the AlertDialog
    AlertDialog logoutDialog = AlertDialog(
      title: Text("Change Password"),
      content: _form(context),
      actions: [
        cancelButton,
        changeButton,
      ],
    );

    return logoutDialog;
  }
  
  Widget _form(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(30),
      child: ReactiveForm(
        formGroup: AccountController.instance.changePasswordForm,
        child: ListView(
          children: [
            SizedBox(height: ScreenUtil.heightInPercent(2),),
            _secretInput(context, formControlName: 'oldPassword', label: 'Old Password'),
            _secretInput(context, formControlName: 'newPassword', label: 'New Password'),
            _secretInput(context, formControlName: 'newPasswordRetype', label: 'New Password (Retype)'),
          ],
        ),
      ),
    );
  }

  Widget _secretInput(BuildContext context, {required String formControlName, required String label}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil.heightInPercent(1)),
      child: ReactiveTextField(
        formControlName: formControlName,
        obscureText: true,
        validationMessages: (control) => {
          'required': TextString.label__cannot_empty,
          'mustMatch': 'Must match with password above'
        },
        style: Style.defaultTextStyle(color: Style.colorPrimary),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Style.colorPrimary, fontWeight: FontWeight.w400),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Style.colorPrimary)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),
        ),
      ),
    );
  }
}
