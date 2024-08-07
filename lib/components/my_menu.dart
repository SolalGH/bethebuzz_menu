import 'package:bethebuzz_menu/components/my_button.dart';
import 'package:bethebuzz_menu/components/my_close_text.dart';
import 'package:bethebuzz_menu/components/my_contact_button.dart';
import 'package:bethebuzz_menu/components/my_main_text.dart';
import 'package:bethebuzz_menu/components/my_secondary_text.dart';
import 'package:bethebuzz_menu/components/my_service_menu.dart';
import 'package:bethebuzz_menu/my_active_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class MyMenu extends StatefulWidget {
  const MyMenu({super.key});

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animation = Tween<double>(
          begin: 0,
          end: MediaQuery.of(context).size.width * 0.6,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOutQuart,
          ),
        )..addListener(() {
            setState(() {});
          });
      });
    });
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
        return Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(7.5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: _animation?.value ?? 0,
              decoration: BoxDecoration(
                color: Colors.grey[100]!.withOpacity(
                  _animationController.value <= 0.5
                      ? _animationController.value + 0.5
                      : 1,
                ),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 80 / 2 - 3,
                      right: 100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // CLOSE
                        MyCloseText(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                        left: 80,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // SERVICES
                              const MyMainText(
                                width: 205,
                                text: "SERVICES",
                                hoverColor: Color(0xFF5E29F9),
                                introIndex: 1,
                              ),
                              Gap(MediaQuery.of(context).size.width * 0.01),

                              // Bouton +
                              const MyButton(
                                isMenuButton: false,
                                size: 60,
                              ),
                            ],
                          ),

                          // Menu SERVICES
                          const MyServiceMenu(),

                          // PLANS
                          const MyMainText(
                            width: 205,
                            text: "PLANS",
                            hoverColor: Color(0xFFFE9421),
                            introIndex: 2,
                          ),

                          // SUCCESS STORIES
                          const MyMainText(
                            width: 205,
                            text: "SUCCESS STORIES",
                            hoverColor: Color(0xFFF35356),
                            introIndex: 3,
                          ),

                          // BLOG
                          const MyMainText(
                            width: 205,
                            text: "BLOG",
                            hoverColor: Color(0xFFE60696),
                            introIndex: 4,
                          ),
                          const Gap(40),
                          const Row(
                            children: [
                              // TEAM
                              MySecondaryText(
                                width: 35,
                                text: "TEAM",
                              ),

                              Gap(30),

                              // CAREERS
                              MySecondaryText(
                                width: 50,
                                text: "CAREERS",
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),

                  // Contact
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 50,
                      left: 80,
                    ),
                    child: MyContactButton(),
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
