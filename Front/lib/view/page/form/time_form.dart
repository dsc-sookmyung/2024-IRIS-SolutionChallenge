import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/page/form/basic_form.dart';

class TimeForm extends StatefulWidget {
  final String title;
  final dynamic controller;

  const TimeForm({super.key, required this.title, required this.controller});

  @override
  State<TimeForm> createState() => _TimeFormState();
}

class _TimeFormState extends State<TimeForm> {
  @override
  Widget build(BuildContext context) {
    return BasicForm(
        title: widget.title,
        isRequired: true,
        widget: Obx(
          () => Column(
            children: [
              OutlinedButton.icon(
                  onPressed: () async {
                    // set initial Time
                    TimeOfDay timeOfDay;
                    if (widget.controller.timeOfDay.value != null) {
                      timeOfDay = widget.controller.timeOfDay.value;
                    } else {
                      timeOfDay = TimeOfDay.now();
                    }

                    showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('취소')),
                                    TextButton(
                                        onPressed: () {
                                          widget.controller.timeOfDay.value =
                                              timeOfDay;
                                          Get.back();
                                        },
                                        child: const Text('저장')),
                                  ],
                                ),
                                CupertinoTimerPicker(
                                  mode: CupertinoTimerPickerMode.hm,
                                  minuteInterval: 1,
                                  onTimerDurationChanged: (Duration value) {
                                    setState(() {
                                      timeOfDay = TimeOfDay(hour: value.inHours, minute: value.inMinutes.remainder(60));
                                    });
                                  },
                                  initialTimerDuration: Duration(
                                      hours: timeOfDay.hour,
                                      minutes: timeOfDay.minute),
                                ),
                              ],
                            ),
                          );
                        });
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
                  icon: const Icon(Icons.access_time),
                  label: Text(widget.controller.timeOfDay.value == null
                      ? '시간 입력'
                      : '${widget.controller.timeOfDay.value?.hour.toString().padLeft(2,"0")} : ${widget.controller.timeOfDay.value?.minute.toString().padLeft(2,"0")}')),
              widget.controller.timeOfDay.value == null &&
                      widget.controller.initValidation.value != true
                  ? Column(
                      children: [
                        const Padding(padding: CustomPadding.slimBottom),
                        Text(
                          '시간을 입력해 주세요.',
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
