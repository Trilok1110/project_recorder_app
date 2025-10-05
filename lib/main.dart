import 'package:flutter/material.dart';
import 'package:recorder_app/core/constants/app_colors.dart';
import 'package:recorder_app/core/theme/app_theme.dart';
import 'package:recorder_app/features/employee/presentation/pages/employee_page.dart';

import 'core/network/api_client.dart';
import 'features/employee/data/data_sources/employee_remote_data_source.dart';
import 'features/employee/data/repositories/employee_repository_impl.dart';
import 'features/employee/domain/usecases/get_employees.dart';
import 'features/employee/presentation/bloc/employee_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeBloc>(
          create: (context) => EmployeeBloc(
            getEmployees: GetEmployees(
              EmployeeRepositoryImpl(
                remoteDataSource: EmployeeRemoteDataSourceImpl(apiClient: ApiClient()),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Recorder App',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
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
        leading: Icon(Icons.menu),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child:TabBar(
              controller: _tabController,
              labelColor: AppColors.primaryBlue,
              unselectedLabelColor: Colors.grey,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: AppColors.primaryBlue,
                  width: 3, // indicator thickness
                ),
                insets: EdgeInsets.symmetric(
                  horizontal:
                  MediaQuery.of(context).size.width * 0.35,
                ),
              ),
              tabs: const [
                Tab(text: 'RECORDING'),
                Tab(text: 'Employee'),
              ],
            )

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
