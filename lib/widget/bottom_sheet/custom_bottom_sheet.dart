import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet {
  static bottomSheetPro(BuildContext context) async {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return BottomSheetWidget();
      },
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  // BottomSheetWidget();
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    // final Function wp = Screen(MediaQuery.of(context).size).wp;
    // final Function hp = Screen(MediaQuery.of(context).size).hp;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 3),
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Container());
  }
}
