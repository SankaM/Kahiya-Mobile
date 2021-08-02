import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_3__service/service__inventory.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__progress_indicator_overlay.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/widget__filter_button.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/controller__inventory.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InventoryPage extends AbstractPageWithBackgroundAndContent {
  InventoryPage() : super(
    title: TextString.page_title__inventory,
    backgroundAsset: Asset.png__background02,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: true,
    showBottomNavigationBar: true,
    selectedIndexOfBottomNavigationBar: -1,
    floatingActionButton: FloatingActionButton(
            child: FaIcon(
              FontAwesomeIcons.pills,
              size: Style.iconSize_S,
              color: Colors.white,
            ),
            backgroundColor: Style.colorPalettes[900],
            elevation: 0,
            onPressed: () {
              RouteNavigator.gotoAddInventoryPage();
            },
          ),
        );

  @override
  Widget constructContent(BuildContext context) {
    InventoryController.instance.init();

    return GetBuilder<InventoryController>(builder: (c) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: _contentCustomAppBar(context),
                body: _contentBody(context),
              )
          ),
          Visibility(
            child: ProgressIndicatorOverlay(text: TextString.label__retrieving_inventory_list,),
            visible: c.progressDialogShow,
          )
        ],
      );
    });
  }

  PreferredSize _contentCustomAppBar(BuildContext context) {
    return CustomAppBarBuilder.build(
      context: context,
      preferredSize: Size.fromHeight(ScreenUtil.heightInPercent(17.5)),
      firstLineLabel: Text(TextString.label__inventory, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
      backButtonIcon: Icon(Icons.arrow_back, color: Colors.white, size: Style.iconSize_2XL,),
    );
  }

  Widget _contentBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _searchBar(context),
        _pagingSection(context),
        _scrollableSection(context),
      ],
    );
  }

  Widget _searchBar(BuildContext context) {
    return Container(
      height: ScreenUtil.heightInPercent(10),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: ReactiveForm(
        formGroup: InventoryController.instance.searchForm,
        child: Row(
          children: [
            Container(
              width: ScreenUtil.widthInPercent(60),
              height: ScreenUtil.heightInPercent(8),
              decoration:  BoxDecoration(
                  borderRadius: new BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(color: Colors.grey[100]!, blurRadius: 10.0, spreadRadius: 0.1)
                  ]
              ),
              child: ReactiveTextField(
                formControlName: 'queryValue',
                style: TextStyle(color: Style.colorPrimary),
                cursorColor: Style.colorPrimary,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: ScreenUtil.heightInPercent(8)),
                  prefixIcon: Icon(Icons.search, color: Style.colorPrimary,),
                  hintText: TextString.label__search,
                  hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Style.colorPalettes[300], fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: ScreenUtil.heightInPercent(8),
              height: ScreenUtil.heightInPercent(8),
              decoration:  BoxDecoration(
                  borderRadius: new BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(color: Style.colorPrimary, blurRadius: ScreenUtil.widthInPercent(10), spreadRadius: 0.1)
                  ]
              ),
              child: FilterButton(
                labels: ['Name', 'Type', 'Mass'],
                onTap: (menuItemLabel) {
                  if(menuItemLabel == 'Name') {
                    InventoryController.instance.search(field: SearchDrugField.NAME);
                  } else if(menuItemLabel == 'Type') {
                    InventoryController.instance.search(field: SearchDrugField.TYPE);
                  } else if(menuItemLabel == 'Mass') {
                    InventoryController.instance.search(field: SearchDrugField.MEASUREMENT);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _pagingSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(4), right: ScreenUtil.widthInPercent(8)),
      child: Row(
        children: [
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Style.colorPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                InkWell(
                  child: Icon(Icons.arrow_left, size: Style.iconSize_2XL, color: Style.colorPrimary,),
                  onTap: () {
                    InventoryController.instance.prevPage();
                  },
                ),
                SizedBox(width: ScreenUtil.widthInPercent(2),),
                Text('|', style: TextStyle(color: Style.colorPrimary),),
                SizedBox(width: ScreenUtil.widthInPercent(2),),
                InkWell(
                  child: Icon(Icons.arrow_right, size: Style.iconSize_2XL, color: Style.colorPrimary,),
                  onTap: () {
                    InventoryController.instance.nextPage();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _scrollableSection(BuildContext context) {
    if(InventoryController.instance.inventoryList.length == 0) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(10),),
          child: Text(TextString.label__no_data, style: Style.defaultTextStyle(color: Colors.grey[600]!, height: 1.5),),
        ),
      );
    }

    List<Widget> children = [];
    children.addAll(InventoryController.instance.inventoryList.map((e) => _InventoryItem(inventory: e)).toList());
    children.addAll([SizedBox(height: ScreenUtil.heightInPercent(20),), SizedBox(height: ScreenUtil.heightInPercent(20),)]);

    List<StaggeredTile> staggeredTileList = [];
    staggeredTileList.addAll(InventoryController.instance.inventoryList.map((e) => StaggeredTile.fit(1)).toList());
    staggeredTileList.addAll([StaggeredTile.fit(1), StaggeredTile.fit(1),]);

    return Container(
      height: ScreenUtil.heightInPercent(60),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: StaggeredGridView.count(
        crossAxisCount: 2,
        children: children,
        staggeredTiles: staggeredTileList,
      ),
    );
  }
}

class _InventoryItem extends StatelessWidget {
  final Inventory inventory;

  _InventoryItem({required this.inventory,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteNavigator.gotoDetailInventoryPage(inventoryId: inventory.id);
      },
      child: Container(
        margin: EdgeInsets.all(ScreenUtil.widthInPercent(2)),
        padding: EdgeInsets.all(ScreenUtil.widthInPercent(2)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[200]!, blurRadius: 4, spreadRadius: 2)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)), child: Image.network(inventory.drug!.imageUrl!),),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),
            Text('${inventory.drug!.name}', overflow: TextOverflow.ellipsis, style: Style.defaultTextStyle(fontWeight: FontWeight.w700, color: Colors.black),),
            Text('${inventory.drug!.measurement} ${inventory.drug!.measurementUnit}' , style: Style.defaultTextStyle(fontSize: Style.fontSize_S, color: Colors.grey, fontWeight: FontWeight.w500),),
            SizedBox(height: ScreenUtil.heightInPercent(1.5),),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.pills, size: Style.iconSize_S, color: Colors.purple,),
                SizedBox(width: ScreenUtil.widthInPercent(1),),
                Text('${inventory.drug!.type!.toLowerCase()}', style: Style.defaultTextStyle(color: Colors.purple),),
              ],
            ),
            SizedBox(height: ScreenUtil.heightInPercent(2),),
            Row(
              children: [
                Text(TextString.label__qty, style: Style.defaultTextStyle(fontSize: Style.iconSize_2XS, color: Colors.grey),),
                SizedBox(width: ScreenUtil.widthInPercent(1),),
                Text('${inventory.availableUnits}', style: Style.defaultTextStyle(fontSize: Style.iconSize_2XS, color: Colors.black),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}