import 'package:flutter/material.dart';
import 'province_model.dart';

class ProvinceDetailPage extends StatelessWidget {
  final ProvinceModel province;

  const ProvinceDetailPage({super.key, required this.province});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(province.name),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: province.locations.length,
        itemBuilder: (context, index) {
          final location = province.locations[index];
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(location.image, fit: BoxFit.cover),
                SizedBox(height: 16),
                Text(
                  location.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(location.description),
              ],
            ),
          );
        },
      ),
    );
  }
}
