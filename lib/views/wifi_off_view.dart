import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';

class WifiOffView extends StatelessWidget {
  final ConnectivityResult status;

  const WifiOffView({
    Key? key,
    required this.status,
  }) : super(key: key);

  Widget buildBluetoothOffIcon(BuildContext context) {
    return const Icon(
      Icons.wifi,
      size: 200.0,
      color: Colors.white54,
    );
  }

  Widget buildTitle(BuildContext context) {
    return Text(
      context.loc.offline_wifi,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .primaryTextTheme
          .titleSmall
          ?.copyWith(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildBluetoothOffIcon(context),
              buildTitle(context),
            ],
          ),
        ),
      ),
    );
  }
}
