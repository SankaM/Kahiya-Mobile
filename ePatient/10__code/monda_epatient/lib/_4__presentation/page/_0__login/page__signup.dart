import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_epatient/_4__presentation/common/widget__monda_logo.dart';
import 'package:monda_epatient/_4__presentation/page/_0__login/controller__signup.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignupPage extends AbstractPageWithBackgroundAndContent {
  SignupPage() : super(
    title: TextString.page_title__sign_up,
    backgroundAsset: Asset.png__background01,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
    selectedIndexOfBottomNavigationBar: -1,
  );

  @override
  Widget constructContent(BuildContext context) {
    SignUpController.instance.init();
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(ScreenUtil.widthInPercent(8)),
      child: ReactiveForm(
        formGroup: SignUpController.instance.vInput.signUpForm,
        child: ListView(
          children: [
            MondaLogo(sideLength: ScreenUtil.heightInPercent(15)),
            SizedBox(height: ScreenUtil.heightInPercent(4),),
            _signUpLabelSection(context),
            SizedBox(height: ScreenUtil.heightInPercent(2),),
            _emailSection(context),
            SizedBox(height: ScreenUtil.heightInPercent(2),),
            _usernameSection(context),
            SizedBox(height: ScreenUtil.heightInPercent(2),),
            _passwordSection(context),
            SizedBox(height: ScreenUtil.heightInPercent(3),),
            _signUpButton(context),
            _signInInfoSection(context),
            SizedBox(height: ScreenUtil.heightInPercent(10),),
          ],
        ),
      ),
    );
  }

  Widget _signUpLabelSection(BuildContext context) {
    return Text(TextString.label__sign_up, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: Style.fontSize_3XL, color: Colors.deepOrange[400], letterSpacing: 2),);
  }

  Widget _emailSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Style.colorPrimary.withOpacity(0.25),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.widthInPercent(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TextString.label__email, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.white),),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),
            // Container(
            //   child: TextFormField(
            //     style: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
            //     cursorColor: Colors.white,
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.email, color: Colors.white, size: Style.iconSize_Default,),
            //       prefixText: '|  ',
            //       prefixStyle: TextStyle(fontSize: Style.fontSize_XL, color: Colors.white, fontWeight: FontWeight.w400),
            //       hintText: TextString.label__enter_email,
            //       hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
            //       filled: true,
            //       fillColor: Style.colorPrimary,
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //         borderSide: BorderSide.none,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              child: ReactiveTextField(
                formControlName: 'email',
                validationMessages: (control) => {
                  'required': TextString.label__cannot_empty,
                },
                style: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.white, size: Style.iconSize_Default,),
                  prefixText: '|  ',
                  prefixStyle: TextStyle(fontSize: Style.fontSize_XL, color: Colors.white, fontWeight: FontWeight.w400),
                  hintText: TextString.label__enter_email,
                  hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Style.colorPrimary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _usernameSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Style.colorPrimary.withOpacity(0.25),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.widthInPercent(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TextString.label__username, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.white),),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),
            // Container(
            //   child: TextFormField(
            //     style: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
            //     cursorColor: Colors.white,
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.person, color: Colors.white, size: Style.iconSize_Default,),
            //       prefixText: '|  ',
            //       prefixStyle: TextStyle(fontSize: Style.fontSize_XL, color: Colors.white, fontWeight: FontWeight.w400),
            //       hintText: TextString.label__enter_username,
            //       hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
            //       filled: true,
            //       fillColor: Style.colorPrimary,
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //         borderSide: BorderSide.none,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              child: ReactiveTextField(
                formControlName: 'username',
                validationMessages: (control) => {
                  'required': TextString.label__cannot_empty,
                },
                style: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.white, size: Style.iconSize_Default,),
                  prefixText: '|  ',
                  prefixStyle: TextStyle(fontSize: Style.fontSize_XL, color: Colors.white, fontWeight: FontWeight.w400),
                  hintText: TextString.label__enter_username,
                  hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Style.colorPrimary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.25),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.widthInPercent(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TextString.label__password, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.white,),),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),
            // Container(
            //   child: TextFormField(
            //     obscureText: true,
            //     cursorColor: Colors.white,
            //     style: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.lock, color: Colors.white, size: Style.iconSize_Default,),
            //       prefixText: '|  ',
            //       prefixStyle: TextStyle(fontSize: Style.fontSize_XL, color: Colors.white, fontWeight: FontWeight.w400),
            //       hintText: TextString.label__enter_password,
            //       hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
            //       filled: true,
            //       fillColor: Colors.green.withOpacity(0.5),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //         borderSide: BorderSide.none,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              child: ReactiveTextField(
                formControlName: 'password',
                validationMessages: (control) => {
                  'required': TextString.label__cannot_empty,
                },
                obscureText: true,
                cursorColor: Colors.white,
                style: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.white, size: Style.iconSize_Default,),
                  prefixText: '|  ',
                  prefixStyle: TextStyle(fontSize: Style.fontSize_XL, color: Colors.white, fontWeight: FontWeight.w400),
                  hintText: TextString.label__enter_password,
                  hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    // return Container(
    //   height: ScreenUtil.heightInPercent(7),
    //   width: double.infinity,
    //   child: InkWell(
    //     onTap: () {
    //       RouteNavigator.gotoHomePage();
    //     },
    //     child: Container(
    //       height: double.infinity,
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //           color: Style.colorPrimary,
    //           border: Border.all(
    //             color: Style.colorPrimary,
    //           ),
    //           borderRadius: BorderRadius.all(Radius.circular(10))
    //       ),
    //       child: Row(
    //         children: [
    //           Expanded(child: Container(), flex: 1,),
    //           Expanded(child: Text(TextString.label__register, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 3),), flex: 2,),
    //           Expanded(child: Icon(Icons.arrow_right_alt, color: Colors.white,), flex: 1,),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    _signup() {
      SignUpController.instance.signup();
    }

    return Container(
      height: ScreenUtil.heightInPercent(7),
      width: double.infinity,
      child: ReactiveFormConsumer(
        builder: (context, form, child) {
          return Container(
            height: 35,
            width: double.infinity,
            child: InkWell(
              onTap: form.valid ? _signup : null,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Style.colorPrimary,
                  border: Border.all(color: Style.colorPrimary,), borderRadius: BorderRadius.all(Radius.circular(10),),),
                child: Row(
                  children: [
                    Expanded(child: Container(), flex: 1,),
                    Expanded(child: Text(TextString.label__register, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 3),), flex: 2,),
                    Expanded(child: Icon(Icons.arrow_right_alt, color: Colors.white,), flex: 1,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _signInInfoSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(TextString.label__already_a_member, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Style.colorPrimary),),
        TextButton(
          onPressed: () {
            RouteNavigator.gotoSignInPage();
          },
          child: Text(TextString.page_title__sign_in, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Style.colorPrimary, fontWeight: FontWeight.w600),),),
      ],
    );
  }
}
