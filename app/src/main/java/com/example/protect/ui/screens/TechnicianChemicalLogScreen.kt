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
fun TechnicianChemicalLogScreen(
    viewModel: AppViewModel,
    onBack: () -> Unit,
    onNavigateToSignoff: () -> Unit
) {
    var agent by remember { mutableStateOf(viewModel.chemicalAgent.value) }
    var dosage by remember { mutableStateOf(viewModel.chemicalDosage.value) }
    var unit by remember { mutableStateOf(viewModel.chemicalUnit.value) }
    var notes by remember { mutableStateOf(viewModel.chemicalNotes.value) }
    var isLogged by remember { mutableStateOf(viewModel.chemicalLoggedSuccess.value) }

    val agents = listOf(
        "Eco-Gel Fipronil 0.05% (Botanical Bio-Bait)",
        "Pyrethrum Natural Extract 1.5% Cold Fog",
        "Imidacloprid Eco-Barrier Termiticide",
        "Coumatetralyl IoT Smart Bait Block"
    )

    val units = listOf("Gram (g)", "Milliliter (mL)", "Liter (L)", "Bait Station Unit")

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Pencatatan Dosis Bahan Kimia (HACCP)",
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
                        viewModel.chemicalAgent.value = agent
                        viewModel.chemicalDosage.value = dosage
                        viewModel.chemicalUnit.value = unit
                        viewModel.chemicalNotes.value = notes
                        viewModel.chemicalLoggedSuccess.value = true
                        isLogged = true
                        onNavigateToSignoff()
                    },
                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                    shape = RoundedCornerShape(12.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)
                        .height(48.dp)
                        .testTag("btn_save_chemical_log")
                ) {
                    Icon(Icons.Default.Draw, contentDescription = null, modifier = Modifier.size(18.dp))
                    Spacer(modifier = Modifier.width(8.dp))
                    Text("Simpan Log & Lanjut Tanda Tangan", fontWeight = FontWeight.Bold)
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
                    text = "Dosis bahan aktif dicatat untuk pelacakan residu kimia pangan dan perhitungan reduksi jejak karbon pada dashboard ESG klien.",
                    icon = Icons.Default.Science
                )
            }

            // Chemical Agent Selector
            item {
                SectionHeader(title = "1. Pilih Bahan Aktif / Formula")
                Spacer(modifier = Modifier.height(8.dp))

                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    agents.forEach { a ->
                        val isSelected = a == agent
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
                                .clickable { agent = a }
                        ) {
                            Row(
                                modifier = Modifier.padding(14.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                RadioButton(
                                    selected = isSelected,
                                    onClick = { agent = a },
                                    colors = RadioButtonDefaults.colors(selectedColor = Emerald600)
                                )
                                Spacer(modifier = Modifier.width(8.dp))
                                Text(
                                    text = a,
                                    fontSize = 13.sp,
                                    fontWeight = FontWeight.SemiBold,
                                    color = DarkSlate900
                                )
                            }
                        }
                    }
                }
            }

            // Dosage & Unit Input
            item {
                SectionHeader(title = "2. Jumlah Dosis & Satuan")
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
                        OutlinedTextField(
                            value = dosage,
                            onValueChange = { dosage = it },
                            label = { Text("Jumlah / Volume Dosis") },
                            modifier = Modifier.fillMaxWidth().testTag("input_dosage_amount"),
                            shape = RoundedCornerShape(10.dp),
                            singleLine = true
                        )

                        Text(
                            text = "Satuan Ukur:",
                            fontSize = 12.sp,
                            fontWeight = FontWeight.Bold,
                            color = DarkSlate900
                        )

                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.spacedBy(8.dp)
                        ) {
                            units.take(2).forEach { u ->
                                val isSelected = u == unit
                                Surface(
                                    shape = RoundedCornerShape(8.dp),
                                    color = if (isSelected) Emerald600 else SurfaceVariantLight,
                                    modifier = Modifier
                                        .weight(1f)
                                        .clickable { unit = u }
                                ) {
                                    Text(
                                        text = u,
                                        fontSize = 11.sp,
                                        fontWeight = FontWeight.Bold,
                                        color = if (isSelected) SurfaceLight else TextSecondary,
                                        modifier = Modifier.padding(vertical = 8.dp, horizontal = 4.dp),
                                        textAlign = androidx.compose.ui.text.style.TextAlign.Center
                                    )
                                }
                            }
                        }
                    }
                }
            }

            // Notes
            item {
                SectionHeader(title = "3. Lokasi Penempatan Spesifik")
                OutlinedTextField(
                    value = notes,
                    onValueChange = { notes = it },
                    label = { Text("Catatan Area / Titik Baiting") },
                    modifier = Modifier.fillMaxWidth(),
                    shape = RoundedCornerShape(12.dp),
                    minLines = 2
                )
            }
        }
    }
}
