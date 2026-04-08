import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Contenedor principal con navegación inferior persistente.
class MainShellScaffold extends StatelessWidget {
  /// Crea un [MainShellScaffold].
  const MainShellScaffold({
    required this.child,
    required this.location,
    super.key,
  });

  /// Contenido de la ruta activa dentro del shell.
  final Widget child;

  /// Ubicación actual para calcular índice seleccionado.
  final String location;

  static const _tabs = <_BottomTab>[
    _BottomTab(label: 'Hoy', icon: Icons.today_outlined, path: '/dashboard'),
    _BottomTab(
      label: 'Calendario',
      icon: Icons.calendar_month_outlined,
      path: '/calendar',
    ),
    _BottomTab(
      label: 'Comidas',
      icon: Icons.restaurant_menu_outlined,
      path: '/meals',
    ),
    _BottomTab(label: 'Usuario', icon: Icons.person_outline, path: '/profile'),
  ];

  int _locationToIndex(String currentLocation) {
    for (var i = 0; i < _tabs.length; i++) {
      if (currentLocation == _tabs[i].path ||
          currentLocation.startsWith('${_tabs[i].path}/')) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => context.go(_tabs[index].path),
        destinations: [
          for (final tab in _tabs)
            NavigationDestination(icon: Icon(tab.icon), label: tab.label),
        ],
      ),
    );
  }
}

class _BottomTab {
  const _BottomTab({
    required this.label,
    required this.icon,
    required this.path,
  });

  final String label;
  final IconData icon;
  final String path;
}
