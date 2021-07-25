
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__counter.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__focus_button.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_reactive_dropdown_field.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_reactive_text_field.dart';
import 'package:monda_edoctor/_4__presentation/page/_3__inventory/controller__inventory_add.dart';
import 'package:monda_edoctor/_4__presentation/page/_3__inventory/controller__inventory_update.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UpdateInventoryPage extends AbstractPageWithBackgroundAndContent {
  UpdateInventoryPage() : super(
    title: TextString.page_title__update_inventory,
    backgroundAsset: Asset.png__background03,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
    selectedIndexOfBottomNavigationBar: -1,
  );

  @override
  Widget constructContent(BuildContext context) {
    AddInventoryController.instance.reset();

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
      firstLineLabel: Text(TextString.label__update, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
      secondLineLabel: Text(TextString.label__drug, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
    );
  }

  Widget _contentBody(BuildContext context) {
    return Container(
        width: double.infinity,
        height: ScreenUtil.heightInPercent(77.5),
        padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(8)),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
          color: Colors.white,
        ),
        child: _UpdateInventoryForm(),
    );
  }
}

class _UpdateInventoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: UpdateInventoryController.instance.updateInventoryForm,
      child: Container(
        height: ScreenUtil.heightInPercent(80),
        width: ScreenUtil.widthInPercent(80),
        child: ListView(
          children: [
            // -----
            Text(TextString.label__name_of_drug, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            MyReactiveTextField(
              formControlName: 'nameOfDrug',
              hintText: 'Enter Name',
              iconData: FontAwesomeIcons.pills,
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
                        Text(TextString.label__type, style: TextStyle(color: Colors.grey),),
                        SizedBox(height: ScreenUtil.heightInPercent(1),),
                        Container(
                          width: ScreenUtil.widthInPercent(40),
                          child: MyReactiveDropdownField(
                            formControlName: 'typeOfDrug',
                            items: [
                              DropdownMenuItem<int>(value: -1, child: Text('Select'),),
                              DropdownMenuItem<int>(value: 1, child: Text('Type 1'),),
                              DropdownMenuItem<int>(value: 2, child: Text('Type 2'),),
                              DropdownMenuItem<int>(value: 3, child: Text('Type 3'),),
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
                        Text(TextString.label__mass, style: TextStyle(color: Colors.grey),),
                        SizedBox(height: ScreenUtil.heightInPercent(1),),
                        Container(
                          width: ScreenUtil.widthInPercent(40),
                          child: MyReactiveDropdownField(
                            formControlName: 'massOfDrug',
                            items: [
                              DropdownMenuItem<int>(value: -1, child: Text('Select'),),
                              DropdownMenuItem<int>(value: 1, child: Text('Mass 1'),),
                              DropdownMenuItem<int>(value: 2, child: Text('Mass 2'),),
                              DropdownMenuItem<int>(value: 3, child: Text('Mass 3'),),
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
            Text(TextString.label__expiry_drug, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            InkWell(
              onTap: () async {
                DateTime? newDateTime = await showRoundedDatePicker(
                  context: context,
                  height: ScreenUtil.heightInPercent(30),
                  theme: ThemeData(primaryColor: Style.colorPrimary, primaryColorBrightness: Brightness.dark),
                  styleDatePicker: MaterialRoundedDatePickerStyle(
                    textStyleDayHeader: TextStyle(color: Style.colorPrimary),
                    colorArrowNext: Style.colorPrimary,
                    colorArrowPrevious: Style.colorPrimary,
                    decorationDateSelected: BoxDecoration(
                      color: Style.colorPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyleButtonNegative: TextStyle(color: Style.colorPrimary),
                    textStyleButtonPositive: TextStyle(color: Style.colorPrimary),
                  ),
                );
              },
              child: Container(
                height: ScreenUtil.heightInPercent(7),
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil.widthInPercent(3)),
                decoration: BoxDecoration(
                  color: Style.colorPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Style.colorPrimary.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Text('Select', style: Style.defaultTextStyle(color: Style.colorPrimary),),
                    Spacer(),
                    FaIcon(FontAwesomeIcons.calendar, color: Style.colorPrimary, size: Style.iconSize_Default,),
                  ],
                ),
              ),
            ),
            SizedBox(height: ScreenUtil.heightInPercent(3),),

            // -----
            Text(TextString.label__drug_count, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            StepCounter(
              controller: StepCounterController(value: 0, minValue: 0),
              width: double.infinity,
              height: ScreenUtil.heightInPercent(7),
              buttonWidth: ScreenUtil.widthInPercent(10),
              buttonHeight: ScreenUtil.heightInPercent(5),
              gap: ScreenUtil.widthInPercent(10),
              buttonTextStyle: Style.defaultTextStyle(fontSize: Style.iconSize_L, color: Style.colorPrimary),
              valueTextStyle: Style.defaultTextStyle(fontSize: Style.iconSize_Default, color: Style.colorPrimary),
              onCounterValueChanged: (newValue) {

              },
            ),
            SizedBox(height: ScreenUtil.heightInPercent(3),),

            // -----
            Text(TextString.label__add_image, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            Container(
              height: ScreenUtil.heightInPercent(7),
              child: DottedBorder(
                color: Style.colorPrimary.withOpacity(0.8),
                strokeWidth: 1,
                dashPattern: [5, 5],
                radius: Radius.circular(10),
                borderType: BorderType.RRect,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: double.infinity,
                    color: Style.colorPrimary.withOpacity(0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(TextString.label__select_file, style: Style.defaultTextStyle(color: Style.colorPrimary),),
                        SizedBox(width: ScreenUtil.widthInPercent(5),),
                        FaIcon(FontAwesomeIcons.image, color: Style.colorPrimary, size: Style.iconSize_Default,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: ScreenUtil.heightInPercent(3),),

            // -----
            FocusButton(
              height: ScreenUtil.heightInPercent(7),
              width: double.infinity,
              onTap: () {},
              label: TextString.label__update_drug,
            ),
            SizedBox(height: ScreenUtil.heightInPercent(3),),

            // -----
            FocusButton(
              height: ScreenUtil.heightInPercent(7),
              width: double.infinity,
              onTap: () {},
              label: TextString.label__delete_drug,
              backgroundColor: Colors.white,
              borderColor: Colors.grey[300]!,
              shadowColor: Colors.white,
              textColor: Colors.grey,
            ),

            // -----
            SizedBox(height: ScreenUtil.heightInPercent(20),),
          ],
        ),
      ),
    );
  }
}
