package com.example.nutrition_offline_app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class ShoppingWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.shopping_widget).apply {
                val title = widgetData.getString("shoppingTitle", "Compra semanal") ?: "Compra semanal"
                val subtitle = widgetData.getString("shoppingSubtitle", "Esta semana") ?: "Esta semana"
                val line1 = widgetData.getString("shoppingLine1", "Nada pendiente") ?: "Nada pendiente"
                val line2 = widgetData.getString("shoppingLine2", "") ?: ""
                val line3 = widgetData.getString("shoppingLine3", "") ?: ""
                val count = widgetData.getInt("shoppingPendingCount", 0)

                setTextViewText(R.id.shopping_widget_title, title)
                setTextViewText(R.id.shopping_widget_subtitle, subtitle)
                setTextViewText(R.id.shopping_widget_badge, "$count items")
                setTextViewText(R.id.shopping_widget_line1, line1)
                setTextViewText(R.id.shopping_widget_line2, line2)
                setTextViewText(R.id.shopping_widget_line3, line3)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}