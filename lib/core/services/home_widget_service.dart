import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

/// Servicio de sincronización entre Flutter y widgets nativos de pantalla inicio.
abstract final class HomeWidgetService {
  static const String _iOSGroupId = 'group.com.example.nutritionOfflineApp';
  static const String _macrosWidgetProviderName = 'MacrosWidgetProvider';
  static const String _macrosQualifiedAndroidWidgetProviderName =
      'com.example.nutrition_offline_app.MacrosWidgetProvider';
  static const String _macrosIOSWidgetName = 'MacrosWidget';
  static const String _musicWidgetProviderName = 'MusicWidgetProvider';
  static const String _musicQualifiedAndroidWidgetProviderName =
      'com.example.nutrition_offline_app.MusicWidgetProvider';
  static const String _musicIOSWidgetName = 'MusicWidget';
  static const String _shoppingWidgetProviderName = 'ShoppingWidgetProvider';
  static const String _shoppingQualifiedAndroidWidgetProviderName =
      'com.example.nutrition_offline_app.ShoppingWidgetProvider';
  static const String _shoppingIOSWidgetName = 'ShoppingWidget';

  /// Inicializa la comunicación compartida requerida por iOS.
  static Future<void> init() async {
    try {
      await HomeWidget.setAppGroupId(_iOSGroupId);
    } catch (error) {
      debugPrint('HomeWidget init omitted: $error');
    }
  }

  /// Persiste los macros consumidos y solicita refresco del widget nativo.
  static Future<void> updateMacrosWidget(
    int kcal,
    int kcalGoal,
    int pro,
    int proGoal,
    int carb,
    int carbGoal,
    int fat,
    int fatGoal,
  ) async {
    try {
      await HomeWidget.saveWidgetData<int>('kcal', kcal);
      await HomeWidget.saveWidgetData<int>('kcalGoal', kcalGoal);
      await HomeWidget.saveWidgetData<int>('pro', pro);
      await HomeWidget.saveWidgetData<int>('proGoal', proGoal);
      await HomeWidget.saveWidgetData<int>('carb', carb);
      await HomeWidget.saveWidgetData<int>('carbGoal', carbGoal);
      await HomeWidget.saveWidgetData<int>('fat', fat);
      await HomeWidget.saveWidgetData<int>('fatGoal', fatGoal);
      await HomeWidget.updateWidget(
        name: _macrosWidgetProviderName,
        qualifiedAndroidName: _macrosQualifiedAndroidWidgetProviderName,
        iOSName: _macrosIOSWidgetName,
      );
    } catch (error) {
      debugPrint('HomeWidget update omitted: $error');
    }
  }

  static Future<void> updateMusicWidget({
    required String title,
    required String subtitle,
    required String modeLabel,
    required bool isPlaying,
  }) async {
    try {
      await HomeWidget.saveWidgetData<String>('musicTitle', title);
      await HomeWidget.saveWidgetData<String>('musicSubtitle', subtitle);
      await HomeWidget.saveWidgetData<String>('musicMode', modeLabel);
      await HomeWidget.saveWidgetData<bool>('musicIsPlaying', isPlaying);
      await HomeWidget.updateWidget(
        name: _musicWidgetProviderName,
        qualifiedAndroidName: _musicQualifiedAndroidWidgetProviderName,
        iOSName: _musicIOSWidgetName,
      );
    } catch (error) {
      debugPrint('Music widget update omitted: $error');
    }
  }

  static Future<void> updateShoppingWidget({
    required String title,
    required String subtitle,
    required String line1,
    required String line2,
    required String line3,
    required int pendingCount,
  }) async {
    try {
      await HomeWidget.saveWidgetData<String>('shoppingTitle', title);
      await HomeWidget.saveWidgetData<String>('shoppingSubtitle', subtitle);
      await HomeWidget.saveWidgetData<String>('shoppingLine1', line1);
      await HomeWidget.saveWidgetData<String>('shoppingLine2', line2);
      await HomeWidget.saveWidgetData<String>('shoppingLine3', line3);
      await HomeWidget.saveWidgetData<int>('shoppingPendingCount', pendingCount);
      await HomeWidget.updateWidget(
        name: _shoppingWidgetProviderName,
        qualifiedAndroidName: _shoppingQualifiedAndroidWidgetProviderName,
        iOSName: _shoppingIOSWidgetName,
      );
    } catch (error) {
      debugPrint('Shopping widget update omitted: $error');
    }
  }
}
