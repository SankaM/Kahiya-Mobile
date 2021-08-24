
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_1__model/appointment.dart';
import 'package:monda_edoctor/_1__model/diagnosis.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_1__model/patient.dart';
import 'package:monda_edoctor/_3__service/service__prescription.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__appointment_info.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__focus_button.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_circular_progress_indicator.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__patient_name_section.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/controller__add_prescription.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
    if(Get.arguments != null && Get.arguments['patient'] != null) {
      Patient patient = Get.arguments['patient'];
      Appointment? appointment = Get.arguments['appointment'];

      AddPrescriptionController.instance.initData(patient: patient, appointment: appointment);
    }

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
    return GetBuilder<AddPrescriptionController>(builder: (c) {
      return Stack(
        children: [
          _mainLayer(context),
          Visibility(
            visible: c.progressDialogShow,
            child: MyCircularProgressIndicator(),
          )
        ],
      );
    });
  }

  Widget _mainLayer(BuildContext context) {
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
      child: GetBuilder<AddPrescriptionController>(
        builder: (c) {
          return _AddPrescriptionForm();
        },
      ),
    );
  }
}

class _AddPrescriptionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Patient patient = AddPrescriptionController.instance.patient!;

    List<Widget> children = [];

    // ----- Appointment
    if(AddPrescriptionController.instance.appointment != null) {
      children.add(AppointmentInfo(appointment: AddPrescriptionController.instance.appointment!),);
      children.add(SizedBox(height: ScreenUtil.heightInPercent(2),),);
    }

    // ----- Patient Name
    children.add(Text(TextString.label__patients_name, style: TextStyle(color: Colors.grey[500]),),);
    children.add(SizedBox(height: ScreenUtil.heightInPercent(3),),);
    children.add(PatientNameSection(patientName: '${patient.name}'),);
    children.add(SizedBox(height: ScreenUtil.heightInPercent(5),),);

    // ----- Diagnosis
    children.add(Text(TextString.label__diagnosis, style: TextStyle(color: Colors.grey[500]),),);
    children.add(SizedBox(height: ScreenUtil.heightInPercent(3),),);
    children.add(_DiagnosisDropdown(),);
    children.add(SizedBox(height: ScreenUtil.heightInPercent(5),),);

    // ----- Illness Severity
    children.add(Text('Illness Severity', style: TextStyle(color: Colors.grey[500]),),);
    children.add(SizedBox(height: ScreenUtil.heightInPercent(3),),);
    children.add(_IllnessSeverityDropdown(),);
    children.add(SizedBox(height: ScreenUtil.heightInPercent(5),),);

    // ----- Treatment
    children.add(Text(TextString.label__treatment, style: TextStyle(color: Colors.grey[500]),),);
    children.add(SizedBox(height: ScreenUtil.heightInPercent(3),),);
    AddPrescriptionController.instance.treatmentItemMap.forEach((key, treatmentItem) {
      children.add(_TreatmentItemWidget(keyOfTreatmentItemMap: key, treatmentItem: treatmentItem));
      children.add(SizedBox(height: ScreenUtil.heightInPercent(5),));
    });
    children.add(SizedBox(height: ScreenUtil.heightInPercent(5),),);


    // ----- Add Notes
    children.add(Text(TextString.label__add_notes, style: TextStyle(color: Colors.grey[500]),),);
    children.add(SizedBox(height: ScreenUtil.heightInPercent(3),),);
    children.add(TextFormField(
      minLines: 5,
      maxLines: 5,
      onChanged: (newNoteValue) {
        AddPrescriptionController.instance.notes = newNoteValue;
      },
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide:BorderSide(color: Colors.grey,), borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.grey,), borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.grey,), borderRadius: BorderRadius.circular(10)),
      ),
    ),);
    children.add(SizedBox(height: ScreenUtil.heightInPercent(5),),);

    // ----- Buttons
    children.add(_AttachmentButton());
    children.add(SizedBox(height: ScreenUtil.heightInPercent(3),),);
    children.add(FocusButton(
      height: ScreenUtil.heightInPercent(7),
      width: double.infinity,
      onTap: () {
        AddPrescriptionController.instance.prescribe();
      },
      label: TextString.label__prescribe,
    ),);
    children.add(SizedBox(height: ScreenUtil.heightInPercent(25),),);

    return Container(
      height: ScreenUtil.heightInPercent(80),
      child: ListView(children: children)
    );
  }
}

class _DiagnosisDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<AddPrescriptionController>(builder: (_) {
          return _dropDown(context);
        }),
        TextButton(
          onPressed: () {
            showNewDiagnosisDialog(context);
          },
          child: Text('New diagnosis'),
        ),
      ],
    );
  }

  Widget _dropDown(BuildContext context) {
    return DropdownSearch<Diagnosis>(
      selectedItem: AddPrescriptionController.instance.selectedDiagnosis,
      showSearchBox: true,
      mode: Mode.MENU,
      autoFocusSearchBox: true,
      isFilteredOnline: true,
      dialogMaxWidth: ScreenUtil.heightInPercent(50),
      maxHeight: ScreenUtil.heightInPercent(50),
      popupShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      dropdownSearchDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.widthInPercent(3), vertical: ScreenUtil.heightInPercent(1),),
        hintText: TextString.label__enter_name,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
      searchBoxDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.widthInPercent(3), vertical: ScreenUtil.heightInPercent(1),),
        border: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
      dropdownBuilder: (BuildContext context, Diagnosis? diagnosis, String s) {
        if(diagnosis != null) {
          return Text('${diagnosis.name}');
        } else {
          return Text(TextString.label__enter_name,);
        }
      },
      onFind: (String filter) async {
        if(filter.length >= 3) {
          var result = await PrescriptionService.instance.getDiagnosis(name: filter);
          return result.data!;
        }

        return [];
      },
      itemAsString: (diagnosis) {
        return '${diagnosis.name}';
      },
      onChanged: (Diagnosis? diagnosis) {
        if(diagnosis != null) {
          AddPrescriptionController.instance.changeDiagnosis(diagnosis);
        }
      },
    );
  }
  
  void showNewDiagnosisDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return _NewDiagnosisDialog();
      },
    );
  }
}

class _NewDiagnosisDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddPrescriptionController.instance.resetNewDiagnosisForm();
    
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    Widget changeButton = TextButton(
      child: Text("Create"),
      onPressed:  () {
        AddPrescriptionController.instance.createAndSelectDiagnosis();
      },
    );

    // set up the AlertDialog
    AlertDialog logoutDialog = AlertDialog(
      title: Text("New Diagnosis", style: Style.defaultTextStyle(color: Style.colorPrimary, fontSize: Style.fontSize_L),),
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
      height: ScreenUtil.heightInPercent(10),
      child: ReactiveForm(
        formGroup: AddPrescriptionController.instance.newDiagnosisForm,
        child: ReactiveTextField(
          formControlName: 'name',
          validationMessages: (control) => {
            'required': TextString.label__cannot_empty,
          },
          style: Style.defaultTextStyle(color: Style.colorPrimary, height: 1.25),
          decoration: InputDecoration(
            hintText: 'Diagnosis',
            hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Style.colorPrimary, fontWeight: FontWeight.w400),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Style.colorPrimary)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),
          ),
        ),
      ),
    );
  }
}

class _IllnessSeverityDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text('Illness Severity'),
      value: AddPrescriptionController.instance.illnessSeverity,
      items: [
        DropdownMenuItem<String>(value: 'LOW', child: Text('Low')),
        DropdownMenuItem<String>(value: 'MEDIUM', child: Text('Medium')),
        DropdownMenuItem<String>(value: 'HIGH', child: Text('High')),
      ],
      onChanged: (illnessSeverity) {
        if(illnessSeverity != null) {
          AddPrescriptionController.instance.illnessSeverity = illnessSeverity;
        }
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class _TreatmentItemWidget extends StatelessWidget {
  final int keyOfTreatmentItemMap;

  final TreatmentItem treatmentItem;

  _TreatmentItemWidget({required this.keyOfTreatmentItemMap, required this.treatmentItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _drugDropdown(context),
        SizedBox(height: ScreenUtil.heightInPercent(1),),
        Row(
          children: [
            Expanded(flex: 2, child: _daysDropdown(context),),
            SizedBox(width: ScreenUtil.widthInPercent(3),),
            Expanded(flex: 3, child: _numberOfTimesDropdown(context),),
          ],
        ),
        SizedBox(height: ScreenUtil.heightInPercent(1),),
        Row(
          children: [
            Expanded(flex: 2, child: _doseDropdown(context),),
            SizedBox(width: ScreenUtil.widthInPercent(3),),
            Expanded(flex: 3, child: _dosageRuleDropdown(context),),
          ],
        ),
        SizedBox(height: ScreenUtil.heightInPercent(1),),
        Row(
          children: [
            if(AddPrescriptionController.instance.isLastTreatmentItem(keyOfTreatmentItemMap)) _addTreatmentItem(),
            if(AddPrescriptionController.instance.treatmentItemMap.length > 1) Spacer(),
            if(AddPrescriptionController.instance.treatmentItemMap.length > 1) _removeTreatmentItem(),
          ],
        )
      ],
    );
  }

  Widget _addTreatmentItem() {
    return ElevatedButton(
      onPressed: () {
        AddPrescriptionController.instance.addTreatmentItem();
      },
      style: ElevatedButton.styleFrom(primary: Style.colorPrimary.withOpacity(0.2), elevation: 0),
      child: Icon(Icons.add_box_outlined, color: Style.colorPrimary,),
    );
  }

  Widget _removeTreatmentItem() {
    return OutlinedButton(
      onPressed: () {
        AddPrescriptionController.instance.removeTreatmentItem(keyOfTreatmentItemMap);
      },
      style: OutlinedButton.styleFrom(primary: Colors.white, elevation: 0),
      child: Icon(Icons.delete, color: Colors.grey),
    );
  }

  Widget _drugDropdown(BuildContext context) {
    return GetBuilder<AddPrescriptionController>(
      builder: (c) {
        if(c.availableInventoryList.length == 0) {
          return Center(child: Text('No Drug Data'),);
        }

        List<DropdownMenuItem<Inventory>> items = [];
        items.addAll(c.availableInventoryList.map((inventory) => DropdownMenuItem<Inventory>(value: inventory, child: Text(inventory.drug!.completeName))).toList());

        return DropdownButtonFormField<Inventory>(
          hint: Text(TextString.label__drug),
          value: AddPrescriptionController.instance.treatmentItemMap[keyOfTreatmentItemMap]!.inventory,
          items: items,
          onChanged: (inventory) {
            if(inventory != null) {
              AddPrescriptionController.instance.updateTreatmentItemInventory(keyOfTreatmentItemMap, inventory);
            }
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
    );
  }

  Widget _daysDropdown(BuildContext context) {
    return DropdownButtonFormField<int>(
      hint: Text(TextString.label__days),
      value: AddPrescriptionController.instance.treatmentItemMap[keyOfTreatmentItemMap]!.treatmentDays,
      items: [
        DropdownMenuItem<int>(value: 1, child: Text('1 Day')),
        DropdownMenuItem<int>(value: 2, child: Text('2 Days')),
        DropdownMenuItem<int>(value: 3, child: Text('3 Days')),
        DropdownMenuItem<int>(value: 4, child: Text('4 Days')),
        DropdownMenuItem<int>(value: 5, child: Text('5 Days')),
        DropdownMenuItem<int>(value: 6, child: Text('6 Days')),
        DropdownMenuItem<int>(value: 7, child: Text('7 Days')),
        DropdownMenuItem<int>(value: 8, child: Text('8 Days')),
        DropdownMenuItem<int>(value: 9, child: Text('9 Days')),
        DropdownMenuItem<int>(value: 10, child: Text('10 Days')),
        DropdownMenuItem<int>(value: 11, child: Text('11 Days')),
        DropdownMenuItem<int>(value: 12, child: Text('12 Days')),
        DropdownMenuItem<int>(value: 13, child: Text('13 Days')),
        DropdownMenuItem<int>(value: 14, child: Text('14 Days')),
      ],
      onChanged: (treatmentDays) {
        if(treatmentDays != null) {
          AddPrescriptionController.instance.updateTreatmentItemTreatmentDays(keyOfTreatmentItemMap, treatmentDays);
        }
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _doseDropdown(BuildContext context) {
    return DropdownButtonFormField<int>(
      hint: Text(TextString.label__dose),
      value: AddPrescriptionController.instance.treatmentItemMap[keyOfTreatmentItemMap]!.dosageCount,
      items: [
        DropdownMenuItem<int>(value: 1, child: Text('1 Dose')),
        DropdownMenuItem<int>(value: 2, child: Text('2 Doses')),
        DropdownMenuItem<int>(value: 3, child: Text('3 Doses')),
        DropdownMenuItem<int>(value: 4, child: Text('4 Doses')),
        DropdownMenuItem<int>(value: 5, child: Text('5 Doses')),
        DropdownMenuItem<int>(value: 6, child: Text('6 Doses')),
        DropdownMenuItem<int>(value: 7, child: Text('7 Doses')),
        DropdownMenuItem<int>(value: 8, child: Text('8 Doses')),
        DropdownMenuItem<int>(value: 9, child: Text('9 Doses')),
        DropdownMenuItem<int>(value: 10, child: Text('10 Doses')),
      ],
      onChanged: (dosageCount) {
        if(dosageCount != null) {
          AddPrescriptionController.instance.updateTreatmentItemDosageCount(keyOfTreatmentItemMap, dosageCount);
        }
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _numberOfTimesDropdown(BuildContext context) {
    return DropdownButtonFormField<int>(
      hint: Text(TextString.label__no_of_times),
      value: AddPrescriptionController.instance.treatmentItemMap[keyOfTreatmentItemMap]!.timesPerDay,
      items: [
        DropdownMenuItem<int>(value: 1, child: Text('1 time / day')),
        DropdownMenuItem<int>(value: 2, child: Text('2 times / day')),
        DropdownMenuItem<int>(value: 3, child: Text('3 times / day')),
        DropdownMenuItem<int>(value: 4, child: Text('4 times / day')),
        DropdownMenuItem<int>(value: 5, child: Text('5 times / day')),
        DropdownMenuItem<int>(value: 6, child: Text('6 times / day')),
        DropdownMenuItem<int>(value: 7, child: Text('7 times / day')),
        DropdownMenuItem<int>(value: 8, child: Text('8 times / day')),
        DropdownMenuItem<int>(value: 9, child: Text('9 times / day')),
        DropdownMenuItem<int>(value: 10, child: Text('10 times / day')),
      ],
      onChanged: (timesPerDay) {
        if(timesPerDay != null) {
          AddPrescriptionController.instance.updateTreatmentItemTimesPerDay(keyOfTreatmentItemMap, timesPerDay);
        }
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _dosageRuleDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text('Rule'),
      value: AddPrescriptionController.instance.treatmentItemMap[keyOfTreatmentItemMap]!.dosageRule,
      items: [
        DropdownMenuItem<String>(value: 'BEFORE_MEAL', child: Text('Before Meal')),
        DropdownMenuItem<String>(value: 'AFTER_MEAL', child: Text('After Meal')),
      ],
      onChanged: (dosageRule) {
        if(dosageRule != null) {
          AddPrescriptionController.instance.updateTreatmentItemDosageRule(keyOfTreatmentItemMap, dosageRule);
        }
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class _AttachmentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(AddPrescriptionController.instance.attachment == null) {
      return _attachFileWidget(context);
    } else {
      return _removeFileWidget(context);
    }
  }

  Widget _attachFileWidget(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(7),
      child: OutlinedButton(
        onPressed: () {
          AddPrescriptionController.instance.attachFile();
        },
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
    );
  }

  Widget _removeFileWidget(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(7),
      child: OutlinedButton(
        onPressed: () {
          AddPrescriptionController.instance.removeFile();
        },
        style: OutlinedButton.styleFrom(elevation: 0, tapTargetSize: MaterialTapTargetSize.shrinkWrap,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ScreenUtil.widthInPercent(60),
              child: Text('${AddPrescriptionController.instance.fileName}', style: TextStyle(color: Colors.grey), softWrap: false, overflow: TextOverflow.fade,),
            ),
            Spacer(),
            Icon(Icons.delete_forever, color: Style.colorPrimary,),
          ],
        ),
      ),
    );
  }
}