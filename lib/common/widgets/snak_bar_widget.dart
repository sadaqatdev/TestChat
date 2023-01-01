import 'package:chat_app/utils/route_utils.dart';
import 'package:flutter/material.dart';

showSnackBarMessage({required String msg}) {
  //

  ScaffoldMessenger.of(GlobalContext.context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      content: Text(
        msg,
        style: const TextStyle(fontSize: 12),
        overflow: TextOverflow.visible,
      ),
    ),
  );
}
