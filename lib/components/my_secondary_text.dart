import 'package:bethebuzz_menu/my_active_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MySecondaryText extends StatefulWidget {
  final double width;
  final String text;
  const MySecondaryText({
    super.key,
    required this.width,
    required this.text,
  });

  @override
  State<MySecondaryText> createState() => _MySecondaryTextState();
}

class _MySecondaryTextState extends State<MySecondaryText>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 175),
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
          Future.delayed(
            const Duration(milliseconds: 5 * 25 + 250),
            () {
              _animationController.forward();
            },
          );
        } else {
          Future.delayed(
            const Duration(milliseconds: (6 - 5) * 25),
            () {
              _animationController.reverse();
            },
          );
        }
        return MouseRegion(
          onEnter: (event) {
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              _isHovered = false;
            });
          },
          cursor: SystemMouseCursors.click,
          child: Transform.translate(
            offset: Offset(
              0,
              provider.isMenuActive
                  ? (1 - _animationController.value) * -75
                  : 0,
            ),
            child: Column(
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.exo2(
                    fontSize: 12.5,
                    color: const Color(0xFF010561)
                        .withOpacity(_animationController.value),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: widget.width,
                      height: 4,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF010561)
                              .withOpacity(_animationController.value),
                          width: 0.25,
                        ),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: _isHovered ? widget.width : 0,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5),
                        color: const Color(0xFF010561),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
