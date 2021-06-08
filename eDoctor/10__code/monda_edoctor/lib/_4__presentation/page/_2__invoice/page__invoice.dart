import 'dart:developer';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/components/avatar/gf_avatar.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_edoctor/_0__infra/asset.dart';
import 'package:monda_edoctor/_0__infra/screen_util.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_page_with_background_and_content.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/widget__doctor_card.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/widget__filter_button.dart';

class InvoicePage extends AbstractPageWithBackgroundAndContent {
  InvoicePage() : super(
    title: TextString.page_title__invoice,
    backgroundAsset: Asset.png__background02,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: true,
    showBottomNavigationBar: true,
    selectedIndexOfBottomNavigationBar: -1,
  );
}
