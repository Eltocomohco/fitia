import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

import '../../../tracking/presentation/providers/body_profile_provider.dart';
import '../../../tracking/domain/services/android_health_connect_models.dart';
import '../../../tracking/domain/services/android_health_connect_service.dart';

enum HealthConnectCardStatus {
  unsupported,
  installRequired,
  permissionsRequired,
  ready,
  error,
}

class HealthConnectCardState {
  const HealthConnectCardState({
    required this.status,
    this.metrics = const AndroidHealthMetrics(),
    this.message,
  });

  const HealthConnectCardState.unsupported()
    : this(
        status: HealthConnectCardStatus.unsupported,
        message: 'Disponible solo en Android mediante Health Connect.',
      );

  const HealthConnectCardState.installRequired()
    : this(
        status: HealthConnectCardStatus.installRequired,
        message:
            'Instala o actualiza Health Connect para sincronizar pasos, sueño y calorías.',
      );

  const HealthConnectCardState.permissionsRequired()
    : this(
        status: HealthConnectCardStatus.permissionsRequired,
        message:
            'Concede permisos de lectura para importar métricas de actividad y descanso.',
      );

  const HealthConnectCardState.ready(AndroidHealthMetrics metrics)
    : this(status: HealthConnectCardStatus.ready, metrics: metrics);

  const HealthConnectCardState.error(String message)
    : this(status: HealthConnectCardStatus.error, message: message);

  final HealthConnectCardStatus status;
  final AndroidHealthMetrics metrics;
  final String? message;

  HealthConnectCardState copyWith({
    HealthConnectCardStatus? status,
    AndroidHealthMetrics? metrics,
    String? message,
  }) {
    return HealthConnectCardState(
      status: status ?? this.status,
      metrics: metrics ?? this.metrics,
      message: message ?? this.message,
    );
  }
}

final healthConnectServiceProvider = Provider<AndroidHealthConnectService>((
  ref,
) {
  return AndroidHealthConnectService();
});

final healthConnectProvider =
    AsyncNotifierProvider<HealthConnectNotifier, HealthConnectCardState>(
      HealthConnectNotifier.new,
    );

class HealthConnectNotifier extends AsyncNotifier<HealthConnectCardState> {
  AndroidHealthConnectService get _service => ref.read(
    healthConnectServiceProvider,
  );

  @override
  Future<HealthConnectCardState> build() => _load();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _load());
  }

  Future<void> requestAccess() async {
    state = const AsyncLoading();

    try {
      final availability = await _service.getAvailability();
      if (availability == AndroidHealthConnectAvailability.installRequired ||
          availability == AndroidHealthConnectAvailability.updateRequired) {
        state = const AsyncData(HealthConnectCardState.installRequired());
        return;
      }

      final granted = await _service.requestReadAccess();
      if (!granted) {
        state = const AsyncData(HealthConnectCardState.permissionsRequired());
        return;
      }

      state = AsyncData(await _load());
    } catch (error, stackTrace) {
      debugPrint('Health Connect access request failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      state = const AsyncData(
        HealthConnectCardState.error(
          'No se pudieron solicitar los permisos de Health Connect. Revisa tambien el permiso de actividad fisica.',
        ),
      );
    }
  }

  Future<void> openInstallPage() async {
    await _service.openStoreListing();
  }

  Future<HealthConnectCardState> _load() async {
    try {
      final availability = await _service.getAvailability();
      switch (availability) {
        case AndroidHealthConnectAvailability.unsupported:
          return const HealthConnectCardState.unsupported();
        case AndroidHealthConnectAvailability.installRequired:
        case AndroidHealthConnectAvailability.updateRequired:
          return const HealthConnectCardState.installRequired();
        case AndroidHealthConnectAvailability.ready:
          break;
      }

      final hasPermissions = await _service.hasReadAccess();
      if (!hasPermissions) {
        return const HealthConnectCardState.permissionsRequired();
      }

      final metrics = await _service.readTodayMetrics();
      try {
        await ref
            .read(bodyProfileProvider.notifier)
            .syncHealthMetrics(
              pasosDiarios: metrics.steps,
              suenoInicio: metrics.latestSleepStart,
              suenoFin: metrics.latestSleepEnd,
            );
      } catch (error, stackTrace) {
        debugPrint('Health Connect sync into profile failed: $error');
        debugPrintStack(stackTrace: stackTrace);
      }
      return HealthConnectCardState.ready(metrics);
    } catch (error, stackTrace) {
      debugPrint('Health Connect load failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      return const HealthConnectCardState.error(
        'Health Connect dio error al leer datos. Revisa permisos de actividad fisica y vuelve a conectar.',
      );
    }
  }
}