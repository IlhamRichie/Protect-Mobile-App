package com.example.protect.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
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
import com.example.protect.model.JobStatus
import com.example.protect.model.TechnicianJob
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.StatusBadge
import com.example.protect.viewmodel.AppViewModel

@Composable
fun TechnicianJobBoardScreen(
    viewModel: AppViewModel,
    onBack: () -> Unit,
    onNavigateToJobDetail: (String) -> Unit
) {
    val jobs by viewModel.jobs.collectAsState()
    var selectedFilter by remember { mutableStateOf("Semua") }

    val filters = listOf("Semua", "Tugas Baru (Assigned)", "Sedang Dikerjakan", "Selesai")

    val filteredJobs = jobs.filter { job ->
        when (selectedFilter) {
            "Tugas Baru (Assigned)" -> job.status == JobStatus.ASSIGNED
            "Sedang Dikerjakan" -> job.status == JobStatus.IN_PROGRESS
            "Selesai" -> job.status == JobStatus.COMPLETED
            else -> true
        }
    }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Papan Tugas Lapangan Teknisi",
                onBackClick = onBack
            )
        }
    ) { innerPadding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .background(BackgroundLight)
                .padding(innerPadding),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(14.dp)
        ) {
            item {
                InfoBanner(
                    text = "Mode Teknisi Aktif: Doni Pratama (ID: TECH-09). Pastikan pengisian SOP keselamatan APD & pencatatan chemical log lengkap sebelum meminta tanda tangan digital.",
                    icon = Icons.Default.Engineering
                )
            }

            // Status Filter Pills
            item {
                LazyRow(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    items(filters) { f ->
                        val isSelected = f == selectedFilter
                        Surface(
                            shape = RoundedCornerShape(16.dp),
                            color = if (isSelected) Emerald600 else SurfaceLight,
                            modifier = Modifier
                                .border(1.dp, if (isSelected) Emerald600 else BorderColor, RoundedCornerShape(16.dp))
                                .clickable { selectedFilter = f }
                        ) {
                            Text(
                                text = f,
                                fontSize = 12.sp,
                                fontWeight = FontWeight.SemiBold,
                                color = if (isSelected) SurfaceLight else TextSecondary,
                                modifier = Modifier.padding(horizontal = 14.dp, vertical = 8.dp)
                            )
                        }
                    }
                }
            }

            items(filteredJobs) { job ->
                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    elevation = CardDefaults.cardElevation(defaultElevation = 1.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .border(1.dp, BorderColor, RoundedCornerShape(16.dp))
                        .clickable { onNavigateToJobDetail(job.id) }
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(
                                text = job.code,
                                fontSize = 12.sp,
                                fontFamily = FontFamily.Monospace,
                                fontWeight = FontWeight.Bold,
                                color = Emerald600
                            )

                            StatusBadge(
                                text = when (job.status) {
                                    JobStatus.ASSIGNED -> "ASSIGNED"
                                    JobStatus.IN_PROGRESS -> "IN PROGRESS"
                                    JobStatus.COMPLETED -> "COMPLETED"
                                },
                                backgroundColor = when (job.status) {
                                    JobStatus.ASSIGNED -> WarningBackground
                                    JobStatus.IN_PROGRESS -> Emerald50
                                    JobStatus.COMPLETED -> Emerald100
                                },
                                textColor = when (job.status) {
                                    JobStatus.ASSIGNED -> WarningColor
                                    JobStatus.IN_PROGRESS -> Emerald700
                                    JobStatus.COMPLETED -> Emerald900
                                }
                            )
                        }

                        Spacer(modifier = Modifier.height(8.dp))

                        Text(
                            text = job.clientName,
                            fontSize = 15.sp,
                            fontWeight = FontWeight.Bold,
                            color = DarkSlate900
                        )

                        Spacer(modifier = Modifier.height(4.dp))

                        Text(
                            text = "Layanan: ${job.serviceType}",
                            fontSize = 12.sp,
                            color = TextSecondary
                        )

                        Text(
                            text = "Target Hama: ${job.pestType}",
                            fontSize = 12.sp,
                            fontWeight = FontWeight.SemiBold,
                            color = DarkSlate800
                        )

                        Spacer(modifier = Modifier.height(8.dp))

                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Icon(Icons.Default.Schedule, contentDescription = null, tint = TextSecondary, modifier = Modifier.size(13.dp))
                            Spacer(modifier = Modifier.width(6.dp))
                            Text(text = job.scheduleTime, fontSize = 11.sp, color = TextSecondary)
                        }

                        Spacer(modifier = Modifier.height(4.dp))

                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Icon(Icons.Default.LocationOn, contentDescription = null, tint = TextSecondary, modifier = Modifier.size(13.dp))
                            Spacer(modifier = Modifier.width(6.dp))
                            Text(text = job.address, fontSize = 11.sp, color = TextSecondary, maxLines = 1)
                        }

                        HorizontalDivider(modifier = Modifier.padding(vertical = 12.dp))

                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.End,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(
                                text = "Buka Prosedur & SOP",
                                fontSize = 12.sp,
                                fontWeight = FontWeight.Bold,
                                color = Emerald600
                            )
                            Icon(Icons.Default.ChevronRight, contentDescription = null, tint = Emerald600)
                        }
                    }
                }
            }
        }
    }
}
