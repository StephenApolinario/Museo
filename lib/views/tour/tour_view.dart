import 'dart:async';
import 'package:flutter/material.dart';
import 'package:museo/models/beacon/beacons.dart';
import 'package:museo/models/quizz/quiz.dart';
import 'package:museo/models/tour/tour_mode.dart';
import 'package:museo/models/tour/tour_piece.dart';
import 'package:museo/views/quiz/quiz_view.dart';
import 'package:museo/views/tour/bluetooth_off_view.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:museo/views/tour/none_piece_detected_view.dart';
import 'package:museo/views/tour/tour_piece_view.dart';

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
  Beacon? previousBeaconDetected;

  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      startScanning();
    });
  }

  Future startScanning() async {
    if (_isScanning == false) {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    }
    detectNearestBeacon();
  }

  Future stopScanning() async {
    loopScannig = false;
    await FlutterBluePlus.stopScan();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
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
    // TODO:  I dont know yet if i uncomment the next line or not.
    // previousBeaconDetected.clear();
    _scanResults.clear();
    stopScanning();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    // First flow 1.0
    if (_adapterState != BluetoothAdapterState.on) {
      return const BluetoothOffView();
    } else {
      // Just for implement the voice.
      // return TourPieceView(
      //   tourMode: widget.tourMode,
      //   tourPiece: widget.tourMode.tourBeacons[0] as TourPiece,
      // );

      // This logic can be read on detect_beacon_workflow.md

      // 3.0
      // detectNearestBeacon();

      if (previousBeaconDetected != null) {
        if (previousBeaconDetected is Quiz) {
          return QuizView(
              tourMode: widget.tourMode, quiz: previousBeaconDetected as Quiz);
        } else {
          return TourPieceView(
            tourMode: widget.tourMode,
            tourPiece: previousBeaconDetected as TourPiece,
          );
        }
      } else {
        // Executed just on the first time. (When detect a beacon, this MUST never be executed)
        startTimer();
        return const NonePieceDetectedView();
      }
    }

    // Second flow 2.0
    //   if (isWaiting == false) {
    //     if (previousBeaconDetected.isNotEmpty) {
    //       if (previousBeaconDetected.length == 1) {
    //         if (previousBeaconDetected.last is Quiz) {
    //           return QuizView(
    //               tourMode: widget.tourMode,
    //               quiz: previousBeaconDetected.last as Quiz);
    //         } else {
    //           return TourPieceView(
    //             tourMode: widget.tourMode,
    //             tourPiece: previousBeaconDetected.last as TourPiece,
    //           );
    //         }
    //       } else {
    //         // ASK if user want to move to a new piece or stay on the last one
    //         // IF user want to move: clear previousBeaconDetected and add the new beacon
    //         // IF user want to stay on the same beacon: isWaiting = true

    //         // IF User wants to move:
    //         // Just keep the last detected beacon.
    //         previousBeaconDetected.removeRange(
    //             0, previousBeaconDetected.length - 1);
    //         if (previousBeaconDetected.last is Quiz) {
    //           return QuizView(
    //               tourMode: widget.tourMode,
    //               quiz: previousBeaconDetected.last as Quiz);
    //         } else {
    //           return TourPieceView(
    //             tourMode: widget.tourMode,
    //             tourPiece: previousBeaconDetected.last as TourPiece,
    //           );
    //         }
    //       }
    //     }
    //     // Executed just on the first time. (When detect a beacon, this MUST never be executed)
    //     else {
    //       startScanning();
    //       return const NonePieceDetectedView();
    //     }
    //   } else {
    //     // Continue showing the last peice
    //     // Wait xx seconds (User can skip the delay)
    //     // Is waiting = false
    //     return const Text('2.0 NO: Not implemented yet');
    //   }
  }

  void detectNearestBeacon() {
    // Find the nearest beacon and check if exists on tourModeBeacons
    Beacon? findedBeacon;
    int findedBeaconRSSI = 999;

    for (var scannedBluetooth in _scanResults) {
      String scannedBluetoothID = scannedBluetooth.device.remoteId.str;
      int scannedBluetoothRSSI = scannedBluetooth.rssi;

      for (var beacon in widget.tourMode.tourBeacons) {
        if (beacon is Quiz) {
          if (scannedBluetoothID == beacon.beaconUUID &&
              scannedBluetoothRSSI.abs() < beacon.rssi &&
              scannedBluetoothRSSI.abs() < findedBeaconRSSI) {
            findedBeacon = beacon;
            findedBeaconRSSI = scannedBluetoothRSSI.abs();
          }
        } else if (beacon is TourPiece) {
          if (scannedBluetoothID == beacon.beaconUUID &&
              scannedBluetoothRSSI.abs() < beacon.rssi &&
              scannedBluetoothRSSI.abs() < findedBeaconRSSI) {
            findedBeacon = beacon;
            findedBeaconRSSI = scannedBluetoothRSSI.abs();
          }
        }
      }
    }

    if (findedBeacon != null) {
      previousBeaconDetected = findedBeacon;
    }
  }
}
