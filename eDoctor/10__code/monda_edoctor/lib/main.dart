import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/route.dart';
import 'package:monda_edoctor/_0__infra/style.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_4__presentation/page/_0__login/page__blank_before_splash.dart';
import 'package:monda_edoctor/_4__presentation/page/_0__login/page__signin.dart';
import 'package:monda_edoctor/_4__presentation/page/_0__login/page__splash.dart';
import 'package:monda_edoctor/_4__presentation/page/_1__home/page__home.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__invoice/page__invoice.dart';
import 'package:monda_edoctor/_4__presentation/page/_3__inventory/page__inventory.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return runApp(
      Phoenix(
        child: MondaEPatientApp(),
      ),
    );
  });
}

class MondaEPatientApp extends StatelessWidget {
  Future<void> _onInit() async {
    // Initialize all controller
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: _onInit,
      title: TextString.app_name,
      initialRoute: Routes.page_blank_before_splash,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Style.appMaterialColor,
        backgroundColor: Style.backgroundColor,
        primaryColorLight: Style.colorPrimary,
      ),
      getPages: [
        // ----------------------------------------------------------- 0. Splash
        GetPage(name: Routes.page_blank_before_splash, page: () => BlankBeforeSplashPage(),),

        GetPage(name: Routes.page_splash, page: () => SplashPage(),),

        GetPage(name: Routes.page_signin, page: () => SignInPage(),),

        // ------------------------------------------------------------- 1. Home
        GetPage(name: Routes.page_home, page: () => HomePage(),),

        // ---------------------------------------------------------- 2. Invoice
        GetPage(name: Routes.page_invoice, page: () => InvoicePage(),),

        // -------------------------------------------------------- 3. Inventory
        GetPage(name: Routes.page_inventory, page: () => InventoryPage(),),
      ],
    );
  }
}