import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';

class SouvenirsView extends StatefulWidget {
  const SouvenirsView({super.key});

  @override
  State<SouvenirsView> createState() => _SouvenirsViewState();
}

class _SouvenirsViewState extends State<SouvenirsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.souvenirs),
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
