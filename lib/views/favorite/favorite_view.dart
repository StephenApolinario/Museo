import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.favorite,
        ),
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
