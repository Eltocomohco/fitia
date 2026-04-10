import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import 'android_health_connect_models.dart';
import 'android_health_connect_service.dart';

AndroidHealthConnectService createAndroidHealthConnectService() =>
    _IoAndroidHealthConnectService();

class _IoAndroidHealthConnectService implements AndroidHealthConnectService {
  static const List<HealthDataType> _permissionTypes = [
    HealthDataType.STEPS,
    HealthDataType.TOTAL_CALORIES_BURNED,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
    HealthDataType.SLEEP_SESSION,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_LIGHT,
    HealthDataType.SLEEP_DEEP,
    HealthDataType.SLEEP_REM,
  ];

  static const List<HealthDataAccess> _readPermissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  final Health _health = Health();
  bool _configured = false;

  bool get _isAndroidTarget => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  @override
  Future<AndroidHealthConnectAvailability> getAvailability() async {
    if (!_isAndroidTarget) {
      return AndroidHealthConnectAvailability.unsupported;
    }

    await _ensureConfigured();
    final status = await _health.getHealthConnectSdkStatus();

    return switch (status) {
      HealthConnectSdkStatus.sdkAvailable =>
        AndroidHealthConnectAvailability.ready,
      HealthConnectSdkStatus.sdkUnavailableProviderUpdateRequired =>
        AndroidHealthConnectAvailability.updateRequired,
      _ => AndroidHealthConnectAvailability.installRequired,
    };
  }

  @override
  Future<bool> hasReadAccess() async {
    if (!_isAndroidTarget) {
      return false;
    }

    final hasActivityRecognition = await _ensureActivityRecognitionPermission(
      requestIfNeeded: false,
    );
    if (!hasActivityRecognition) {
      return false;
    }

    await _ensureConfigured();
    final granted = await _health.hasPermissions(
      _permissionTypes,
      permissions: _readPermissions,
    );
    return granted ?? false;
  }

  @override
  Future<bool> requestReadAccess() async {
    if (!_isAndroidTarget) {
      return false;
    }

    final hasActivityRecognition = await _ensureActivityRecognitionPermission(
      requestIfNeeded: true,
    );
    if (!hasActivityRecognition) {
      return false;
    }

    await _ensureConfigured();
    return _health.requestAuthorization(
      _permissionTypes,
      permissions: _readPermissions,
    );
  }

  @override
  Future<void> openStoreListing() async {
    if (!_isAndroidTarget) {
      return;
    }

    await _ensureConfigured();
    await _health.installHealthConnect();
  }

  @override
  Future<AndroidHealthMetrics> readTodayMetrics() async {
    if (!_isAndroidTarget) {
      return const AndroidHealthMetrics();
    }

    final hasActivityRecognition = await _ensureActivityRecognitionPermission(
      requestIfNeeded: false,
    );
    if (!hasActivityRecognition) {
      return const AndroidHealthMetrics();
    }

    await _ensureConfigured();

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final steps = await _safeRead<int>(
      () async => await _health.getTotalStepsInInterval(startOfDay, now) ?? 0,
      fallback: 0,
      label: 'steps',
    );
    final caloriesBurned = await _safeRead<int>(
      () => _readCaloriesBurned(startOfDay, now),
      fallback: 0,
      label: 'calories',
    );
    final latestSleepWindow = await _safeRead<_SleepWindow>(
      () => _readLatestSleepWindow(now),
      fallback: const _SleepWindow(),
      label: 'sleep',
    );
    final latestHeartRate = await _safeRead<int?>(
      () => _readLatestHeartRate(now),
      fallback: null,
      label: 'heart_rate',
    );

    return AndroidHealthMetrics(
      steps: steps,
      caloriesBurned: caloriesBurned,
      sleepDuration: latestSleepWindow.duration,
      latestSleepStart: latestSleepWindow.start,
      latestSleepEnd: latestSleepWindow.end,
      latestHeartRate: latestHeartRate,
      syncedAt: now,
    );
  }

  Future<void> _ensureConfigured() async {
    if (_configured) {
      return;
    }

    await _health.configure();
    _configured = true;
  }

  Future<bool> _ensureActivityRecognitionPermission({
    required bool requestIfNeeded,
  }) async {
    final status = await Permission.activityRecognition.status;
    if (status.isGranted) {
      return true;
    }
    if (!requestIfNeeded) {
      return false;
    }

    final requested = await Permission.activityRecognition.request();
    return requested.isGranted;
  }

  Future<T> _safeRead<T>(
    Future<T> Function() action, {
    required T fallback,
    required String label,
  }) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      debugPrint('Health Connect read failure ($label): $error');
      debugPrintStack(stackTrace: stackTrace);
      return fallback;
    }
  }

  Future<int> _readCaloriesBurned(DateTime start, DateTime end) async {
    final totalCalories = await _sumNumericValues(
      start,
      end,
      const [HealthDataType.TOTAL_CALORIES_BURNED],
    );
    if (totalCalories > 0) {
      return totalCalories;
    }

    return _sumNumericValues(
      start,
      end,
      const [HealthDataType.ACTIVE_ENERGY_BURNED],
    );
  }

  Future<int> _sumNumericValues(
    DateTime start,
    DateTime end,
    List<HealthDataType> types,
  ) async {
    final points = await _health.getHealthDataFromTypes(
      types: types,
      startTime: start,
      endTime: end,
    );
    var total = 0.0;

    for (final point in points) {
      final value = point.value;
      if (value is NumericHealthValue) {
        total += value.numericValue.toDouble();
      }
    }

    return total.round();
  }

  Future<int?> _readLatestHeartRate(DateTime now) async {
    final points = await _health.getHealthDataFromTypes(
      types: const [HealthDataType.HEART_RATE],
      startTime: now.subtract(const Duration(hours: 24)),
      endTime: now,
    );

    if (points.isEmpty) {
      return null;
    }

    points.sort((a, b) => a.dateTo.compareTo(b.dateTo));
    final latest = points.last.value;
    if (latest is! NumericHealthValue) {
      return null;
    }

    return latest.numericValue.round();
  }

  Future<_SleepWindow> _readLatestSleepWindow(DateTime now) async {
    final rangeStart = now.subtract(const Duration(hours: 36));
    final sessionPoints = await _health.getHealthDataFromTypes(
      types: const [HealthDataType.SLEEP_SESSION],
      startTime: rangeStart,
      endTime: now,
    );

    if (sessionPoints.isNotEmpty) {
      sessionPoints.sort((a, b) => a.dateTo.compareTo(b.dateTo));
      final latestSession = sessionPoints.last;
      return _SleepWindow(
        start: latestSession.dateFrom,
        end: latestSession.dateTo,
      );
    }

    final stagePoints = await _health.getHealthDataFromTypes(
      types: const [
        HealthDataType.SLEEP_ASLEEP,
        HealthDataType.SLEEP_LIGHT,
        HealthDataType.SLEEP_DEEP,
        HealthDataType.SLEEP_REM,
      ],
      startTime: rangeStart,
      endTime: now,
    );

    if (stagePoints.isEmpty) {
      return const _SleepWindow();
    }

    stagePoints.sort((a, b) => a.dateFrom.compareTo(b.dateFrom));

    var mergedStart = stagePoints.first.dateFrom;
    var mergedEnd = stagePoints.first.dateTo;
    var totalDuration = Duration.zero;

    for (final point in stagePoints.skip(1)) {
      if (point.dateFrom.isAfter(mergedEnd)) {
        totalDuration += mergedEnd.difference(mergedStart);
        mergedStart = point.dateFrom;
        mergedEnd = point.dateTo;
        continue;
      }

      if (point.dateTo.isAfter(mergedEnd)) {
        mergedEnd = point.dateTo;
      }
    }

    totalDuration += mergedEnd.difference(mergedStart);
    return _SleepWindow(
      start: mergedStart,
      end: mergedStart.add(totalDuration),
    );
  }
}

class _SleepWindow {
  const _SleepWindow({this.start, this.end});

  final DateTime? start;
  final DateTime? end;

  Duration get duration {
    if (start == null || end == null) {
      return Duration.zero;
    }
    return end!.difference(start!);
  }
}