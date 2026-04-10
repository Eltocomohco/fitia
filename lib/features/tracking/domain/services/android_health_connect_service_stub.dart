import 'android_health_connect_models.dart';
import 'android_health_connect_service.dart';

AndroidHealthConnectService createAndroidHealthConnectService() =>
    _UnsupportedAndroidHealthConnectService();

class _UnsupportedAndroidHealthConnectService
    implements AndroidHealthConnectService {
  @override
  Future<AndroidHealthConnectAvailability> getAvailability() async {
    return AndroidHealthConnectAvailability.unsupported;
  }

  @override
  Future<bool> hasReadAccess() async => false;

  @override
  Future<void> openStoreListing() async {}

  @override
  Future<AndroidHealthMetrics> readTodayMetrics() async {
    return const AndroidHealthMetrics();
  }

  @override
  Future<bool> requestReadAccess() async => false;
}