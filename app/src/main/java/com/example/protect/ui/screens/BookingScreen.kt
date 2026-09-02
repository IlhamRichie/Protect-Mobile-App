package com.example.protect.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
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
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.data.SampleDataProvider
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.SectionHeader
import com.example.protect.viewmodel.AppViewModel
import java.text.NumberFormat
import java.util.*

@Composable
fun BookingScreen(
    viewModel: AppViewModel,
    onBack: () -> Unit,
    onProceedToPayment: () -> Unit
) {
    val selectedService by viewModel.selectedService.collectAsState()
    var address by remember { mutableStateOf(viewModel.bookingAddress.value) }
    var date by remember { mutableStateOf(viewModel.bookingDate.value) }
    var time by remember { mutableStateOf(viewModel.bookingTime.value) }
    var notes by remember { mutableStateOf(viewModel.bookingNotes.value) }

    val currencyFormat = remember {
        NumberFormat.getCurrencyInstance(Locale("id", "ID")).apply {
            maximumFractionDigits = 0
        }
    }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Pemesanan & Jadwal Kunjungan",
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
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column {
                        Text(
                            text = "Estimasi Biaya:",
                            fontSize = 11.sp,
                            color = TextSecondary
                        )
                        Text(
                            text = currencyFormat.format(selectedService.price),
                            fontSize = 18.sp,
                            fontWeight = FontWeight.ExtraBold,
                            color = Emerald600
                        )
                    }

                    Button(
                        onClick = {
                            viewModel.bookingAddress.value = address
                            viewModel.bookingDate.value = date
                            viewModel.bookingTime.value = time
                            viewModel.bookingNotes.value = notes
                            onProceedToPayment()
                        },
                        colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                        shape = RoundedCornerShape(12.dp),
                        modifier = Modifier.testTag("btn_proceed_payment")
                    ) {
                        Text("Lanjut ke Pembayaran", fontWeight = FontWeight.Bold)
                        Spacer(modifier = Modifier.width(6.dp))
                        Icon(
                            imageVector = Icons.Default.ArrowForward,
                            contentDescription = null,
                            modifier = Modifier.size(16.dp)
                        )
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
            item {
                InfoBanner(
                    text = "Teknisi bersertifikat kami akan melakukan inspeksi menyeluruh, analisa kelembapan, dan penanganan ramah lingkungan bergaransi 12 bulan.",
                    icon = Icons.Default.VerifiedUser
                )
            }

            item {
                SectionHeader(title = "1. Pilih Paket Layanan")
                Spacer(modifier = Modifier.height(8.dp))

                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    SampleDataProvider.services.forEach { service ->
                        val isSelected = service.id == selectedService.id
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
                                .clickable { viewModel.selectedService.value = service }
                        ) {
                            Row(
                                modifier = Modifier.padding(14.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                RadioButton(
                                    selected = isSelected,
                                    onClick = { viewModel.selectedService.value = service },
                                    colors = RadioButtonDefaults.colors(selectedColor = Emerald600)
                                )
                                Spacer(modifier = Modifier.width(8.dp))
                                Column(modifier = Modifier.weight(1f)) {
                                    Text(
                                        text = service.title,
                                        fontWeight = FontWeight.Bold,
                                        fontSize = 13.sp,
                                        color = DarkSlate900
                                    )
                                    Text(
                                        text = service.subtitle,
                                        fontSize = 11.sp,
                                        color = TextSecondary
                                    )
                                }
                                Text(
                                    text = currencyFormat.format(service.price),
                                    fontWeight = FontWeight.Bold,
                                    fontSize = 13.sp,
                                    color = Emerald600
                                )
                            }
                        }
                    }
                }
            }

            item {
                SectionHeader(title = "2. Lokasi & Jadwal Inspeksi")
                Spacer(modifier = Modifier.height(8.dp))

                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(
                        modifier = Modifier.padding(16.dp),
                        verticalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        OutlinedTextField(
                            value = address,
                            onValueChange = { address = it },
                            label = { Text("Alamat Lengkap Kunjungan") },
                            leadingIcon = {
                                Icon(Icons.Default.LocationOn, contentDescription = null, tint = Emerald600)
                            },
                            modifier = Modifier.fillMaxWidth().testTag("input_address"),
                            shape = RoundedCornerShape(10.dp)
                        )

                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.spacedBy(10.dp)
                        ) {
                            OutlinedTextField(
                                value = date,
                                onValueChange = { date = it },
                                label = { Text("Tanggal") },
                                leadingIcon = {
                                    Icon(Icons.Default.CalendarToday, contentDescription = null, tint = Emerald600)
                                },
                                modifier = Modifier.weight(1f).testTag("input_date"),
                                shape = RoundedCornerShape(10.dp)
                            )

                            OutlinedTextField(
                                value = time,
                                onValueChange = { time = it },
                                label = { Text("Waktu") },
                                leadingIcon = {
                                    Icon(Icons.Default.AccessTime, contentDescription = null, tint = Emerald600)
                                },
                                modifier = Modifier.weight(1f).testTag("input_time"),
                                shape = RoundedCornerShape(10.dp)
                            )
                        }

                        OutlinedTextField(
                            value = notes,
                            onValueChange = { notes = it },
                            label = { Text("Catatan Area / Jenis Hama (Opsional)") },
                            placeholder = { Text("Contoh: Rayap di kusen pintu dapur & plafon lt 2") },
                            modifier = Modifier.fillMaxWidth().testTag("input_notes"),
                            shape = RoundedCornerShape(10.dp),
                            minLines = 2
                        )
                    }
                }
            }
        }
    }
}
