import 'package:flutter/material.dart';

/// Base class for a searchable dialog
///
/// Not sure I really want this tbh O-O
class DialogBase extends StatelessWidget {
  // -- Base

  final Function onDone;
  final Function onSearchClear;
  final Widget child;

  DialogBase({Key? key, required this.onDone, required this.child, required this.onSearchClear})
        : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                  },
                )
              ],
            ),
            Expanded(child: this.child),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text('Done'),
                  onPressed: () {
                    onDone();
                    return Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}