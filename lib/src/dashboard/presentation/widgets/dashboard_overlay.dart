import 'dart:math';

import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:montra_app/src/add_transaction/presentation/views/expense_screen.dart';
import 'package:montra_app/src/add_transaction/presentation/views/income_screen.dart';

class DashboardOverlay extends StatefulWidget {
  const DashboardOverlay({super.key});

  @override
  State<DashboardOverlay> createState() => _DashboardOverlayState();
}

class _DashboardOverlayState extends State<DashboardOverlay>
    with SingleTickerProviderStateMixin {
  OverlayEntry? overlayEntry;
  int currentPageIndex = 0;
  ///////////////////////////////////
  bool toggle = true;
  late AnimationController _controller;
  late CurvedAnimation _animation;
  ///////////////////////////////////
  Alignment alignment1 = Alignment.center;
  Alignment alignment2 = Alignment.center;
  Alignment alignment3 = Alignment.center;

  double size1 = 50;
  double size2 = 50;
  double size3 = 50;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 275),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  void createHighlightOverlay() {
    // Remove the existing OverlayEntry.
    removeHighlightOverlay();

    assert(overlayEntry == null, 'Somthing Wrong');

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        // Align is used to position the highlight overlay
        // relative to the NavigationBar destination.
        return SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 180,
              width: 180,
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: toggle
                        ? const Duration(milliseconds: 275)
                        : const Duration(milliseconds: 875),
                    alignment: const Alignment(-0.9, -0.7),
                    curve: toggle ? Curves.easeIn : Curves.elasticOut,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          toggle = !toggle;
                          _controller.reverse();
                          removeHighlightOverlay();
                        });
                        Navigator.pushNamed(
                          context,
                          IncomeScreen.routeName,
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 275),
                        curve: toggle ? Curves.easeIn : Curves.easeOut,
                        height: size1,
                        width: size1,
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: AppColorsLight.greenColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            MediaRes.incomeIcon,
                            color: AppColorsLight.light80Color,
                            width: context.width * 0.08,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedAlign(
                    duration: toggle
                        ? const Duration(milliseconds: 275)
                        : const Duration(milliseconds: 875),
                    alignment: const Alignment(0, -1.4),
                    curve: toggle ? Curves.easeIn : Curves.elasticOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 275),
                      curve: toggle ? Curves.easeIn : Curves.easeOut,
                      height: size2,
                      width: size2,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: AppColorsLight.blueColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          MediaRes.currencyExchangeIcon,
                          color: AppColorsLight.light80Color,
                          width: context.width * 0.08,
                        ),
                      ),
                    ),
                  ),
                  AnimatedAlign(
                    duration: toggle
                        ? const Duration(milliseconds: 275)
                        : const Duration(milliseconds: 875),
                    alignment: const Alignment(0.9, -0.7),
                    curve: toggle ? Curves.easeIn : Curves.elasticOut,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          toggle = !toggle;
                          _controller.reverse();
                          removeHighlightOverlay();
                        });
                        Navigator.pushNamed(
                          context,
                          ExpenseScreen.routeName,
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 275),
                        curve: toggle ? Curves.easeIn : Curves.easeOut,
                        height: size3,
                        width: size3,
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: AppColorsLight.redColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            MediaRes.expenseIcon,
                            color: AppColorsLight.light80Color,
                            width: context.width * 0.08,
                          ),
                        ),
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

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  // Remove the OverlayEntry.
  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    removeHighlightOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _animation.value * pi * (3 / 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 375),
        width: toggle ? 60 : 50,
        height: toggle ? 60 : 50,
        curve: Curves.easeOut,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColorsLight.primaryColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: IconButton(
            splashColor: Colors.black54,
            splashRadius: 31,
            onPressed: () {
              setState(() {
                if (toggle) {
                  toggle = !toggle;
                  _controller.forward();
                  createHighlightOverlay();
                } else {
                  toggle = !toggle;
                  _controller.reverse();
                  removeHighlightOverlay();
                }
              });
            },
            icon: Image.asset(
              MediaRes.addIcon,
              width: 27,
              height: 27,
            ),
          ),
        ),
      ),
    );
  }
}
