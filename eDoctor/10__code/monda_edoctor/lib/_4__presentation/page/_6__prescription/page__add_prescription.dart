
import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__focus_button.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__patient_name_section.dart';
import 'package:monda_edoctor/_4__presentation/page/_5__patient/controller__patient_register.dart';

class AddPrescriptionPage extends AbstractPageWithBackgroundAndContent {
  AddPrescriptionPage() : super(
    title: TextString.page_title__add_prescription,
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
      firstLineLabel: Text(TextString.label__add, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
      secondLineLabel: Text(TextString.label__prescription, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
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
      child: _AddPrescriptionForm()
    );
  }
}

class _AddPrescriptionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(80),
      child: ListView(
        children: [
          // ----- Patient Name
          Text(TextString.label__patients_name, style: TextStyle(color: Colors.grey[500]),),
          SizedBox(height: ScreenUtil.heightInPercent(3),),
          PatientNameSection(patientName: 'Linda Williams'),
          SizedBox(height: ScreenUtil.heightInPercent(5),),

          // ----- Diagnosis
          Text(TextString.label__diagnosis, style: TextStyle(color: Colors.grey[500]),),
          SizedBox(height: ScreenUtil.heightInPercent(3),),
          _DiagnosisDropdown(selectedValue: 1),
          SizedBox(height: ScreenUtil.heightInPercent(3),),
          _DiagnosisDropdown(selectedValue: 2),
          SizedBox(height: ScreenUtil.heightInPercent(3),),
          _DiagnosisDropdown(selectedValue: 3),
          SizedBox(height: ScreenUtil.heightInPercent(5),),

          // ----- Treatment
          Text(TextString.label__treatment, style: TextStyle(color: Colors.grey[500]),),
          SizedBox(height: ScreenUtil.heightInPercent(3),),
          _AddSinglePrescriptionBox(),
          SizedBox(height: ScreenUtil.heightInPercent(3),),
          _AddSinglePrescriptionBox(addMorePrescriptionBox: true,),
          SizedBox(height: ScreenUtil.heightInPercent(5),),

          // ----- Add Notes
          Text(TextString.label__add_notes, style: TextStyle(color: Colors.grey[500]),),
          SizedBox(height: ScreenUtil.heightInPercent(3),),
          TextFormField(
            minLines: 5,
            maxLines: 5,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide:BorderSide(color: Colors.grey,), borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.grey,), borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.grey,), borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(height: ScreenUtil.heightInPercent(5),),

          // ----- Buttons
          Container(
            height: ScreenUtil.heightInPercent(7),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(elevation: 0, tapTargetSize: MaterialTapTargetSize.shrinkWrap,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(TextString.label__attach_files, style: TextStyle(color: Colors.grey),),
                  SizedBox(width: ScreenUtil.widthInPercent(3),),
                  Icon(Icons.attach_file, color: Style.colorPrimary,),
                ],
              ),
            ),
          ),
          SizedBox(height: ScreenUtil.heightInPercent(3),),
          FocusButton(
            height: ScreenUtil.heightInPercent(7),
            width: double.infinity,
            onTap: () {},
            label: TextString.label__prescribe,
          ),

          // -----
          SizedBox(height: ScreenUtil.heightInPercent(25),),
        ],
      )
    );
  }
}



class _DiagnosisDropdown extends StatelessWidget {
  final int selectedValue;

  _DiagnosisDropdown({required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: selectedValue,
      items: [
        DropdownMenuItem<int>(value: 1, child: Text('Flu')),
        DropdownMenuItem<int>(value: 2, child: Text('Fever')),
        DropdownMenuItem<int>(value: 3, child: Text('Cough')),
      ],
      onChanged: (_) {},
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class _AddSinglePrescriptionBox extends StatelessWidget {
  final bool addMorePrescriptionBox;

  _AddSinglePrescriptionBox({this.addMorePrescriptionBox = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 3,child: _drugDropdown(context),),
            SizedBox(width: ScreenUtil.widthInPercent(3),),
            Expanded(flex: 2,child: _daysDropdown(context),),
          ],
        ),
        SizedBox(height: ScreenUtil.heightInPercent(1),),
        Row(
          children: [
            Expanded(flex: 2,child: _doseDropdown(context),),
            SizedBox(width: ScreenUtil.widthInPercent(3),),
            Expanded(flex: 3,child: _numberOfTimesDropdown(context),),
          ],
        ),
        SizedBox(height: ScreenUtil.heightInPercent(1),),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Style.colorPrimary,),
              child: Row(
                children: [
                  Text(TextString.label__add),
                  SizedBox(width: ScreenUtil.widthInPercent(3),),
                  Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(width: ScreenUtil.widthInPercent(3),),
            if(addMorePrescriptionBox) ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Style.colorPrimary.withOpacity(0.2), elevation: 0),
              child: Icon(Icons.add_box_outlined, color: Style.colorPrimary,),
            ),
            Spacer(),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(primary: Colors.white, elevation: 0),
              child: Icon(Icons.delete, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }

  Widget _drugDropdown(BuildContext context) {
    return DropdownButtonFormField<int>(
      hint: Text(TextString.label__drug),
      items: [
        DropdownMenuItem<int>(value: 1, child: Text('Drug 1')),
        DropdownMenuItem<int>(value: 2, child: Text('Drug 2')),
        DropdownMenuItem<int>(value: 3, child: Text('Drug 3')),
      ],
      onChanged: (_) {},
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _daysDropdown(BuildContext context) {
    return DropdownButtonFormField<int>(
      hint: Text(TextString.label__days),
      items: [
        DropdownMenuItem<int>(value: 1, child: Text('Day 1')),
        DropdownMenuItem<int>(value: 2, child: Text('Day 2')),
        DropdownMenuItem<int>(value: 3, child: Text('Day 3')),
      ],
      onChanged: (_) {},
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _doseDropdown(BuildContext context) {
    return DropdownButtonFormField<int>(
      hint: Text(TextString.label__dose),
      items: [
        DropdownMenuItem<int>(value: 1, child: Text('Dose 1')),
        DropdownMenuItem<int>(value: 2, child: Text('Dose 2')),
        DropdownMenuItem<int>(value: 3, child: Text('Dose 3')),
      ],
      onChanged: (_) {},
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _numberOfTimesDropdown(BuildContext context) {
    return DropdownButtonFormField<int>(
      hint: Text(TextString.label__no_of_times),
      items: [
        DropdownMenuItem<int>(value: 1, child: Text('1')),
        DropdownMenuItem<int>(value: 2, child: Text('2')),
        DropdownMenuItem<int>(value: 3, child: Text('3')),
      ],
      onChanged: (_) {},
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
