package com.example.protect.ui.screens

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.PathEffect
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.theme.*
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.StatusBadge
import com.example.protect.viewmodel.AppViewModel

@Composable
fun LiveTrackerScreen(
    viewModel: AppViewModel,
    onBack: () -> Unit,
    onNavigateToChat: () -> Unit
) {
    val progress by viewModel.trackerProgress.collectAsState()
    val eta by viewModel.trackerEtaMinutes.collectAsState()
    val distance by viewModel.trackerDistanceKm.collectAsState()
    val statusText by viewModel.trackerStatusText.collectAsState()

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Live GPS Tracking Teknisi",
                onBackClick = onBack
            )
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .background(BackgroundLight)
                .padding(innerPadding)
        ) {
            // Map Canvas Viewport
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f)
                    .background(Color(0xFFE2E8F0))
            ) {
                // Interactive Map Canvas with Grid Lines, Road Path, and Live Marker
                Canvas(modifier = Modifier.fillMaxSize()) {
                    val w = size.width
                    val h = size.height

                    // Draw Map Grid Roads
                    val gridPaint = Color(0xFFCBD5E1)
                    for (i in 1..6) {
                        drawLine(
                            color = gridPaint,
                            start = Offset(0f, h * i / 7),
                            end = Offset(w, h * i / 7),
                            strokeWidth = 2.dp.toPx()
                        )
                        drawLine(
                            color = gridPaint,
                            start = Offset(w * i / 7, 0f),
                            end = Offset(w * i / 7, h),
                            strokeWidth = 2.dp.toPx()
                        )
                    }

                    // Draw S-Curve Route
                    val path = Path().apply {
                        moveTo(w * 0.15f, h * 0.85f) // Start: Dispatch Hub
                        cubicTo(
                            w * 0.35f, h * 0.70f,
                            w * 0.40f, h * 0.35f,
                            w * 0.85f, h * 0.20f // End: Customer Destination
                        )
                    }

                    // Road background
                    drawPath(
                        path = path,
                        color = Color(0xFF94A3B8),
                        style = Stroke(width = 10.dp.toPx(), cap = StrokeCap.Round)
                    )

                    // Active traveled path
                    drawPath(
                        path = path,
                        color = Emerald500,
                        style = Stroke(
                            width = 6.dp.toPx(),
                            cap = StrokeCap.Round,
                            pathEffect = PathEffect.dashPathEffect(floatArrayOf(20f, 10f), 0f)
                        )
                    )

                    // Dispatch Hub Pin
                    drawCircle(
                        color = DarkSlate800,
                        radius = 8.dp.toPx(),
                        center = Offset(w * 0.15f, h * 0.85f)
                    )

                    // Destination Pin
                    drawCircle(
                        color = DangerColor,
                        radius = 10.dp.toPx(),
                        center = Offset(w * 0.85f, h * 0.20f)
                    )

                    // Current Moving Tech Marker Position
                    val techX = w * (0.15f + 0.70f * progress)
                    val techY = h * (0.85f - 0.65f * progress)

                    // Outer ripple
                    drawCircle(
                        color = Emerald500.copy(alpha = 0.3f),
                        radius = 22.dp.toPx(),
                        center = Offset(techX, techY)
                    )
                    // Inner dot
                    drawCircle(
                        color = Emerald600,
                        radius = 10.dp.toPx(),
                        center = Offset(techX, techY)
                    )
                    drawCircle(
                        color = SurfaceLight,
                        radius = 4.dp.toPx(),
                        center = Offset(techX, techY)
                    )
                }

                // Top Floating Status Chip
                Surface(
                    shape = RoundedCornerShape(20.dp),
                    color = DarkSlate900.copy(alpha = 0.9f),
                    modifier = Modifier
                        .align(Alignment.TopCenter)
                        .padding(16.dp)
                ) {
                    Row(
                        modifier = Modifier.padding(horizontal = 16.dp, vertical = 8.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Box(
                            modifier = Modifier
                                .size(8.dp)
                                .clip(CircleShape)
                                .background(Emerald400)
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text(
                            text = "GPS LIVE • AKURASI < 5M",
                            fontSize = 11.sp,
                            fontWeight = FontWeight.Bold,
                            color = SurfaceLight,
                            letterSpacing = 1.sp
                        )
                    }
                }
            }

            // Bottom Technician Detail Card
            Card(
                shape = RoundedCornerShape(topStart = 24.dp, topEnd = 24.dp),
                colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                elevation = CardDefaults.cardElevation(defaultElevation = 8.dp),
                modifier = Modifier
                    .fillMaxWidth()
                    .border(1.dp, BorderColor, RoundedCornerShape(topStart = 24.dp, topEnd = 24.dp))
            ) {
                Column(modifier = Modifier.padding(20.dp)) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Column {
                            Text(
                                text = "Estimasi Tiba (ETA)",
                                fontSize = 12.sp,
                                color = TextSecondary
                            )
                            Text(
                                text = "$eta Menit • $distance km",
                                fontSize = 22.sp,
                                fontWeight = FontWeight.ExtraBold,
                                color = Emerald600
                            )
                        }

                        StatusBadge(
                            text = "EN ROUTE",
                            backgroundColor = Emerald50,
                            textColor = Emerald700
                        )
                    }

                    Spacer(modifier = Modifier.height(6.dp))

                    Text(
                        text = statusText,
                        fontSize = 12.sp,
                        color = DarkSlate900,
                        fontWeight = FontWeight.Medium
                    )

                    HorizontalDivider(modifier = Modifier.padding(vertical = 14.dp))

                    // Technician Bio Row
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Box(
                            modifier = Modifier
                                .size(48.dp)
                                .clip(CircleShape)
                                .background(Emerald50),
                            contentAlignment = Alignment.Center
                        ) {
                            Icon(
                                imageVector = Icons.Default.Engineering,
                                contentDescription = null,
                                tint = Emerald600,
                                modifier = Modifier.size(28.dp)
                            )
                        }

                        Spacer(modifier = Modifier.width(12.dp))

                        Column(modifier = Modifier.weight(1f)) {
                            Text(
                                text = "Doni Pratama",
                                fontSize = 15.sp,
                                fontWeight = FontWeight.Bold,
                                color = DarkSlate900
                            )
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Icon(
                                    imageVector = Icons.Default.Star,
                                    contentDescription = null,
                                    tint = WarningColor,
                                    modifier = Modifier.size(14.dp)
                                )
                                Spacer(modifier = Modifier.width(4.dp))
                                Text(
                                    text = "4.95 • 320+ Penanganan",
                                    fontSize = 11.sp,
                                    color = TextSecondary
                                )
                            }
                        }

                        IconButton(
                            onClick = onNavigateToChat,
                            modifier = Modifier
                                .clip(CircleShape)
                                .background(Emerald50)
                                .testTag("btn_call_tech")
                        ) {
                            Icon(
                                imageVector = Icons.Default.Chat,
                                contentDescription = "Chat Teknisi",
                                tint = Emerald600
                            )
                        }
                    }
                }
            }
        }
    }
}
