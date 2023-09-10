import 'package:flutter/material.dart';

class StyledTextForm extends StatelessWidget {
  const StyledTextForm({super.key, this.placeholder = ''});

  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 3,
      maxLines: 5,
      decoration: InputDecoration(
        constraints: const BoxConstraints(minHeight: 1, minWidth: 1),
        isDense: true,
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
    );
  }
}
