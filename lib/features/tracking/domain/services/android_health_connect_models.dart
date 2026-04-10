enum AndroidHealthConnectAvailability {
  unsupported,
  ready,
  installRequired,
  updateRequired,
}

class AndroidHealthMetrics {
  const AndroidHealthMetrics({
    this.steps = 0,
    this.caloriesBurned = 0,
    this.sleepDuration = Duration.zero,
    this.latestSleepStart,
    this.latestSleepEnd,
    this.latestHeartRate,
    this.syncedAt,
  });

  final int steps;
  final int caloriesBurned;
  final Duration sleepDuration;
  final DateTime? latestSleepStart;
  final DateTime? latestSleepEnd;
  final int? latestHeartRate;
  final DateTime? syncedAt;

  bool get hasAnyData =>
      steps > 0 ||
      caloriesBurned > 0 ||
      sleepDuration > Duration.zero ||
      latestHeartRate != null;
}