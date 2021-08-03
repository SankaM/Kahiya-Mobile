import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__string.dart';
import 'package:monda_edoctor/_1__model/drug.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_circular_progress_indicator.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/controller__inventory_detail.dart';

class DetailInventoryPage extends AbstractPageWithBackgroundAndContent {
  DetailInventoryPage() : super(
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
    if(Get.arguments != null && Get.arguments['inventoryId'] != null) {
      String inventoryId = Get.arguments['inventoryId'];
      DetailInventoryController.instance.retrieveInventory(inventoryId: inventoryId);
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
      firstLineLabel: Text(TextString.label__detail, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
      secondLineLabel: Text(TextString.label__inventory, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
    );
  }

  Widget _contentBody(BuildContext context) {
    return GetBuilder<DetailInventoryController>(builder: (c) {
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
    if(DetailInventoryController.instance.inventory == null) {
      return Container();
    }

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
      child: Visibility(
        visible: DetailInventoryController.instance.inventory != null && !DetailInventoryController.instance.progressDialogShow,
        child: _InventoryDetail(inventory: DetailInventoryController.instance.inventory!,)
      ),
    );
  }
}

class _InventoryDetail extends StatelessWidget {
  final Inventory inventory;


  _InventoryDetail({required this.inventory});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _drugInfo(context),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        _inventoryInfo(context),
        SizedBox(height: ScreenUtil.heightInPercent(6),),
        _batchesInfo(context),
        SizedBox(height: ScreenUtil.heightInPercent(20),),
      ],
    );
  }

  Widget _drugInfo(BuildContext context) {
    Drug drug = inventory.drug!;
    TextStyle textContentStyle = Style.defaultTextStyle(color: Style.colorPrimary);
    TextStyle labelStyle = TextStyle(color: Colors.grey);

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.network('${drug.imageUrl}', height: ScreenUtil.heightInPercent(30),),
        ),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        _MyTextContainer(
          label: TextString.label__name_of_drug,
          textContent: '${drug.name}',
          labelStyle: labelStyle,
          textContentStyle: textContentStyle,
        ),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _MyTextContainer(
                textContent: '${drug.measurement}${drug.measurementUnit!.toLowerCase()}',
                label: TextString.label__mass,
                textContentStyle: textContentStyle,
                labelStyle: labelStyle,
              ),
            ),
            SizedBox(width: ScreenUtil.widthInPercent(1),),
            Expanded(
              flex: 1,
              child: _MyTextContainer(
                textContent: '${StringUtil.capitalize(drug.type)}',
                label: TextString.label__type,
                textContentStyle: textContentStyle,
                labelStyle: labelStyle,
              ),
            ),
          ],

        ),
        SizedBox(height: ScreenUtil.heightInPercent(3),),
        _MyTextContainer(
          label: TextString.label__description,
          textContent: '${drug.description}',
          labelStyle: labelStyle,
          textContentStyle: textContentStyle.copyWith(height: 1.5),
        ),
      ],
    );
  }

  Widget _inventoryInfo(BuildContext context) {
    TextStyle textContentStyle = Style.defaultTextStyle(color: Style.colorPrimary);
    TextStyle labelStyle = TextStyle(color: Colors.grey);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _MyTextContainer(
            textContent: '${inventory.availableUnits}',
            label: TextString.label__available_units,
            textContentStyle: textContentStyle,
            labelStyle: labelStyle,
          ),
        ),
        SizedBox(width: ScreenUtil.widthInPercent(2),),
        Expanded(
          flex: 1,
          child: _MyTextContainer(
            textContent: '${inventory.unitPriceCurrency} ${inventory.unitSellPrice}',
            label: TextString.label__sell_price,
            textContentStyle: textContentStyle,
            labelStyle: labelStyle,
          ),
        ),
      ],
    );
  }

  Widget _batchesInfo(BuildContext context) {
    return Container(
      width: ScreenUtil.widthInPercent(90),
      height: ScreenUtil.heightInPercent(50),
      child: _BatchInfo(inventory: inventory),
    );
  }
}

class _MyTextContainer extends StatelessWidget {
  final String? label;

  final String textContent;

  final TextStyle? textContentStyle;

  final TextStyle? labelStyle;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  _MyTextContainer({required this.textContent, this.label, this.margin, this.padding, this.textContentStyle, this.labelStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != null) Text(label!, style: labelStyle),
        if(label != null) SizedBox(height: ScreenUtil.heightInPercent(1),),
        Container(
          margin: margin,
          padding: padding,
          child: InputDecorator(
            decoration: InputDecoration(
              fillColor: Style.colorPrimary.withOpacity(0.2),
              filled: true,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Style.colorPrimary.withOpacity(0.2)), borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(textContent, style: textContentStyle,),
          ),
        )
      ],
    );
  }
}

class _BatchInfo extends StatelessWidget {
  final Inventory inventory;

  _BatchInfo({required this.inventory});

  final DateFormat dateFormat = DateFormat('MMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return HorizontalDataTable(
      itemCount: inventory.inventoryBatchList!.length,
      leftHandSideColumnWidth: ScreenUtil.widthInPercent(25),
      rightHandSideColumnWidth: ScreenUtil.widthInPercent(80),
      leftSideItemBuilder: _batchInfoFirstColumn,
      rightSideItemBuilder: _batchInfoRightHandSideColumnRow,
      headerWidgets: _generateTitleWidget(),
      isFixedHeader: true,
      rowSeparatorWidget: Divider(),
    );
  }

  List<Widget> _generateTitleWidget() {
    return [
      Container(
        width: ScreenUtil.widthInPercent(25),
        child: Text(TextString.label__batch_date, style: Style.defaultTextStyle(color: Style.colorPrimary, fontWeight: FontWeight.w500),),
      ),
      Container(
          width: ScreenUtil.widthInPercent(25),
        padding: EdgeInsets.only(right: ScreenUtil.widthInPercent(4)),
          child: Text(TextString.label__unit_count, textAlign: TextAlign.right, style: Style.defaultTextStyle(color: Style.colorPrimary, fontWeight: FontWeight.w500),),
      ),
      Container(
          width: ScreenUtil.widthInPercent(25),
        padding: EdgeInsets.only(right: ScreenUtil.widthInPercent(4)),
          child: Text(TextString.label__buy_price, textAlign: TextAlign.right, style: Style.defaultTextStyle(color: Style.colorPrimary, fontWeight: FontWeight.w500),),
      ),
      Container(
          width: ScreenUtil.widthInPercent(30),
        padding: EdgeInsets.only(right: ScreenUtil.widthInPercent(4)),
          child: Text(TextString.label__expiry_date, textAlign: TextAlign.right, style: Style.defaultTextStyle(color: Style.colorPrimary, fontWeight: FontWeight.w500),),
      ),
    ];
  }

  Widget _batchInfoFirstColumn(BuildContext context, int index) {
    return Text('${dateFormat.format(DateTime.parse(inventory.inventoryBatchList![index].batchDate!))}',
      style: Style.defaultTextStyle(color: Colors.grey),);
  }

  Widget _batchInfoRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: [
        Container(
          width: ScreenUtil.widthInPercent(25),
          padding: EdgeInsets.only(right: ScreenUtil.widthInPercent(4)),
          child: Text('${inventory.inventoryBatchList![index].unitCounts.toString()}',
            textAlign: TextAlign.right,
            style: Style.defaultTextStyle(color: Colors.grey),),
        ),
        Container(
          width: ScreenUtil.widthInPercent(25),
          padding: EdgeInsets.only(right: ScreenUtil.widthInPercent(4)),
          child: Text('${inventory.inventoryBatchList![index].unitPriceCurrency!} ${inventory.inventoryBatchList![index].unitBuyPrice!}',
            textAlign: TextAlign.right,
            style: Style.defaultTextStyle(color: Colors.grey),),
        ),
        Container(
          width: ScreenUtil.widthInPercent(30),
          child: Text('${dateFormat.format(DateTime.parse(inventory.inventoryBatchList![index].expiryDate!))}',
            textAlign: TextAlign.right,
            style: Style.defaultTextStyle(color: Colors.grey),),
        ),
      ],
    );
  }
}
