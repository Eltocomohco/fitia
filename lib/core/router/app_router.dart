import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/inventory/presentation/screens/add_food_screen.dart';
import '../../features/inventory/presentation/screens/inventory_screen.dart';
import '../../features/meals/presentation/screens/meals_screen.dart';
import '../../features/recipes/presentation/screens/recipe_builder_screen.dart';
import '../../features/recipes/presentation/screens/recipe_screen.dart';
import '../../features/shopping/presentation/screens/shopping_list_screen.dart';
import '../../features/tracking/presentation/screens/body_tracking_screen.dart';
import '../../features/user/presentation/screens/import_json_screen.dart';
import '../../features/user/presentation/screens/daily_goals_screen.dart';
import '../../features/user/presentation/screens/profile_screen.dart';
import '../../features/user/presentation/screens/reports_screen.dart';
import '../navigation/main_shell_scaffold.dart';

/// Rutas con estructura declarativa para la app de nutrición.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainShellScaffold(location: state.uri.path, child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            pageBuilder: (context, state) =>
                _bookPageTransition(state, const DashboardScreen()),
          ),
          GoRoute(
            path: '/calendar',
            name: 'calendar',
            pageBuilder: (context, state) =>
                _bookPageTransition(state, const CalendarScreen()),
          ),
          GoRoute(
            path: '/meals',
            name: 'meals',
            pageBuilder: (context, state) =>
                _bookPageTransition(state, const MealsScreen()),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) =>
                _bookPageTransition(state, const ProfileScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/inventory',
        name: 'inventory',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const InventoryScreen()),
      ),
      GoRoute(
        path: '/recipes',
        name: 'recipes',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const RecipeScreen()),
      ),
      GoRoute(
        path: '/body-tracking',
        name: 'bodyTracking',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const BodyTrackingScreen()),
      ),
      GoRoute(
        path: '/shopping-list',
        name: 'shoppingList',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const ShoppingListScreen()),
      ),
      GoRoute(
        path: '/inventory/new-recipe',
        name: 'newRecipe',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const RecipeBuilderScreen()),
      ),
      GoRoute(
        path: '/recipes/new',
        name: 'recipesNew',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const RecipeBuilderScreen()),
      ),
      GoRoute(
        path: '/inventory/new-food',
        name: 'newFood',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const AddFoodScreen()),
      ),
      GoRoute(
        path: '/reports',
        name: 'reports',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const ReportsScreen()),
      ),
      GoRoute(
        path: '/daily-goals',
        name: 'dailyGoals',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const DailyGoalsScreen()),
      ),
      GoRoute(
        path: '/import-json',
        name: 'importJson',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const ImportJsonScreen()),
      ),
    ],
  );
});

CustomTransitionPage<void> _bookPageTransition(
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 520),
    reverseTransitionDuration: const Duration(milliseconds: 420),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      final slide = Tween<Offset>(
        begin: const Offset(0.8, 0),
        end: Offset.zero,
      ).animate(curved);

      final rotation = Tween<double>(
        begin: -math.pi / 8,
        end: 0,
      ).animate(curved);

      return SlideTransition(
        position: slide,
        child: AnimatedBuilder(
          animation: rotation,
          child: child,
          builder: (context, widgetChild) {
            return Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0012)
                ..rotateY(rotation.value),
              child: widgetChild,
            );
          },
        ),
      );
    },
  );
}
