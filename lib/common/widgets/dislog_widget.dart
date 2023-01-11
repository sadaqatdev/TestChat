import 'package:chat_app/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
  
Future showFileOPtion(Function(ImageSource)? function) async {
  await showDialog(
      context: GlobalContext.context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Select Source"),
          children: [
            Material(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        function!(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      child: const Text("Gallery"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        function!(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      child: const Text("Camera"),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      });
}
