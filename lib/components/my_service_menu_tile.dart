import 'package:bethebuzz_menu/my_active_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyServiceMenuTile extends StatefulWidget {
  final String text;
  const MyServiceMenuTile({
    super.key,
    required this.text,
  });

  @override
  State<MyServiceMenuTile> createState() => _MyServiceMenuTileState();
}

class _MyServiceMenuTileState extends State<MyServiceMenuTile>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 125),
      vsync: this,
    );
    _animation = ColorTween(
      begin: const Color(0xFF010561),
      end: Colors.white,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyActiveProvider>(
      builder: (context, provider, _) {
        return MouseRegion(
          onEnter: (event) {
            _animationController.forward();
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (event) {
            _animationController.reverse();
            setState(() {
              _isHovered = false;
            });
          },
          cursor: SystemMouseCursors.click,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 125),
            opacity: provider.isServiceDeployed ? 1 : 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 125),
              decoration: BoxDecoration(
                color: _isHovered ? const Color(0xFF010561) : null,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey[300]!,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(
                widget.text,
                style: GoogleFonts.exo2(
                  color: _animation.value,
                  fontSize: 12.5,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
