import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wildsense/screens/dashboardpages/historyscreen/historyscreenwidgets/customchart.dart';
import 'package:wildsense/screens/dashboardpages/historyscreen/historyscreenwidgets/historylistview.dart';
import 'package:wildsense/screens/dashboardpages/historyscreen/historyscreenwidgets/todayshistory.dart';

class ChartData {
  final String label;
  final num value;

  ChartData({required this.label, required this.value});
}

class UserHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeInOut,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/newbackground.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 25, left: 16),
                  child: Text(
                    'My History & Statistics',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'SF Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Todays History',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SF Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // Horizontal scroll view with items
                TodayHistory(),
                SizedBox(height: 20),
                Divider(
                  color: Colors.white,
                ),
                // Space between sections
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'History Visibility',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SF Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // Card with circular statistics and text
                CustomChart(),
                SizedBox(height: 20),
                Divider(
                  color: Colors.white,
                ),
                // Space between sections
                SizedBox(height: 20),
                // Vertical scroll view with single card per line
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Past History',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SF Pro',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Filter: ',
                            style: TextStyle(fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<String>(
                            value: 'Last 7 days',
                            onChanged: (String? value) {
                              // Implement filter functionality here
                              print('Selected filter: $value');
                            },
                            items: <String>['Today', 'Last 7 days', 'Last month']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // ListView for vertical scrolling with single card per line
                ListViewBuilderHistory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

