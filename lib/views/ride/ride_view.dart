import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/menu/menu.dart' as menu;

class RideView extends StatelessWidget {
  const RideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.route_title),
      ),
      drawer: const menu.NavigationDrawer(),
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
