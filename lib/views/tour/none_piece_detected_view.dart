import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';

class NonePieceDetectedView extends StatelessWidget {
  const NonePieceDetectedView({Key? key}) : super(key: key);

  Widget buildNearIcon(BuildContext context) {
    return const Icon(
      Icons.near_me,
      size: 200.0,
      color: Colors.white54,
    );
  }

  Widget buildTitle(BuildContext context) {
    return Text(
      context.loc.move_near,
      style: Theme.of(context)
          .primaryTextTheme
          .titleSmall
          ?.copyWith(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.loc.lets_start)),
      body: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildNearIcon(context),
              buildTitle(context),
            ],
          ),
        ),
      ),
    );
  }
}
