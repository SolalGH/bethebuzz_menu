import 'package:bethebuzz_menu/my_active_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyMainText extends StatefulWidget {
  final double width;
  final String text;
  final Color hoverColor;
  final int introIndex;
  const MyMainText(
      {super.key,
      required this.width,
      required this.text,
      required this.hoverColor,
      required this.introIndex});

  @override
  State<MyMainText> createState() => _MyMainTextState();
}

class _MyMainTextState extends State<MyMainText>
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
            Duration(milliseconds: widget.introIndex * 25 + 250),
            () {
              if (!_animationController.isAnimating &&
                  !_animationController.isCompleted) {
                _animationController.reset();
              }
              _animationController.forward();
            },
          );
        } else {
          Future.delayed(
            Duration(milliseconds: (6 - widget.introIndex) * 25),
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
                  ? (1 - _animationController.value) * -50
                  : 0,
            ),
            child: SizedBox(
              width: widget.width,
              height: 60,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 175),
                    top: _isHovered ||
                            provider.isServiceDeployed &&
                                widget.text == "SERVICES"
                        ? -15 - 60
                        : -15,
                    child: Opacity(
                      opacity: _animationController.value,
                      child: Text(
                        widget.text,
                        style: GoogleFonts.oswald(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF010561),
                          letterSpacing: -4,
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 175),
                    top: _isHovered ||
                            provider.isServiceDeployed &&
                                widget.text == "SERVICES"
                        ? -15
                        : -15 + 60,
                    child: Text(
                      widget.text,
                      style: GoogleFonts.oswald(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: widget.hoverColor,
                        letterSpacing: -4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
