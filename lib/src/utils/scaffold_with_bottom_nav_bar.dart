import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/presentation/email_password/utils/email_password_sign_in_form_type.dart';
import 'package:mon_essaye_riverpod/src/routing/app_router.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _selectedIndex = 0;

  void _tap(BuildContext context, int index) {
    if (index == _selectedIndex) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      context.goNamed(AppRoute.jobs.name);
    } else if (index == 1) {
      context.goNamed(AppRoute.entries.name);
    } else if (index == 2) {
      context.goNamed(AppRoute.account.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.work), label: 'Jobs'.hardcoded),
          BottomNavigationBarItem(
              icon: const Icon(Icons.view_headline),
              label: 'Entries'.hardcoded),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: 'Account'.hardcoded),
        ],
        onTap: (index) => _tap(context, index),
      ),
    );
  }
}
