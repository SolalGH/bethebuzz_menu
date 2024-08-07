import 'package:bethebuzz_menu/my_active_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBackgroundBlur extends StatefulWidget {
  const MyBackgroundBlur({super.key});

  @override
  State<MyBackgroundBlur> createState() => _MyBackgroundBlurState();
}

class _MyBackgroundBlurState extends State<MyBackgroundBlur>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyActiveProvider>(
      builder: (context, provider, _) {
        if (provider.isMenuActive) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: _animationController.value * 0.5,
          child: Container(
            color: Colors.deepPurple[900],
          ),
        );
      },
    );
  }
}
