import 'package:flutter/material.dart' show AppBar, AssetImage, BorderRadius, BoxDecoration, BoxFit, BoxShadow, BuildContext, Center, Colors, Column, Container, DecorationImage, EdgeInsets, Expanded, FontWeight, GestureDetector, MaterialPageRoute, Navigator, Offset, PageController, PageView, Scaffold, Shadow, State, StatefulWidget, Text, TextStyle, Transform, Widget;
import 'province_detail_page.dart';
import 'province_model.dart';

class HomeScreen extends StatefulWidget {
  final List<ProvinceModel> provinces;

  const HomeScreen({super.key, required this.provinces});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ceylon Explore'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.provinces.length,
              itemBuilder: (context, index) {
                final province = widget.provinces[index];
                double scale = (_currentPage - index).abs() < 1
                    ? 1 - (_currentPage - index).abs() * 0.2
                    : 0.8;
                return Transform.scale(
                  scale: scale,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProvinceDetailPage(province: province),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(province.image),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          province.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Swipe vertically to see more about each province',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
