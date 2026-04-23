import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/notifications/local_notification_service.dart';
import 'core/database/isar_config.dart';
import 'core/router/app_router.dart';
import 'core/services/audio_player_service.dart';
import 'core/services/home_widget_service.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/presentation/widgets/startup_splash_overlay.dart';
import 'features/user/data/models/notification_preferences.dart';
import 'features/workouts/data/services/workout_seed_service.dart';
import 'dev/seed_test_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('No se pudo cargar el archivo .env: $e');
  }
  runApp(const ProviderScope(child: AppBootstrap()));
}

class AppBootstrap extends ConsumerStatefulWidget {
  const AppBootstrap({super.key});

  @override
  ConsumerState<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends ConsumerState<AppBootstrap> {
  static const _minimumSplashDuration = Duration(milliseconds: 2550);

  Future<void>? _bootstrapFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _bootstrapFuture = _bootstrap();
      });
    });
  }

  Future<void> _bootstrap() async {
    await Future.wait<void>([
      _initializeServices(),
      Future<void>.delayed(_minimumSplashDuration),
    ]);
  }

  Future<void> _initializeServices() async {
    final isar = await IsarConfig.ensureInitialized();

    await Future.wait([
      _runBootstrapStep('HomeWidgetService.init', HomeWidgetService.init),
      _runBootstrapStep(
        'WorkoutAudioService.ensureInitialized',
        WorkoutAudioService.ensureInitialized,
      ),
      _runBootstrapStep(
        'LocalNotificationService.initialize',
        LocalNotificationService.instance.initialize,
      ),
    ]);

    await Future.wait([
      _runBootstrapStep('seedTestData', () => seedTestData(isar)),
      _runBootstrapStep(
        'WorkoutSeedService.seedExercisesIfEmpty',
        () => WorkoutSeedService.seedExercisesIfEmpty(isar),
      ),
    ]);

    await _runBootstrapStep('LocalNotificationService.rescheduleAll', () async {
      final preferences =
          await isar.notificationPreferences.get(1) ?? NotificationPreferences();
      await LocalNotificationService.instance.rescheduleAll(preferences);
    });
  }

  Future<void> _runBootstrapStep(
    String stepName,
    Future<void> Function() step,
  ) async {
    try {
      await step();
    } catch (error, stackTrace) {
      debugPrint('Bootstrap step failed ($stepName): $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bootstrapFuture = _bootstrapFuture;

    if (bootstrapFuture == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nutrition Offline',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const StartupSplashScreen(duration: _minimumSplashDuration),
      );
    }

    return FutureBuilder<void>(
      future: bootstrapFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Nutrition Offline',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.system,
            home: _BootstrapErrorScreen(onRetry: _retryBootstrap),
          );
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Nutrition Offline',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.system,
            home: const StartupSplashScreen(duration: _minimumSplashDuration),
          );
        }

        return const AppEntryPoint();
      },
    );
  }

  void _retryBootstrap() {
    setState(() {
      _bootstrapFuture = _bootstrap();
    });
  }
}

class AppEntryPoint extends ConsumerWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MainApp();
  }
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Nutrition Offline',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

class _BootstrapErrorScreen extends StatelessWidget {
  const _BootstrapErrorScreen({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 42),
              const SizedBox(height: 16),
              Text(
                'No se pudo completar el arranque de la app.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
