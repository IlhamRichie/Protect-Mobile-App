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
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.StatusBadge

@Composable
fun DigitalWarrantyScreen(
    onBack: () -> Unit,
    onClaimWarranty: () -> Unit
) {
    var isClaimed by remember { mutableStateOf(false) }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "E-Sertifikat Garansi 12 Bulan",
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
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            // Certificate Card
            item {
                Card(
                    shape = RoundedCornerShape(20.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .border(2.dp, Emerald600, RoundedCornerShape(20.dp))
                ) {
                    Column(
                        modifier = Modifier.padding(20.dp),
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        // Official Brand Logo & Gold Seal Header
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            com.example.protect.ui.components.ProtectBrandLogo(height = 24.dp)

                            Box(
                                modifier = Modifier
                                    .size(44.dp)
                                    .clip(CircleShape)
                                    .background(Emerald50)
                                    .border(2.dp, WarningColor, CircleShape),
                                contentAlignment = Alignment.Center
                            ) {
                                Icon(
                                    imageVector = Icons.Default.Verified,
                                    contentDescription = null,
                                    tint = WarningColor,
                                    modifier = Modifier.size(24.dp)
                                )
                            }
                        }

                        Spacer(modifier = Modifier.height(12.dp))

                        Text(
                            text = "SERTIFIKAT GARANSI PERLINDUNGAN",
                            fontSize = 15.sp,
                            fontWeight = FontWeight.ExtraBold,
                            color = DarkSlate900,
                            letterSpacing = 1.sp,
                            textAlign = TextAlign.Center
                        )

                        Text(
                            text = "No. Dokumen: CERT-2026-WAR-8821",
                            fontSize = 11.sp,
                            fontFamily = FontFamily.Monospace,
                            color = TextSecondary
                        )

                        Spacer(modifier = Modifier.height(16.dp))
                        HorizontalDivider()
                        Spacer(modifier = Modifier.height(16.dp))

                        // Details Breakdown
                        WarrantyDetailRow(label = "Pemilik Sertifikat", value = "PT. Boga Lestari Prima")
                        WarrantyDetailRow(label = "Layanan", value = "Termite Control & Barrier Treatment")
                        WarrantyDetailRow(label = "Alamat Properti", value = "Jl. Senopati Raya No. 88, Jaksel")
                        WarrantyDetailRow(label = "Tanggal Pengerjaan", value = "02 September 2026")
                        WarrantyDetailRow(label = "Masa Garansi", value = "12 Bulan Penuh (Hingga 02 Sep 2027)")
                        WarrantyDetailRow(label = "Teknisi Bertanggung Jawab", value = "Doni Pratama (ID: TECH-09)")

                        Spacer(modifier = Modifier.height(16.dp))

                        // Barcode & QR Verification Box
                        Surface(
                            shape = RoundedCornerShape(12.dp),
                            color = SurfaceVariantLight,
                            modifier = Modifier.fillMaxWidth()
                        ) {
                            Column(
                                modifier = Modifier.padding(14.dp),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Icon(
                                    imageVector = Icons.Default.QrCode,
                                    contentDescription = null,
                                    tint = DarkSlate900,
                                    modifier = Modifier.size(64.dp)
                                )
                                Spacer(modifier = Modifier.height(6.dp))
                                Text(
                                    text = "SHA-256: 8f4a9b2c...e12d (HACCP Verified)",
                                    fontSize = 10.sp,
                                    fontFamily = FontFamily.Monospace,
                                    color = TextSecondary
                                )
                            }
                        }
                    }
                }
            }

            // Guarantee Benefits
            item {
                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(16.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(10.dp)) {
                        Text(
                            text = "Ketentuan & Hak Garansi",
                            fontSize = 14.sp,
                            fontWeight = FontWeight.Bold,
                            color = DarkSlate900
                        )

                        BenefitItem(text = "Re-treatment 100% GRATIS jika ada tanda aktivitas hama selama masa aktif.")
                        BenefitItem(text = "Respon teknisi siaga prioritas dalam waktu kurang dari 2 jam.")
                        BenefitItem(text = "Menggunakan bahan botanical non-repellent aman bagi anak dan staf.")
                    }
                }
            }

            // Claim Action Button
            item {
                if (isClaimed) {
                    InfoBanner(
                        text = "Klaim Garansi Telah Dikirim! Tim Teknisi Siaga PROTECT akan menghubungi Anda dalam 15 menit.",
                        icon = Icons.Default.CheckCircle,
                        backgroundColor = Emerald50,
                        contentColor = Emerald800
                    )
                } else {
                    Button(
                        onClick = { isClaimed = true },
                        colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                        shape = RoundedCornerShape(12.dp),
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(48.dp)
                            .testTag("btn_claim_warranty")
                    ) {
                        Icon(Icons.Default.SupportAgent, contentDescription = null, modifier = Modifier.size(18.dp))
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("Ajukan Klaim Garansi / Re-Treatment", fontWeight = FontWeight.Bold)
                    }
                }
            }
        }
    }
}

@Composable
fun WarrantyDetailRow(label: String, value: String) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Text(text = label, fontSize = 11.sp, color = TextSecondary)
        Text(
            text = value,
            fontSize = 11.sp,
            fontWeight = FontWeight.Bold,
            color = DarkSlate900,
            textAlign = TextAlign.End,
            modifier = Modifier.padding(start = 12.dp)
        )
    }
}

@Composable
fun BenefitItem(text: String) {
    Row(verticalAlignment = Alignment.Top) {
        Icon(
            imageVector = Icons.Default.CheckCircle,
            contentDescription = null,
            tint = Emerald600,
            modifier = Modifier.size(16.dp)
        )
        Spacer(modifier = Modifier.width(8.dp))
        Text(
            text = text,
            fontSize = 12.sp,
            color = DarkSlate900,
            lineHeight = 18.sp
        )
    }
}
