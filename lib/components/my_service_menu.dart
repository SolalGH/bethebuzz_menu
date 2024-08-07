import 'package:bethebuzz_menu/components/my_service_menu_tile.dart';
import 'package:bethebuzz_menu/my_active_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class MyServiceMenu extends StatelessWidget {
  const MyServiceMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyActiveProvider>(
      builder: (context, provider, _) {
        return Align(
          alignment: Alignment.centerLeft,
          child: ClipRRect(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 300,
              height: provider.isServiceDeployed ? 125 : 0,
              padding: const EdgeInsets.only(top: 10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyServiceMenuTile(
                      text: "Go-To-Market Strategy & Integration"),
                  Gap(5),
                  MyServiceMenuTile(
                      text: "Digital Marketing Program Execution"),
                  Gap(5),
                  MyServiceMenuTile(text: "Creative & Content Development"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
