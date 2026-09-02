package com.example.protect.ui.screens

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
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
import androidx.compose.ui.graphics.StrokeJoin
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.model.JobStatus
import com.example.protect.model.PointF2D
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.SectionHeader
import com.example.protect.viewmodel.AppViewModel

@Composable
fun TechnicianSignoffScreen(
    viewModel: AppViewModel,
    onBack: () -> Unit,
    onFinishJob: () -> Unit
) {
    val paths = remember { mutableStateListOf<List<Offset>>() }
    var currentPath by remember { mutableStateOf<List<Offset>>(emptyList()) }
    var isSubmitted by remember { mutableStateOf(false) }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Tanda Tangan Berita Acara Digital",
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
                Button(
                    onClick = {
                        isSubmitted = true
                        viewModel.updateJobStatus("job-1", JobStatus.COMPLETED)
                    },
                    enabled = !isSubmitted && (paths.isNotEmpty() || currentPath.isNotEmpty()),
                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                    shape = RoundedCornerShape(12.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)
                        .height(48.dp)
                        .testTag("btn_submit_signoff")
                ) {
                    Icon(Icons.Default.Verified, contentDescription = null, modifier = Modifier.size(18.dp))
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = if (isSubmitted) "Pekerjaan Ditutup & Garansi Terbit" else "Selesaikan Tugas & Terbitkan Garansi",
                        fontWeight = FontWeight.Bold
                    )
                }
            }
        }
    ) { innerPadding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .background(BackgroundLight)
                .padding(innerPadding),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            item {
                InfoBanner(
                    text = "Minta tanda tangan perwakilan klien (Supervisor/QA Facility) di bawah ini sebagai konfirmasi pekerjaan telah selesai sesuai standar HACCP.",
                    icon = Icons.Default.Draw
                )
            }

            if (isSubmitted) {
                item {
                    InfoBanner(
                        text = "Berita Acara & Sertifikat E-Garansi 12 Bulan Berhasil Diterbitkan! Data telah disinkronkan ke cloud.",
                        icon = Icons.Default.CheckCircle,
                        backgroundColor = Emerald50,
                        contentColor = Emerald800
                    )
                }

                item {
                    Button(
                        onClick = onFinishJob,
                        colors = ButtonDefaults.buttonColors(containerColor = DarkSlate900),
                        shape = RoundedCornerShape(12.dp),
                        modifier = Modifier.fillMaxWidth().height(46.dp)
                    ) {
                        Text("Kembali ke Beranda", fontWeight = FontWeight.Bold)
                    }
                }
            }

            // Interactive Signature Canvas Pad
            item {
                SectionHeader(
                    title = "Pad Tanda Tangan Klien (E-Sign)",
                    actionTitle = "Hapus / Ulangi",
                    onActionClick = {
                        paths.clear()
                        currentPath = emptyList()
                    }
                )

                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(240.dp)
                        .border(2.dp, Emerald600, RoundedCornerShape(16.dp))
                ) {
                    Box(modifier = Modifier.fillMaxSize()) {
                        Canvas(
                            modifier = Modifier
                                .fillMaxSize()
                                .pointerInput(Unit) {
                                    detectDragGestures(
                                        onDragStart = { offset ->
                                            currentPath = listOf(offset)
                                        },
                                        onDrag = { change, _ ->
                                            currentPath = currentPath + change.position
                                        },
                                        onDragEnd = {
                                            if (currentPath.isNotEmpty()) {
                                                paths.add(currentPath)
                                                currentPath = emptyList()
                                            }
                                        }
                                    )
                                }
                        ) {
                            // Draw previously drawn strokes
                            for (stroke in paths) {
                                if (stroke.size > 1) {
                                    val path = Path().apply {
                                        moveTo(stroke[0].x, stroke[0].y)
                                        for (i in 1 until stroke.size) {
                                            lineTo(stroke[i].x, stroke[i].y)
                                        }
                                    }
                                    drawPath(
                                        path = path,
                                        color = DarkSlate900,
                                        style = Stroke(width = 3.dp.toPx(), cap = StrokeCap.Round, join = StrokeJoin.Round)
                                    )
                                }
                            }

                            // Draw current stroke
                            if (currentPath.size > 1) {
                                val path = Path().apply {
                                    moveTo(currentPath[0].x, currentPath[0].y)
                                    for (i in 1 until currentPath.size) {
                                        lineTo(currentPath[i].x, currentPath[i].y)
                                    }
                                }
                                drawPath(
                                    path = path,
                                    color = DarkSlate900,
                                    style = Stroke(width = 3.dp.toPx(), cap = StrokeCap.Round, join = StrokeJoin.Round)
                                )
                            }
                        }

                        if (paths.isEmpty() && currentPath.isEmpty()) {
                            Text(
                                text = "Goreskan tanda tangan di sini...",
                                fontSize = 13.sp,
                                color = TextMuted,
                                modifier = Modifier.align(Alignment.Center)
                            )
                        }
                    }
                }
            }

            // Signer Info
            item {
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(6.dp)) {
                        Text(
                            text = "Penandatangan: Budi Hartono (Facility & QA Mgr)",
                            fontSize = 12.sp,
                            fontWeight = FontWeight.Bold,
                            color = DarkSlate900
                        )
                        Text(
                            text = "PT. Boga Lestari Prima • 02 Sep 2026",
                            fontSize = 11.sp,
                            color = TextSecondary
                        )
                    }
                }
            }
        }
    }
}
