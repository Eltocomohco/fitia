import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/ai_chat/data/models/ai_chat_agent.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/ai_chat/presentation/screens/gemini_chat_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/food_hub/presentation/screens/food_hub_screen.dart';
import '../../features/inventory/presentation/screens/add_food_screen.dart';
import '../../features/inventory/presentation/screens/barcode_scanner_screen.dart';
import '../../features/inventory/presentation/screens/inventory_screen.dart';
import '../../features/meals/presentation/screens/meals_screen.dart';
import '../../features/recipes/presentation/screens/recipe_builder_screen.dart';
import '../../features/recipes/presentation/screens/recipe_screen.dart';
import '../../features/shopping/presentation/screens/shopping_list_screen.dart';
import '../../features/tracking/presentation/screens/body_tracking_screen.dart';
import '../../features/training_hub/presentation/screens/training_hub_screen.dart';
import '../../features/user/presentation/screens/import_json_screen.dart';
import '../../features/user/presentation/screens/daily_goals_screen.dart';
import '../../features/user/presentation/screens/notification_settings_screen.dart';
import '../../features/user/presentation/screens/profile_screen.dart';
import '../../features/user/presentation/screens/reports_screen.dart';
import '../../features/workouts/presentation/screens/active_workout_screen.dart';
import '../../features/workouts/presentation/screens/workout_audio_screen.dart';
import '../../features/workouts/presentation/screens/workout_catalog_screen.dart';
import '../../features/workouts/presentation/screens/workout_history_screen.dart';
import '../../features/workouts/presentation/screens/workout_routine_detail_screen.dart';
import '../../features/workouts/presentation/screens/workout_routine_editor_screen.dart';
import '../navigation/main_shell_scaffold.dart';

DateTime? _parseRouteDate(String? rawValue) {
  if (rawValue == null || rawValue.trim().isEmpty) {
    return null;
  }
  return DateTime.tryParse(rawValue.trim());
}

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
            path: '/food',
            name: 'food',
            pageBuilder: (context, state) =>
                _bookPageTransition(state, const FoodHubScreen()),
          ),
          GoRoute(
            path: '/training',
            name: 'training',
            pageBuilder: (context, state) =>
                _bookPageTransition(state, const TrainingHubScreen()),
          ),
          GoRoute(
            path: '/ai-chat',
            name: 'aiChat',
            pageBuilder: (context, state) => _bookPageTransition(
              state,
              GeminiChatScreen(
                initialAgent: parseAiChatAgent(
                  state.uri.queryParameters['agent'],
                ),
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const ProfileScreen()),
      ),
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        pageBuilder: (context, state) => _bookPageTransition(
          state,
          CalendarScreen(
            initialDate: _parseRouteDate(state.uri.queryParameters['date']),
          ),
        ),
      ),
      GoRoute(
        path: '/meals',
        name: 'meals',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const MealsScreen()),
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
        path: '/workouts/active',
        name: 'activeWorkout',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const ActiveWorkoutScreen()),
      ),
      GoRoute(
        path: '/workouts/new',
        name: 'workoutNew',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const WorkoutRoutineEditorScreen()),
      ),
      GoRoute(
        path: '/workouts',
        name: 'workouts',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const WorkoutCatalogScreen()),
      ),
      GoRoute(
        path: '/player',
        name: 'player',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const WorkoutAudioScreen()),
      ),
      GoRoute(
        path: '/workouts/history',
        name: 'workoutHistory',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const WorkoutHistoryScreen()),
      ),
      GoRoute(
        path: '/workouts/routine/:id',
        name: 'workoutRoutineDetail',
        pageBuilder: (context, state) {
          final routineId = int.tryParse(state.pathParameters['id'] ?? '');
          if (routineId == null) {
            return _bookPageTransition(state, const WorkoutCatalogScreen());
          }

          return _bookPageTransition(
            state,
            WorkoutRoutineDetailScreen(routineId: routineId),
          );
        },
      ),
      GoRoute(
        path: '/workouts/routine/:id/edit',
        name: 'workoutRoutineEdit',
        pageBuilder: (context, state) {
          final routineId = int.tryParse(state.pathParameters['id'] ?? '');
          if (routineId == null) {
            return _bookPageTransition(state, const WorkoutCatalogScreen());
          }

          return _bookPageTransition(
            state,
            WorkoutRoutineEditorScreen(routineId: routineId),
          );
        },
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
        path: '/inventory/barcode-scanner',
        name: 'barcodeScanner',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const BarcodeScannerScreen()),
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
      GoRoute(
        path: '/notification-settings',
        name: 'notificationSettings',
        pageBuilder: (context, state) =>
            _bookPageTransition(state, const NotificationSettingsScreen()),
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
    transitionDuration: const Duration(milliseconds: 180),
    reverseTransitionDuration: const Duration(milliseconds: 140),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      );

      final slide = Tween<Offset>(
        begin: const Offset(0.03, 0),
        end: Offset.zero,
      ).animate(curved);

      return FadeTransition(
        opacity: curved,
        child: SlideTransition(position: slide, child: child),
      );
    },
  );
}
