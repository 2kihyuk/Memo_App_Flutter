import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_list_app/Screen/Setting_Page/setting_page.dart';

import 'Screen/Memo_Page/List_Page.dart';
import 'database/drift.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  GetIt.I.registerSingleton<AppDatabase>(database);

  final resp = await database.getMemos();

  print(resp);

  runApp(
     ProviderScope(
       child: MaterialApp(
        home: HomeScreen(),
           ),
     ),
  );
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin{
  int selectedIndex = 0;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(tapListener);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.removeListener(tapListener);
  }

  void tapListener(){
    setState(() {
      selectedIndex = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.white,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          type: BottomNavigationBarType.shifting,
          onTap: (int index) {
            controller.animateTo(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.add), label: '리스트 추가'),
            // BottomNavigationBarItem(icon: Icon(Icons.list), label: '리스트 조회'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: '세팅')
          ]),

      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          AddTodolistScreen(),
          // TodolistScreen(),
          SettingPage(),
        ],
      ),
    );
  }
}
