import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';

class SubmitButton extends StatelessWidget {
  final Function()? onPressed;

  const SubmitButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Theme.of(context).colorScheme.outline;
              } else {
                return Theme.of(context).colorScheme.primaryContainer;
              }
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Theme.of(context).colorScheme.outline;
              } else {
                return Theme.of(context).colorScheme.onPrimaryContainer;
              }
            }),
          ),
          child: const Text('등록', style: CustomTextStyle.basicBold),
        ),
        const Padding(padding: CustomPadding.regularRight),
      ],
    );
  }
}
