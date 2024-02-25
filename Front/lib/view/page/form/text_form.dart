import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/view/page/form/form_title.dart';

// form:  title + text
class TextForm extends StatelessWidget {
  final TextEditingController textEditingController;
  final String title;
  final bool isRequired;
  final String? validatorText;
  final String hintText;
  final int maxLength;
  final int? maxLengths;

  const TextForm({
    Key? key,
    required this.textEditingController,
    required this.title,
    required this.isRequired,
    this.validatorText,
    required this.hintText,
    required this.maxLength,
    this.maxLengths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormTitle(title: title, isRequired: isRequired),
        TextFormField(
          controller: textEditingController,
          maxLines: maxLengths ?? 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                BorderSide(color: Theme.of(context).colorScheme.outline)),
          ),
          validator: (value) {
            if (value!.isEmpty && isRequired && validatorText!.isNotEmpty) {
              return validatorText;
            }
            return null;
          },
          textInputAction: TextInputAction.done,
        ),
        const Padding(padding: CustomPadding.regularBottom),
      ],
    );
  }
}
