import 'package:bethebuzz_menu/my_active_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyCloseText extends StatefulWidget {
  const MyCloseText({super.key});

  @override
  State<MyCloseText> createState() => _MyCloseTextState();
}

class _MyCloseTextState extends State<MyCloseText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 125),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyActiveProvider>(
      builder: (context, provider, _) {
        if (provider.isMenuActive) {
          Future.delayed(
            const Duration(milliseconds: 250),
            () {
              _animationController.forward();
            },
          );
        } else {
          _animationController.reverse();
        }
        return Transform.translate(
          offset: Offset((1 - _animation.value) * 30, 0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: provider.isMenuActive ? 250 : 0),
            opacity: _animation.value,
            child: Text(
              "CLOSE",
              style: GoogleFonts.exo2(
                color: const Color(0xFF010561),
                fontWeight: FontWeight.w500,
                letterSpacing: -0.75,
              ),
            ),
          ),
        );
      },
    );
  }
}
