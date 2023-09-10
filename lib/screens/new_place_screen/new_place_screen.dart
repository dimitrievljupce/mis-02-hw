import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_together/screens/new_place_screen/new_place_screen_viewmodel.dart';
import 'package:work_together/widgets/styled_button.dart';
import 'package:work_together/widgets/styled_button_with_icon.dart';
import 'package:work_together/widgets/styled_entry.dart';
import 'package:work_together/widgets/styled_text_form.dart';

class NewPlaceScreen extends StatefulWidget {
  const NewPlaceScreen({Key? key}) : super(key: key);

  @override
  State<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends State<NewPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  'Add new place',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(26, 0, 26, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    StyledEntry(placeholder: 'Name', onChanged: (value) => {}),
                    const SizedBox(height: 20),
                    const StyledTextForm(
                      placeholder: 'Description',
                    ),
                    const SizedBox(height: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Attach photo'),
                        SizedBox(height: 10),
                        StyledButtonWithIcon(
                          icon: Icons.add,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 0, 26, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: StyledButton(
                      text: "Submit",
                      clicked: () => {},
                      overlayColorValue: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) => Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StyledButton(
                      clicked: () async => {
                        await context
                            .read<NewPlaceViewModel>()
                            .navigateBack(context)
                      },
                      text: "Cancel",
                      overlayColorValue: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) => Theme.of(context)
                            .colorScheme
                            .error
                            .withOpacity(0.7),
                      ),
                      backgroundColorValue:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Theme.of(context)
                                .colorScheme
                                .error
                                .withOpacity(0.7);
                          }
                          return Colors.red;
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
