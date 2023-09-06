import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/menu/menu.dart' as menu;

class WingsView extends StatelessWidget {
  const WingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const menu.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Alas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.loc.under_construction),
          ],
        ),
      ),
    );
  }
}
