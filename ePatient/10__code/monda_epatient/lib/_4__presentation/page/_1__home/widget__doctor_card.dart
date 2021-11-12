import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/route.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_1__model/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  
  late final String? imageUrl;

  final double width;

  final double height;

  DoctorCard({required this.doctor, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    ImageProvider noImage = AssetImage(Asset.png__no_image_available);

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: ScreenUtil.heightInPercent(1), bottom: ScreenUtil.heightInPercent(1)),
      child: InkWell(
        onTap: () {
          RouteNavigator.gotoDoctorProfilePage(doctorId: doctor.id, doctorName: doctor.nameNonNull);
        },
        child:Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(ScreenUtil.widthInPercent(2)),
                  height: double.infinity,
                  child: GFAvatar(
                    backgroundImage: doctor.imageUrl == null ? noImage : NetworkImage(doctor.imageUrl!),
                    shape: GFAvatarShape.square,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: ScreenUtil.widthInPercent(1.5), top: ScreenUtil.heightInPercent(1.5), right: ScreenUtil.widthInPercent(1.5), bottom: ScreenUtil.heightInPercent(1.5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor.nameNonNull, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, color: Colors.grey[700], fontWeight: FontWeight.w700),),
                      SizedBox(height: ScreenUtil.heightInPercent(1),),
                      Text(doctor.nonNullSpeciality, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[500]),),
                      Spacer(),
                      Row(
                        children: [
                          Image.asset(Asset.png_time01, width: Style.iconSize_Default, height: Style.iconSize_Default,),
                          SizedBox(width: ScreenUtil.widthInPercent(1.5),),
                          Text(doctor.nonNullGeneralWorkHour, style: GoogleFonts.montserrat(fontSize: Style.fontSize_S, color: Colors.grey[700], fontWeight: FontWeight.w600),),
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