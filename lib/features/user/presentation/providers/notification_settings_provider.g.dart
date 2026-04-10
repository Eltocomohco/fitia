// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier que carga, persiste y reprograma los recordatorios del usuario.

@ProviderFor(NotificationSettings)
const notificationSettingsProvider = NotificationSettingsProvider._();

/// Notifier que carga, persiste y reprograma los recordatorios del usuario.
final class NotificationSettingsProvider
    extends
        $AsyncNotifierProvider<NotificationSettings, NotificationPreferences> {
  /// Notifier que carga, persiste y reprograma los recordatorios del usuario.
  const NotificationSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSettingsHash();

  @$internal
  @override
  NotificationSettings create() => NotificationSettings();
}

String _$notificationSettingsHash() =>
    r'812978b8367ec6518b23bba4a0683d7acb12b8b0';

/// Notifier que carga, persiste y reprograma los recordatorios del usuario.

abstract class _$NotificationSettings
    extends $AsyncNotifier<NotificationPreferences> {
  FutureOr<NotificationPreferences> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<NotificationPreferences>,
              NotificationPreferences
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NotificationPreferences>,
                NotificationPreferences
              >,
              AsyncValue<NotificationPreferences>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
