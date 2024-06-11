import 'dart:async';
import 'dart:io';

import 'package:diet/app/core/utils/healty_utils.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';

import 'package:permission_handler/permission_handler.dart';

class HealthApp extends StatefulWidget {
  @override
  _HealthAppState createState() => _HealthAppState();
}

class _HealthAppState extends State<HealthApp> {
  List<HealthDataPoint> healthDataList = [];
  int _nofSteps = 0;

  double totalDistance = 0;

  double distance = 0;

  List<HealthDataType> get types => (Platform.isAndroid)
      ? dataTypesAndroid
      : (Platform.isIOS)
          ? dataTypesIOS
          : [];

  List<HealthDataAccess> get permissions =>
      types.map((e) => HealthDataAccess.READ).toList();

  @override
  void initState() {
    Health().configure(useHealthConnectIfAvailable: true);
    fetchStepData();
    super.initState();
  }

  Future<void> installHealthConnect() async {
    await Health().installHealthConnect();
  }

  Future<void> authorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    var hasPermissions =
        await Health().hasPermissions(types, permissions: permissions);

    hasPermissions = false;

    if (!hasPermissions) {
      try {} catch (error) {
        debugPrint('Exception in authorize: $error');
      }
    }
  }

  Future<void> getHealthConnectSdkStatus() async {
    assert(Platform.isAndroid, 'This is only available on Android');

    await Health().getHealthConnectSdkStatus();

    setState(() {});
  }

  Future<void> fetchStepData() async {
    int? steps;

    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    var distancePermission = await Health()
            .hasPermissions([HealthDataType.DISTANCE_WALKING_RUNNING]) ??
        false;

    if (!distancePermission) {
      distancePermission = await Health()
          .requestAuthorization([HealthDataType.DISTANCE_WALKING_RUNNING]);
    }
    if (distancePermission) {
      try {
        final healthData = await Health().getHealthDataFromTypes(
          types: [HealthDataType.DISTANCE_WALKING_RUNNING],
          startTime: midnight,
          endTime: now,
        );

        var tempTotalDistance = 0.0;
        for (final dataPoint in healthData) {
          if (dataPoint.value is NumericHealthValue) {
            tempTotalDistance +=
                (dataPoint.value as NumericHealthValue).numericValue;
          }
        }

        setState(() {
          healthDataList = healthData;
          totalDistance = tempTotalDistance;
        });
      } catch (error) {
        debugPrint('Exception in getTotalDistanceInInterval: $error');
      }
    }

    var stepsPermission =
        await Health().hasPermissions([HealthDataType.STEPS]) ?? false;
    if (!stepsPermission) {
      stepsPermission =
          await Health().requestAuthorization([HealthDataType.STEPS]);
    }

    if (stepsPermission) {
      try {
        steps = await Health().getTotalStepsInInterval(midnight, now);
      } catch (error) {
        debugPrint('Exception in getTotalStepsInInterval: $error');
      }

      debugPrint('Total number of steps: $steps');

      setState(() {
        _nofSteps = (steps == null) ? 0 : steps;
      });
    } else {
      debugPrint('Authorization not granted - error in authorization');
    }
  }

  Future<void> revokeAccess() async {
    try {
      await Health().revokePermissions();
    } catch (error) {
      debugPrint('Exception in revokeAccess: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Health Example'),
        ),
        body: Column(
          children: [
            Wrap(
              spacing: 10,
              children: [
                TextButton(
                  onPressed: authorize,
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                  child: const Text(
                    'Authenticate',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                if (Platform.isAndroid)
                  TextButton(
                    onPressed: getHealthConnectSdkStatus,
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    child: const Text(
                      'Check Health Connect Status',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                TextButton(
                  onPressed: fetchStepData,
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                  child: const Text(
                    'Fetch Step Data',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: revokeAccess,
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                  child: const Text(
                    'Revoke Access',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                if (Platform.isAndroid)
                  TextButton(
                    onPressed: installHealthConnect,
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    child: const Text(
                      'Install Health Connect',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            const Divider(thickness: 3),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Daily Step : $_nofSteps'),
                    Text(
                      'Total Distance: $totalDistance',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
