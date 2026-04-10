package com.example.nutrition_offline_app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.Rect
import android.graphics.RectF
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import kotlin.math.min

class MacrosWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.macros_widget).apply {
                val kcal = widgetData.getInt("kcal", 0)
                val kcalGoal = widgetData.getInt("kcalGoal", 2000)
                val pro = widgetData.getInt("pro", 0)
                val proGoal = widgetData.getInt("proGoal", 150)
                val carb = widgetData.getInt("carb", 0)
                val carbGoal = widgetData.getInt("carbGoal", 25)
                val fat = widgetData.getInt("fat", 0)
                val fatGoal = widgetData.getInt("fatGoal", 140)

                setTextViewText(R.id.widget_title, "Fitora")
                setTextViewText(R.id.widget_subtitle, "Resumen de hoy")

                setImageViewBitmap(
                    R.id.widget_kcal_ring,
                    buildRingBitmap(value = kcal, goal = kcalGoal, accentColor = 0xFFE5C043.toInt()),
                )
                setImageViewBitmap(
                    R.id.widget_pro_ring,
                    buildRingBitmap(value = pro, goal = proGoal, accentColor = 0xFF7FB069.toInt()),
                )
                setImageViewBitmap(
                    R.id.widget_carb_ring,
                    buildRingBitmap(value = carb, goal = carbGoal, accentColor = 0xFFD98F4E.toInt()),
                )
                setImageViewBitmap(
                    R.id.widget_fat_ring,
                    buildRingBitmap(value = fat, goal = fatGoal, accentColor = 0xFFD96C5B.toInt()),
                )

                setTextViewText(R.id.widget_kcal_label, "Kcal")
                setTextViewText(R.id.widget_kcal_value, "$kcal/$kcalGoal")
                setTextViewText(R.id.widget_pro_label, "Prote")
                setTextViewText(R.id.widget_pro_value, "${pro}g/${proGoal}g")
                setTextViewText(R.id.widget_carb_label, "Carb")
                setTextViewText(R.id.widget_carb_value, "${carb}g/${carbGoal}g")
                setTextViewText(R.id.widget_fat_label, "Grasa")
                setTextViewText(R.id.widget_fat_value, "${fat}g/${fatGoal}g")
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    private fun buildRingBitmap(value: Int, goal: Int, accentColor: Int): Bitmap {
        val size = 220
        val strokeWidth = 18f
        val bitmap = Bitmap.createBitmap(size, size, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        val center = size / 2f
        val radius = (size / 2f) - strokeWidth - 8f
        val safeGoal = goal.coerceAtLeast(1)
        val progress = (value.toFloat() / safeGoal.toFloat()).coerceIn(0f, 1f)
        val ringBounds = RectF(
            center - radius,
            center - radius,
            center + radius,
            center + radius,
        )

        val trackPaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            style = Paint.Style.STROKE
            this.strokeWidth = strokeWidth
            color = 0x26111111.toInt()
            strokeCap = Paint.Cap.ROUND
        }
        val progressPaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            style = Paint.Style.STROKE
            this.strokeWidth = strokeWidth
            color = accentColor
            strokeCap = Paint.Cap.ROUND
        }
        val valuePaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = 0xFF111111.toInt()
            textAlign = Paint.Align.CENTER
            textSize = 42f
            isFakeBoldText = true
        }
        val percentPaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = 0x992A3441.toInt()
            textAlign = Paint.Align.CENTER
            textSize = 24f
        }

        canvas.drawArc(ringBounds, -90f, 360f, false, trackPaint)
        canvas.drawArc(ringBounds, -90f, progress * 360f, false, progressPaint)

        val valueText = value.toString()
        val valueBounds = Rect()
        valuePaint.getTextBounds(valueText, 0, valueText.length, valueBounds)
        val percentText = "${(progress * 100).toInt()}%"

        canvas.drawText(valueText, center, center + min(10f, valueBounds.height() / 2f), valuePaint)
        canvas.drawText(percentText, center, center + 42f, percentPaint)

        return bitmap
    }
}