import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final bool isLoading;
  const LoadingPage({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Container(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            width: 100,
            height: 100,
            child: CupertinoActivityIndicator(color: Colors.white, radius: 15),
          ),
        ),
      ),
    );
  }
}
