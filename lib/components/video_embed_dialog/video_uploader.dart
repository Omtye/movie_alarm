import 'package:flutter/material.dart';

class VideoUploader extends StatelessWidget {
  final Function onDone;

  VideoUploader({Key? key, required this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.1),
      child: Container(
        child: TextButton(
          child: Text('동영상 임베드 또는 업로드'),
          onPressed: () {
            onDone();
          },
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 246, 243, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
