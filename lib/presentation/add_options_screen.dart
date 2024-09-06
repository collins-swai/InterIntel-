import 'package:flutter/material.dart';
import 'package:interintel_pre_screening/presentation/review_variant_screen.dart';

class AddOptionsScreen extends StatefulWidget {
  @override
  _AddOptionsScreenState createState() => _AddOptionsScreenState();
}

class _AddOptionsScreenState extends State<AddOptionsScreen> {
  List<Map<String, dynamic>> options = [];

  void _addOption() {
    setState(() {
      options.add({
        'optionName': TextEditingController(),
        'optionValues': [TextEditingController()],
      });
    });
  }

  void _addOptionValue(int optionIndex) {
    setState(() {
      options[optionIndex]['optionValues'].add(TextEditingController());
    });
  }

  void _removeOptionValue(int optionIndex, int valueIndex) {
    setState(() {
      options[optionIndex]['optionValues'].removeAt(valueIndex);
    });
  }

  void _removeOption(int index) {
    setState(() {
      options.removeAt(index);
    });
  }

  void _saveOptions() {
    List<Map<String, dynamic>> finalOptions = [];

    for (var option in options) {
      final optionName = option['optionName'].text;
      final optionValues = option['optionValues']
          .map((controller) => controller.text)
          .toList();

      finalOptions.add({
        'optionName': optionName,
        'optionValues': optionValues,
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewVariantsScreen(
          productOptions: finalOptions,
        ),
      ),
    ).then((result) {
      if (result != null) {
        List<List<String>> formattedResult = result is List<List<String>> ? List<List<String>>.from(result) : [];

        Navigator.pop(context, formattedResult);
      }
    });
  }

  @override
  void dispose() {
    for (var option in options) {
      option['optionName'].dispose();
      for (var valueController in option['optionValues']) {
        valueController.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product Options & Variants'),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: _saveOptions,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Product Options:',
              style: TextStyle(
                fontSize: isWideScreen ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, optionIndex) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: options[optionIndex]['optionName'],
                            decoration: InputDecoration(
                              labelText: 'Option Name (e.g. Size, Color)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Option Values:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: options[optionIndex]['optionValues'].length,
                            itemBuilder: (context, valueIndex) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: options[optionIndex]['optionValues'][valueIndex],
                                      decoration: InputDecoration(
                                        labelText: 'Value (e.g. Small, Red)',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                                    onPressed: () => _removeOptionValue(optionIndex, valueIndex),
                                    tooltip: 'Remove Value',
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: () => _addOptionValue(optionIndex),
                            icon: Icon(Icons.add, color: Colors.green),
                            label: Text('Add More Values'),
                            style: TextButton.styleFrom(
                              primary: Colors.green,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => _removeOption(optionIndex),
                              icon: Icon(Icons.delete, color: Colors.red),
                              label: Text('Remove Option'),
                              style: TextButton.styleFrom(
                                primary: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addOption,
              child: Text('Add New Option'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
