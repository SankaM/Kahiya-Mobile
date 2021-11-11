import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/screen_util.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_9__modify/flutter/custom_popup_menu_item.dart';

class FilterButton extends StatefulWidget {
  final List<String> labels;

  final Function onTap;

  FilterButton({required this.labels, required this.onTap});

  @override
  State<StatefulWidget> createState() {
    return _FilterButtonState();
  }
}

class _FilterButtonState extends State<FilterButton> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: _filterButton(),
      offset: Offset(0, 40),
      padding: EdgeInsets.zero,
      onSelected: (menuItemLabel) {
        selectedIndex = widget.labels.indexOf(menuItemLabel.toString());
        widget.onTap(menuItemLabel);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      itemBuilder: (context) {
        List<PopupMenuEntry> list = [];

        for(int i = 0; i < widget.labels.length; i++) {
          list.add(_menuItem(widget.labels[i]));
          if(i != widget.labels.length - 1) list.add(PopupMenuDivider());
        }

        return list;
      },
    );
  }

  Widget _filterButton() {
    return Container(
      width: ScreenUtil.widthInPercent(17),
      child: Image.asset(Asset.png_filter_button),
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
    );
  }

  CustomPopupMenuItem _menuItem(String menuItemLabel) {
    Color markerColor = Style.colorPrimary;
    Color textColor = Style.colorPrimary;

    if(menuItemLabel != widget.labels[selectedIndex]) {
      markerColor = Colors.white.withOpacity(0);
      textColor = Colors.grey;
    }

    return CustomPopupMenuItem(
      value: menuItemLabel,
      child: Row(
        children: [
          Container(height: ScreenUtil.heightInPercent(3), width: ScreenUtil.widthInPercent(1), color: markerColor,),
          SizedBox(width: ScreenUtil.heightInPercent(3), height: ScreenUtil.heightInPercent(6),),
          Text(menuItemLabel, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, fontWeight: FontWeight.w500, color: textColor),),
        ],
      ),
    );
  }
}
