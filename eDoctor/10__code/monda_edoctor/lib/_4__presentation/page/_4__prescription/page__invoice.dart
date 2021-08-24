import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__string.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/common/builder__custom_app_bar.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__progress_indicator_overlay.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/controller__invoice.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InvoicePage extends AbstractPageWithBackgroundAndContent {
  InvoicePage() : super(
    title: TextString.page_title__invoice,
    backgroundAsset: Asset.png__background02,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
    selectedIndexOfBottomNavigationBar: 0,
        );

  @override
  Widget constructContent(BuildContext context) {
    InvoiceController.instance.init();

    return GetBuilder<InvoiceController>(builder: (c) {
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
      firstLineLabel: Text(TextString.label__invoice, style: Style.defaultTextStyle(fontSize: Style.fontSize_3XL),),
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
        formGroup: InvoiceController.instance.searchForm,
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
                  hintText: 'Search by patient name...',
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
              child: InkWell(
                onTap: () {
                  InvoiceController.instance.search();
                },
                child: Container(
                  width: ScreenUtil.widthInPercent(17),
                  child: Icon(Icons.search, color: Colors.white,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Style.colorPrimary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400]!,
                        offset: Offset(0.5, 0.5), //(x,y)
                        blurRadius: 0.5,
                      ),
                    ],
                  ),
                ),
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
                    InvoiceController.instance.prevPage();
                  },
                ),
                SizedBox(width: ScreenUtil.widthInPercent(2),),
                Text('|', style: TextStyle(color: Style.colorPrimary),),
                SizedBox(width: ScreenUtil.widthInPercent(2),),
                InkWell(
                  child: Icon(Icons.arrow_right, size: Style.iconSize_2XL, color: Style.colorPrimary,),
                  onTap: () {
                    InvoiceController.instance.nextPage();
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
    if(InvoiceController.instance.prescriptionList.length == 0) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: ScreenUtil.heightInPercent(10),),
          child: Text(TextString.label__no_data, style: Style.defaultTextStyle(color: Colors.grey[600]!, height: 1.5),),
        ),
      );
    }

    return Container(
      height: ScreenUtil.heightInPercent(60),
      padding: EdgeInsets.only(left: ScreenUtil.widthInPercent(8), top: ScreenUtil.heightInPercent(2.5), right: ScreenUtil.widthInPercent(8)),
      child: ListView(children: InvoiceController.instance.prescriptionList.map((e) => _PrescriptionItem(prescription: e)).toList(),),
    );
  }
}

class _PrescriptionItem extends StatelessWidget {
  final Prescription prescription;

  _PrescriptionItem({required this.prescription,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil.heightInPercent(15),
      margin: EdgeInsets.only(top: ScreenUtil.heightInPercent(1), bottom: ScreenUtil.heightInPercent(1)),
      child: InkWell(
        onTap: () {
          RouteNavigator.gotoInvoiceDetailPage(prescriptionId: prescription.id);
        },
        child:Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(ScreenUtil.widthInPercent(2)),
                  height: double.infinity,
                  child: prescription.patient!.imageUrl != null ? GFAvatar(
                    backgroundImage: NetworkImage(prescription.patient!.imageUrl!),
                    shape: GFAvatarShape.square,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ) : Image.asset(Asset.png__no_image_available),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(left: ScreenUtil.widthInPercent(1.5), top: ScreenUtil.heightInPercent(1.5), right: ScreenUtil.widthInPercent(1.5), bottom: ScreenUtil.heightInPercent(1.5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${prescription.patient!.name}', style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.grey[700], fontWeight: FontWeight.w700),),
                      SizedBox(height: ScreenUtil.heightInPercent(1),),
                      Text('${DateFormat.yMMMd().format(prescription.prescriptionDate!)}', style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[500]),),
                      Spacer(),
                      Row(
                        children: [
                          Text('Total Cost: ', style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[700],),),
                          Text('${StringUtil.formatDouble(prescription.totalCost!)}', style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.grey[700], fontWeight: FontWeight.w500),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
