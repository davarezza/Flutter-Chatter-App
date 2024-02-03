import 'package:chatter/pages/calls_page.dart';
import 'package:chatter/pages/contacts_page.dart';
import 'package:chatter/pages/messages_page.dart';
import 'package:chatter/pages/notifications_page.dart';
import 'package:chatter/theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage()
  ];

  var index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: (i) {
          setState(() {
            index = i;
          });
        },
      ),
    );
  }  
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({required this.onItemSelected});

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavigationBarItem(
            index: 0,
            lable: 'Messages',
            isSelected: (selectedIndex == 0),
            icon: Icons.message,
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 1,
            lable: 'Notifications',
            isSelected: (selectedIndex == 1),
            icon: Icons.notification_add,
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 2,
            lable: 'Calls',
            isSelected: (selectedIndex == 2),
            icon: Icons.phone,
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 3,
            lable: 'Contacts',
            isSelected: (selectedIndex == 3),
            icon: Icons.person,
            onTap: handleItemSelected,
          ),
        ],
      ),
      );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    required this.index,
    required this.lable,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  });


  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
              ),
              const SizedBox(
                height: 8,
                ),
            Text(
              lable,
              style: isSelected 
              ? const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
                ) 
              : const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}