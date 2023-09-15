import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/menu/menu.dart' as menu;

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const menu.NavigationDrawer(),
      appBar: AppBar(
        title: Text(context.loc.search),
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
