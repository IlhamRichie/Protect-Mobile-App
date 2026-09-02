package com.example.protect.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
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
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.SectionHeader
import com.example.protect.viewmodel.AppViewModel

@Composable
fun TechnicianSopScreen(
    viewModel: AppViewModel,
    onBack: () -> Unit,
    onNavigateToChemicalLog: () -> Unit
) {
    val apdList = remember {
        mutableStateListOf(
            "Masker Respirator N95 / Katrid Kimia" to true,
            "Sarung Tangan Nitril Tahan Kimia" to true,
            "Kacamata Goggles Keselamatan" to true,
            "Sepatu Safety Boots K3 Anti-Slip" to true,
            "Wearpack / Jas Lab Standar HACCP" to false
        )
    }

    val prepList = remember {
        mutableStateListOf(
            "Identifikasi titik ingress pipa saluran" to true,
            "Kalibrasi alat cold fogger / sprayer" to true,
            "Konfirmasi evakuasi bahan pangan terbuka" to true,
            "Pemberitahuan kepada supervisor area" to false
        )
    }

    val isAllApdChecked = apdList.all { it.second }
    val isAllPrepChecked = prepList.all { it.second }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Checklist Standar Operasional Prosedur (SOP)",
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
                    onClick = onNavigateToChemicalLog,
                    enabled = isAllApdChecked && isAllPrepChecked,
                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                    shape = RoundedCornerShape(12.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)
                        .height(48.dp)
                        .testTag("btn_proceed_chemical_log")
                ) {
                    Icon(Icons.Default.ArrowForward, contentDescription = null, modifier = Modifier.size(18.dp))
                    Spacer(modifier = Modifier.width(8.dp))
                    Text("Lanjut ke Log Dosis Bahan Kimia", fontWeight = FontWeight.Bold)
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
                    text = "Kepatuhan K3 & APD adalah syarat mutlak audit HACCP. Centang seluruh item untuk membuka form pencatatan bahan kimia.",
                    icon = Icons.Default.HealthAndSafety
                )
            }

            // APD Section
            item {
                SectionHeader(title = "1. Kelengkapan Alat Pelindung Diri (APD)")
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(12.dp)) {
                        apdList.forEachIndexed { index, item ->
                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .clickable { apdList[index] = item.first to !item.second }
                                    .padding(vertical = 6.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Checkbox(
                                    checked = item.second,
                                    onCheckedChange = { isChecked ->
                                        apdList[index] = item.first to (isChecked == true)
                                    },
                                    colors = CheckboxDefaults.colors(checkedColor = Emerald600)
                                )
                                Spacer(modifier = Modifier.width(8.dp))
                                Text(
                                    text = item.first,
                                    fontSize = 13.sp,
                                    fontWeight = if (item.second) FontWeight.SemiBold else FontWeight.Normal,
                                    color = if (item.second) DarkSlate900 else TextSecondary
                                )
                            }
                            if (index < apdList.size - 1) HorizontalDivider()
                        }
                    }
                }
            }

            // Preparation Section
            item {
                SectionHeader(title = "2. Inspeksi Area & Keamanan Pangan")
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(12.dp)) {
                        prepList.forEachIndexed { index, item ->
                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .clickable { prepList[index] = item.first to !item.second }
                                    .padding(vertical = 6.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Checkbox(
                                    checked = item.second,
                                    onCheckedChange = { isChecked ->
                                        prepList[index] = item.first to (isChecked == true)
                                    },
                                    colors = CheckboxDefaults.colors(checkedColor = Emerald600)
                                )
                                Spacer(modifier = Modifier.width(8.dp))
                                Text(
                                    text = item.first,
                                    fontSize = 13.sp,
                                    fontWeight = if (item.second) FontWeight.SemiBold else FontWeight.Normal,
                                    color = if (item.second) DarkSlate900 else TextSecondary
                                )
                            }
                            if (index < prepList.size - 1) HorizontalDivider()
                        }
                    }
                }
            }
        }
    }
}
