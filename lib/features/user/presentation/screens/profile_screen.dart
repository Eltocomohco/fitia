import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme_provider.dart';
import '../../../tracking/presentation/widgets/fasting_widget.dart';

/// Pantalla de usuario con accesos de cuenta y utilidades.
class ProfileScreen extends ConsumerWidget {
  /// Crea un [ProfileScreen].
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(appThemeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil y ajustes'),
        actions: [
          IconButton(
            tooltip: 'Calendario',
            onPressed: () => context.push('/calendar'),
            icon: const Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primaryContainer,
                    child: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Perfil personal',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Ajustes, progreso corporal, hábitos y utilidades generales de tu cuenta.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Seguimiento personal',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const FastingWidget(),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.monitor_weight_outlined),
              title: const Text('Tracking corporal'),
              subtitle: const Text('Peso, IMC, grasa corporal y agua'),
              onTap: () => context.push('/body-tracking'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.tune_outlined),
              title: const Text('Objetivos diarios'),
              subtitle: const Text(
                'Calorías, proteínas, carbohidratos y grasas',
              ),
              onTap: () => context.push('/daily-goals'),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Sistema y utilidades',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications_active_outlined),
              title: const Text('Notificaciones'),
              subtitle: const Text('Recordatorios de agua, comidas, entreno y planificacion'),
              onTap: () => context.push('/notification-settings'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.insights_outlined),
              title: const Text('Informes'),
              subtitle: const Text('Resumen diario, semanal y mensual'),
              onTap: () => context.push('/reports'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.file_upload_outlined),
              title: const Text('Importar JSON'),
              subtitle: const Text('Cargar alimentos y recetas desde JSON'),
              onTap: () => context.push('/import-json'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Calendario'),
              subtitle: const Text('Vista global del seguimiento diario y semanal'),
              onTap: () => context.push('/calendar'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: const Text('Tema de la app'),
              subtitle: Text(
                currentTheme == AppTheme.pandaRojo ? 'Panda Rojo 🐼' : 'Original',
              ),
              trailing: PopupMenuButton<AppTheme>(
                onSelected: (theme) =>
                    ref.read(appThemeProvider.notifier).setTheme(theme),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: AppTheme.original,
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline, size: 16),
                        const SizedBox(width: 8),
                        Text(currentTheme == AppTheme.original
                            ? '✓ Original'
                            : 'Original'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: AppTheme.pandaRojo,
                    child: Row(
                      children: [
                        const Icon(Icons.pets_outlined, size: 16),
                        const SizedBox(width: 8),
                        Text(currentTheme == AppTheme.pandaRojo
                            ? '✓ Panda Rojo 🐼'
                            : 'Panda Rojo 🐼'),
                      ],
                    ),
                  ),
                ],
                icon: const Icon(Icons.more_vert),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
