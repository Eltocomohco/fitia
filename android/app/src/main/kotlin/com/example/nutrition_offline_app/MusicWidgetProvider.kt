package com.example.nutrition_offline_app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class MusicWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.music_widget).apply {
                val title = widgetData.getString("musicTitle", "Workout Radio") ?: "Workout Radio"
                val subtitle = widgetData.getString("musicSubtitle", "Selecciona una emisora") ?: "Selecciona una emisora"
                val mode = widgetData.getString("musicMode", "Radio") ?: "Radio"
                val isPlaying = widgetData.getBoolean("musicIsPlaying", false)

                setTextViewText(R.id.music_widget_title, "Música")
                setTextViewText(R.id.music_widget_mode, mode)
                setTextViewText(R.id.music_widget_track, title)
                setTextViewText(R.id.music_widget_subtitle, subtitle)
                setTextViewText(R.id.music_widget_state, if (isPlaying) "Reproduciendo" else "Pausado")
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}