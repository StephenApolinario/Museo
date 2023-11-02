import 'dart:async';
import 'package:flutter/material.dart';
import 'package:museo/models/museum_piece.dart';
import 'package:museo/models/quiz.dart';
import 'package:museo/models/tour_mode.dart';
import 'package:museo/providers/user/user.dart';
import 'package:museo/services/user_service.dart';
import 'package:museo/views/quiz/quiz_view.dart';
import 'package:museo/views/tour/bluetooth_off_view.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:museo/views/tour/none_piece_detected_view.dart';
import 'package:museo/views/tour/tour_piece_view.dart';
import 'package:provider/provider.dart';

class TourView extends StatefulWidget {
  final TourMode tourMode;

  const TourView({
    super.key,
    required this.tourMode,
  });

  @override
  State<TourView> createState() => _TourViewState();
}

class _TourViewState extends State<TourView> {
  late User userProvider;

  // Bluetooth Adapter State
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  // For bluetooth beacon logic
  // Scan bluetooth devices list
  List<ScanResult> _scanResults = [];
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;
  bool _isScanning = false;
  late bool loopScannig = false;
  late bool isWaiting = false;
  dynamic previousBeaconDetected;

  late Timer timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      startScanning();
    });
  }

  Future startScanning() async {
    if (timer.isActive) {
      timer.cancel();
    }
    if (_isScanning == false && loopScannig) {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
      detectNearestBeacon();
    }
  }

  Future stopScanning() async {
    if (timer.isActive) {
      timer.cancel();
    }
    loopScannig = false;
    await FlutterBluePlus.stopScan();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<User>(context, listen: false);

    loopScannig = true;
    // Bluetooth state
    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      setState(() {});
    });

    // Bluetooth scan result
    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;
      setState(() {});
    });

    // Bluetooth is scanning?
    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    _scanResults.clear();
    previousBeaconDetected.clear();
    stopScanning();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    // First flow 1.0
    if (_adapterState != BluetoothAdapterState.on) {
      return const BluetoothOffView();
    } else {
      if (previousBeaconDetected != null) {
        if (previousBeaconDetected is NewQuiz) {
          return QuizView(
            tourMode: widget.tourMode,
            quiz: previousBeaconDetected as NewQuiz,
          );
        } else {
          return TourPieceView(
            tourMode: widget.tourMode,
            tourPiece: previousBeaconDetected as MuseumPiece,
          );
        }
      } else {
        // Executed just on the first time. (When detect a beacon, this MUST never be executed)
        startTimer();
        return const NonePieceDetectedView();
      }
    }
  }

  void detectNearestBeacon() {
    //foundBeacon can be a Tour Piece/Quiz or "null"
    dynamic foundBeacon;
    int foundBeaconRSSI = 999;

    List<dynamic> beacons = [
      ...widget.tourMode.tourPieces,
      ...widget.tourMode.tourQuizzes
    ];

    for (var scannedBluetooth in _scanResults) {
      String scannedBluetoothID = scannedBluetooth.device.remoteId.str;
      int scannedBluetoothRSSI = scannedBluetooth.rssi;

      // Get the nearest beacon
      var tempFoundBeacon = beacons.firstWhere(
        (beacon) {
          return scannedBluetoothID == beacon.beaconUUID &&
              scannedBluetoothRSSI.abs() < beacon.rssi &&
              scannedBluetoothRSSI.abs() < foundBeaconRSSI;
        },
        orElse: () => null,
      );

      // Check if the beacon has been found and if it is different from the last beacon found
      if (tempFoundBeacon != null &&
          (previousBeaconDetected == null ||
              previousBeaconDetected != tempFoundBeacon)) {
        foundBeaconRSSI = tempFoundBeacon.rssi;
        foundBeacon = tempFoundBeacon;
      }
    }

    if (foundBeacon != null) {
      // Check if it is a quiz and if the user is logged and if already completed the quiz
      if (foundBeacon is NewQuiz && userProvider.logged) {
        final completed = UserService().checkQuiz(context, (foundBeacon).id);
        if (!completed) {
          previousBeaconDetected = foundBeacon;
        }
        // else {
        //   print('I found the quiz but I won't show it because the user has already completed it!');
        // }
      } else if (foundBeacon is MuseumPiece) {
        previousBeaconDetected = foundBeacon;
      }
    }
  }
}
