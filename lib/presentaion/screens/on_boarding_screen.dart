import 'package:baader/presentaion/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/custom_scaffold.dart'; // استيراد المكتبة

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  // بيانات الشرائح
  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Welcome to Baader project for development',
      'description': 'Join us in making the world a better place.',
      'image': 'assets/images/logo1.png',
    },
    {
      'title': 'Support Our Cause',
      'description': 'Your support helps us bring hope to those in need.',
      'image': 'assets/images/OIP1.png',
    },
    {
      'title': 'Get Involved',
      'description':
          'Volunteer, donate, or spread the word to make a difference.',
      'image': 'assets/images/1.png',
    },
  ];

  void _nextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "",
      appBarActions: const Text(""),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      _onboardingData[index]['image']!,
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      _onboardingData[index]['title']!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        _onboardingData[index]['description']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // استخدام SmoothPageIndicator لعرض المؤشرات
          SmoothPageIndicator(
            controller: _pageController,
            count: _onboardingData.length,
            effect: ExpandingDotsEffect(
              dotHeight: MediaQuery.of(context).size.height * 0.01,
              dotWidth: MediaQuery.of(context).size.width * 0.03,
              activeDotColor: Colors.blue,
              dotColor: Colors.white,
            ),
          ),
          // زر التالي/ابدأ
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _nextPage,
              child: Text(
                _currentIndex == _onboardingData.length - 1
                    ? 'Get Started'
                    : 'Next',
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
