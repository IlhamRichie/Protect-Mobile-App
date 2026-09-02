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
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.SectionHeader

@Composable
fun ExportHaccpScreen(
    onBack: () -> Unit = {},
    onBackClick: () -> Unit = onBack
) {
    var selectedPeriod by remember { mutableStateOf("Kuartal 3 (Jul - Sep 2026)") }
    var selectedFormat by remember { mutableStateOf("PDF Resmi (Digital Sign)") }
    var isExporting by remember { mutableStateOf(false) }
    var exportCompleted by remember { mutableStateOf(false) }

    val periods = listOf(
        "Bulan Ini (September 2026)",
        "Kuartal 3 (Jul - Sep 2026)",
        "Tahun Berjalan 2026 (YTD)"
    )

    val formats = listOf(
        "PDF Resmi (Digital Sign)",
        "Microsoft Excel (.xlsx)",
        "CSV Raw Telemetry Data"
    )

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Export Dokumen Audit HACCP",
                onBackClick = onBackClick
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
                        isExporting = true
                        exportCompleted = true
                    },
                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                    shape = RoundedCornerShape(12.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)
                        .height(48.dp)
                        .testTag("btn_generate_haccp_export")
                ) {
                    Icon(Icons.Default.FileDownload, contentDescription = null, modifier = Modifier.size(18.dp))
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = if (exportCompleted) "Unduh Ulang Laporan" else "Generate & Unduh Dokumen Audit",
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
                    text = "Laporan audit otomatis tersinkronisasi dengan sensor IoT dan berita acara teknisi, terverifikasi standar ekspor HACCP & ISO 22000.",
                    icon = Icons.Default.Verified
                )
            }

            if (exportCompleted) {
                item {
                    InfoBanner(
                        text = "Dokumen Audit Berhasil Digenerate! File [HACCP_Audit_Report_Q3_2026.pdf] siap diunduh.",
                        icon = Icons.Default.CheckCircle,
                        backgroundColor = Emerald50,
                        contentColor = Emerald800
                    )
                }
            }

            // Period Selector
            item {
                SectionHeader(title = "1. Pilih Periode Audit")
                Spacer(modifier = Modifier.height(8.dp))

                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    periods.forEach { period ->
                        val isSelected = period == selectedPeriod
                        Card(
                            shape = RoundedCornerShape(12.dp),
                            colors = CardDefaults.cardColors(
                                containerColor = if (isSelected) Emerald50 else SurfaceLight
                            ),
                            modifier = Modifier
                                .fillMaxWidth()
                                .border(
                                    if (isSelected) 2.dp else 1.dp,
                                    if (isSelected) Emerald600 else BorderColor,
                                    RoundedCornerShape(12.dp)
                                )
                                .clickable { selectedPeriod = period }
                        ) {
                            Row(
                                modifier = Modifier.padding(14.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                RadioButton(
                                    selected = isSelected,
                                    onClick = { selectedPeriod = period },
                                    colors = RadioButtonDefaults.colors(selectedColor = Emerald600)
                                )
                                Spacer(modifier = Modifier.width(8.dp))
                                Text(
                                    text = period,
                                    fontSize = 13.sp,
                                    fontWeight = FontWeight.SemiBold,
                                    color = DarkSlate900
                                )
                            }
                        }
                    }
                }
            }

            // Format Selector
            item {
                SectionHeader(title = "2. Pilih Format Output")
                Spacer(modifier = Modifier.height(8.dp))

                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    formats.forEach { fmt ->
                        val isSelected = fmt == selectedFormat
                        Card(
                            shape = RoundedCornerShape(12.dp),
                            colors = CardDefaults.cardColors(
                                containerColor = if (isSelected) Emerald50 else SurfaceLight
                            ),
                            modifier = Modifier
                                .fillMaxWidth()
                                .border(
                                    if (isSelected) 2.dp else 1.dp,
                                    if (isSelected) Emerald600 else BorderColor,
                                    RoundedCornerShape(12.dp)
                                )
                                .clickable { selectedFormat = fmt }
                        ) {
                            Row(
                                modifier = Modifier.padding(14.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Icon(
                                    imageVector = if (fmt.contains("PDF")) Icons.Default.PictureAsPdf else Icons.Default.TableChart,
                                    contentDescription = null,
                                    tint = if (isSelected) Emerald600 else TextSecondary
                                )
                                Spacer(modifier = Modifier.width(12.dp))
                                Text(
                                    text = fmt,
                                    fontSize = 13.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = DarkSlate900,
                                    modifier = Modifier.weight(1f)
                                )
                                RadioButton(
                                    selected = isSelected,
                                    onClick = { selectedFormat = fmt },
                                    colors = RadioButtonDefaults.colors(selectedColor = Emerald600)
                                )
                            }
                        }
                    }
                }
            }

            // Audit Summary Preview Card
            item {
                SectionHeader(title = "Ringkasan Parameter Laporan")
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(10.dp)) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            com.example.protect.ui.components.ProtectBrandLogo(height = 20.dp)
                            Text("Standard HACCP 2026", fontSize = 11.sp, fontWeight = FontWeight.Bold, color = Emerald700)
                        }
                        HorizontalDivider()
                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                            Text("Skor Kepatuhan Sanitasi", fontSize = 12.sp, color = TextSecondary)
                            Text("98.4% (Grade A+)", fontSize = 12.sp, fontWeight = FontWeight.Bold, color = Emerald600)
                        }
                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                            Text("Temuan Hama Kritis", fontSize = 12.sp, color = TextSecondary)
                            Text("0 Aktif (3 Terselesaikan)", fontSize = 12.sp, fontWeight = FontWeight.Bold, color = DarkSlate900)
                        }
                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                            Text("Tanda Tangan QA Berwenang", fontSize = 12.sp, color = TextSecondary)
                            Text("Budi Hartono (QA Mgr)", fontSize = 12.sp, fontWeight = FontWeight.Bold, color = DarkSlate900)
                        }
                    }
                }
            }
        }
    }
}
