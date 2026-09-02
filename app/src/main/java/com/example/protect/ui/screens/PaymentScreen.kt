package com.example.protect.ui.screens

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
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
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.SectionHeader
import com.example.protect.viewmodel.AppViewModel
import java.text.NumberFormat
import java.util.*

@Composable
fun PaymentScreen(
    viewModel: AppViewModel,
    onBack: () -> Unit,
    onNavigateToWarranty: () -> Unit,
    onNavigateToLiveTracker: () -> Unit
) {
    val selectedService by viewModel.selectedService.collectAsState()
    val address by viewModel.bookingAddress.collectAsState()
    val date by viewModel.bookingDate.collectAsState()
    val time by viewModel.bookingTime.collectAsState()
    val discount by viewModel.discount.collectAsState()
    val selectedMethod by viewModel.selectedPaymentMethod.collectAsState()
    val treatmentStep by viewModel.treatmentProgressStep.collectAsState()

    var voucherInput by remember { mutableStateOf("") }
    var voucherMessage by remember { mutableStateOf<String?>(null) }

    val subtotal = selectedService.price
    val grandTotal = (subtotal - discount).coerceAtLeast(0L)

    val currencyFormat = remember {
        NumberFormat.getCurrencyInstance(Locale("id", "ID")).apply {
            maximumFractionDigits = 0
        }
    }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = if (treatmentStep > 0) "Status Penanganan & Garansi" else "Pembayaran (Checkout)",
                onBackClick = onBack
            )
        },
        bottomBar = {
            if (treatmentStep == 0) {
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
                                text = "Total Pembayaran:",
                                fontSize = 11.sp,
                                color = TextSecondary
                            )
                            Text(
                                text = currencyFormat.format(grandTotal),
                                fontSize = 18.sp,
                                fontWeight = FontWeight.ExtraBold,
                                color = Emerald600
                            )
                        }

                        Button(
                            onClick = { viewModel.processPayment() },
                            colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                            shape = RoundedCornerShape(12.dp),
                            modifier = Modifier.testTag("btn_pay_now")
                        ) {
                            Icon(Icons.Default.Lock, contentDescription = null, modifier = Modifier.size(16.dp))
                            Spacer(modifier = Modifier.width(6.dp))
                            Text("Bayar Sekarang", fontWeight = FontWeight.Bold)
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
            if (treatmentStep > 0) {
                // Treatment Progress Tracker View
                item {
                    InfoBanner(
                        text = "Pembayaran Berhasil! Teknisi Bpk. Doni Pratama siap menuju lokasi untuk melakukan inspeksi dan penanganan.",
                        icon = Icons.Default.CheckCircle,
                        backgroundColor = Emerald50,
                        contentColor = Emerald800
                    )
                }

                item {
                    SectionHeader(title = "Live Treatment Progress Tracker")
                    Card(
                        shape = RoundedCornerShape(16.dp),
                        colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                        modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(16.dp))
                    ) {
                        Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
                            TreatmentStepItem(
                                stepNumber = 1,
                                title = "Pembayaran Terverifikasi",
                                subtitle = "Metode: $selectedMethod terkonfirmasi lunas.",
                                isDone = treatmentStep >= 1
                            )
                            TreatmentStepItem(
                                stepNumber = 2,
                                title = "Teknisi En Route Menuju Lokasi",
                                subtitle = "Bpk. Doni dalam perjalanan (Estimasi 12 menit).",
                                isDone = treatmentStep >= 2
                            )
                            TreatmentStepItem(
                                stepNumber = 3,
                                title = "Penanganan & E-Sign Garansi",
                                subtitle = "Berita acara dan sertifikat garansi 12 bulan siap.",
                                isDone = treatmentStep >= 3
                            )
                        }
                    }
                }

                item {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(10.dp)
                    ) {
                        Button(
                            onClick = onNavigateToLiveTracker,
                            colors = ButtonDefaults.buttonColors(containerColor = InfoColor),
                            shape = RoundedCornerShape(12.dp),
                            modifier = Modifier.weight(1f)
                        ) {
                            Icon(Icons.Default.Navigation, contentDescription = null, modifier = Modifier.size(16.dp))
                            Spacer(modifier = Modifier.width(6.dp))
                            Text("Pantau GPS", fontWeight = FontWeight.Bold)
                        }

                        Button(
                            onClick = onNavigateToWarranty,
                            enabled = treatmentStep >= 3,
                            colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                            shape = RoundedCornerShape(12.dp),
                            modifier = Modifier.weight(1f).testTag("btn_view_warranty")
                        ) {
                            Icon(Icons.Default.Verified, contentDescription = null, modifier = Modifier.size(16.dp))
                            Spacer(modifier = Modifier.width(6.dp))
                            Text("Buka Garansi", fontWeight = FontWeight.Bold)
                        }
                    }
                }
            } else {
                // Checkout Form
                item {
                    Card(
                        shape = RoundedCornerShape(16.dp),
                        colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                        modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(16.dp))
                    ) {
                        Column(modifier = Modifier.padding(16.dp)) {
                            Text(
                                text = "Ringkasan Layanan Booking",
                                fontSize = 15.sp,
                                fontWeight = FontWeight.Bold,
                                color = DarkSlate900
                            )
                            HorizontalDivider(modifier = Modifier.padding(vertical = 12.dp))

                            SummaryRow(label = "Layanan", value = selectedService.title)
                            Spacer(modifier = Modifier.height(8.dp))
                            SummaryRow(label = "Lokasi", value = address)
                            Spacer(modifier = Modifier.height(8.dp))
                            SummaryRow(label = "Jadwal", value = "$date • $time")
                            HorizontalDivider(modifier = Modifier.padding(vertical = 12.dp))

                            SummaryRow(label = "Subtotal Biaya", value = currencyFormat.format(subtotal))

                            if (discount > 0) {
                                Spacer(modifier = Modifier.height(6.dp))
                                Row(
                                    modifier = Modifier.fillMaxWidth(),
                                    horizontalArrangement = Arrangement.SpaceBetween
                                ) {
                                    Text(
                                        text = "Diskon Voucher Promo",
                                        fontSize = 12.sp,
                                        fontWeight = FontWeight.Bold,
                                        color = Emerald600
                                    )
                                    Text(
                                        text = "- ${currencyFormat.format(discount)}",
                                        fontSize = 12.sp,
                                        fontWeight = FontWeight.Bold,
                                        color = Emerald600
                                    )
                                }
                            }
                        }
                    }
                }

                // Voucher Promo Card
                item {
                    Card(
                        shape = RoundedCornerShape(14.dp),
                        colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                        modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                    ) {
                        Column(modifier = Modifier.padding(14.dp)) {
                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                OutlinedTextField(
                                    value = voucherInput,
                                    onValueChange = { voucherInput = it },
                                    placeholder = { Text("Kode Promo (e.g. PROTECTFREE)", fontSize = 12.sp) },
                                    leadingIcon = {
                                        Icon(Icons.Default.CardGiftcard, contentDescription = null, tint = Emerald600)
                                    },
                                    modifier = Modifier.weight(1f).testTag("input_voucher"),
                                    shape = RoundedCornerShape(10.dp),
                                    singleLine = true
                                )

                                Spacer(modifier = Modifier.width(8.dp))

                                Button(
                                    onClick = {
                                        val success = viewModel.applyVoucher(voucherInput)
                                        voucherMessage = if (success) "Voucher Rp 50.000 berhasil diterapkan!" else "Kode voucher tidak valid."
                                    },
                                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                                    shape = RoundedCornerShape(10.dp),
                                    modifier = Modifier.testTag("btn_apply_voucher")
                                ) {
                                    Text("Terapkan", fontSize = 12.sp, fontWeight = FontWeight.Bold)
                                }
                            }

                            if (voucherMessage != null) {
                                Spacer(modifier = Modifier.height(6.dp))
                                Text(
                                    text = voucherMessage ?: "",
                                    fontSize = 11.sp,
                                    color = if (discount > 0) Emerald600 else DangerColor,
                                    fontWeight = FontWeight.SemiBold
                                )
                            }
                        }
                    }
                }

                // Payment Methods Selection
                item {
                    SectionHeader(title = "Pilih Metode Pembayaran")
                    Spacer(modifier = Modifier.height(8.dp))

                    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        viewModel.paymentMethods.forEach { method ->
                            val isSelected = method == selectedMethod
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
                                    .clickable { viewModel.selectedPaymentMethod.value = method }
                            ) {
                                Row(
                                    modifier = Modifier.padding(14.dp),
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    Icon(
                                        imageVector = when {
                                            method.contains("QRIS") -> Icons.Default.QrCodeScanner
                                            method.contains("Tunai") -> Icons.Default.Payments
                                            method.contains("Kartu") -> Icons.Default.CreditCard
                                            else -> Icons.Default.AccountBalance
                                        },
                                        contentDescription = null,
                                        tint = if (isSelected) Emerald600 else TextSecondary
                                    )
                                    Spacer(modifier = Modifier.width(12.dp))
                                    Text(
                                        text = method,
                                        fontSize = 13.sp,
                                        fontWeight = FontWeight.Bold,
                                        color = DarkSlate900,
                                        modifier = Modifier.weight(1f)
                                    )
                                    RadioButton(
                                        selected = isSelected,
                                        onClick = { viewModel.selectedPaymentMethod.value = method },
                                        colors = RadioButtonDefaults.colors(selectedColor = Emerald600)
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun SummaryRow(label: String, value: String) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Text(text = label, fontSize = 12.sp, color = TextSecondary)
        Spacer(modifier = Modifier.width(12.dp))
        Text(
            text = value,
            fontSize = 12.sp,
            fontWeight = FontWeight.Bold,
            color = DarkSlate900
        )
    }
}

@Composable
fun TreatmentStepItem(
    stepNumber: Int,
    title: String,
    subtitle: String,
    isDone: Boolean
) {
    Row(verticalAlignment = Alignment.CenterVertically) {
        Box(
            modifier = Modifier
                .size(28.dp)
                .clip(CircleShape)
                .background(if (isDone) Emerald600 else BorderColor),
            contentAlignment = Alignment.Center
        ) {
            if (isDone) {
                Icon(
                    imageVector = Icons.Default.Check,
                    contentDescription = null,
                    tint = SurfaceLight,
                    modifier = Modifier.size(16.dp)
                )
            } else {
                Text(
                    text = "$stepNumber",
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Bold,
                    color = TextSecondary
                )
            }
        }

        Spacer(modifier = Modifier.width(12.dp))

        Column {
            Text(
                text = title,
                fontSize = 13.sp,
                fontWeight = if (isDone) FontWeight.Bold else FontWeight.Medium,
                color = if (isDone) DarkSlate900 else TextSecondary
            )
            Text(
                text = subtitle,
                fontSize = 11.sp,
                color = TextSecondary
            )
        }
    }
}
