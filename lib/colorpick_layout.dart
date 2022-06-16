import 'package:flutter/material.dart';

import 'menu_page.dart';

class ColorPickLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MenuPage(),
      ),
    );
  }
}

