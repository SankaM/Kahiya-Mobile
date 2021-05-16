import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/style.dart';

class DoctorCard extends StatelessWidget {
  final String assetImage;

  final String firstLineText;

  final String secondLineText;

  final String thirdLineText;

  final String assetIcon;

  final double width;

  DoctorCard({required this.assetImage, required this.firstLineText, required this.secondLineText, required this.thirdLineText, required this.assetIcon, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 125,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(10),
                height: double.infinity,
                child: GFAvatar(
                  backgroundImage: AssetImage(assetImage),
                  shape: GFAvatarShape.square,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(firstLineText, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.grey[700], fontWeight: FontWeight.w700),),
                    SizedBox(height: 5,),
                    Text(secondLineText, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[500]),),
                    Spacer(),
                    Row(
                      children: [
                        Image.asset(assetIcon, width: 16, height: 16,),
                        SizedBox(width: 10,),
                        Text(thirdLineText, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[700], fontWeight: FontWeight.w600),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}