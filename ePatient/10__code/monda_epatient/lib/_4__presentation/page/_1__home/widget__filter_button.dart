import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/style.dart';
import 'package:monda_epatient/_9__modify/flutter/custom_popup_menu_item.dart';

class FilterButton extends StatefulWidget {
  final List<String> labels;

  FilterButton({required this.labels});

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
      padding: EdgeInsets.all(17),
      child: Image.asset(Asset.png_filter_button),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Style.colorPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
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
            Container(height: 20, width: 4, color: markerColor,),
            SizedBox(width: 20,),
            Text(menuItemLabel, style: GoogleFonts.montserrat(fontSize: Style.fontSize_Default, fontWeight: FontWeight.w500, color: textColor),),
          ],
        ),
    );
  }
}
