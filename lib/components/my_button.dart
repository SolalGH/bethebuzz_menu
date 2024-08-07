import 'dart:math';

import 'package:bethebuzz_menu/my_active_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyButton extends StatefulWidget {
  final bool isMenuButton;
  final double size;
  const MyButton({
    super.key,
    required this.isMenuButton,
    required this.size,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late bool
      _isPressed = false;

  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: widget.isMenuButton ? 250 : 125),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0, end: widget.isMenuButton ? pi  : -pi / 4)
            .animate(_animationController)
          ..addListener(() {
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
    return AnimatedScale(
      duration: const Duration(milliseconds: 125),
      scale: _isHovered ? 1.1 : 1,
      child: MouseRegion(
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
        child: GestureDetector(
          onTap: () {
            if (widget.isMenuButton) {
              if (!_isPressed) {
                // Faire disparaître les autres lignes
                setState(() {
                  _isPressed = true;
                });

                Future.delayed(
                  const Duration(milliseconds: 125),
                  () {
                    // Faire tourner la ligne du milieu
                    _animationController.forward();
                  },
                );

                // Afficher le menu
                Future.delayed(
                  const Duration(milliseconds: 375),
                  () {
                    Provider.of<MyActiveProvider>(context, listen: false)
                        .setIsMenuActive(true);
                  },
                );
              } else {
                // Faire tourner la ligne du milieu
                _animationController.reverse();

                Future.delayed(
                  const Duration(milliseconds: 250),
                  () {
                    // Faire disparaître les autres lignes
                    setState(() {
                      _isPressed = false;
                    });
                  },
                );

                // Enlever le menu
                Future.delayed(
                  const Duration(milliseconds: 375),
                  () {
                    Provider.of<MyActiveProvider>(context, listen: false)
                        .setIsMenuActive(false);
                  },
                );
              }
            } else {
              if (!_isPressed) {
                _animationController.forward();
                Provider.of<MyActiveProvider>(context, listen: false)
                    .setIsServiceDeployed(true);
              } else {
                _animationController.reverse();
                Provider.of<MyActiveProvider>(context, listen: false)
                    .setIsServiceDeployed(false);
              }
              _isPressed = !_isPressed;
            }
          },
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              boxShadow: [
                BoxShadow(
                  color: widget.isMenuButton
                      ? Colors.black.withOpacity(0.25)
                      : Colors.transparent,
                  offset: const Offset(-3, 5),
                  blurRadius: 7.5,
                ),
              ],
            ),
            child: widget.isMenuButton
                ? Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 125),
                        top: _isPressed
                            ? widget.size / 2 - 1
                            : widget.size / 2 - 1 - 5,
                        left: widget.size / 2 - 10,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 125),
                          opacity: _isPressed ? 0 : 1,
                          child: Container(
                            width: 20,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: widget.size / 2 - 1,
                        left: widget.size / 2 - 10,
                        child: Transform.rotate(
                          angle: _animation.value,
                          child: Container(
                            width: 20,
                            height: 2,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 125),
                        top: _isPressed
                            ? widget.size / 2 - 1
                            : widget.size / 2 - 1 + 5,
                        left: widget.size / 2 - 10,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 125),
                          opacity: _isPressed ? 0 : 1,
                          child: Container(
                            width: 20,
                            height: 2,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                    ],
                  )
                : Transform.rotate(
                    angle: _animation.value,
                    child: Icon(
                      Icons.add,
                      color: Colors.blue[900],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
