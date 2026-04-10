import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Contenedor principal con navegación inferior persistente.
class MainShellScaffold extends StatefulWidget {
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

  @override
  State<MainShellScaffold> createState() => _MainShellScaffoldState();
}

class _MainShellScaffoldState extends State<MainShellScaffold> {
  DateTime? _lastBackPressAt;

  static const _tabs = <_BottomTab>[
    _BottomTab(label: 'Hoy', icon: Icons.today_outlined, path: '/dashboard'),
    _BottomTab(
      label: 'Comida',
      icon: Icons.restaurant_menu_outlined,
      path: '/food',
    ),
    _BottomTab(
      label: 'Entreno',
      icon: Icons.sports_gymnastics_outlined,
      path: '/training',
    ),
    _BottomTab(
      label: 'Chat',
      icon: Icons.smart_toy_outlined,
      path: '/ai-chat',
    ),
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

  bool _isRootTabLocation(String currentLocation) {
    return _tabs.any((tab) => tab.path == currentLocation);
  }

  Future<bool> _handleWillPop() async {
    if (!_isRootTabLocation(widget.location)) {
      return true;
    }

    final now = DateTime.now();
    if (_lastBackPressAt != null &&
        now.difference(_lastBackPressAt!) <= const Duration(seconds: 2)) {
      return true;
    }

    _lastBackPressAt = now;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Pulsa otra vez atrás para salir'),
          duration: Duration(seconds: 2),
        ),
      );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _locationToIndex(widget.location);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }

        final navigator = Navigator.of(context);
        final shouldPop = await _handleWillPop();
        if (shouldPop && mounted) {
          navigator.pop(result);
        }
      },
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) => context.go(_tabs[index].path),
          destinations: [
            for (final tab in _tabs)
              NavigationDestination(icon: Icon(tab.icon), label: tab.label),
          ],
        ),
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
