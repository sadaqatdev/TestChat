import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide:
            const BorderSide(color: Color.fromARGB(255, 134, 128, 128)));

    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          // hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade600,
            size: 20,
          ),
          filled: true,
          // fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.all(8),
          enabledBorder: border,
          border: border,
          focusedBorder: border,
        ),
      ),
    );
  }
}
