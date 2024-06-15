import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:lottie/lottie.dart';

class TaxonomyWidget extends StatelessWidget {
  final String speciesName;

  const TaxonomyWidget({Key? key, required this.speciesName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: FutureBuilder<Map<String, String>>(
        future: fetchTaxonomyData(speciesName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Lottie.asset('assets/loading_animation.json'), // Add your Lottie animation file here
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final taxonomyData = snapshot.data!;
            return SizedBox(
              width: 390,
              height: 280.89,
              child: Stack(
                children: [
                  _buildTaxonomyItem('Kingdom', taxonomyData['Kingdom'] ?? ''),
                  _buildTaxonomyItem('Phylum', taxonomyData['Phylum'] ?? ''),
                  _buildTaxonomyItem('Class', taxonomyData['Class'] ?? ''),
                  _buildTaxonomyItem('Order', taxonomyData['Order'] ?? ''),
                  _buildTaxonomyItem('Family', taxonomyData['Family'] ?? ''),
                  _buildTaxonomyItem('Genus', taxonomyData['Genus'] ?? ''),
                  _buildTaxonomyItem('Species', taxonomyData['Species'] ?? ''),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTaxonomyItem(String category, String name) {
    return Positioned(
      left: _leftOffsetForCategory(category),
      top: _topOffsetForCategory(category),
      child: Container(
        width: 400, // Adjusted container width
        height: 41.20,
        padding: const EdgeInsets.only(bottom: 8), // Reduced padding
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: Offset(0, 0), // Adjust the offset if needed
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1), // Set black border
                ),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(1.00, -0.01),
                      end: Alignment(-1, 0.01),
                      colors: [Color(0xFF9C3FE4), Color(0xFFC65647)],
                    ),
                    shape: CircleBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(width: 14),
            SizedBox(
              width: 80, // Adjusted width for the category label
              height: 19,
              child: Text(
                '$category:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 19,
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _leftOffsetForCategory(String category) {
    switch (category) {
      case 'Kingdom':
        return 0;
      case 'Phylum':
        return 31.77;
      case 'Class':
        return 57.67;
      case 'Order':
        return 82.38;
      case 'Family':
        return 108.27;
      case 'Genus':
        return 128.28;
      case 'Species':
        return 154.17;
      default:
        return 0;
    }
  }

  double _topOffsetForCategory(String category) {
    switch (category) {
      case 'Kingdom':
        return 0;
      case 'Phylum':
        return 40;
      case 'Class':
        return 80;
      case 'Order':
        return 120;
      case 'Family':
        return 160;
      case 'Genus':
        return 200;
      case 'Species':
        return 240;
      default:
        return 0;
    }
  }

  Future<Map<String, String>> fetchTaxonomyData(String speciesName) async {
    final response = await http.get(Uri.parse('https://en.wikipedia.org/wiki/$speciesName'));

    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      final taxonomyData = _extractTaxonomyData(document);
      return taxonomyData;
    } else {
      throw Exception('Failed to load taxonomy data');
    }
  }

  Map<String, String> _extractTaxonomyData(dom.Document document) {
    final taxonomyData = <String, String>{};
    final taxonomyTable = document.querySelector('table.infobox.biota');
    final rows = taxonomyTable?.querySelectorAll('tr');

    if (rows != null) {
      for (final row in rows) {
        final cells = row.querySelectorAll('th, td');
        if (cells.length == 2) {
          final category = cells[0].text.trim().replaceAll(':', '');
          final name = cells[1].text.trim();
          taxonomyData[category] = name;
        }
      }
    }
    return taxonomyData;
  }
}
