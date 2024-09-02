import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  ///Variables

  ///update index when page scroll
  void updatePageIndicator(index) {}

  ///jump to the specific dot selected page
  void dotNavigationClick(index) {}

  ///Update current index and jump to the next page
  void nextPage() {}

  ///update current index and jump to the last page
  void skipPage() {}
}
