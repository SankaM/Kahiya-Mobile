import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_1__model/inventoryBatch.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__counter.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__focus_button.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_circular_progress_indicator.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_reactive_date_picker_container.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_reactive_dropdown_field.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_reactive_text_field.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/controller__inventory_batch_update.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InventoryBatchUpdatePage extends AbstractPageWithBackgroundAndContent {
  InventoryBatchUpdatePage() : super(
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
    if(Get.arguments != null && Get.arguments['inventoryBatch'] != null && Get.arguments['inventoryBatch'] is InventoryBatch) {
      Inventory inventory = Get.arguments['inventory'];
      InventoryBatch inventoryBatch = Get.arguments['inventoryBatch'];
      InventoryBatchUpdateController.instance.initData(inventory: inventory, inventoryBatch: inventoryBatch);
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
      firstLineLabel: Text(TextString.label__update, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
      secondLineLabel: Text(TextString.label__drug, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
    );
  }

  Widget _contentBody(BuildContext context) {
    return GetBuilder<InventoryBatchUpdateController>(builder: (c) {
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
      child: _UpdateInventoryBatchForm(),
    );
  }
}

class _UpdateInventoryBatchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: InventoryBatchUpdateController.instance.updateForm,
      child: Container(
        height: ScreenUtil.heightInPercent(80),
        width: ScreenUtil.widthInPercent(80),
        child: ListView(
          children: [
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
              controller: StepCounterController(value: InventoryBatchUpdateController.instance.updateForm.control('unitCount').value, minValue: 0),
              width: double.infinity,
              height: ScreenUtil.heightInPercent(7),
              buttonWidth: ScreenUtil.widthInPercent(10),
              buttonHeight: ScreenUtil.heightInPercent(5),
              gap: ScreenUtil.widthInPercent(3),
              buttonTextStyle: Style.defaultTextStyle(fontSize: Style.iconSize_L, color: Style.colorPrimary),
              valueTextStyle: Style.defaultTextStyle(fontSize: Style.iconSize_S, color: Style.colorPrimary),
              onCounterValueChanged: (newValue) {
                InventoryBatchUpdateController.instance.changeUnitCount(newValue);
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
      InventoryBatchUpdateController.instance.submit();
    }

    return ReactiveFormConsumer(
      builder: (context, form, child) => FocusButton(
        height: ScreenUtil.heightInPercent(7),
        width: double.infinity,
        onTap: form.valid ? submit : null,
        label: 'Update',
      ),
    );
  }
}
