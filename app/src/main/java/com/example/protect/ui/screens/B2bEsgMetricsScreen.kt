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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.data.SampleDataProvider
import com.example.protect.model.EsgMetric
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.SectionHeader
import com.example.protect.ui.components.StatusBadge

@Composable
fun B2bEsgMetricsScreen(
    onBack: () -> Unit
) {
    val metrics = SampleDataProvider.esgMetrics
    var isExported by remember { mutableStateOf(false) }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "ESG & Sustainability Metrics",
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
                    onClick = { isExported = true },
                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                    shape = RoundedCornerShape(12.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)
                        .height(48.dp)
                        .testTag("btn_export_esg")
                ) {
                    Icon(Icons.Default.FileDownload, contentDescription = null, modifier = Modifier.size(18.dp))
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = if (isExported) "Laporan ESG Berhasil Diunduh" else "Export Ringkasan ESG (PDF)",
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
                    text = "Perhitungan kuantitatif otomatis pengurangan toksisitas dan emisi karbon sejalan dengan standar GRI & SDG 12 (Responsible Consumption).",
                    icon = Icons.Default.Eco
                )
            }

            if (isExported) {
                item {
                    InfoBanner(
                        text = "File ESG_Sustainability_Scorecard_2026.pdf telah tersimpan di dokumen Anda.",
                        icon = Icons.Default.CheckCircle,
                        backgroundColor = Emerald50,
                        contentColor = Emerald800
                    )
                }
            }

            item {
                SectionHeader(title = "Indikator Kunci Keberlanjutan Lingkungan")
            }

            items(metrics) { metric ->
                EsgMetricCard(metric = metric)
            }

            // Chemical Distribution Card
            item {
                SectionHeader(title = "Distribusi Agen Pengendali Ramah Lingkungan")
                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(16.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
                        ChemicalDistRow(name = "Botanical Pyrethrum Extract", percentage = 45, color = Emerald600)
                        ChemicalDistRow(name = "Eco-Gel Bait (Biodegradable)", percentage = 43, color = Emerald500)
                        ChemicalDistRow(name = "Conventional Low-Residue Chemical", percentage = 12, color = WarningColor)
                    }
                }
            }
        }
    }
}

@Composable
fun EsgMetricCard(metric: EsgMetric) {
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
                    text = metric.label,
                    fontSize = 13.sp,
                    fontWeight = FontWeight.Bold,
                    color = DarkSlate900,
                    modifier = Modifier.weight(1f)
                )
                StatusBadge(
                    text = metric.change,
                    backgroundColor = Emerald50,
                    textColor = Emerald700
                )
            }

            Spacer(modifier = Modifier.height(10.dp))

            Text(
                text = metric.value,
                fontSize = 24.sp,
                fontWeight = FontWeight.ExtraBold,
                color = Emerald600
            )

            Spacer(modifier = Modifier.height(4.dp))

            Text(
                text = metric.unit,
                fontSize = 11.sp,
                color = TextSecondary
            )
        }
    }
}

@Composable
fun ChemicalDistRow(name: String, percentage: Int, color: Color) {
    Column {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text(text = name, fontSize = 12.sp, color = DarkSlate900, fontWeight = FontWeight.Medium)
            Text(text = "$percentage%", fontSize = 12.sp, fontWeight = FontWeight.Bold, color = color)
        }
        Spacer(modifier = Modifier.height(4.dp))
        LinearProgressIndicator(
            progress = { percentage / 100f },
            modifier = Modifier.fillMaxWidth().height(6.dp).clip(RoundedCornerShape(3.dp)),
            color = color,
            trackColor = BorderColor
        )
    }
}
