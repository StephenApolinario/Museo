import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/menu/menu.dart' as menu;

class SouvenirsView extends StatefulWidget {
  const SouvenirsView({super.key});

  @override
  State<SouvenirsView> createState() => _SouvenirsViewState();
}

class _SouvenirsViewState extends State<SouvenirsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const menu.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Souvenirs'),
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
