import 'package:flutter/material.dart';

class StyledButtonWithIcon extends StatelessWidget {
  const StyledButtonWithIcon({Key? key, required this.icon}) : super(key: key);

  final IconData icon; // Changed type to IconData

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(100.0),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Icon(
            icon, // Use the dynamically passed icon
            size: 20.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
