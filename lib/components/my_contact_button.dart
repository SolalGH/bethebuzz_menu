import 'package:bethebuzz_menu/my_active_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyContactButton extends StatefulWidget {
  const MyContactButton({super.key});

  @override
  State<MyContactButton> createState() => _MyContactButtonState();
}

class _MyContactButtonState extends State<MyContactButton>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _colorAnimationController;
  late Animation _colorAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 175),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _colorAnimationController = AnimationController(
      duration: const Duration(milliseconds: 175),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _colorAnimation = ColorTween(
        begin: const Color(0xFF010561),
        end: const Color(
          0xFF5E29F9,
        )).animate(_colorAnimationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _colorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyActiveProvider>(
      builder: (context, provider, _) {
        if (provider.isMenuActive) {
          Future.delayed(
            const Duration(milliseconds: 6 * 25 + 250),
            () {
              _animationController.forward();
            },
          );
        } else {
          Future.delayed(
            const Duration(milliseconds: 0),
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
            _colorAnimationController.forward();
          },
          onExit: (event) {
            setState(() {
              _isHovered = false;
            });
            _colorAnimationController.reverse();
          },
          cursor: SystemMouseCursors.click,
          child: Transform.translate(
            offset: Offset(
              0,
              provider.isMenuActive
                  ? (1 - _animationController.value) * -50
                  : 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Keycaps
                Container(
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF010561),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Stack(
                    children: [
                      // Flèche par défaut
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 175),
                        top: 30 / 2 - 25 / 2,
                        left:
                            _isHovered ? 40 / 2 - 25 / 2 + 40 : 40 / 2 - 25 / 2,
                        child: Transform.flip(
                          flipX: true,
                          child: const Icon(
                            CupertinoIcons.return_icon,
                            color: Color(0xFF010561),
                          ),
                        ),
                      ),

                      // Flèche + Arrière plan coloré (onHover)
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 175),
                        left: _isHovered ? 0 : -45,
                        child: Container(
                          width: 40,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xFF5E29F9),
                          ),
                          child: Transform.flip(
                            flipX: true,
                            child: const Icon(
                              CupertinoIcons.return_icon,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(15),

                // Text
                Text(
                  "GROW@BETHEBUZZ.CO",
                  style: GoogleFonts.gupter(
                    fontSize: 30,
                    fontWeight: FontWeight.w100,
                    color: _colorAnimation.value,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
