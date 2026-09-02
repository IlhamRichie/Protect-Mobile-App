package com.example.protect.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.model.IncidentItem
import com.example.protect.model.IncidentStatus
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.SectionHeader
import com.example.protect.ui.components.StatusBadge
import com.example.protect.viewmodel.AppViewModel

@Composable
fun IncidentDetailScreen(
    incidentId: String,
    viewModel: AppViewModel,
    onBack: () -> Unit,
    onNavigateToResolve: (String) -> Unit,
    onNavigateToRoiEditor: () -> Unit
) {
    val incidents by viewModel.incidents.collectAsState()
    val incident = incidents.find { it.id == incidentId || it.code == incidentId } ?: incidents.first()

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Detail Insiden & Pelanggaran",
                onBackClick = onBack
            )
        },
        bottomBar = {
            if (incident.status != IncidentStatus.RESOLVED) {
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
                        horizontalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        OutlinedButton(
                            onClick = onNavigateToRoiEditor,
                            shape = RoundedCornerShape(12.dp),
                            modifier = Modifier.weight(1f)
                        ) {
                            Icon(Icons.Default.CropFree, contentDescription = null, modifier = Modifier.size(16.dp))
                            Spacer(modifier = Modifier.width(6.dp))
                            Text("Edit ROI", fontWeight = FontWeight.Bold)
                        }

                        Button(
                            onClick = { onNavigateToResolve(incident.id) },
                            colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                            shape = RoundedCornerShape(12.dp),
                            modifier = Modifier
                                .weight(1f)
                                .testTag("btn_resolve_incident")
                        ) {
                            Icon(Icons.Default.TaskAlt, contentDescription = null, modifier = Modifier.size(16.dp))
                            Spacer(modifier = Modifier.width(6.dp))
                            Text("Tangani Insiden", fontWeight = FontWeight.Bold)
                        }
                    }
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
            // Breach Header Banner
            item {
                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(
                        containerColor = if (incident.status == IncidentStatus.RESOLVED) Emerald50 else DangerBackground
                    ),
                    modifier = Modifier
                        .fillMaxWidth()
                        .border(
                            1.dp,
                            if (incident.status == IncidentStatus.RESOLVED) Emerald600 else DangerColor.copy(alpha = 0.5f),
                            RoundedCornerShape(16.dp)
                        )
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(
                                text = incident.code,
                                fontSize = 12.sp,
                                fontFamily = FontFamily.Monospace,
                                fontWeight = FontWeight.Bold,
                                color = if (incident.status == IncidentStatus.RESOLVED) Emerald700 else DangerColor
                            )

                            StatusBadge(
                                text = when (incident.status) {
                                    IncidentStatus.ACTIVE_BREACH -> "ACTIVE BREACH"
                                    IncidentStatus.RESOLVING -> "IN RESOLUTION"
                                    IncidentStatus.RESOLVED -> "RESOLVED (SOP CLOSED)"
                                },
                                backgroundColor = if (incident.status == IncidentStatus.RESOLVED) Emerald100 else DangerColor.copy(alpha = 0.15f),
                                textColor = if (incident.status == IncidentStatus.RESOLVED) Emerald900 else DangerColor
                            )
                        }

                        Spacer(modifier = Modifier.height(10.dp))

                        Text(
                            text = incident.title,
                            fontSize = 16.sp,
                            fontWeight = FontWeight.Bold,
                            color = DarkSlate900
                        )

                        Spacer(modifier = Modifier.height(4.dp))

                        Text(
                            text = "${incident.location} • ${incident.timestamp}",
                            fontSize = 12.sp,
                            color = TextSecondary
                        )
                    }
                }
            }

            // AI Vision Evidence Card
            item {
                SectionHeader(title = "Bukti Tangkapan Layar AI Vision")
                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(containerColor = DarkSlate900),
                    modifier = Modifier.fillMaxWidth()
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Box(
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(160.dp)
                                .clip(RoundedCornerShape(12.dp))
                                .background(DarkSlate800)
                                .border(1.dp, DangerColor, RoundedCornerShape(12.dp)),
                            contentAlignment = Alignment.Center
                        ) {
                            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                                Icon(
                                    imageVector = Icons.Default.CameraAlt,
                                    contentDescription = null,
                                    tint = Color.White.copy(alpha = 0.3f),
                                    modifier = Modifier.size(48.dp)
                                )
                                Spacer(modifier = Modifier.height(8.dp))
                                Text(
                                    text = "THERMAL CAMERA SNAPSHOT",
                                    fontSize = 11.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = Color.White.copy(alpha = 0.5f),
                                    letterSpacing = 1.sp
                                )
                                Text(
                                    text = "Deteksi: ${incident.species} (${incident.confidence}%)",
                                    fontSize = 11.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = DangerColor
                                )
                            }
                        }

                        Spacer(modifier = Modifier.height(12.dp))

                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween
                        ) {
                            Text(
                                text = "Kamera: ${incident.cameraName}",
                                fontSize = 11.sp,
                                color = SurfaceLight
                            )
                            Text(
                                text = "Zona: ${incident.detectionZone}",
                                fontSize = 11.sp,
                                color = Emerald400
                            )
                        }
                    }
                }
            }

            // Recommended Action Card
            item {
                SectionHeader(title = "Rekomendasi Tindakan Korektif (HACCP)")
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Text(
                            text = incident.recommendedAction,
                            fontSize = 13.sp,
                            color = DarkSlate900,
                            lineHeight = 20.sp
                        )
                    }
                }
            }
        }
    }
}
