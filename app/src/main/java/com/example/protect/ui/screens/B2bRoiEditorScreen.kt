package com.example.protect.ui.screens

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.*
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
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.viewmodel.AppViewModel

@Composable
fun B2bRoiEditorScreen(
    viewModel: AppViewModel,
    onBack: () -> Unit
) {
    val points by viewModel.roiPoints.collectAsState()
    var isSaved by remember { mutableStateOf(false) }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Editor Polygon ROI AI Vision",
                onBackClick = onBack
            )
        },
        bottomBar = {
            Surface(
                color = SurfaceLight,
                tonalElevation = 8.dp,
                shadowElevation = 8.dp,
                modifier = Modifier.navigationBarsPadding()
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp),
                    horizontalArrangement = Arrangement.spacedBy(10.dp)
                ) {
                    OutlinedButton(
                        onClick = { viewModel.resetRoiPoints() },
                        shape = RoundedCornerShape(12.dp),
                        modifier = Modifier.weight(1f).testTag("btn_reset_roi")
                    ) {
                        Icon(Icons.Default.Refresh, contentDescription = null, modifier = Modifier.size(16.dp))
                        Spacer(modifier = Modifier.width(6.dp))
                        Text("Reset Default")
                    }

                    Button(
                        onClick = { isSaved = true },
                        colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                        shape = RoundedCornerShape(12.dp),
                        modifier = Modifier.weight(1f).testTag("btn_save_roi")
                    ) {
                        Icon(Icons.Default.Save, contentDescription = null, modifier = Modifier.size(16.dp))
                        Spacer(modifier = Modifier.width(6.dp))
                        Text("Simpan Poligon", fontWeight = FontWeight.Bold)
                    }
                }
            }
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .background(BackgroundLight)
                .padding(innerPadding)
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(14.dp)
        ) {
            InfoBanner(
                text = "Ketuk pada kanvas video di bawah untuk menambahkan titik batas deteksi zona kritis (ROI). AI hanya akan membunyikan alarm saat hama melintasi area ini.",
                icon = Icons.Default.TouchApp
            )

            if (isSaved) {
                InfoBanner(
                    text = "Konfigurasi Zona ROI Tersimpan! Model YOLO-Pest telah disinkronkan ke gateway edge CCTV.",
                    icon = Icons.Default.CheckCircle,
                    backgroundColor = Emerald50,
                    contentColor = Emerald800
                )
            }

            // Interactive Polygon Canvas Editor
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f)
                    .clip(RoundedCornerShape(16.dp))
                    .background(DarkSlate900)
                    .border(2.dp, Emerald600, RoundedCornerShape(16.dp))
            ) {
                Canvas(
                    modifier = Modifier
                        .fillMaxSize()
                        .pointerInput(Unit) {
                            detectTapGestures { offset ->
                                val normalizedX = offset.x / size.width
                                val normalizedY = offset.y / size.height
                                viewModel.addRoiPoint(normalizedX, normalizedY)
                            }
                        }
                ) {
                    val w = size.width
                    val h = size.height

                    if (points.isNotEmpty()) {
                        val path = Path().apply {
                            moveTo(points[0].x * w, points[0].y * h)
                            for (i in 1 until points.size) {
                                lineTo(points[i].x * w, points[i].y * h)
                            }
                            close()
                        }

                        // Fill translucent ROI
                        drawPath(
                            path = path,
                            color = Emerald500.copy(alpha = 0.25f)
                        )

                        // Outline
                        drawPath(
                            path = path,
                            color = Emerald400,
                            style = Stroke(width = 3.dp.toPx(), cap = StrokeCap.Round)
                        )

                        // Draw anchor points
                        points.forEachIndexed { idx, pt ->
                            drawCircle(
                                color = Emerald300,
                                radius = 7.dp.toPx(),
                                center = Offset(pt.x * w, pt.y * h)
                            )
                            drawCircle(
                                color = SurfaceLight,
                                radius = 3.dp.toPx(),
                                center = Offset(pt.x * w, pt.y * h)
                            )
                        }
                    }
                }

                // Overlay Instructions Label
                Surface(
                    color = DarkSlate900.copy(alpha = 0.8f),
                    shape = RoundedCornerShape(8.dp),
                    modifier = Modifier
                        .align(Alignment.TopCenter)
                        .padding(12.dp)
                ) {
                    Text(
                        text = "Titik Sudut Aktif: ${points.size} (Maks 8)",
                        fontSize = 11.sp,
                        fontWeight = FontWeight.Bold,
                        color = SurfaceLight,
                        modifier = Modifier.padding(horizontal = 10.dp, vertical = 4.dp)
                    )
                }
            }
        }
    }
}
