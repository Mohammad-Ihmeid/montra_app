import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/media_res.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          MediaRes.pageUnderConstruction,
          width: context.width * 0.9,
        ),
      ),
    );
  }
}
