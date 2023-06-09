import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/common/constants.dart';
import 'package:getx_tutorial/viewmodels/controller.dart';
import 'package:getx_tutorial/views/add_record.dart';
import 'package:getx_tutorial/views/graph.dart';
import 'package:getx_tutorial/views/history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0;
  final List<Widget> screens = [GraphScreen(), HistoryScreen()];
  Widget currentScreen = GraphScreen();
  final PageStorageBucket bucket = PageStorageBucket();
  final Controller _controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Get.to(() => AddRecordScreen());
            //_controller.addRecord(Record(dateTime: DateTime.now(), weight: 30.0));
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          height: Get.height / 12,
          leftCornerRadius: Constants.cornerRadii,
          rightCornerRadius: Constants.cornerRadii,
          icons: [FontAwesomeIcons.chartLine, FontAwesomeIcons.history],
          activeColor: Colors.white,
          inactiveColor: Colors.grey.shade400,
          iconSize: 26,
          activeIndex: _currentTab,
          onTap: (int) {
            setState(() {
              setScreen(int);
              _currentTab = int;
            });
          },
          gapLocation: GapLocation.center,
          backgroundColor: Colors.black,
        ));
  }

  void setScreen(int tabIndex) {
    if (tabIndex == 0) {
      currentScreen = GraphScreen();
    } else {
      currentScreen = HistoryScreen();
    }
  }
}
