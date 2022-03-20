import 'dart:js';

import 'package:flutter/material.dart';
import 'package:shabusystem/model/menu.dart';
import 'package:shabusystem/model/order.dart';
import 'package:shabusystem/screen/customer_order_popup.dart';
import 'package:shabusystem/screen/detail_order_popup.dart';
import 'package:shabusystem/screen/exit_confirmation_dialog.dart';

class DialogHelper {
  static exit(context,
          {required String name, required String image, required String ID}) =>
      showDialog(
          context: context,
          builder: (context) => ExitConfirmationDialog(
                name: name,
                image: image,
                ID: ID,
              ));
  static customer_order_popup(context,
          {required String name, required String image, required String ID}) =>
      showDialog(
          context: context,
          builder: (context) =>
              CustomerOrderPopup(name: name, image: image, ID: ID));
}
