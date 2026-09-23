import 'package:flowee_app/screens/favorite_screen.dart';
import 'package:flowee_app/screens/home_screen.dart';
import 'package:flowee_app/widgets/buttom_nav_item.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const _screens = [HomeScreen(), FavoriteScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**
       * extendbody: true => akan membuat body bisa terscroll sampai ke belakang navbar bawah yang flooting(melayang)
       * bukan berhenti di atasnya
       */
      extendBody: true,
      body: IndexedStack(index: _selectedIndex, children: _screens,),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 24,
                offset: Offset(0, 10)
              )
            ]
          ),
          child: Row(
            children: [
              Expanded(
                child: ButtomNavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  selected: _selectedIndex == 0,
                  onTap: () => setState(() => _selectedIndex= 0),
                ),
              ),
               Expanded(
                child: ButtomNavItem(
                  icon: Icons.favorite_rounded,
                  label: 'Favorite',
                  selected: _selectedIndex == 1,
                  onTap: () => setState(() => _selectedIndex= 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}