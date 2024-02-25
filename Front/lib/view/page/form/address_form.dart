import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/page/form/basic_form.dart';
import 'package:iris_flutter/view/page/form/address_input_map_dialog.dart';

class AddressForm extends StatelessWidget {
  final String title;
  final dynamic controller;

  const AddressForm({Key? key, required this.title, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicForm(
        title: title,
        isRequired: true,
        widget: Obx(
          () => Column(
            children: [
              OutlinedButton.icon(
                  onPressed: () {
                    showAddressInputMapDialog(controller);
                  },
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  icon: const Icon(Icons.my_location),
                  label: Text(controller.address.value ?? '위치 입력')),
              controller.address.value == null &&
                      controller.initValidation.value != true
                  ? Column(
                      children: [
                        const Padding(padding: CustomPadding.slimBottom),
                        Text(
                          '위치를 입력해 주세요.',
                          style: CustomTextStyle.small.copyWith(
                              color: Theme.of(context).colorScheme.error),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ));
  }
}
