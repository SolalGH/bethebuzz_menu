import 'package:bethebuzz_menu/components/my_background_blur.dart';
import 'package:bethebuzz_menu/components/my_button.dart';
import 'package:bethebuzz_menu/components/my_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.blue[900]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Effet de flou
          const MyBackgroundBlur(),

          // Menu
          const MyMenu(),

          // Bouton menu
          const Positioned(
            top: 15,
            right: 15,
            child: MyButton(
              isMenuButton: true,
              size: 80,
            ),
          ),
        ],
      ),
    );
  }
}
