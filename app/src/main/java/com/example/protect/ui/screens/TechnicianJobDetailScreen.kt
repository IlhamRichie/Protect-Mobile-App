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
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.model.JobStatus
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.SectionHeader
import com.example.protect.ui.components.StatusBadge
import com.example.protect.viewmodel.AppViewModel

@Composable
fun TechnicianJobDetailScreen(
    jobId: String,
    viewModel: AppViewModel,
    onBack: () -> Unit,
    onNavigateToSop: () -> Unit,
    onNavigateToChemicalLog: () -> Unit,
    onNavigateToSignoff: () -> Unit
) {
    val jobs by viewModel.jobs.collectAsState()
    val job = jobs.find { it.id == jobId || it.code == jobId } ?: jobs.first()

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Detail Penugasan Lapangan",
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
                        viewModel.updateJobStatus(job.id, JobStatus.IN_PROGRESS)
                        onNavigateToSop()
                    },
                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                    shape = RoundedCornerShape(12.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)
                        .height(48.dp)
                        .testTag("btn_start_sop")
                ) {
                    Icon(Icons.Default.PlayArrow, contentDescription = null, modifier = Modifier.size(18.dp))
                    Spacer(modifier = Modifier.width(8.dp))
                    Text("Mulai Checklist SOP & APD", fontWeight = FontWeight.Bold)
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
                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
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
                                text = job.code,
                                fontSize = 13.sp,
                                fontFamily = FontFamily.Monospace,
                                fontWeight = FontWeight.Bold,
                                color = Emerald600
                            )
                            StatusBadge(
                                text = job.status.name,
                                backgroundColor = Emerald50,
                                textColor = Emerald700
                            )
                        }

                        Spacer(modifier = Modifier.height(10.dp))

                        Text(
                            text = job.clientName,
                            fontSize = 16.sp,
                            fontWeight = FontWeight.Bold,
                            color = DarkSlate900
                        )

                        Text(
                            text = job.address,
                            fontSize = 12.sp,
                            color = TextSecondary
                        )

                        Spacer(modifier = Modifier.height(8.dp))

                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Icon(Icons.Default.Phone, contentDescription = null, tint = Emerald600, modifier = Modifier.size(14.dp))
                            Spacer(modifier = Modifier.width(6.dp))
                            Text(text = job.phone, fontSize = 12.sp, fontWeight = FontWeight.SemiBold, color = Emerald600)
                        }
                    }
                }
            }

            // Target Details Card
            item {
                SectionHeader(title = "Parameter Pekerjaan")
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(10.dp)) {
                        JobParamRow(label = "Jenis Layanan", value = job.serviceType)
                        JobParamRow(label = "Target Spesies", value = job.pestType)
                        JobParamRow(label = "Tingkat Keparahan", value = job.severity)
                        JobParamRow(label = "Jadwal", value = job.scheduleTime)
                        HorizontalDivider()
                        Text(
                            text = "Catatan Khusus Klien:",
                            fontSize = 12.sp,
                            fontWeight = FontWeight.Bold,
                            color = DarkSlate900
                        )
                        Text(
                            text = job.notes,
                            fontSize = 12.sp,
                            color = TextSecondary,
                            lineHeight = 18.sp
                        )
                    }
                }
            }

            // Quick Navigation to Steps
            item {
                SectionHeader(title = "Tahapan Pengerjaan Mandatori")
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(10.dp)
                ) {
                    OutlinedButton(
                        onClick = onNavigateToChemicalLog,
                        shape = RoundedCornerShape(10.dp),
                        modifier = Modifier.weight(1f)
                    ) {
                        Icon(Icons.Default.Science, contentDescription = null, modifier = Modifier.size(16.dp))
                        Spacer(modifier = Modifier.width(4.dp))
                        Text("Chemical Log", fontSize = 11.sp)
                    }

                    OutlinedButton(
                        onClick = onNavigateToSignoff,
                        shape = RoundedCornerShape(10.dp),
                        modifier = Modifier.weight(1f)
                    ) {
                        Icon(Icons.Default.Draw, contentDescription = null, modifier = Modifier.size(16.dp))
                        Spacer(modifier = Modifier.width(4.dp))
                        Text("E-Sign TTD", fontSize = 11.sp)
                    }
                }
            }
        }
    }
}

@Composable
fun JobParamRow(label: String, value: String) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Text(text = label, fontSize = 12.sp, color = TextSecondary)
        Text(text = value, fontSize = 12.sp, fontWeight = FontWeight.Bold, color = DarkSlate900)
    }
}
