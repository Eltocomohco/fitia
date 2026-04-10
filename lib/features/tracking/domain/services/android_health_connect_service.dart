import 'android_health_connect_models.dart';
import 'android_health_connect_service_stub.dart'
    if (dart.library.io) 'android_health_connect_service_io.dart' as impl;

abstract class AndroidHealthConnectService {
  factory AndroidHealthConnectService() =>
      impl.createAndroidHealthConnectService();

  Future<AndroidHealthConnectAvailability> getAvailability();

  Future<bool> hasReadAccess();

  Future<bool> requestReadAccess();

  Future<void> openStoreListing();

  Future<AndroidHealthMetrics> readTodayMetrics();
}