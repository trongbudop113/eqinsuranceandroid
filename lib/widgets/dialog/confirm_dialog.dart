import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatefulWidget {

  final String title;
  final String message;

  const ConfirmDialog({this.message = "", this.title = "Notice"});

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> with SingleTickerProviderStateMixin {

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
                Text(widget.message, style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15)),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                Container(
                  height: 45,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            rs = false;
                            Navigator.pop(context, rs);
                          },
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Text("Cancel"),
                          ),
                        ),
                      ),
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
                            child: Text("OK"),
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