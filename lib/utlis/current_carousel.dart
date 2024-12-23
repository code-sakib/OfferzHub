import 'package:flutter/material.dart';
import 'package:offerzhub/utlis/url_launcher_func.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CurrentCarousel extends StatefulWidget {
  const CurrentCarousel({super.key});

  static List currentCarouselImageList = [
    //mivi
    'https://www.mivi.in/cdn/shop/files/BOGO_-_Sale_-_Desktop.png?v=1710826372&width=2000',
    //lenskart
    'https://firebasestorage.googleapis.com/v0/b/offershub-5e52e.appspot.com/o/currentCarousel%2FScreenshot%202024-08-19%20144848.png?alt=media&token=0658026e-7dcd-4855-a719-8c2cc10e13f0',
    //crocs
    'https://cdn0.desidime.com/attachments/photos/799586/medium/IMG_20220827_202714.jpg?1661612241',
    //bananaClub
    'https://firebasestorage.googleapis.com/v0/b/offershub-5e52e.appspot.com/o/currentCarousel%2FScreenshot%202024-08-19%20144955.png?alt=media&token=a48156ab-8c24-4759-bf28-95037d2928b8',
  ];

  static List currentCarouselOffersList = [
    //mivi
    'https://www.mivi.in/collections/buy-one-get-one?srsltid=AfmBOoqm3nuOKKq732GPWIwR6K92XgUv0ARLmT3BnUijvadvblXG0EXv',
    //lenskart
    'https://www.lenskart.com/sunglasses/promotions/pick-2-pay-for-1-offer.html',
    //crocs
    'https://www.crocs.in/sale/buy-one-get-one-free.html',
    //bananaClub
    'https://bananaclub.co.in/collections/buy-any-2-topwear-1599?srsltid=AfmBOoqA93O9dnPULjPn8hUCIkgKSP9NFLmofNF7k64DQurih20yPc-m',
  ];

  @override
  State<CurrentCarousel> createState() => _CurrentCarouselState();
}

class _CurrentCarouselState extends State<CurrentCarousel> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Exciting offers to find offermate👩🏻‍🤝‍🧑🏻'),
          SizedBox(
            height: 150,
            child: PageView(
              controller: pageController,
              children: [
                GestureDetector(
                  onTap: () => launchUrlFunc(
                      CurrentCarousel.currentCarouselOffersList[0]),
                  child: Image.network(
                    CurrentCarousel.currentCarouselImageList[0],
                    fit: BoxFit.contain,
                  ),
                ),
                GestureDetector(
                  onTap: () => launchUrlFunc(
                      CurrentCarousel.currentCarouselOffersList[1]),
                  child: Image.network(
                    CurrentCarousel.currentCarouselImageList[1],
                    fit: BoxFit.contain,
                  ),
                ),
                GestureDetector(
                  onTap: () => launchUrlFunc(
                      CurrentCarousel.currentCarouselOffersList[2]),
                  child: Image.network(
                    CurrentCarousel.currentCarouselImageList[2],
                    fit: BoxFit.contain,
                  ),
                ),
                GestureDetector(
                  onTap: () => launchUrlFunc(
                      CurrentCarousel.currentCarouselOffersList[3]),
                  child: Image.network(
                    CurrentCarousel.currentCarouselImageList[3],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmoothPageIndicator(
                controller: pageController,
                count: 4,
                effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.deepPurple, dotHeight: 8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
