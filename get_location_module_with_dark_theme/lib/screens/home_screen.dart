import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:get_location_module_with_dark_theme/providers/my_colors_provider.dart';

import 'package:get_location_module_with_dark_theme/widgets/get_location_widget.dart';

import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<MyColors>(context);
    return Scaffold(
      //backgroundColor: themeData.myBackGroundColor,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: themeData.isDark ? Colors.black : Colors.white,
        child: Stack(
          children: [
            myEyeCover(themeData.isDark),
            Column(
              children: [
                const SizedBox(height: 100),
                customAppBar(context, themeData.myText),
                const SizedBox(height: 80),
                const GetLocation(),
              ],
            ),

          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          themeData.toggleTheme();
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Icon(themeData.isDark
            ? Icons.toggle_on_outlined
            : Icons.toggle_off_outlined,
            color: themeData.myText),
      ),
    );
  }

  Widget myEyeCover(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: isDark ? Colors.black.withOpacity(0.5) : Colors.transparent,
    );
  }
}
