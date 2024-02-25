import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';

// text Field 의 제목
class FormTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  const FormTitle({Key? key,
    required this.title,
    required this.isRequired,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: CustomTextStyle.basicBold,
            ),
            isRequired == true
                ? Text(
              '*',
              style: CustomTextStyle.basicBold.copyWith(color: Theme.of(context).colorScheme.error),
            )
                : const SizedBox()
          ],
        ),
        const Padding(padding: CustomPadding.slimBottom),
      ],
    );
  }
}
