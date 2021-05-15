import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common_widget/abstract_page.dart';

class LoginPage extends AbstractPage {
  LoginPage() : super(
    title: TextString.page_title__login,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
  );

  @override
  Widget constructBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.5, 0.9],
          colors: [
            Color.fromRGBO(255, 218, 202, 1),
            Color.fromRGBO(215, 255, 185, 1),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(child: SvgPicture.asset(Asset.svg_background01), top: 0.0,),
          _constructLoginForm(context),
        ],
      )
    );
  }

  Widget _constructLoginForm(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: ListView(
        children: [
          SizedBox(height: 75,),
          _logoSection(context),
          SizedBox(height: 40,),
          _signinLabelSection(context),
          SizedBox(height: 30,),
          _usernameSection(context),
          SizedBox(height: 20,),
          _passwordSection(context),
          SizedBox(height: 50,),
          _loginButton(context),
          SizedBox(height: 75,),
        ],
      ),
    );
  }

  Widget _logoSection(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Image.asset(
        Asset.png_logo,
        width: 100,
      ),
    );
  }

  Widget _signinLabelSection(BuildContext context) {
    return Text(TextString.label__signin, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: Style.fontSize_3XL, color: Colors.deepOrange[400], letterSpacing: 2),);
  }

  Widget _usernameSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Style.colorPrimary.withOpacity(0.25),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TextString.label__username, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.white),),
            SizedBox(height: 15,),
            Container(
              child: TextFormField(
                style: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.white, size: Style.iconSize_Default,),
                  prefixText: '|  ',
                  prefixStyle: TextStyle(fontSize: Style.fontSize_XL, color: Colors.white, fontWeight: FontWeight.w400),
                  hintText: TextString.label__enter_username,
                  hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Style.colorPrimary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.25),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TextString.label__password, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.white,),),
            SizedBox(height: 15,),
            Container(
              child: TextFormField(
                obscureText: true,
                cursorColor: Colors.white,
                style: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.white, size: Style.iconSize_Default,),
                  prefixText: '|  ',
                  prefixStyle: TextStyle(fontSize: Style.fontSize_XL, color: Colors.white, fontWeight: FontWeight.w400),
                  hintText: TextString.label__enter_password,
                  hintStyle: TextStyle(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          RouteNavigator.gotoHomePage();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Style.colorPrimary,
              border: Border.all(
                color: Style.colorPrimary,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Row(
            children: [
              Expanded(child: Container(), flex: 1,),
              Expanded(child: Text('LOGIN', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 3),), flex: 2,),
              Expanded(child: Icon(Icons.arrow_right_alt, color: Colors.white,), flex: 1,),
            ],
          ),
        ),
      ),
    );
  }
}
