import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/menu/menu.dart' as menu;

class MoviView extends StatelessWidget {
  const MoviView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      drawer: const menu.NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: mainBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          context.loc.about_movi,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/movi.png'),
              const SizedBox(height: 50),
              Text(
                context.loc.about_movi_content,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
