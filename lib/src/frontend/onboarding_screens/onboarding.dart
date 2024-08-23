import 'package:flutter/material.dart';
import 'package:simplyputapp/src/frontend/onboarding_screens/onboarding_images.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///Horiozntal scrollable pages
          PageView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.6,
                        image: const AssetImage(SPImages.onBoardingImage1)),
                    Text(
                      SPImagesText.onBoardingTitle1,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      SPImagesText.onBoardingSubtitle1,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            ],
          )

          ///Skip button

          ///Dot Navigation smoith indicator

          /// Circular button
        ],
      ),
    );
  }
}
