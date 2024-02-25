import 'package:flutter/cupertino.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/view/page/form/form_title.dart';

// form : title + widget
class BasicForm extends StatelessWidget {
  final String title;
  final bool isRequired;
  final Widget widget;

  const BasicForm(
      {Key? key,
      required this.title,
      required this.isRequired,
      required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormTitle(title: title, isRequired: true),
        widget,
        const Padding(padding: CustomPadding.mediumBottom),
      ],
    );
  }
}
