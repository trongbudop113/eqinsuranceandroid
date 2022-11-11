import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final Function(String) onSubmit;
  final Function(String)? onChange;
  final String hint;
  final bool isShowLeftIcon;
  final TextEditingController? controller;
  final String leftIcon;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final bool obscureText;

  const TextFieldWidget({Key? key, required this.onSubmit, this.hint = "", this.controller, this.isShowLeftIcon = false, this.leftIcon = "", this.onChange, this.textInputType, this.inputFormatter, this.obscureText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      height: 40,
      child: Row(
        children: [
          Visibility(
            visible: isShowLeftIcon,
            child: GestureDetector(
              child: Container(
                height: 12,
                width: 12,
                margin: EdgeInsets.only(left: 10),
                child: Image.asset(leftIcon),
              ),
              onTap: (){

              },
            ),
          ),
          Expanded(
            child: TextField(
                controller: controller,
                autocorrect: true,
                obscureText: obscureText,
                maxLines: 1,
                keyboardType: textInputType,
                inputFormatters: inputFormatter,
                onSubmitted: (value) {
                  onSubmit(value);
                },
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 14, color: ColorResource.plaintext_textColor, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 14, color: ColorResource.plaintext_textColorHint, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class SearchTextFieldWidget extends StatelessWidget {
  final Function(String) onSubmit;
  final Function(String)? onChange;
  final String hint;
  final TextEditingController? controller;

  const SearchTextFieldWidget({Key? key, required this.onSubmit, this.hint = "", this.controller, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        border: Border.all(color: Colors.grey)
      ),
      height: 36,
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(Icons.search)
          ),
          Expanded(
            child: TextField(
                controller: controller,
                autocorrect: true,
                maxLines: 1,
                onSubmitted: (value) {
                  onSubmit(value);
                },
                onChanged: (value){
                  onChange!(value);
                },
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}