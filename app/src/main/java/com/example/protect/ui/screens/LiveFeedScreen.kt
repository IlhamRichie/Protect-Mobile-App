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
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.PathEffect
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
fun LiveFeedScreen(
    viewModel: AppViewModel
) {
    val fps by viewModel.liveFps.collectAsState()
    val latency by viewModel.liveLatency.collectAsState()
    val model by viewModel.liveModel.collectAsState()
    val species by viewModel.detectedSpecies.collectAsState()
    val confidence by viewModel.detectionConfidence.collectAsState()
    val id by viewModel.detectedId.collectAsState()
    val cameras by viewModel.cameras.collectAsState()

    var selectedCameraIndex by remember { mutableIntStateOf(0) }
    var isOverlayVisible by remember { mutableStateOf(true) }

    Scaffold(
        containerColor = Color.Black,
        topBar = {
            ProtectTopBar(
                title = "Live Stream & AI Vision Overlay"
            )
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
        ) {
            // Top HUD Metric Bar
            Surface(
                color = DarkSlate900.copy(alpha = 0.85f),
                shape = RoundedCornerShape(14.dp),
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp, vertical = 8.dp)
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = 16.dp, vertical = 10.dp),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "FPS: $fps",
                        fontSize = 12.sp,
                        fontWeight = FontWeight.Bold,
                        color = Emerald400
                    )
                    Text(
                        text = "Latency: $latency",
                        fontSize = 12.sp,
                        fontWeight = FontWeight.Bold,
                        color = WarningColor
                    )
                    Text(
                        text = "Model: $model",
                        fontSize = 12.sp,
                        fontWeight = FontWeight.Bold,
                        color = SurfaceLight
                    )
                }
            }

            // Stream Viewport with AI Vision Custom Canvas Overlay
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f)
                    .background(DarkSlate900)
            ) {
                // Mock Video Feed Graphic
                Column(
                    modifier = Modifier.align(Alignment.Center),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Icon(
                        imageVector = Icons.Default.Videocam,
                        contentDescription = null,
                        tint = Color.White.copy(alpha = 0.2f),
                        modifier = Modifier.size(80.dp)
                    )
                    Spacer(modifier = Modifier.height(12.dp))
                    Text(
                        text = "RTSP STREAM 1080P • LIVE FEED",
                        fontSize = 13.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color.White.copy(alpha = 0.4f),
                        letterSpacing = 2.sp
                    )
                    Text(
                        text = cameras.getOrNull(selectedCameraIndex)?.name ?: "CCTV-01 Kitchen North Zone",
                        fontSize = 11.sp,
                        color = Color.White.copy(alpha = 0.3f)
                    )
                }

                // AI Vision Overlay Canvas
                if (isOverlayVisible) {
                    Canvas(modifier = Modifier.fillMaxSize()) {
                        val w = size.width
                        val h = size.height

                        // Virtual Intrusion Boundary Line (Y = 55%)
                        drawLine(
                            color = DangerColor,
                            start = Offset(0f, h * 0.55f),
                            end = Offset(w, h * 0.55f),
                            strokeWidth = 3.dp.toPx(),
                            pathEffect = PathEffect.dashPathEffect(floatArrayOf(15f, 10f), 0f)
                        )

                        // AI Detected Bounding Box
                        val boxLeft = w * 0.28f
                        val boxTop = h * 0.38f
                        val boxWidth = w * 0.44f
                        val boxHeight = h * 0.22f

                        drawRect(
                            color = DangerColor,
                            topLeft = Offset(boxLeft, boxTop),
                            size = Size(boxWidth, boxHeight),
                            style = Stroke(width = 2.5.dp.toPx())
                        )
                    }

                    // Floating Bounding Box Label
                    Surface(
                        color = DangerColor,
                        shape = RoundedCornerShape(6.dp),
                        modifier = Modifier
                            .align(Alignment.Center)
                            .offset(y = (-50).dp)
                    ) {
                        Text(
                            text = "[ID #$id] $species ($confidence%)",
                            fontSize = 11.sp,
                            fontWeight = FontWeight.Bold,
                            color = SurfaceLight,
                            modifier = Modifier.padding(horizontal = 8.dp, vertical = 4.dp)
                        )
                    }
                }
            }

            // Bottom Stream Controls Bar
            Surface(
                color = DarkSlate900,
                modifier = Modifier.fillMaxWidth()
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column {
                        Text(
                            text = "Kamera Terpilih:",
                            fontSize = 11.sp,
                            color = TextMuted
                        )
                        Text(
                            text = cameras.getOrNull(selectedCameraIndex)?.name ?: "CCTV-01",
                            fontSize = 13.sp,
                            fontWeight = FontWeight.Bold,
                            color = SurfaceLight
                        )
                    }

                    Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        IconButton(
                            onClick = { isOverlayVisible = !isOverlayVisible },
                            modifier = Modifier
                                .clip(CircleShape)
                                .background(if (isOverlayVisible) Emerald600 else DarkSlate800)
                        ) {
                            Icon(
                                imageVector = Icons.Default.Visibility,
                                contentDescription = "Toggle Overlay",
                                tint = SurfaceLight
                            )
                        }

                        IconButton(
                            onClick = {
                                selectedCameraIndex = (selectedCameraIndex + 1) % cameras.size
                            },
                            modifier = Modifier
                                .clip(CircleShape)
                                .background(DarkSlate800)
                        ) {
                            Icon(
                                imageVector = Icons.Default.FlipCameraIos,
                                contentDescription = "Switch Camera",
                                tint = SurfaceLight
                            )
                        }
                    }
                }
            }
        }
    }
}
