import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Pantalla de usuario con accesos de cuenta y utilidades.
class ProfileScreen extends StatelessWidget {
  /// Crea un [ProfileScreen].
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuario')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
        ],
      ),
    );
  }
}
