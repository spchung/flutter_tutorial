import 'package:flutter/material.dart';
import 'package:flutter_template/providers/counter.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_template/providers/tab_navigator.dart';
import 'package:flutter_template/widgets/profile/profile.dart';
import 'package:flutter_template/widgets/home/home.dart';


class HomeNavigator extends StatelessWidget {
  HomeNavigator({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final tabProvider = context.watch<TabNavigatorProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: IndexedStack(
        index: tabProvider.tabIndex,
        children: const [
          HomePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (idx) => GetIt.instance<TabNavigatorProvider>().setTabIndex(idx),
      ),
    );
  }
}
