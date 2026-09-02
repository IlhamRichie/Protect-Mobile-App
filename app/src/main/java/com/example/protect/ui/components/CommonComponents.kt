package com.example.protect.ui.components

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.protect.R
import com.example.protect.model.UserRole
import com.example.protect.theme.*

@Composable
fun ProtectBrandLogo(
    modifier: Modifier = Modifier,
    height: Dp = 32.dp,
    showTagline: Boolean = false,
    contentScale: ContentScale = ContentScale.Fit
) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = modifier
    ) {
        Image(
            painter = painterResource(id = R.drawable.logo_protect),
            contentDescription = "PROTECT Integrated Pest Management",
            contentScale = contentScale,
            modifier = Modifier
                .height(height)
                .testTag("protect_brand_logo")
        )
        if (showTagline) {
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                text = "The Best Protection For Your Environment",
                fontSize = 11.sp,
                fontWeight = FontWeight.Medium,
                color = Emerald700,
                textAlign = TextAlign.Center
            )
        }
    }
}

@Composable
fun RoleBadgeChip(
    currentRole: UserRole,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    Surface(
        onClick = onClick,
        shape = RoundedCornerShape(20.dp),
        color = when (currentRole) {
            UserRole.B2C_RETAIL -> Emerald500.copy(alpha = 0.15f)
            UserRole.B2B_ENTERPRISE -> InfoColor.copy(alpha = 0.15f)
            UserRole.FIELD_TECHNICIAN -> WarningColor.copy(alpha = 0.15f)
        },
        border = androidx.compose.foundation.BorderStroke(
            1.dp,
            when (currentRole) {
                UserRole.B2C_RETAIL -> Emerald500
                UserRole.B2B_ENTERPRISE -> InfoColor
                UserRole.FIELD_TECHNICIAN -> WarningColor
            }
        ),
        modifier = modifier.testTag("role_switcher_chip")
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.padding(horizontal = 10.dp, vertical = 5.dp)
        ) {
            Text(
                text = currentRole.iconEmoji,
                fontSize = 12.sp
            )
            Spacer(modifier = Modifier.width(6.dp))
            Text(
                text = currentRole.shortName,
                fontSize = 11.sp,
                fontWeight = FontWeight.Bold,
                color = when (currentRole) {
                    UserRole.B2C_RETAIL -> Emerald700
                    UserRole.B2B_ENTERPRISE -> DarkSlate900
                    UserRole.FIELD_TECHNICIAN -> DarkSlate900
                }
            )
            Spacer(modifier = Modifier.width(4.dp))
            Icon(
                imageVector = Icons.Default.SwapHoriz,
                contentDescription = "Ganti Peran",
                tint = TextSecondary,
                modifier = Modifier.size(14.dp)
            )
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RoleSwitcherBottomSheet(
    currentRole: UserRole,
    onRoleSelected: (UserRole) -> Unit,
    onDismissRequest: () -> Unit
) {
    ModalBottomSheet(
        onDismissRequest = onDismissRequest,
        containerColor = SurfaceLight,
        shape = RoundedCornerShape(topStart = 24.dp, topEnd = 24.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 20.dp, vertical = 8.dp)
                .navigationBarsPadding()
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column {
                    Text(
                        text = "Pilih Peran Pengguna",
                        fontSize = 18.sp,
                        fontWeight = FontWeight.Bold,
                        color = DarkSlate900
                    )
                    Text(
                        text = "Jelajahi 3 Ekosistem Terpadu PROTECT",
                        fontSize = 12.sp,
                        color = TextSecondary
                    )
                }
                ProtectBrandLogo(height = 24.dp)
            }

            Spacer(modifier = Modifier.height(16.dp))

            UserRole.values().forEach { role ->
                val isSelected = role == currentRole
                Card(
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(
                        containerColor = if (isSelected) Emerald50 else SurfaceLight
                    ),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 6.dp)
                        .border(
                            width = if (isSelected) 1.5.dp else 1.dp,
                            color = if (isSelected) Emerald600 else BorderColor,
                            shape = RoundedCornerShape(16.dp)
                        )
                        .clickable {
                            onRoleSelected(role)
                            onDismissRequest()
                        }
                        .testTag("role_option_${role.name.lowercase()}")
                ) {
                    Row(
                        modifier = Modifier.padding(16.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Box(
                            modifier = Modifier
                                .size(44.dp)
                                .clip(RoundedCornerShape(12.dp))
                                .background(
                                    if (isSelected) Emerald600.copy(alpha = 0.2f)
                                    else BorderColor.copy(alpha = 0.4f)
                                ),
                            contentAlignment = Alignment.Center
                        ) {
                            Text(
                                text = role.iconEmoji,
                                fontSize = 22.sp
                            )
                        }

                        Spacer(modifier = Modifier.width(14.dp))

                        Column(modifier = Modifier.weight(1f)) {
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Text(
                                    text = role.title,
                                    fontSize = 14.sp,
                                    fontWeight = FontWeight.Bold,
                                    color = DarkSlate900
                                )
                                if (isSelected) {
                                    Spacer(modifier = Modifier.width(8.dp))
                                    StatusBadge(
                                        text = "AKTIF",
                                        backgroundColor = Emerald600,
                                        textColor = SurfaceLight
                                    )
                                }
                            }
                            Spacer(modifier = Modifier.height(2.dp))
                            Text(
                                text = role.subtitle,
                                fontSize = 11.sp,
                                color = TextSecondary,
                                lineHeight = 15.sp
                            )
                            Spacer(modifier = Modifier.height(4.dp))
                            Text(
                                text = role.businessModel,
                                fontSize = 10.sp,
                                fontWeight = FontWeight.Medium,
                                color = Emerald700
                            )
                        }

                        RadioButton(
                            selected = isSelected,
                            onClick = {
                                onRoleSelected(role)
                                onDismissRequest()
                            },
                            colors = RadioButtonDefaults.colors(selectedColor = Emerald600)
                        )
                    }
                }
            }

            Spacer(modifier = Modifier.height(16.dp))
        }
    }
}

@Composable
fun BusinessModelDialog(
    onDismissRequest: () -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismissRequest,
        title = {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(
                    text = "💰 Model Bisnis PROTECT",
                    fontSize = 17.sp,
                    fontWeight = FontWeight.Bold,
                    color = DarkSlate900
                )
            }
        },
        text = {
            Column(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                // B2C Model
                Card(
                    shape = RoundedCornerShape(12.dp),
                    colors = CardDefaults.cardColors(containerColor = Emerald50)
                ) {
                    Column(modifier = Modifier.padding(12.dp)) {
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Text(text = "🏠", fontSize = 16.sp)
                            Spacer(modifier = Modifier.width(6.dp))
                            Text(
                                text = "B2C Retail (Model Transaksional)",
                                fontSize = 13.sp,
                                fontWeight = FontWeight.Bold,
                                color = Emerald900
                            )
                        }
                        Spacer(modifier = Modifier.height(4.dp))
                        Text(
                            text = "Monetisasi didapat dari biaya per layanan (per-service booking) pembasmian rayap, tikus, atau serangga rumah/ruko dan paket pencegahan berkala dengan e-Garansi 12 bulan.",
                            fontSize = 11.sp,
                            color = DarkSlate800,
                            lineHeight = 16.sp
                        )
                    }
                }

                // B2B Model
                Card(
                    shape = RoundedCornerShape(12.dp),
                    colors = CardDefaults.cardColors(containerColor = InfoColor.copy(alpha = 0.1f))
                ) {
                    Column(modifier = Modifier.padding(12.dp)) {
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Text(text = "🏢", fontSize = 16.sp)
                            Spacer(modifier = Modifier.width(6.dp))
                            Text(
                                text = "B2B Enterprise (SaaS + Hardware)",
                                fontSize = 13.sp,
                                fontWeight = FontWeight.Bold,
                                color = DarkSlate900
                            )
                        }
                        Spacer(modifier = Modifier.height(4.dp))
                        Text(
                            text = "Perusahaan industri, gudang, & pabrik F&B membayar biaya langganan software AI monitoring CCTV (ProViewAI), pemeliharaan sensor/kamera, dan laporan audit HACCP/ESG berkala.",
                            fontSize = 11.sp,
                            color = DarkSlate800,
                            lineHeight = 16.sp
                        )
                    }
                }
            }
        },
        confirmButton = {
            Button(
                onClick = onDismissRequest,
                colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                shape = RoundedCornerShape(8.dp)
            ) {
                Text("Tutup", fontWeight = FontWeight.Bold)
            }
        }
    )
}

@Composable
fun StatusBadge(
    text: String,
    modifier: Modifier = Modifier,
    backgroundColor: Color = Emerald50,
    textColor: Color = Emerald700,
    icon: ImageVector? = null
) {
    Row(
        modifier = modifier
            .clip(RoundedCornerShape(8.dp))
            .background(backgroundColor)
            .padding(horizontal = 8.dp, vertical = 4.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        if (icon != null) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                tint = textColor,
                modifier = Modifier.size(12.dp)
            )
            Spacer(modifier = Modifier.width(4.dp))
        }
        Text(
            text = text,
            color = textColor,
            fontSize = 11.sp,
            fontWeight = FontWeight.Bold
        )
    }
}

@Composable
fun SectionHeader(
    title: String,
    modifier: Modifier = Modifier,
    actionTitle: String? = null,
    onActionClick: (() -> Unit)? = null
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(
            text = title,
            fontSize = 16.sp,
            fontWeight = FontWeight.Bold,
            color = DarkSlate900
        )
        if (actionTitle != null && onActionClick != null) {
            Text(
                text = actionTitle,
                fontSize = 13.sp,
                fontWeight = FontWeight.SemiBold,
                color = Emerald600,
                modifier = Modifier
                    .clip(RoundedCornerShape(4.dp))
                    .clickable { onActionClick() }
                    .padding(horizontal = 6.dp, vertical = 2.dp)
            )
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProtectTopBar(
    title: String,
    onBackClick: (() -> Unit)? = null,
    actions: @Composable RowScope.() -> Unit = {}
) {
    TopAppBar(
        title = {
            Text(
                text = title,
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                color = DarkSlate900,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )
        },
        navigationIcon = {
            if (onBackClick != null) {
                IconButton(
                    onClick = onBackClick,
                    modifier = Modifier.testTag("back_button")
                ) {
                    Icon(
                        imageVector = Icons.AutoMirrored.Filled.ArrowBack,
                        contentDescription = "Back",
                        tint = DarkSlate900
                    )
                }
            }
        },
        actions = actions,
        colors = TopAppBarDefaults.topAppBarColors(
            containerColor = BackgroundLight
        )
    )
}

@Composable
fun InfoBanner(
    text: String,
    modifier: Modifier = Modifier,
    icon: ImageVector? = null,
    backgroundColor: Color = Emerald50,
    borderColor: Color = Emerald600.copy(alpha = 0.3f),
    contentColor: Color = Emerald900
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(12.dp))
            .background(backgroundColor)
            .border(1.dp, borderColor, RoundedCornerShape(12.dp))
            .padding(14.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        if (icon != null) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                tint = contentColor,
                modifier = Modifier.size(20.dp)
            )
            Spacer(modifier = Modifier.width(10.dp))
        }
        Text(
            text = text,
            fontSize = 12.sp,
            fontWeight = FontWeight.Medium,
            color = contentColor,
            lineHeight = 18.sp,
            modifier = Modifier.weight(1f)
        )
    }
}

