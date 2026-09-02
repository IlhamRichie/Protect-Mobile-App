package com.example.protect.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowForward
import androidx.compose.material.icons.filled.*
import androidx.compose.material.icons.outlined.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.model.UserRole
import com.example.protect.theme.*
import com.example.protect.ui.components.*
import com.example.protect.viewmodel.AppViewModel

@Composable
fun ProfileScreen(
    viewModel: AppViewModel? = null,
    onNavigateToChat: () -> Unit
) {
    var showLogoutDialog by remember { mutableStateOf(false) }
    var showRoleSwitcher by remember { mutableStateOf(false) }
    var showBusinessModelDialog by remember { mutableStateOf(false) }

    val currentRole = viewModel?.currentRole?.collectAsState()?.value ?: UserRole.B2C_RETAIL

    if (showLogoutDialog) {
        AlertDialog(
            onDismissRequest = { showLogoutDialog = false },
            title = { Text("Konfirmasi Keluar") },
            text = { Text("Apakah Anda yakin ingin keluar dari akun PROTECT?") },
            confirmButton = {
                TextButton(onClick = { showLogoutDialog = false }) {
                    Text("Keluar", color = DangerColor, fontWeight = FontWeight.Bold)
                }
            },
            dismissButton = {
                TextButton(onClick = { showLogoutDialog = false }) {
                    Text("Batal")
                }
            }
        )
    }

    if (showRoleSwitcher && viewModel != null) {
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

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Profil & Ekosistem Akun"
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
            // Profile Header Card with Official Logo
            item {
                Card(
                    shape = RoundedCornerShape(20.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier
                        .fillMaxWidth()
                        .border(1.dp, BorderColor, RoundedCornerShape(20.dp))
                ) {
                    Column(modifier = Modifier.padding(18.dp)) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            ProtectBrandLogo(height = 24.dp)
                            StatusBadge(
                                text = "VERIFIED ACCOUNT",
                                backgroundColor = Emerald50,
                                textColor = Emerald700
                            )
                        }

                        Spacer(modifier = Modifier.height(14.dp))

                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Box(
                                modifier = Modifier
                                    .size(54.dp)
                                    .clip(CircleShape)
                                    .background(Emerald600.copy(alpha = 0.15f)),
                                contentAlignment = Alignment.Center
                            ) {
                                Text(currentRole.iconEmoji, fontSize = 24.sp)
                            }

                            Spacer(modifier = Modifier.width(14.dp))

                            Column {
                                Text(
                                    text = when (currentRole) {
                                        UserRole.B2C_RETAIL -> "Hendra Wijaya"
                                        UserRole.B2B_ENTERPRISE -> "Budi Hartono (PT Boga Lestari)"
                                        UserRole.FIELD_TECHNICIAN -> "Doni Setiawan (ID: TECH-782)"
                                    },
                                    fontSize = 15.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = DarkSlate900
                                )
                                Spacer(modifier = Modifier.height(2.dp))
                                Text(
                                    text = when (currentRole) {
                                        UserRole.B2C_RETAIL -> "Pemilik Hunian & Ruko • Jakarta Selatan"
                                        UserRole.B2B_ENTERPRISE -> "Plant & QA Manager • Cikarang"
                                        UserRole.FIELD_TECHNICIAN -> "Senior Pest Control Specialist • Licensed"
                                    },
                                    fontSize = 11.sp,
                                    color = TextSecondary
                                )
                            }
                        }
                    }
                }
            }

            // Role Switcher Interactive Card
            item {
                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(containerColor = DarkSlate900),
                    modifier = Modifier
                        .fillMaxWidth()
                        .clickable { showRoleSwitcher = true }
                        .testTag("profile_role_switcher_card")
                ) {
                    Row(
                        modifier = Modifier.padding(16.dp),
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Column(modifier = Modifier.weight(1f)) {
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Text("Ganti Peran / Ekosistem", fontSize = 13.sp, fontWeight = FontWeight.Bold, color = SurfaceLight)
                                Spacer(modifier = Modifier.width(6.dp))
                                StatusBadge(
                                    text = currentRole.shortName,
                                    backgroundColor = Emerald600,
                                    textColor = SurfaceLight
                                )
                            }
                            Spacer(modifier = Modifier.height(4.dp))
                            Text(
                                text = "Beralih antara B2C Retail, B2B Enterprise, atau Field Tech Mode.",
                                fontSize = 11.sp,
                                color = TextMuted
                            )
                        }

                        Icon(
                            imageVector = Icons.Default.SwapHoriz,
                            contentDescription = null,
                            tint = Emerald400,
                            modifier = Modifier.size(24.dp)
                        )
                    }
                }
            }

            // Monetization & Business Model Card
            item {
                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier
                        .fillMaxWidth()
                        .border(1.dp, BorderColor, RoundedCornerShape(16.dp))
                        .clickable { showBusinessModelDialog = true }
                        .testTag("profile_business_model_card")
                ) {
                    Row(
                        modifier = Modifier.padding(16.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Box(
                            modifier = Modifier
                                .size(40.dp)
                                .clip(RoundedCornerShape(10.dp))
                                .background(WarningColor.copy(alpha = 0.15f)),
                            contentAlignment = Alignment.Center
                        ) {
                            Text("💰", fontSize = 18.sp)
                        }

                        Spacer(modifier = Modifier.width(12.dp))

                        Column(modifier = Modifier.weight(1f)) {
                            Text(
                                text = "Struktur & Model Bisnis PROTECT",
                                fontSize = 13.sp,
                                fontWeight = FontWeight.Bold,
                                color = DarkSlate900
                            )
                            Text(
                                text = "B2C Transaksional (Per-Booking) & B2B SaaS + Hardware Subscription.",
                                fontSize = 11.sp,
                                color = TextSecondary
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

            // Menu Settings List Card
            item {
                SectionHeader(title = "Pengaturan Akun & Keamanan")
                Spacer(modifier = Modifier.height(6.dp))

                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(16.dp))
                ) {
                    Column {
                        ProfileMenuItem(
                            icon = Icons.Outlined.Person,
                            title = "Edit Profil & Alamat Operasional",
                            onClick = {}
                        )
                        HorizontalDivider()
                        ProfileMenuItem(
                            icon = Icons.Outlined.Lock,
                            title = "Keamanan & Password Akun",
                            onClick = {}
                        )
                        HorizontalDivider()
                        ProfileMenuItem(
                            icon = Icons.Outlined.Security,
                            title = "Data Privacy & TLS Edge Encryption",
                            onClick = {}
                        )
                        HorizontalDivider()
                        ProfileMenuItem(
                            icon = Icons.Outlined.SupportAgent,
                            title = "Customer Support & Konsultasi 24/7",
                            onClick = onNavigateToChat
                        )
                        HorizontalDivider()
                        ProfileMenuItem(
                            icon = Icons.Outlined.Description,
                            title = "Kebijakan Privasi & Syarat Ketentuan",
                            onClick = {}
                        )
                    }
                }
            }

            // Logout Button
            item {
                Button(
                    onClick = { showLogoutDialog = true },
                    colors = ButtonDefaults.buttonColors(
                        containerColor = DangerBackground,
                        contentColor = DangerColor
                    ),
                    shape = RoundedCornerShape(14.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(48.dp)
                        .testTag("btn_logout")
                ) {
                    Icon(
                        imageVector = Icons.Default.Logout,
                        contentDescription = null,
                        tint = DangerColor,
                        modifier = Modifier.size(18.dp)
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = "Keluar dari Akun",
                        fontWeight = FontWeight.Bold,
                        color = DangerColor
                    )
                }
            }
        }
    }
}

@Composable
fun ProfileMenuItem(
    icon: ImageVector,
    title: String,
    onClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .clickable { onClick() }
            .padding(16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            imageVector = icon,
            contentDescription = null,
            tint = Emerald600,
            modifier = Modifier.size(20.dp)
        )
        Spacer(modifier = Modifier.width(14.dp))
        Text(
            text = title,
            fontSize = 13.sp,
            fontWeight = FontWeight.SemiBold,
            color = DarkSlate900,
            modifier = Modifier.weight(1f)
        )
        Icon(
            imageVector = Icons.Default.ChevronRight,
            contentDescription = null,
            tint = TextMuted,
            modifier = Modifier.size(18.dp)
        )
    }
}
