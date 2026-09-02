package com.example.protect.ui.screens

import androidx.compose.animation.AnimatedVisibility
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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.data.SampleDataProvider
import com.example.protect.model.IncidentStatus
import com.example.protect.model.SeverityLevel
import com.example.protect.theme.*
import com.example.protect.ui.components.InfoBanner
import com.example.protect.ui.components.SectionHeader
import com.example.protect.ui.components.StatusBadge
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
    onNavigateToTechBoard: () -> Unit
) {
    val incidents by viewModel.incidents.collectAsState()
    val orders by viewModel.orders.collectAsState()
    var isB2bMode by remember { mutableStateOf(true) }

    val activeBreach = incidents.firstOrNull { it.status == IncidentStatus.ACTIVE_BREACH }
    val currencyFormat = remember {
        NumberFormat.getCurrencyInstance(Locale("id", "ID")).apply {
            maximumFractionDigits = 0
        }
    }

    LazyColumn(
        modifier = Modifier
            .fillMaxSize()
            .background(BackgroundLight),
        contentPadding = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        // Header Section
        item {
            Card(
                shape = RoundedCornerShape(20.dp),
                colors = CardDefaults.cardColors(containerColor = DarkSlate900),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(modifier = Modifier.padding(20.dp)) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Column {
                            Text(
                                text = "Selamat Datang,",
                                fontSize = 12.sp,
                                color = Emerald400,
                                fontWeight = FontWeight.SemiBold
                            )
                            Text(
                                text = "PT Boga Lestari Prima",
                                fontSize = 18.sp,
                                fontWeight = FontWeight.Bold,
                                color = SurfaceLight
                            )
                        }

                        IconButton(
                            onClick = onNavigateToChat,
                            modifier = Modifier
                                .clip(CircleShape)
                                .background(DarkSlate800)
                                .testTag("cs_chat_header_btn")
                        ) {
                            Icon(
                                imageVector = Icons.Filled.SupportAgent,
                                contentDescription = "CS Support",
                                tint = Emerald400
                            )
                        }
                    }

                    Spacer(modifier = Modifier.height(16.dp))

                    // B2B / B2C Mode Toggle
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .clip(RoundedCornerShape(12.dp))
                            .background(DarkSlate800)
                            .padding(4.dp)
                    ) {
                        Button(
                            onClick = { isB2bMode = true },
                            colors = ButtonDefaults.buttonColors(
                                containerColor = if (isB2bMode) Emerald600 else Color.Transparent,
                                contentColor = SurfaceLight
                            ),
                            shape = RoundedCornerShape(8.dp),
                            modifier = Modifier.weight(1f).height(36.dp),
                            contentPadding = PaddingValues(0.dp)
                        ) {
                            Text(
                                text = "B2B Enterprise Audit",
                                fontSize = 11.sp,
                                fontWeight = FontWeight.Bold
                            )
                        }

                        Button(
                            onClick = { isB2bMode = false },
                            colors = ButtonDefaults.buttonColors(
                                containerColor = if (!isB2bMode) Emerald600 else Color.Transparent,
                                contentColor = SurfaceLight
                            ),
                            shape = RoundedCornerShape(8.dp),
                            modifier = Modifier.weight(1f).height(36.dp),
                            contentPadding = PaddingValues(0.dp)
                        ) {
                            Text(
                                text = "B2C Residential",
                                fontSize = 11.sp,
                                fontWeight = FontWeight.Bold
                            )
                        }
                    }
                }
            }
        }

        // Active Critical Breach Alert Card
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
                                    text = "AI INTRUSION BREACH ALERT",
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
                                text = "Lihat SOP Penanganan & CCTV",
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

        // Quick Action Grid
        item {
            SectionHeader(title = "Layanan & Modul Operasional")
            Spacer(modifier = Modifier.height(8.dp))

            Column(verticalArrangement = Arrangement.spacedBy(10.dp)) {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(10.dp)
                ) {
                    QuickActionCard(
                        title = "Pesan Layanan",
                        subtitle = "Booking Teknisi",
                        icon = Icons.Default.CalendarMonth,
                        iconColor = Emerald600,
                        modifier = Modifier.weight(1f),
                        testTag = "btn_quick_booking",
                        onClick = onNavigateToBooking
                    )
                    QuickActionCard(
                        title = "Live GPS Tracker",
                        subtitle = "Pantau Teknisi",
                        icon = Icons.Default.Navigation,
                        iconColor = InfoColor,
                        modifier = Modifier.weight(1f),
                        testTag = "btn_quick_tracker",
                        onClick = onNavigateToLiveTracker
                    )
                }

                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(10.dp)
                ) {
                    QuickActionCard(
                        title = "E-Garansi 12 Bln",
                        subtitle = "Sertifikat Digital",
                        icon = Icons.Default.Verified,
                        iconColor = WarningColor,
                        modifier = Modifier.weight(1f),
                        testTag = "btn_quick_warranty",
                        onClick = onNavigateToWarranty
                    )
                    QuickActionCard(
                        title = "CS WhatsApp AI",
                        subtitle = "Bantuan 24/7",
                        icon = Icons.Default.Forum,
                        iconColor = SuccessColor,
                        modifier = Modifier.weight(1f),
                        testTag = "btn_quick_chat",
                        onClick = onNavigateToChat
                    )
                }

                if (isB2bMode) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(10.dp)
                    ) {
                        QuickActionCard(
                            title = "Kamera AI RTSP",
                            subtitle = "ROI & Sensitivity",
                            icon = Icons.Default.Videocam,
                            iconColor = Emerald700,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_camera",
                            onClick = onNavigateToCameras
                        )
                        QuickActionCard(
                            title = "Export HACCP",
                            subtitle = "Audit Report PDF",
                            icon = Icons.Default.FileDownload,
                            iconColor = DarkSlate700,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_haccp",
                            onClick = onNavigateToHaccp
                        )
                    }

                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(10.dp)
                    ) {
                        QuickActionCard(
                            title = "ESG Dashboard",
                            subtitle = "Eco Metrics",
                            icon = Icons.Default.Eco,
                            iconColor = Emerald500,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_esg",
                            onClick = onNavigateToEsg
                        )
                        QuickActionCard(
                            title = "Job Teknisi",
                            subtitle = "SOP & Sign-Off",
                            icon = Icons.Default.Engineering,
                            iconColor = WarningColor,
                            modifier = Modifier.weight(1f),
                            testTag = "btn_quick_tech_jobs",
                            onClick = onNavigateToTechBoard
                        )
                    }
                }
            }
        }

        // Active Order Tracker Card
        val activeOrder = orders.firstOrNull { it.status == com.example.protect.model.OrderStatus.EN_ROUTE }
        if (activeOrder != null) {
            item {
                SectionHeader(title = "Pesanan Aktif")
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
                                text = "TEKNISI EN ROUTE",
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
                            text = "Teknisi: ${activeOrder.technicianName}",
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

        // Services Catalog Section
        item {
            SectionHeader(
                title = "Katalog Layanan Unggulan",
                actionTitle = "Booking",
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
                                    overflow = TextOverflow.ellipsis
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
