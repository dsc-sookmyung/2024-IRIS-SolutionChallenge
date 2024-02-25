import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  final String genImage;
  final bool genRepresent;

  const ImageCarousel(
      {Key? key,
      required this.images,
      required this.genImage,
      required this.genRepresent})
      : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final controller = CarouselController();
  int activeIndex = 0;
  List<String> fullImages = [];
  int genImageIndex = 0;

  @override
  void initState() {
    //  대표 여부에 따라 ImageCarousel에 보일 전체 이미지 리스트 저장
    if (widget.genRepresent) {
      fullImages.add(widget.genImage);
      fullImages.addAll(widget.images);
      genImageIndex = 0;
    } else {
      fullImages.addAll(widget.images);
      fullImages.add(widget.genImage);
      genImageIndex = fullImages.length - 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider.builder(
                carouselController: controller,
                itemCount: fullImages.length,
                itemBuilder: (context, index, realindex) {
                  final images = fullImages[index];
                  return buildImage(images, index);
                },
                options: CarouselOptions(
                    initialPage: 0,
                    height: 300,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index))),
            Padding(
                padding: CustomPadding.pageInsets,
                child: Row(
                  children: [
                    if (activeIndex != 0)
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                        onPressed: () => {
                          setState(() {
                            activeIndex -= 1;
                            controller.animateToPage(activeIndex);
                          })
                        },
                      ),
                    const Spacer(),
                    if (activeIndex != (fullImages.length - 1))
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () => {
                          setState(() {
                            activeIndex += 1;
                            controller.animateToPage(activeIndex);
                          })
                        },
                      )
                  ],
                ))
          ],
        ),
        const Padding(padding: CustomPadding.regularBottom),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
      onDotClicked: animateToSlide,
      effect: WormEffect(
          activeDotColor: Theme.of(context).colorScheme.primaryContainer,
          dotWidth: 15,
          dotHeight: 15),
      activeIndex: activeIndex,
      count: fullImages.length);

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String urlImage, int index) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(urlImage, fit: BoxFit.cover),
            ),
          ),
          if (index == genImageIndex) ...[
            // genImage가 대표 사진
            genImageInfo()
          ]
        ],
      );

  Center genImageInfo() {
    // genImage 임을 알려주는 안내 위젯
    return Center(
      child: Container(
        padding: const EdgeInsets.all(1.0),
        color: Colors.white.withOpacity(0.5), // 반투명한 하얀 상자
        child: const Text(
          "입력된 정보를 기반으로 \nAI가 생성한 이미지 입니다.",
          style: CustomTextStyle.small,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
