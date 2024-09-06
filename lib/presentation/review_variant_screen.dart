import 'package:flutter/material.dart';

class ReviewVariantsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productOptions;

  ReviewVariantsScreen({required this.productOptions});

  List<List<String>> _generateVariants(List<Map<String, dynamic>> options) {
    List<List<String>> result = [[]];

    for (var option in options) {
      List<String> values = List<String>.from(option['optionValues']);
      List<List<String>> temp = [];

      for (var variant in result) {
        for (var value in values) {
          temp.add([...variant, value]);
        }
      }
      result = temp;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> variants = _generateVariants(productOptions);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Variants'),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Generated Variants:',
              style: TextStyle(
                fontSize: isWideScreen ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: variants.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        variants[index].join(' / '),
                        style: TextStyle(fontSize: isWideScreen ? 18 : 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, variants);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: isWideScreen ? 20 : 18, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Confirm Variants'),
            ),
          ],
        ),
      ),
    );
  }
}
