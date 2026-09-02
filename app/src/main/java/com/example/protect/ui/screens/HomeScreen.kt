package com.example.protect.ui.screens

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material.icons.outlined.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.R
import com.example.protect.data.SampleDataProvider
import com.example.protect.model.*
import com.example.protect.theme.*
import com.example.protect.ui.components.*
import com.example.protect.viewmodel.AppViewModel
import java.text.NumberFormat
import java.util.*

@Composable
fun HomeScreen(
    viewModel: AppViewModel,
    onNavigateToBooking: () -> Unit,
    onNavigateToLiveTracker: () -> Unit,
    onNavigateToWarranty: () -> Unit,
    onNavigateToChat: () -> Unit,
    onNavigateToIncident: (String) -> Unit,
    onNavigateToHaccp: () -> Unit,
    onNavigateToCameras: () -> Unit,
    onNavigateToEsg: () -> Unit,
    onNavigateToTechBoard: () -> Unit,
    onNavigateToLiveFeed: () -> Unit = {},
    onNavigateToRoiEditor: () -> Unit = {},
    onNavigateToSop: () -> Unit = {},
    onNavigateToChemicalLog: () -> Unit = {},
    onNavigateToSignoff: () -> Unit = {}
) {
    val currentRole by viewModel.currentRole.collectAsState()
    val incidents by viewModel.incidents.collectAsState()
    val orders by viewModel.orders.collectAsState()
    val jobs by viewModel.jobs.collectAsState()
    val isGpsCheckedIn by viewModel.isGpsCheckedIn.collectAsState()
    val gpsLocationName by viewModel.gpsLocationName.collectAsState()
    val quoteAreaM2 by viewModel.quoteAreaM2.collectAsState()
    val quotePestType by viewModel.quotePestType.collectAsState()
    val quoteEstimatedPrice by viewModel.quoteEstimatedPrice.collectAsState()

    var showRoleSwitcher by remember { mutableStateOf(false) }
    var showBusinessModelDialog by remember { mutableStateOf(false) }

    val activeBreach = incidents.firstOrNull { it.status == IncidentStatus.ACTIVE_BREACH }
    val currencyFormat = remember {
        NumberFormat.getCurrencyInstance(Locale("id", "ID")).apply {
            maximumFractionDigits = 0
        }
    }

    if (showRoleSwitcher) {
        RoleSwitcherBottomSheet(
            currentRole = currentRole,
            onRoleSelected = { viewModel.setRole(it) },
            onDismissRequest = { showRoleSwitcher = false }
        )
    }

    if (showBusinessModelDialog) {
        BusinessModelDialog(
            onDismissRequest = { showBusinessModelDialog = false }
        )
    }

    LazyColumn(
        modifier = Modifier
            .fillMaxSize()
            .background(BackgroundLight),
        contentPadding = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        // App Branding & Role Switcher Header Card
        item {
            Card(
                shape = RoundedCornerShape(20.dp),
                colors = CardDefaults.cardColors(containerColor = DarkSlate900),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(18.dp)) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        // Official Logo Container
                        Surface(
                            shape = RoundedCornerShape(10.dp),
                            color = SurfaceLight,
                            modifier = Modifier.padding(vertical = 2.dp)
                        ) {
                            Box(modifier = Modifier.padding(horizontal = 10.dp, vertical = 6.dp)) {
                                ProtectBrandLogo(height = 24.dp)
                            }
                        }

                        Row(
                            horizontalArrangement = Arrangement.spacedBy(8.dp),
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            // Business Model Info Trigger
                            IconButton(
                                onClick = { showBusinessModelDialog = true },
                                modifier = Modifier
                                    .size(36.dp)
                                    .clip(CircleShape)
                                    .background(DarkSlate800)
                                    .testTag("btn_business_model_info")
                            ) {
                                Text("💰", fontSize = 16.sp)
                            }

                            // 24/7 CS Support Button
                            IconButton(
                                onClick = onNavigateToChat,
                                modifier = Modifier
                                    .size(36.dp)
                                    .clip(CircleShape)
                                    .background(DarkSlate800)
                                    .testTag("cs_chat_header_btn")
                            ) {
                                Icon(
                                    imageVector = Icons.Filled.SupportAgent,
                                    contentDescription = "CS Support",
                                    tint = Emerald400,
                                    modifier = Modifier.size(20.dp)
                                )
                            }
                        }
                    }

                    Spacer(modifier = Modifier.height(14.dp))

                    // Role Header Info Bar with Tap-to-Switch
                    Surface(
                        shape = RoundedCornerShape(12.dp),
                        color = DarkSlate800,
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable { showRoleSwitcher = true }
                            .testTag("role_header_bar")
                    ) {
                        Row(
                            modifier = Modifier.padding(horizontal = 14.dp, vertical = 10.dp),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Row(
                                verticalAlignment = Alignment.CenterVertically,
                                modifier = Modifier.weight(1f)
                            ) {
                                Box(
                                    modifier = Modifier
                                        .size(36.dp)
                                        .clip(CircleShape)
                                        .background(
                                            when (currentRole) {
                                                UserRole.B2C_RETAIL -> Emerald500.copy(alpha = 0.2f)
                                                UserRole.B2B_ENTERPRISE -> InfoColor.copy(alpha = 0.2f)
                                                UserRole.FIELD_TECHNICIAN -> WarningColor.copy(alpha = 0.2f)
                                            }
                                        ),
                                    contentAlignment = Alignment.Center
                                ) {
                                    Text(currentRole.iconEmoji, fontSize = 18.sp)
                                }
                                Spacer(modifier = Modifier.width(10.dp))
                                Column {
                                    Row(verticalAlignment = Alignment.CenterVertically) {
                                        Text(
                                            text = currentRole.title,
                                            fontSize = 13.sp,
                                            fontWeight = FontWeight.Bold,
                                            color = SurfaceLight
                                        )
                                        Spacer(modifier = Modifier.width(6.dp))
                                        StatusBadge(
                                            text = currentRole.shortName,
                                            backgroundColor = when (currentRole) {
                                                UserRole.B2C_RETAIL -> Emerald600
                                                UserRole.B2B_ENTERPRISE -> InfoColor
                                                UserRole.FIELD_TECHNICIAN -> WarningColor
                                            },
                                            textColor = SurfaceLight
                                        )
                                    }
                                    Text(
                                        text = currentRole.subtitle,
                                        fontSize = 10.sp,
                                        color = TextMuted,
                                        maxLines = 1,
                                        overflow = TextOverflow.Ellipsis
                                    )
                                }
                            }

                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Text(
                                    text = "Ubah",
                                    fontSize = 11.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = Emerald400
                                )
                                Icon(
                                    imageVector = Icons.Default.SwapHoriz,
                                    contentDescription = null,
                                    tint = Emerald400,
                                    modifier = Modifier.size(16.dp)
                                )
                            }
                        }
                    }
                }
            }
        }

        // ==========================================
        // DYNAMIC ECOSYSTEM CONTENT PER ACTIVE ROLE
        // ==========================================
        when (currentRole) {
            UserRole.B2C_RETAIL -> {
                // ----------------------------------------
                // 1. ALUR PENGGUNA RETAIL (B2C)
                // ----------------------------------------

                // 3-Step Booking Wizard Launcher Banner
                item {
                    Card(
                        shape = RoundedCornerShape(16.dp),
                        colors = CardDefaults.cardColors(containerColor = Emerald600),
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable { onNavigateToBooking() }
                            .testTag("b2c_wizard_banner")
                    ) {
                        Column(modifier = Modifier.padding(18.dp)) {
                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                StatusBadge(
                                    text = "3-STEP BOOKING WIZARD",
                                    backgroundColor = SurfaceLight.copy(alpha = 0.2f),
                                    textColor = SurfaceLight
                                )
                                Text(
                                    text = "E-Garansi 12 Bln",
                                    fontSize = 11.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = SurfaceLight
                                )
                            }

                            Spacer(modifier = Modifier.height(10.dp))

                            Text(
                                text = "Bebaskan Hunian Anda dari Hama",
                                fontSize = 17.sp,
                                fontWeight = FontWeight.Bold,
                                color = SurfaceLight
                            )
                            Text(
                                text = "1. Pilih Layanan • 2. Atur Alamat • 3. Tentukan Jadwal",
                                fontSize = 12.sp,
                                color = SurfaceLight.copy(alpha = 0.9f)
                            )

                            Spacer(modifier = Modifier.height(14.dp))

                            Button(
                                onClick = onNavigateToBooking,
                                colors = ButtonDefaults.buttonColors(
                                    containerColor = SurfaceLight,
                                    contentColor = Emerald800
                                ),
                                shape = RoundedCornerShape(10.dp),
                                modifier = Modifier.fillMaxWidth()
                            ) {
                                Icon(
                                    imageVector = Icons.Default.AddShoppingCart,
                                    contentDescription = null,
                                    modifier = Modifier.size(16.dp)
                                )
                                Spacer(modifier = Modifier.width(8.dp))
                                Text("Pesan Layanan Sekarang", fontWeight = FontWeight.Bold)
                            }
                        }
                    }
                }

                // Quick Actions (B2C)
                item {
                    SectionHeader(title = "Akses Cepat Pengguna Retail")
                    Spacer(modifier = Modifier.height(8.dp))

                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(10.dp)
                    ) {
                        QuickActionCard(
                            title = "Pesan Layanan",
                            subtitle = "Wizard 3-Langkah",
                            icon = Icons.Default.CalendarMonth,
                            iconColor = Emerald600,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_booking",
                            onClick = onNavigateToBooking
                        )
                        QuickActionCard(
                            title = "Live Tracker",
                            subtitle = "Pantau Teknisi",
                            icon = Icons.Default.Navigation,
                            iconColor = InfoColor,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_tracker",
                            onClick = onNavigateToLiveTracker
                        )
                    }

                    Spacer(modifier = Modifier.height(10.dp))

                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(10.dp)
                    ) {
                        QuickActionCard(
                            title = "E-Garansi 12 Bln",
                            subtitle = "Sertifikat Sah",
                            icon = Icons.Default.Verified,
                            iconColor = WarningColor,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_warranty",
                            onClick = onNavigateToWarranty
                        )
                        QuickActionCard(
                            title = "Konsultasi CS",
                            subtitle = "Chat & Estimasi",
                            icon = Icons.Default.Forum,
                            iconColor = SuccessColor,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_chat",
                            onClick = onNavigateToChat
                        )
                    }
                }

                // Instant Pricing Estimator Calculator Card (B2C_QUOTE)
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
                                Row(verticalAlignment = Alignment.CenterVertically) {
                                    Icon(
                                        imageVector = Icons.Default.Calculate,
                                        contentDescription = null,
                                        tint = Emerald600,
                                        modifier = Modifier.size(20.dp)
                                    )
                                    Spacer(modifier = Modifier.width(6.dp))
                                    Text(
                                        text = "Kalkulator Estimasi Biaya (B2C Quote)",
                                        fontSize = 13.sp,
                                        fontWeight = FontWeight.Bold,
                                        color = DarkSlate900
                                    )
                                }
                                StatusBadge(
                                    text = "INSTANT ESTIMATE",
                                    backgroundColor = Emerald50,
                                    textColor = Emerald700
                                )
                            }

                            Spacer(modifier = Modifier.height(12.dp))

                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.spacedBy(10.dp)
                            ) {
                                listOf("Rayap & Serangga", "Tikus & Rodent", "Fogging Nyamuk").forEach { pest ->
                                    val isSelected = pest == quotePestType
                                    Surface(
                                        onClick = { viewModel.recalculateQuote(quoteAreaM2, pest) },
                                        shape = RoundedCornerShape(8.dp),
                                        color = if (isSelected) Emerald600 else BorderColor.copy(alpha = 0.3f),
                                        modifier = Modifier.weight(1f)
                                    ) {
                                        Text(
                                            text = pest,
                                            fontSize = 10.sp,
                                            fontWeight = FontWeight.Bold,
                                            color = if (isSelected) SurfaceLight else DarkSlate800,
                                            textAlign = androidx.compose.ui.text.style.TextAlign.Center,
                                            modifier = Modifier.padding(vertical = 8.dp, horizontal = 4.dp)
                                        )
                                    }
                                }
                            }

                            Spacer(modifier = Modifier.height(12.dp))

                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .clip(RoundedCornerShape(10.dp))
                                    .background(Emerald50)
                                    .padding(12.dp),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Column {
                                    Text(
                                        text = "Estimasi Luas Area: $quoteAreaM2 m²",
                                        fontSize = 11.sp,
                                        color = DarkSlate800
                                    )
                                    Text(
                                        text = currencyFormat.format(quoteEstimatedPrice),
                                        fontSize = 16.sp,
                                        fontWeight = FontWeight.ExtraBold,
                                        color = Emerald700
                                    )
                                }

                                Button(
                                    onClick = onNavigateToBooking,
                                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                                    shape = RoundedCornerShape(8.dp)
                                ) {
                                    Text("Setujui & Booking", fontSize = 11.sp, fontWeight = FontWeight.Bold)
                                }
                            }
                        }
                    }
                }

                // Active Order Live Tracker Card
                val activeOrder = orders.firstOrNull { it.status == OrderStatus.EN_ROUTE }
                if (activeOrder != null) {
                    item {
                        SectionHeader(title = "Status Pesanan Aktif (B2C Tracker)")
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
                                        text = activeOrder.orderNumber,
                                        fontSize = 12.sp,
                                        fontWeight = FontWeight.Bold,
                                        color = Emerald600
                                    )
                                    StatusBadge(
                                        text = "TEKNISI MENUJU LOKASI",
                                        backgroundColor = Emerald50,
                                        textColor = Emerald700
                                    )
                                }

                                Spacer(modifier = Modifier.height(8.dp))

                                Text(
                                    text = activeOrder.serviceTitle,
                                    fontSize = 15.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = DarkSlate900
                                )

                                Text(
                                    text = "Teknisi: ${activeOrder.technicianName} • Estimasi Tiba: 12 Menit",
                                    fontSize = 12.sp,
                                    color = TextSecondary
                                )

                                Spacer(modifier = Modifier.height(12.dp))

                                Button(
                                    onClick = onNavigateToLiveTracker,
                                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                                    shape = RoundedCornerShape(10.dp),
                                    modifier = Modifier.fillMaxWidth().testTag("track_active_order_btn")
                                ) {
                                    Icon(
                                        imageVector = Icons.Default.LocationSearching,
                                        contentDescription = null,
                                        modifier = Modifier.size(16.dp)
                                    )
                                    Spacer(modifier = Modifier.width(8.dp))
                                    Text("Buka Live GPS Tracker", fontWeight = FontWeight.Bold)
                                }
                            }
                        }
                    }
                }

                // Services Catalog
                item {
                    SectionHeader(
                        title = "Katalog Layanan Pembasmian Hama",
                        actionTitle = "Pesan Cepat",
                        onActionClick = onNavigateToBooking
                    )

                    Column(verticalArrangement = Arrangement.spacedBy(10.dp)) {
                        SampleDataProvider.services.forEach { service ->
                            Card(
                                shape = RoundedCornerShape(14.dp),
                                colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                                    .clickable {
                                        viewModel.selectedService.value = service
                                        onNavigateToBooking()
                                    }
                            ) {
                                Row(
                                    modifier = Modifier.padding(14.dp),
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    Box(
                                        modifier = Modifier
                                            .size(44.dp)
                                            .clip(RoundedCornerShape(10.dp))
                                            .background(Emerald50),
                                        contentAlignment = Alignment.Center
                                    ) {
                                        Icon(
                                            imageVector = Icons.Default.Shield,
                                            contentDescription = null,
                                            tint = Emerald600,
                                            modifier = Modifier.size(24.dp)
                                        )
                                    }

                                    Spacer(modifier = Modifier.width(12.dp))

                                    Column(modifier = Modifier.weight(1f)) {
                                        Text(
                                            text = service.title,
                                            fontSize = 13.sp,
                                            fontWeight = FontWeight.Bold,
                                            color = DarkSlate900
                                        )
                                        Text(
                                            text = service.subtitle,
                                            fontSize = 11.sp,
                                            color = TextSecondary,
                                            maxLines = 1,
                                            overflow = TextOverflow.Ellipsis
                                        )
                                        Spacer(modifier = Modifier.height(4.dp))
                                        Text(
                                            text = "Mulai ${currencyFormat.format(service.price)}",
                                            fontSize = 12.sp,
                                            fontWeight = FontWeight.ExtraBold,
                                            color = Emerald600
                                        )
                                    }

                                    Icon(
                                        imageVector = Icons.Default.ChevronRight,
                                        contentDescription = null,
                                        tint = TextMuted
                                    )
                                }
                            }
                        }
                    }
                }
            }

            UserRole.B2B_ENTERPRISE -> {
                // ----------------------------------------
                // 2. ALUR PERUSAHAAN KORPORAT & PABRIK (B2B ProViewAI)
                // ----------------------------------------

                // Critical Intrusion Breach Alert (if any)
                if (activeBreach != null) {
                    item {
                        Card(
                            shape = RoundedCornerShape(16.dp),
                            colors = CardDefaults.cardColors(containerColor = DangerBackground),
                            modifier = Modifier
                                .fillMaxWidth()
                                .border(1.5.dp, DangerColor.copy(alpha = 0.5f), RoundedCornerShape(16.dp))
                                .clickable { onNavigateToIncident(activeBreach.id) }
                                .testTag("active_breach_alert_card")
                        ) {
                            Column(modifier = Modifier.padding(16.dp)) {
                                Row(
                                    modifier = Modifier.fillMaxWidth(),
                                    horizontalArrangement = Arrangement.SpaceBetween,
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    Row(verticalAlignment = Alignment.CenterVertically) {
                                        Box(
                                            modifier = Modifier
                                                .size(10.dp)
                                                .clip(CircleShape)
                                                .background(DangerColor)
                                        )
                                        Spacer(modifier = Modifier.width(8.dp))
                                        Text(
                                            text = "PROVIEWAI INTRUSION BREACH",
                                            fontSize = 11.sp,
                                            fontWeight = FontWeight.ExtraBold,
                                            color = DangerColor,
                                            letterSpacing = 1.sp
                                        )
                                    }
                                    StatusBadge(
                                        text = "${activeBreach.confidence}% CONFIDENCE",
                                        backgroundColor = DangerColor.copy(alpha = 0.15f),
                                        textColor = DangerColor
                                    )
                                }

                                Spacer(modifier = Modifier.height(10.dp))

                                Text(
                                    text = activeBreach.title,
                                    fontSize = 14.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = DarkSlate900
                                )

                                Spacer(modifier = Modifier.height(4.dp))

                                Text(
                                    text = "${activeBreach.location} • ${activeBreach.timestamp}",
                                    fontSize = 11.sp,
                                    color = TextSecondary
                                )

                                Spacer(modifier = Modifier.height(12.dp))

                                Row(
                                    modifier = Modifier.fillMaxWidth(),
                                    horizontalArrangement = Arrangement.End,
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    Text(
                                        text = "Tangani Insiden & Verifikasi CCTV",
                                        fontSize = 12.sp,
                                        fontWeight = FontWeight.Bold,
                                        color = DangerColor
                                    )
                                    Icon(
                                        imageVector = Icons.Default.ArrowForward,
                                        contentDescription = null,
                                        tint = DangerColor,
                                        modifier = Modifier.size(14.dp)
                                    )
                                }
                            }
                        }
                    }
                }

                // B2B 24/7 Command Center Telemetry Banner
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
                                Row(verticalAlignment = Alignment.CenterVertically) {
                                    Box(
                                        modifier = Modifier
                                            .size(8.dp)
                                            .clip(CircleShape)
                                            .background(SuccessColor)
                                    )
                                    Spacer(modifier = Modifier.width(6.dp))
                                    Text(
                                        text = "ProViewAI Command Center (24/7 Active)",
                                        fontSize = 12.sp,
                                        fontWeight = FontWeight.Bold,
                                        color = DarkSlate900
                                    )
                                }
                                Text(
                                    text = "Plant Cikarang",
                                    fontSize = 11.sp,
                                    color = TextSecondary
                                )
                            }

                            Spacer(modifier = Modifier.height(12.dp))

                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.spacedBy(8.dp)
                            ) {
                                TelemetryMetricCard(
                                    title = "CCTV Online",
                                    value = "6 / 6 RTSP",
                                    subtitle = "Full Coverage",
                                    modifier = Modifier.weight(1f)
                                )
                                TelemetryMetricCard(
                                    title = "AI Inference",
                                    value = "30 FPS",
                                    subtitle = "18ms Latency",
                                    modifier = Modifier.weight(1f)
                                )
                                TelemetryMetricCard(
                                    title = "HACCP Score",
                                    value = "94.8 / 100",
                                    subtitle = "Grade A+ Ready",
                                    modifier = Modifier.weight(1f)
                                )
                            }
                        }
                    }
                }

                // Quick Actions (B2B ProViewAI)
                item {
                    SectionHeader(title = "Modul Kepatuhan & AI Enterprise")
                    Spacer(modifier = Modifier.height(8.dp))

                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(10.dp)
                    ) {
                        QuickActionCard(
                            title = "Live CCTV AI",
                            subtitle = "ProViewAI Vision",
                            icon = Icons.Default.Videocam,
                            iconColor = Emerald600,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_live_feed",
                            onClick = onNavigateToCameras
                        )
                        QuickActionCard(
                            title = "Export HACCP",
                            subtitle = "Audit Report PDF",
                            icon = Icons.Default.FileDownload,
                            iconColor = DarkSlate800,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_haccp",
                            onClick = onNavigateToHaccp
                        )
                    }

                    Spacer(modifier = Modifier.height(10.dp))

                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(10.dp)
                    ) {
                        QuickActionCard(
                            title = "Metrik ESG",
                            subtitle = "Eco Chemical",
                            icon = Icons.Default.Eco,
                            iconColor = Emerald500,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_esg",
                            onClick = onNavigateToEsg
                        )
                        QuickActionCard(
                            title = "Kamera & ROI",
                            subtitle = "Boundary Area",
                            icon = Icons.Default.CropFree,
                            iconColor = InfoColor,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_roi",
                            onClick = onNavigateToCameras
                        )
                    }
                }

                // Incident Logs Overview
                item {
                    SectionHeader(
                        title = "Log Deteksi Hama Kritis (IncidentLogView)",
                        actionTitle = "Semua Log",
                        onActionClick = { onNavigateToIncident(incidents.first().id) }
                    )

                    Column(verticalArrangement = Arrangement.spacedBy(10.dp)) {
                        incidents.take(3).forEach { incident ->
                            Card(
                                shape = RoundedCornerShape(12.dp),
                                colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .border(1.dp, BorderColor, RoundedCornerShape(12.dp))
                                    .clickable { onNavigateToIncident(incident.id) }
                            ) {
                                Row(
                                    modifier = Modifier.padding(12.dp),
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    Box(
                                        modifier = Modifier
                                            .size(40.dp)
                                            .clip(RoundedCornerShape(8.dp))
                                            .background(
                                                if (incident.severity == SeverityLevel.CRITICAL) DangerColor.copy(alpha = 0.15f)
                                                else WarningColor.copy(alpha = 0.15f)
                                            ),
                                        contentAlignment = Alignment.Center
                                    ) {
                                        Icon(
                                            imageVector = Icons.Default.Warning,
                                            contentDescription = null,
                                            tint = if (incident.severity == SeverityLevel.CRITICAL) DangerColor else WarningColor,
                                            modifier = Modifier.size(20.dp)
                                        )
                                    }

                                    Spacer(modifier = Modifier.width(12.dp))

                                    Column(modifier = Modifier.weight(1f)) {
                                        Row(
                                            modifier = Modifier.fillMaxWidth(),
                                            horizontalArrangement = Arrangement.SpaceBetween
                                        ) {
                                            Text(
                                                text = incident.code,
                                                fontSize = 11.sp,
                                                fontWeight = FontWeight.Bold,
                                                color = Emerald600
                                            )
                                            StatusBadge(
                                                text = if (incident.status == IncidentStatus.ACTIVE_BREACH) "NEED ACTION" else "RESOLVED",
                                                backgroundColor = if (incident.status == IncidentStatus.ACTIVE_BREACH) DangerColor.copy(alpha = 0.15f) else SuccessColor.copy(alpha = 0.15f),
                                                textColor = if (incident.status == IncidentStatus.ACTIVE_BREACH) DangerColor else SuccessColor
                                            )
                                        }
                                        Text(
                                            text = incident.title,
                                            fontSize = 12.sp,
                                            fontWeight = FontWeight.Bold,
                                            color = DarkSlate900
                                        )
                                        Text(
                                            text = "${incident.location} • ${incident.timestamp}",
                                            fontSize = 10.sp,
                                            color = TextSecondary
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }

            UserRole.FIELD_TECHNICIAN -> {
                // ----------------------------------------
                // 3. ALUR EKSEKUTOR LAPANGAN (Field Technician Mode)
                // ----------------------------------------

                // GPS Check-In Verification Card
                item {
                    Card(
                        shape = RoundedCornerShape(16.dp),
                        colors = CardDefaults.cardColors(
                            containerColor = if (isGpsCheckedIn) Emerald50 else WarningColor.copy(alpha = 0.1f)
                        ),
                        modifier = Modifier
                            .fillMaxWidth()
                            .border(
                                1.5.dp,
                                if (isGpsCheckedIn) Emerald600 else WarningColor,
                                RoundedCornerShape(16.dp)
                            )
                    ) {
                        Column(modifier = Modifier.padding(16.dp)) {
                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Row(verticalAlignment = Alignment.CenterVertically) {
                                    Icon(
                                        imageVector = if (isGpsCheckedIn) Icons.Default.GpsFixed else Icons.Default.GpsNotFixed,
                                        contentDescription = null,
                                        tint = if (isGpsCheckedIn) Emerald600 else WarningColor,
                                        modifier = Modifier.size(20.dp)
                                    )
                                    Spacer(modifier = Modifier.width(8.dp))
                                    Text(
                                        text = if (isGpsCheckedIn) "GPS CHECK-IN VALID" else "VERIFIKASI GPS DIPERLUKAN",
                                        fontSize = 12.sp,
                                        fontWeight = FontWeight.ExtraBold,
                                        color = if (isGpsCheckedIn) Emerald800 else DarkSlate900
                                    )
                                }
                                StatusBadge(
                                    text = if (isGpsCheckedIn) "TERVERIFIKASI" else "PENDING",
                                    backgroundColor = if (isGpsCheckedIn) Emerald600 else WarningColor,
                                    textColor = SurfaceLight
                                )
                            }

                            Spacer(modifier = Modifier.height(8.dp))

                            Text(
                                text = "Lokasi Klien: $gpsLocationName",
                                fontSize = 13.sp,
                                fontWeight = FontWeight.Bold,
                                color = DarkSlate900
                            )
                            Text(
                                text = "Koordinat: ${viewModel.gpsCoordinates.value}",
                                fontSize = 11.sp,
                                color = TextSecondary
                            )

                            Spacer(modifier = Modifier.height(12.dp))

                            if (!isGpsCheckedIn) {
                                Button(
                                    onClick = { viewModel.performGpsCheckIn() },
                                    colors = ButtonDefaults.buttonColors(containerColor = WarningColor),
                                    shape = RoundedCornerShape(10.dp),
                                    modifier = Modifier.fillMaxWidth().testTag("btn_gps_checkin")
                                ) {
                                    Icon(
                                        imageVector = Icons.Default.LocationOn,
                                        contentDescription = null,
                                        tint = DarkSlate900,
                                        modifier = Modifier.size(16.dp)
                                    )
                                    Spacer(modifier = Modifier.width(6.dp))
                                    Text(
                                        text = "Verifikasi Kehadiran di Lokasi (GPS Check-In)",
                                        fontWeight = FontWeight.Bold,
                                        color = DarkSlate900
                                    )
                                }
                            } else {
                                InfoBanner(
                                    text = "Kehadiran teknisi tercatat pada server pusat. Anda siap melaksanakan SOP & chemical logging.",
                                    icon = Icons.Default.CheckCircle
                                )
                            }
                        }
                    }
                }

                // Quick Actions (Field Tech)
                item {
                    SectionHeader(title = "Tahapan Kerja Lapangan")
                    Spacer(modifier = Modifier.height(8.dp))

                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(10.dp)
                    ) {
                        QuickActionCard(
                            title = "Job Board",
                            subtitle = "Daftar Tugas",
                            icon = Icons.Default.Assignment,
                            iconColor = Emerald600,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_jobboard",
                            onClick = onNavigateToTechBoard
                        )
                        QuickActionCard(
                            title = "SOP Keselamatan",
                            subtitle = "APD & Pangan",
                            icon = Icons.Default.HealthAndSafety,
                            iconColor = InfoColor,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_sop",
                            onClick = onNavigateToTechBoard
                        )
                    }

                    Spacer(modifier = Modifier.height(10.dp))

                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(10.dp)
                    ) {
                        QuickActionCard(
                            title = "Chemical Log",
                            subtitle = "Dosis & Bahan",
                            icon = Icons.Default.Science,
                            iconColor = WarningColor,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_chemical_log",
                            onClick = onNavigateToTechBoard
                        )
                        QuickActionCard(
                            title = "E-Sign Pad",
                            subtitle = "Tanda Tangan",
                            icon = Icons.Default.Draw,
                            iconColor = SuccessColor,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_signoff",
                            onClick = onNavigateToTechBoard
                        )
                    }
                }

                // Assigned Job Queue
                item {
                    SectionHeader(
                        title = "Daftar Kunjungan Hari Ini (TechnicianJobBoardView)",
                        actionTitle = "Buka Board",
                        onActionClick = onNavigateToTechBoard
                    )

                    Column(verticalArrangement = Arrangement.spacedBy(10.dp)) {
                        jobs.forEach { job ->
                            Card(
                                shape = RoundedCornerShape(14.dp),
                                colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                                    .clickable { onNavigateToTechBoard() }
                            ) {
                                Column(modifier = Modifier.padding(14.dp)) {
                                    Row(
                                        modifier = Modifier.fillMaxWidth(),
                                        horizontalArrangement = Arrangement.SpaceBetween,
                                        verticalAlignment = Alignment.CenterVertically
                                    ) {
                                        Text(
                                            text = job.code,
                                            fontSize = 11.sp,
                                            fontWeight = FontWeight.Bold,
                                            color = Emerald600
                                        )
                                        StatusBadge(
                                            text = if (job.status == JobStatus.COMPLETED) "SELESAI" else "SIAP EKSEKUSI",
                                            backgroundColor = if (job.status == JobStatus.COMPLETED) SuccessColor.copy(alpha = 0.15f) else Emerald50,
                                            textColor = if (job.status == JobStatus.COMPLETED) SuccessColor else Emerald700
                                        )
                                    }

                                    Spacer(modifier = Modifier.height(6.dp))

                                    Text(
                                        text = job.clientName,
                                        fontSize = 14.sp,
                                        fontWeight = FontWeight.Bold,
                                        color = DarkSlate900
                                    )
                                    Text(
                                        text = "${job.serviceType} • Jadwal: ${job.scheduleTime}",
                                        fontSize = 11.sp,
                                        color = TextSecondary
                                    )
                                    Text(
                                        text = job.address,
                                        fontSize = 10.sp,
                                        color = TextMuted,
                                        maxLines = 1,
                                        overflow = TextOverflow.Ellipsis
                                    )

                                    Spacer(modifier = Modifier.height(10.dp))

                                    Button(
                                        onClick = onNavigateToTechBoard,
                                        colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                                        shape = RoundedCornerShape(8.dp),
                                        modifier = Modifier.fillMaxWidth()
                                    ) {
                                        Text("Buka Lembar Kerja & SOP", fontSize = 11.sp, fontWeight = FontWeight.Bold)
                                    }
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
fun TelemetryMetricCard(
    title: String,
    value: String,
    subtitle: String,
    modifier: Modifier = Modifier
) {
    Card(
        shape = RoundedCornerShape(10.dp),
        colors = CardDefaults.cardColors(containerColor = Emerald50.copy(alpha = 0.5f)),
        modifier = modifier
    ) {
        Column(modifier = Modifier.padding(10.dp)) {
            Text(
                text = title,
                fontSize = 10.sp,
                color = TextSecondary
            )
            Text(
                text = value,
                fontSize = 13.sp,
                fontWeight = FontWeight.Bold,
                color = Emerald800
            )
            Text(
                text = subtitle,
                fontSize = 9.sp,
                color = Emerald600
            )
        }
    }
}

@Composable
fun QuickActionCard(
    title: String,
    subtitle: String,
    icon: ImageVector,
    iconColor: Color,
    modifier: Modifier = Modifier,
    testTag: String = "",
    onClick: () -> Unit
) {
    Card(
        shape = RoundedCornerShape(14.dp),
        colors = CardDefaults.cardColors(containerColor = SurfaceLight),
        elevation = CardDefaults.cardElevation(defaultElevation = 1.dp),
        modifier = modifier
            .border(1.dp, BorderColor, RoundedCornerShape(14.dp))
            .clickable { onClick() }
            .testTag(testTag)
    ) {
        Column(modifier = Modifier.padding(12.dp)) {
            Box(
                modifier = Modifier
                    .size(36.dp)
                    .clip(RoundedCornerShape(8.dp))
                    .background(iconColor.copy(alpha = 0.12f)),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = icon,
                    contentDescription = null,
                    tint = iconColor,
                    modifier = Modifier.size(20.dp)
                )
            }
            Spacer(modifier = Modifier.height(10.dp))
            Text(
                text = title,
                fontSize = 13.sp,
                fontWeight = FontWeight.Bold,
                color = DarkSlate900
            )
            Text(
                text = subtitle,
                fontSize = 10.sp,
                color = TextSecondary
            )
        }
    }
}
