import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__string.dart';
import 'package:monda_edoctor/_1__model/drug.dart';
import 'package:monda_edoctor/_3__service/service__inventory.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__counter.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__focus_button.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_circular_progress_indicator.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_reactive_date_picker_container.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_reactive_dropdown_field.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_reactive_text_field.dart';
import 'package:monda_edoctor/_4__presentation/page/_3__inventory/controller__inventory_add.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddInventoryPage extends AbstractPageWithBackgroundAndContent {
  AddInventoryPage() : super(
    title: TextString.page_title__add_inventory,
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
      firstLineLabel: Text(TextString.label__add, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
      secondLineLabel: Text(TextString.label__inventory, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
    );
  }

  Widget _contentBody(BuildContext context) {
    return GetBuilder<AddInventoryController>(builder: (c) {
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
      height: ScreenUtil.heightInPercent(77.5),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(8)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
        color: Colors.white,
      ),
      child: _AddInventoryForm(),
    );
  }
}

class _AddInventoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: AddInventoryController.instance.addInventoryForm,
      child: Container(
        height: ScreenUtil.heightInPercent(80),
        width: ScreenUtil.widthInPercent(80),
        child: ListView(
          children: [
            // ----------
            // Drug
            // ----------
            Text(TextString.label__name_of_drug, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            DrugDropDownSearch(),
            SizedBox(height: ScreenUtil.heightInPercent(3),),

            // ----------
            // Buy Price & Currency
            // ----------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(TextString.label__buy_price, style: TextStyle(color: Colors.grey),),
                SizedBox(height: ScreenUtil.heightInPercent(1),),
                Row(
                  children: [
                    Container(
                      width: ScreenUtil.widthInPercent(30),
                      child: MyReactiveDropdownField<String>(
                        formControlName: 'unitBuyCurrency',
                        items: [
                          DropdownMenuItem<String>(value: 'SGD', child: Text('SGD'),),
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
                        formControlName: 'unitBuyPrice',
                        style: Style.defaultTextStyle(color: Style.colorPrimary),
                        contentPadding: EdgeInsets.symmetric(vertical: ScreenUtil.heightInPercent(3.5), horizontal: ScreenUtil.widthInPercent(4)),
                        hintText: TextString.label__enter_price,
                        iconData: Icons.monetization_on_outlined,
                        keyboardType: TextInputType.number,
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

            // ----------
            // Sell Price & Currency
            // ----------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(TextString.label__sell_price, style: TextStyle(color: Colors.grey),),
                SizedBox(height: ScreenUtil.heightInPercent(1),),
                Row(
                  children: [
                    Container(
                      width: ScreenUtil.widthInPercent(30),
                      child: MyReactiveDropdownField<String>(
                        formControlName: 'unitSellCurrency',
                        items: [
                          DropdownMenuItem<String>(value: 'SGD', child: Text('SGD'),),
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
                        formControlName: 'unitSellPrice',
                        style: Style.defaultTextStyle(color: Style.colorPrimary),
                        contentPadding: EdgeInsets.symmetric(vertical: ScreenUtil.heightInPercent(3.5), horizontal: ScreenUtil.widthInPercent(4)),
                        hintText: TextString.label__enter_price,
                        iconData: Icons.monetization_on_outlined,
                        keyboardType: TextInputType.number,
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

            // ----------
            // Drug Count
            // ----------
            Text(TextString.label__drug_count, style: TextStyle(color: Colors.grey),),
            SizedBox(height: ScreenUtil.heightInPercent(1),),
            StepCounter(
              controller: StepCounterController(value: 0, minValue: 0),
              width: double.infinity,
              height: ScreenUtil.heightInPercent(7),
              buttonWidth: ScreenUtil.widthInPercent(10),
              buttonHeight: ScreenUtil.heightInPercent(5),
              gap: ScreenUtil.widthInPercent(3),
              buttonTextStyle: Style.defaultTextStyle(fontSize: Style.iconSize_L, color: Style.colorPrimary),
              valueTextStyle: Style.defaultTextStyle(fontSize: Style.iconSize_S, color: Style.colorPrimary),
              onCounterValueChanged: (newValue) {
                AddInventoryController.instance.changeUnitCount(newValue);
              },
            ),
            SizedBox(height: ScreenUtil.heightInPercent(3),),

            // ----------
            // Batch Date & Expiry Date
            // ----------
            Row(
              children: [
                Container(
                    height: ScreenUtil.heightInPercent(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TextString.label__batch_date, style: TextStyle(color: Colors.grey),),
                        SizedBox(height: ScreenUtil.heightInPercent(1),),
                        Container(
                          width: ScreenUtil.widthInPercent(39),
                          child: MyReactiveDatePickerContainer(
                            formControlName: 'batchDate',
                            lastDate: DateTime.utc(2100),
                            fieldLabelText: TextString.label__batch_date,
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(width: ScreenUtil.widthInPercent(2),),
                Container(
                    height: ScreenUtil.heightInPercent(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TextString.label__expiry_date, style: TextStyle(color: Colors.grey),),
                        SizedBox(height: ScreenUtil.heightInPercent(1),),
                        Container(
                          width: ScreenUtil.widthInPercent(39),
                          child: MyReactiveDatePickerContainer(
                            formControlName: 'expiryDate',
                            lastDate: DateTime.utc(2100),
                            fieldLabelText: TextString.label__expiry_date,
                          ),
                        ),
                      ],
                    ),
                ),
              ],
            ),

            // -----
            _submitButton(context),

            // -----
            SizedBox(height: ScreenUtil.heightInPercent(20),),
          ],
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    submit() {
      AddInventoryController.instance.submit();
    }

    return ReactiveFormConsumer(
      builder: (context, form, child) => FocusButton(
        height: ScreenUtil.heightInPercent(7),
        width: double.infinity,
        onTap: form.valid ? submit : null,
        label: TextString.label__add_inventory,
      ),
    );
  }
}

class DrugDropDownSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Drug>(
      showSearchBox: true,
      mode: Mode.MENU,
      autoFocusSearchBox: true,
      isFilteredOnline: true,
      dialogMaxWidth: ScreenUtil.heightInPercent(50),
      maxHeight: ScreenUtil.heightInPercent(50),
      dropDownButton: Icon(FontAwesomeIcons.pills, color: Style.colorPrimary,),
      popupShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      dropdownSearchDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.widthInPercent(3), vertical: ScreenUtil.heightInPercent(1),),
        hintText: TextString.label__enter_name,
        filled: true,
        fillColor: Style.colorPrimary.withOpacity(0.2),
        focusColor: Style.colorPrimary.withOpacity(0.2),
        hintStyle: TextStyle(color: Style.colorPrimary),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
      ),
      searchBoxDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.widthInPercent(3), vertical: ScreenUtil.heightInPercent(1),),
        hintStyle: TextStyle(color: Style.colorPrimary),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
      ),
      searchBoxStyle: Style.defaultTextStyle(fontSize: Style.fontSize_Default, color: Style.colorPrimary),
      dropdownBuilder: (BuildContext context, Drug? drug, String s) {
        if(drug != null) {
          return Text('${drug.name} - ${StringUtil.capitalize(drug.type!)} (${drug.measurement} ${drug.measurementUnit!.toLowerCase()})',
              style: Style.defaultTextStyle(fontSize: Style.fontSize_Default, color: Style.colorPrimary));
        } else {
          return Text(TextString.label__enter_name, style: Style.defaultTextStyle(fontSize: Style.fontSize_Default, color: Style.colorPrimary),);
        }
      },
      onFind: (String filter) async {
        if(filter.length >= 3) {
          var result = await InventoryService.instance.getSearchDrug(name: filter);
          return result.data!;
        }

        return [];
      },
      itemAsString: (drug) {
        return '${drug.name} - ${StringUtil.capitalize(drug.type!)} (${drug.measurement} ${drug.measurementUnit!.toLowerCase()})';
      },
      onChanged: (Drug? drug) {
        if(drug != null) {
          AddInventoryController.instance.changeDrugId(drug.id);
        }
      },
    );
  }
}
