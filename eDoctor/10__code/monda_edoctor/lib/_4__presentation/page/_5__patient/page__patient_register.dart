import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__focus_button.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_reactive_dropdown_field.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_reactive_text_field.dart';
import 'package:monda_edoctor/_4__presentation/page/_5__patient/controller__patient_register.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterPatientPage extends AbstractPageWithBackgroundAndContent {
  RegisterPatientPage() : super(
    title: TextString.page_title__register_patient,
    backgroundAsset: Asset.png__background03,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
    selectedIndexOfBottomNavigationBar: -1,
  );

  @override
  Widget constructContent(BuildContext context) {
    PatientRegisterController.instance.reset();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _contentCustomAppBar(context),
      body: _contentBody(context),
    );
  }

  PreferredSize _contentCustomAppBar(BuildContext context) {
    return CustomAppBarBuilder.build(
      context: context,
      preferredSize: Size.fromHeight(ScreenUtil.heightInPercent(22.5)),
      firstLineLabel: Text(TextString.label__register, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
      secondLineLabel: Text(TextString.label__patient, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
    );
  }

  Widget _contentBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(8)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Style.colorPrimary.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: _PatientRegistrationForm()
    );
  }
}

class _PatientRegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: PatientRegisterController.instance.patientRegistrationForm,
      child: Container(
        height: ScreenUtil.heightInPercent(80),
        width: ScreenUtil.widthInPercent(80),
        child: ListView(
          children: [
            // -----
            Text(TextString.label__first_name, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            MyReactiveTextField(
              formControlName: 'firstName',
              hintText: TextString.label__enter_first_name,
              iconData: Icons.person,
              validationMessages: (control) => {
                'required': TextString.label__required,
              },
            ),
            SizedBox(height: ScreenUtil.heightInPercent(2),),

            // -----
            Text(TextString.label__last_name, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            MyReactiveTextField(
              formControlName: 'lastName',
              hintText: TextString.label__enter_last_name,
              iconData: Icons.person,
              validationMessages: (control) => {
                'required': TextString.label__required,
              },
            ),
            SizedBox(height: ScreenUtil.heightInPercent(2),),

            // -----
            Row(
              children: [
                Container(
                  height: ScreenUtil.heightInPercent(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TextString.label__age, style: TextStyle(color: Colors.grey),),
                      SizedBox(height: ScreenUtil.heightInPercent(1),),
                      Container(
                        width: ScreenUtil.widthInPercent(40),
                        child: MyReactiveDropdownField(
                          formControlName: 'age',
                          items: [
                            DropdownMenuItem<int>(value: -1, child: Text('Select'),),
                            DropdownMenuItem<int>(value: 10, child: Text('10'),),
                            DropdownMenuItem<int>(value: 11, child: Text('11'),),
                            DropdownMenuItem<int>(value: 12, child: Text('12'),),
                            DropdownMenuItem<int>(value: 13, child: Text('13'),),
                          ],
                          validationMessages: (control) => {
                            'required': TextString.label__required,
                          },
                        ),
                      ),
                    ],
                  )
                ),
                Spacer(),
                Container(
                    height: ScreenUtil.heightInPercent(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TextString.label__gender, style: TextStyle(color: Colors.grey),),
                        SizedBox(height: ScreenUtil.heightInPercent(1),),
                        Container(
                          width: ScreenUtil.widthInPercent(40),
                          child: MyReactiveDropdownField(
                            formControlName: 'gender',
                            items: [
                              DropdownMenuItem<String>(value: 'M', child: Text('Male'),),
                              DropdownMenuItem<String>(value: 'F', child: Text('Female'),),
                            ],
                            validationMessages: (control) => {
                              'required': TextString.label__required,
                            },
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),

            // -----
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(TextString.label__mobile, style: TextStyle(color: Colors.grey),),
                SizedBox(height: ScreenUtil.heightInPercent(1),),
                Row(
                  children: [
                    Container(
                      width: ScreenUtil.widthInPercent(30),
                      child: MyReactiveDropdownField(
                        formControlName: 'phoneCountryCode',
                        prefixText: TextString.label__code,
                        items: [
                          DropdownMenuItem<String>(value: '+1', child: Text('+1'),),
                          DropdownMenuItem<String>(value: '+62', child: Text('+62'),),
                        ],
                        validationMessages: (control) => {
                          'required': TextString.label__required,
                        },
                      ),
                    ),
                    SizedBox(width: ScreenUtil.widthInPercent(1),),
                    Container(
                      width: ScreenUtil.widthInPercent(50),
                      child: MyReactiveTextField(
                        formControlName: 'phoneNumber',
                        hintText: TextString.label__enter_number,
                        iconData: Icons.phone,
                        validationMessages: (control) => {
                          'required': TextString.label__required,
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: ScreenUtil.heightInPercent(3),),

            // -----
            Text(TextString.label__optional, style: TextStyle(color: Colors.grey, fontSize: Style.fontSize_XL),),
            SizedBox(height: ScreenUtil.heightInPercent(2),),

            // -----
            Text(TextString.label__username, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            MyReactiveTextField(
              formControlName: 'username',
              hintText: TextString.label__enter_username,
              iconData: Icons.person,
              validationMessages: (control) => {
              },
            ),
            SizedBox(height: ScreenUtil.heightInPercent(2),),

            // -----
            Text(TextString.label__email, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            MyReactiveTextField(
              formControlName: 'email',
              hintText: TextString.label__enter_email,
              iconData: Icons.mail,
              validationMessages: (control) => {
              },
            ),
            SizedBox(height: ScreenUtil.heightInPercent(2),),

            // -----
            Text(TextString.label__nic, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            MyReactiveTextField(
              formControlName: 'nic',
              hintText: TextString.label__enter_nic_number,
              iconData: Icons.assignment,
              validationMessages: (control) => {
              },
            ),
            SizedBox(height: ScreenUtil.heightInPercent(5),),

            // -----
            _submitButton(context),

            // -----
            SizedBox(height: ScreenUtil.heightInPercent(20),),
          ],
        ),
      )
    );
  }

  Widget _submitButton(BuildContext context) {
    return FocusButton(
      height: ScreenUtil.heightInPercent(7),
      width: double.infinity,
      onTap: () {
        log('=================================== submit button clicked');
      },
      label: TextString.label__submit,
    );
  }
}
