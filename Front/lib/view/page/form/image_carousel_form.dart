import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// form: 이미지 캐로셀
class ImageCarouselForm extends StatefulWidget {
  final String title;
  final dynamic controller;

  const ImageCarouselForm(
      {Key? key, required this.title, required this.controller})
      : super(key: key);

  @override
  State<ImageCarouselForm> createState() => _ImageCarouselFormState();
}

class _ImageCarouselFormState extends State<ImageCarouselForm> {
  CarouselController carouselController = CarouselController();
  int activeIndex = 0;

  @override
  void initState() {
    widget.controller.images.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        widget.controller.images.isEmpty ? addInitImage() : imageCarousel());
  }

  Widget addInitImage() {
    return Padding(
      padding: CustomPadding.thickBottom,
      child: Column(
        children: [
          OutlinedButton(
            onPressed: () {
              widget.controller.pickImage();
            },
            style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 250),
                foregroundColor: Theme.of(context).colorScheme.primary,
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            child: Column(
              children: [
                const Text(''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_circle_outline),
                    const Padding(padding: CustomPadding.slimRight),
                    Text('${widget.title} 사진 추가')
                  ],
                ),
                Text(
                  '(최대 3장)',
                  style: CustomTextStyle.small.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => widget.controller.images.isEmpty &&
                    widget.controller.initValidation.value != true
                ? Column(
                  children: [
                    const Padding(padding: CustomPadding.slimBottom),
                    Text(
                      '사진을 추가해 주세요.',
                      style: CustomTextStyle.small
                          .copyWith(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget imageCarousel() {
    return Column(
      children: [
        Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              // Carousel
              CarouselSlider.builder(
                  carouselController: carouselController,
                  itemCount: widget.controller.images.length,
                  itemBuilder: (context, index, realindex) {
                    final image = widget.controller.images[index];
                    return buildImage(image.path, index);
                  },
                  options: CarouselOptions(
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index))),
              // 좌우 키
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      if (activeIndex != 0)
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                          onPressed: () => {
                            setState(() {
                              activeIndex -= 1;
                              carouselController.animateToPage(activeIndex);
                            })
                          },
                        ),
                      const Spacer(),
                      if (activeIndex != (widget.controller.images.length - 1))
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                          onPressed: () => {
                            setState(() {
                              activeIndex += 1;
                              carouselController.animateToPage(activeIndex);
                            })
                          },
                        )
                    ],
                  )),
              // 삭제 아이콘
              Positioned(
                  top: 3,
                  right: MediaQuery.of(context).size.width / 9,
                  child: IconButton(
                      onPressed: () {
                        widget.controller.images.removeAt(activeIndex);
                      },
                      icon: const Icon(Icons.delete_outline),
                      style: IconButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))))
            ],
          ),
        ),
        const Padding(padding: CustomPadding.regularBottom),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.controller.images.length + 1 <= Config.maxImagesLength
                  ? const SizedBox(
                      width: 100,
                    )
                  : const SizedBox(),
              buildIndicator(widget.controller),

              // 추가 버튼
              widget.controller.images.length + 1 <= Config.maxImagesLength
                  ? OutlinedButton.icon(
                      onPressed: () {
                        widget.controller.pickImage();
                      },
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size(40, 35),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text('추가'))
                  : const SizedBox(),
            ],
          ),
        ),
        const Padding(padding: CustomPadding.regularBottom),
      ],
    );
  }

  Widget buildImage(String imagePath, int index) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.file(
              File(imagePath),
              height: 200,
              fit: BoxFit.fitHeight,
            )));
  }

  Widget buildIndicator(dynamic controller) {
    return AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: WormEffect(
            activeDotColor: Theme.of(context).colorScheme.primaryContainer,
            dotWidth: 15,
            dotHeight: 15),
        activeIndex: activeIndex,
        count: controller.images.length);
  }

  void animateToSlide(int index) => carouselController.animateToPage(index);
}
