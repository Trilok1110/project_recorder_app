import 'package:flutter/material.dart';
import 'package:recorder_app/core/theme/app_theme.dart';
import 'package:recorder_app/features/employee/presentation/pages/employee_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recorder App',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}

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
        title: const Text('My Recorder'),
leading: Icon(Icons.menu),        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.blue,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'RECORDING'),
                Tab(text: 'Employee'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const Center(child: Text('Recording Tab')),
          EmployeePage(),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Placeholder()),
          );
        },
        child: const Icon(Icons.mic, color: Colors.white),
      )
          : null, // FAB only appears on first tab

    );
  }
}
