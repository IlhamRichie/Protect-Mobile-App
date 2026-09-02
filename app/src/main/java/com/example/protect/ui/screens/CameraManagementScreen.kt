package com.example.protect.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.SectionHeader
import com.example.protect.ui.components.StatusBadge
import com.example.protect.viewmodel.AppViewModel

@Composable
fun CameraManagementScreen(
    viewModel: AppViewModel,
    onBack: () -> Unit,
    onNavigateToRoi: () -> Unit,
    onNavigateToAlertSettings: () -> Unit
) {
    val cameras by viewModel.cameras.collectAsState()
    var showAddDialog by remember { mutableStateOf(false) }
    var newCamName by remember { mutableStateOf("") }
    var newCamUrl by remember { mutableStateOf("rtsp://192.168.1.104:554/live") }
    var newCamLoc by remember { mutableStateOf("Loading Bay Area #2") }

    if (showAddDialog) {
        AlertDialog(
            onDismissRequest = { showAddDialog = false },
            title = { Text("Tambah Kamera RTSP Baru") },
            text = {
                Column(verticalArrangement = Arrangement.spacedBy(10.dp)) {
                    OutlinedTextField(
                        value = newCamName,
                        onValueChange = { newCamName = it },
                        label = { Text("Nama Kamera") },
                        placeholder = { Text("CCTV-04 Kitchen Prep") },
                        singleLine = true
                    )
                    OutlinedTextField(
                        value = newCamUrl,
                        onValueChange = { newCamUrl = it },
                        label = { Text("RTSP Stream URL") },
                        singleLine = true
                    )
                    OutlinedTextField(
                        value = newCamLoc,
                        onValueChange = { newCamLoc = it },
                        label = { Text("Lokasi Penempatan") },
                        singleLine = true
                    )
                }
            },
            confirmButton = {
                Button(
                    onClick = {
                        if (newCamName.isNotBlank()) {
                            viewModel.addCamera(newCamName, newCamUrl, newCamLoc)
                            newCamName = ""
                            showAddDialog = false
                        }
                    },
                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600)
                ) {
                    Text("Simpan")
                }
            },
            dismissButton = {
                TextButton(onClick = { showAddDialog = false }) {
                    Text("Batal")
                }
            }
        )
    }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Manajemen Kamera RTSP & AI Vision",
                onBackClick = onBack
            )
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = { showAddDialog = true },
                containerColor = Emerald600,
                contentColor = SurfaceLight,
                modifier = Modifier.testTag("fab_add_camera")
            ) {
                Icon(Icons.Default.Add, contentDescription = "Tambah Kamera")
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
                    text = "Edge AI memproses stream video RTSP langsung di local network gateway tanpa lag. Konfigurasikan ROI dan sensitivitas di bawah ini.",
                    icon = Icons.Default.Videocam
                )
            }

            item {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(10.dp)
                ) {
                    Button(
                        onClick = onNavigateToRoi,
                        colors = ButtonDefaults.buttonColors(containerColor = DarkSlate900),
                        shape = RoundedCornerShape(12.dp),
                        modifier = Modifier.weight(1f).testTag("btn_goto_roi_editor")
                    ) {
                        Icon(Icons.Default.CropFree, contentDescription = null, modifier = Modifier.size(16.dp))
                        Spacer(modifier = Modifier.width(6.dp))
                        Text("ROI Zone Editor", fontSize = 12.sp, fontWeight = FontWeight.Bold)
                    }

                    Button(
                        onClick = onNavigateToAlertSettings,
                        colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                        shape = RoundedCornerShape(12.dp),
                        modifier = Modifier.weight(1f).testTag("btn_goto_alert_settings")
                    ) {
                        Icon(Icons.Default.NotificationsActive, contentDescription = null, modifier = Modifier.size(16.dp))
                        Spacer(modifier = Modifier.width(6.dp))
                        Text("Pengaturan Alert", fontSize = 12.sp, fontWeight = FontWeight.Bold)
                    }
                }
            }

            item {
                SectionHeader(title = "Daftar Stream Kamera Terdaftar (${cameras.size})")
            }

            items(cameras) { cam ->
                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    elevation = CardDefaults.cardElevation(defaultElevation = 1.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .border(1.dp, BorderColor, RoundedCornerShape(16.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(
                                text = cam.name,
                                fontSize = 14.sp,
                                fontWeight = FontWeight.Bold,
                                color = DarkSlate900
                            )
                            StatusBadge(
                                text = if (cam.isAiActive) "AI ACTIVE" else "AI DISABLED",
                                backgroundColor = if (cam.isAiActive) Emerald50 else SurfaceVariantLight,
                                textColor = if (cam.isAiActive) Emerald700 else TextSecondary
                            )
                        }

                        Spacer(modifier = Modifier.height(6.dp))

                        Text(
                            text = cam.location,
                            fontSize = 12.sp,
                            color = TextSecondary
                        )

                        Text(
                            text = cam.rtspUrl,
                            fontSize = 11.sp,
                            fontFamily = FontFamily.Monospace,
                            color = TextMuted
                        )

                        HorizontalDivider(modifier = Modifier.padding(vertical = 10.dp))

                        // Controls
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Column {
                                Text(
                                    text = "AI Sensitivitas: ${(cam.sensitivity * 100).toInt()}%",
                                    fontSize = 11.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = DarkSlate900
                                )
                                Slider(
                                    value = cam.sensitivity,
                                    onValueChange = { viewModel.updateCameraSensitivity(cam.id, it) },
                                    valueRange = 0.5f..0.99f,
                                    modifier = Modifier.width(180.dp),
                                    colors = SliderDefaults.colors(
                                        thumbColor = Emerald600,
                                        activeTrackColor = Emerald600
                                    )
                                )
                            }

                            Switch(
                                checked = cam.isAiActive,
                                onCheckedChange = { viewModel.toggleCameraAi(cam.id) },
                                colors = SwitchDefaults.colors(
                                    checkedThumbColor = Emerald600,
                                    checkedTrackColor = Emerald100
                                )
                            )
                        }
                    }
                }
            }
        }
    }
}
