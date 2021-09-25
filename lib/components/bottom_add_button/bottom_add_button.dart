import 'package:flutter/material.dart';

class BottomAddButton extends StatelessWidget {
  final Function() onPressed;

  const BottomAddButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(100),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox.fromSize(
          size: Size.fromHeight(50),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 30.0,
                  ),
                ]
            ),
            child: IconButton(
              onPressed: onPressed,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              icon: Icon(
                Icons.add_circle,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
