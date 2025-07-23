import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    'lib/assets/images/onbrd1.jpg',
    'lib/assets/images/onbrd2.jpg',
    'lib/assets/images/onbrd3.png',
  ];

  final List<String> _titles = [
    'Welcome to Ceylon Explorer',
    'Discover New Places',
    'Plan Your Trip',
  ];

  final List<String> _descriptions = [
    'Explore the beauty of Sri Lanka with us!',
    'Find hidden gems and popular destinations.',
    'Create and manage your travel plans easily.',
  ];

  void _completeOnboarding() {
    GoRouter.of(context).go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        child: Image.asset(
                          _images[index],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.broken_image, size: 120, color: Colors.grey),
                              const SizedBox(height: 12),
                              Text('Image not found: \n'+_images[index]+'', style: TextStyle(color: Colors.red, fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _titles[index],
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF4B6F45)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        _descriptions[index],
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
          if (_currentPage == _images.length - 1)
            Positioned(
              bottom: 20,
              left: 40,
              right: 40,
              child: ElevatedButton(
                onPressed: _completeOnboarding,
                child: const Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: Color(0xFF4B6F45),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
