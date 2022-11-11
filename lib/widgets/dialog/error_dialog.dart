import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatefulWidget {

  final String title;
  final String message;

  const ErrorDialog({this.message = "", this.title = "Notice"});

  @override
  _ErrorDialogState createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> with SingleTickerProviderStateMixin {

  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller!, curve: Curves.bounceInOut);

    controller?.addListener(() {
      setState(() {});
    });

    controller?.forward();
  }

  bool rs = false;

  @override
  Widget build(BuildContext context) {

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
            width: Get.width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 15),
                Text(widget.title, style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(widget.message, style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15), textAlign: TextAlign.center),
                ),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                Container(
                  height: 45,
                  child: Row(
                    children: [
                      Container(
                        height: 45,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            rs = true;
                            Navigator.pop(context, rs);
                          },
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Text("OK", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}