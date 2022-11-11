import 'package:eqinsuranceandroid/page/register/controller/register_controller.dart';
import 'package:eqinsuranceandroid/page/register/models/country_code_res.dart';
import 'package:eqinsuranceandroid/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryCodeDialog extends StatefulWidget {
  final RegisterController controller;
  const CountryCodeDialog({required this.controller});
  @override
  _CountryCodeDialogState createState() => _CountryCodeDialogState();
}

class _CountryCodeDialogState extends State<CountryCodeDialog> with SingleTickerProviderStateMixin {

  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller!, curve: Curves.bounceOut);

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
            height: Get.height * 0.8,
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SearchTextFieldWidget(onSubmit: (String ) {

                  }, onChange: (value){
                    widget.controller.onSearchCountryCode(value);
                  }),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Obx(() => ListView.builder(
                    itemCount: widget.controller.listCountryCode.length,
                    itemBuilder: (ctx, index){
                      return GestureDetector(
                        onTap: (){
                          widget.controller.onChangeSearchCountry(index);
                          Navigator.pop(context, rs);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 15),
                                  Container(
                                    child: Text(widget.controller.listCountryCode[index].name ?? ""),
                                    padding: EdgeInsets.symmetric(vertical: 3),
                                  ),
                                  Spacer(flex: 1),

                                  selectedCheckbox(widget.controller.listCountryCode[index].isChecked.value),
                                  SizedBox(width: 15),
                                ],
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      );
                    },
                  )),
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
                            child: Text("Close", style:  Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
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

  Widget selectedCheckbox(bool isSelected){

    final double size = 12;
    return Visibility(
      visible: isSelected,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
        ),
        child: Icon(Icons.check, color: Colors.black, size: 10),
      ),
      replacement: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
        ),
      ),
    );
  }
}