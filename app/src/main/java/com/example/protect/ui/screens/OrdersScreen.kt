package com.example.protect.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
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
import com.example.protect.model.OrderItem
import com.example.protect.model.OrderStatus
import com.example.protect.theme.*
import com.example.protect.ui.components.ProtectTopBar
import com.example.protect.ui.components.StatusBadge
import com.example.protect.viewmodel.AppViewModel
import java.text.NumberFormat
import java.util.*

@Composable
fun OrdersScreen(
    viewModel: AppViewModel,
    onNavigateToLiveTracker: () -> Unit,
    onNavigateToWarranty: () -> Unit,
    onNavigateToBooking: () -> Unit
) {
    val orders by viewModel.orders.collectAsState()
    var selectedFilter by remember { mutableStateOf("Semua") }

    val filters = listOf("Semua", "Sedang Berjalan", "Selesai")

    val filteredOrders = orders.filter { order ->
        when (selectedFilter) {
            "Sedang Berjalan" -> order.status == OrderStatus.EN_ROUTE || order.status == OrderStatus.IN_PROGRESS || order.status == OrderStatus.PENDING
            "Selesai" -> order.status == OrderStatus.COMPLETED
            else -> true
        }
    }

    val currencyFormat = remember {
        NumberFormat.getCurrencyInstance(Locale("id", "ID")).apply {
            maximumFractionDigits = 0
        }
    }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Riwayat Pesanan Layanan"
            )
        }
    ) { innerPadding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .background(BackgroundLight)
                .padding(innerPadding),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(14.dp)
        ) {
            // Filter Pills
            item {
                LazyRow(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    items(filters) { f ->
                        val isSelected = f == selectedFilter
                        Surface(
                            shape = RoundedCornerShape(16.dp),
                            color = if (isSelected) Emerald600 else SurfaceLight,
                            modifier = Modifier
                                .border(1.dp, if (isSelected) Emerald600 else BorderColor, RoundedCornerShape(16.dp))
                                .clickable { selectedFilter = f }
                        ) {
                            Text(
                                text = f,
                                fontSize = 12.sp,
                                fontWeight = FontWeight.SemiBold,
                                color = if (isSelected) SurfaceLight else TextSecondary,
                                modifier = Modifier.padding(horizontal = 14.dp, vertical = 8.dp)
                            )
                        }
                    }
                }
            }

            if (filteredOrders.isEmpty()) {
                item {
                    Column(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(top = 40.dp),
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Icon(
                            imageVector = Icons.Default.AssignmentLate,
                            contentDescription = null,
                            tint = TextMuted,
                            modifier = Modifier.size(64.dp)
                        )
                        Spacer(modifier = Modifier.height(12.dp))
                        Text(
                            text = "Tidak ada pesanan pada kategori ini.",
                            fontSize = 14.sp,
                            fontWeight = FontWeight.Bold,
                            color = TextSecondary
                        )
                    }
                }
            } else {
                items(filteredOrders) { order ->
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
                                    text = order.orderNumber,
                                    fontSize = 12.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = Emerald600
                                )
                                StatusBadge(
                                    text = when (order.status) {
                                        OrderStatus.EN_ROUTE -> "EN ROUTE"
                                        OrderStatus.IN_PROGRESS -> "DALAM PROSES"
                                        OrderStatus.COMPLETED -> "SELESAI & BERGARANSI"
                                        OrderStatus.PENDING -> "MENUNGGU"
                                        OrderStatus.CANCELLED -> "DIBATALKAN"
                                    },
                                    backgroundColor = when (order.status) {
                                        OrderStatus.EN_ROUTE -> Emerald50
                                        OrderStatus.COMPLETED -> Emerald100
                                        else -> SurfaceVariantLight
                                    },
                                    textColor = when (order.status) {
                                        OrderStatus.EN_ROUTE -> Emerald700
                                        OrderStatus.COMPLETED -> Emerald900
                                        else -> TextSecondary
                                    }
                                )
                            }

                            Spacer(modifier = Modifier.height(10.dp))

                            Text(
                                text = order.serviceTitle,
                                fontSize = 15.sp,
                                fontWeight = FontWeight.Bold,
                                color = DarkSlate900
                            )

                            Spacer(modifier = Modifier.height(6.dp))

                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Icon(
                                    imageVector = Icons.Default.CalendarToday,
                                    contentDescription = null,
                                    tint = TextSecondary,
                                    modifier = Modifier.size(13.dp)
                                )
                                Spacer(modifier = Modifier.width(6.dp))
                                Text(
                                    text = "${order.date} • ${order.time}",
                                    fontSize = 11.sp,
                                    color = TextSecondary
                                )
                            }

                            Spacer(modifier = Modifier.height(4.dp))

                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Icon(
                                    imageVector = Icons.Default.LocationOn,
                                    contentDescription = null,
                                    tint = TextSecondary,
                                    modifier = Modifier.size(13.dp)
                                )
                                Spacer(modifier = Modifier.width(6.dp))
                                Text(
                                    text = order.address,
                                    fontSize = 11.sp,
                                    color = TextSecondary,
                                    maxLines = 1
                                )
                            }

                            HorizontalDivider(modifier = Modifier.padding(vertical = 12.dp))

                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Column {
                                    Text(
                                        text = "Total Biaya",
                                        fontSize = 11.sp,
                                        color = TextSecondary
                                    )
                                    Text(
                                        text = currencyFormat.format(order.price),
                                        fontSize = 14.sp,
                                        fontWeight = FontWeight.Bold,
                                        color = DarkSlate900
                                    )
                                }

                                if (order.status == OrderStatus.EN_ROUTE) {
                                    Button(
                                        onClick = onNavigateToLiveTracker,
                                        colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                                        shape = RoundedCornerShape(10.dp)
                                    ) {
                                        Icon(Icons.Default.Navigation, contentDescription = null, modifier = Modifier.size(14.dp))
                                        Spacer(modifier = Modifier.width(6.dp))
                                        Text("Live GPS", fontSize = 12.sp, fontWeight = FontWeight.Bold)
                                    }
                                } else if (order.status == OrderStatus.COMPLETED) {
                                    Button(
                                        onClick = onNavigateToWarranty,
                                        colors = ButtonDefaults.buttonColors(containerColor = Emerald50, contentColor = Emerald700),
                                        shape = RoundedCornerShape(10.dp)
                                    ) {
                                        Icon(Icons.Default.Verified, contentDescription = null, modifier = Modifier.size(14.dp))
                                        Spacer(modifier = Modifier.width(6.dp))
                                        Text("E-Garansi", fontSize = 12.sp, fontWeight = FontWeight.Bold)
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
