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
fun ResolveTicketScreen(
    incidentId: String,
    viewModel: AppViewModel,
    onBack: () -> Unit
) {
    val incidents by viewModel.incidents.collectAsState()
    val incident = incidents.find { it.id == incidentId || it.code == incidentId } ?: incidents.first()

    var resolutionNotes by remember { mutableStateOf("Penutupan pipa saluran pembuangan utama telah dipasang grating stainless 2mm. Umpan eco-bait station #3 diaktifkan.") }
    val checklistItems = remember {
        mutableStateListOf(
            "Isolasi perimeter area dapur steril" to true,
            "Pembersihan residu & sanitasi permukaan" to true,
            "Pemasangan tamper-proof eco-bait station" to true,
            "Verifikasi ulang feed CCTV selama 15 menit" to false
        )
    }
    var isSubmitted by remember { mutableStateOf(false) }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Penyelesaian Insiden & SOP HACCP",
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
                        viewModel.resolveIncident(incident.id, resolutionNotes)
                        isSubmitted = true
                    },
                    enabled = !isSubmitted,
                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                    shape = RoundedCornerShape(12.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)
                        .height(48.dp)
                        .testTag("btn_submit_resolution")
                ) {
                    Icon(Icons.Default.CheckCircle, contentDescription = null, modifier = Modifier.size(18.dp))
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = if (isSubmitted) "Insiden Telah Diselesaikan" else "Konfirmasi Penyelesaian & Tutup Tiket",
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
                    text = "Penyelesaian insiden akan dicatat secara kriptografis dalam Log Audit HACCP dan diteruskan ke Dashboard ESG.",
                    icon = Icons.Default.Security
                )
            }

            if (isSubmitted) {
                item {
                    InfoBanner(
                        text = "Tiket Insiden ${incident.code} Berhasil Ditutup! Status kepatuhan HACCP kembali normal (Audit Grade A+).",
                        icon = Icons.Default.TaskAlt,
                        backgroundColor = Emerald50,
                        contentColor = Emerald800
                    )
                }
            }

            item {
                SectionHeader(title = "Checklist Tindakan Korektif (Corrective Action)")
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(12.dp)) {
                        checklistItems.forEachIndexed { index, pair ->
                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .clickable { checklistItems[index] = pair.first to !pair.second }
                                    .padding(vertical = 8.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Checkbox(
                                    checked = pair.second,
                                    onCheckedChange = { isChecked ->
                                        checklistItems[index] = pair.first to (isChecked == true)
                                    },
                                    colors = CheckboxDefaults.colors(checkedColor = Emerald600)
                                )
                                Spacer(modifier = Modifier.width(8.dp))
                                Text(
                                    text = pair.first,
                                    fontSize = 13.sp,
                                    fontWeight = if (pair.second) FontWeight.SemiBold else FontWeight.Normal,
                                    color = if (pair.second) DarkSlate900 else TextSecondary
                                )
                            }
                            if (index < checklistItems.size - 1) {
                                HorizontalDivider()
                            }
                        }
                    }
                }
            }

            item {
                SectionHeader(title = "Catatan Berita Acara Penyelesaian")
                OutlinedTextField(
                    value = resolutionNotes,
                    onValueChange = { resolutionNotes = it },
                    label = { Text("Deskripsi Tindakan & Material Digunakan") },
                    modifier = Modifier
                        .fillMaxWidth()
                        .testTag("input_resolution_notes"),
                    shape = RoundedCornerShape(12.dp),
                    minLines = 3
                )
            }
        }
    }
}
