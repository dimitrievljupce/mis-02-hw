import 'package:flutter/material.dart';

class NewPlaceViewModel extends ChangeNotifier {
  Future<void> navigateBack(BuildContext context) async {
    Navigator.of(context).pop();
  }
}
