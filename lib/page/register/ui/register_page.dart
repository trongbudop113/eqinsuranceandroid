
import 'package:eqinsuranceandroid/page/loading/loading_page.dart';
import 'package:eqinsuranceandroid/page/register/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterPage extends GetView<RegisterController>{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        onTap: (){
          controller.hideKeyboard(context: context);
        },
        child: Obx(() => Stack(
          children: [
            Container(
                child: controller.getWidgetContent()
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.listCountPage.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentIndex == entry.key ? Colors.brown : Colors.grey
                    ),
                  );
                }).toList(),
              ),
            ),
            Obx(() => LoadingPage(isLoading: controller.isLoading.value))
          ],
        )),
      ),
      onWillPop: () async{
        controller.onBackPress();
        return true;
      },
    );
  }

}