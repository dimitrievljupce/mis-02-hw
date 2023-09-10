import 'package:flutter/material.dart';

class StyledEntry extends StatelessWidget {
  const StyledEntry(
      {super.key,
      this.isPassword = false,
      required this.placeholder,
      required this.onChanged});

  final bool isPassword;
  final String placeholder;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      shadowColor: Theme.of(context).shadowColor,
      child: TextField(
        obscureText: isPassword,
        autocorrect: false,
        onChanged: (String newValue) {
          onChanged(newValue);
        },
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          constraints: const BoxConstraints(minHeight: 1, minWidth: 1),
          contentPadding: const EdgeInsets.all(10),
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Theme.of(context).shadowColor, width: 0.75),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 0.75),
          ),
        ),
      ),
    );
  }
}
