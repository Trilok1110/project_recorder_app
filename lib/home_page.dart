import 'package:flutter/material.dart';
import 'package:recorder_app/core/constants/app_colors.dart';
import 'package:recorder_app/features/employee/presentation/pages/employee_page.dart';

import 'features/recording/presentation/pages/recording_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NowAWave Voice Recorder'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Image.asset(
              'assets/app_logo.webp',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ],       leading: Icon(Icons.menu),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: AppColors.surfaceWhite,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primaryBlue,
              unselectedLabelColor: AppColors.textTertiary,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: AppColors.primaryBlue, width: 3),
                insets: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.35,
                ),
              ),
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
              tabs: const [
                Tab(text: 'RECORDING'),
                Tab(text: 'EMPLOYEE'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RecordingPage(),
          EmployeePage(),
        ],
      ),
    );
  }
}
