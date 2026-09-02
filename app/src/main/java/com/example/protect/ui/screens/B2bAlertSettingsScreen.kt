package com.example.protect.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.border
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
fun B2bAlertSettingsScreen(
    viewModel: AppViewModel,
    onBack: () -> Unit
) {
    var webhookUrl by remember { mutableStateOf(viewModel.alertWebhookUrl.value) }
    var telegram by remember { mutableStateOf(viewModel.alertTelegramEnabled.value) }
    var slack by remember { mutableStateOf(viewModel.alertSlackEnabled.value) }
    var email by remember { mutableStateOf(viewModel.alertEmailEnabled.value) }
    var sms by remember { mutableStateOf(viewModel.alertSmsEnabled.value) }
    var threshold by remember { mutableStateOf(viewModel.alertSensitivityThreshold.value) }
    var isSaved by remember { mutableStateOf(false) }

    Scaffold(
        topBar = {
            ProtectTopBar(
                title = "Pengaturan Notifikasi & Webhook Alert",
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
                        viewModel.alertWebhookUrl.value = webhookUrl
                        viewModel.alertTelegramEnabled.value = telegram
                        viewModel.alertSlackEnabled.value = slack
                        viewModel.alertEmailEnabled.value = email
                        viewModel.alertSmsEnabled.value = sms
                        viewModel.alertSensitivityThreshold.value = threshold
                        isSaved = true
                    },
                    colors = ButtonDefaults.buttonColors(containerColor = Emerald600),
                    shape = RoundedCornerShape(12.dp),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)
                        .height(48.dp)
                        .testTag("btn_save_alerts")
                ) {
                    Icon(Icons.Default.Save, contentDescription = null, modifier = Modifier.size(18.dp))
                    Spacer(modifier = Modifier.width(8.dp))
                    Text("Simpan Konfigurasi Alert", fontWeight = FontWeight.Bold)
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
                    text = "Ketika AI mendeteksi intrusi melebihi ambang batas, sinyal HTTP POST webhook instan akan dikirimkan ke endpoint sistem pabrik Anda.",
                    icon = Icons.Default.NotificationsActive
                )
            }

            if (isSaved) {
                item {
                    InfoBanner(
                        text = "Konfigurasi notifikasi berhasil diperbarui!",
                        icon = Icons.Default.CheckCircle,
                        backgroundColor = Emerald50,
                        contentColor = Emerald800
                    )
                }
            }

            // Webhook Configuration Card
            item {
                SectionHeader(title = "1. Enterprise Webhook URL")
                Spacer(modifier = Modifier.height(8.dp))
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        OutlinedTextField(
                            value = webhookUrl,
                            onValueChange = { webhookUrl = it },
                            label = { Text("Webhook Endpoint (HTTPS)") },
                            modifier = Modifier.fillMaxWidth().testTag("input_webhook_url"),
                            shape = RoundedCornerShape(10.dp),
                            singleLine = true
                        )
                    }
                }
            }

            // Notification Channels Card
            item {
                SectionHeader(title = "2. Saluran Notifikasi Darurat")
                Spacer(modifier = Modifier.height(8.dp))
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        AlertToggleRow(
                            title = "Telegram Bot Alert (@ProtectHaccpBot)",
                            checked = telegram,
                            onCheckedChange = { telegram = it }
                        )
                        HorizontalDivider(modifier = Modifier.padding(vertical = 10.dp))
                        AlertToggleRow(
                            title = "Slack Channel Integration (#haccp-alerts)",
                            checked = slack,
                            onCheckedChange = { slack = it }
                        )
                        HorizontalDivider(modifier = Modifier.padding(vertical = 10.dp))
                        AlertToggleRow(
                            title = "Email Broadcast ke Tim QA & Sanitasi",
                            checked = email,
                            onCheckedChange = { email = it }
                        )
                        HorizontalDivider(modifier = Modifier.padding(vertical = 10.dp))
                        AlertToggleRow(
                            title = "SMS Broadcast Gateway Darurat",
                            checked = sms,
                            onCheckedChange = { sms = it }
                        )
                    }
                }
            }

            // Threshold Slider
            item {
                SectionHeader(title = "3. Ambang Batas Sensitivitas AI: ${(threshold * 100).toInt()}%")
                Card(
                    shape = RoundedCornerShape(14.dp),
                    colors = CardDefaults.cardColors(containerColor = SurfaceLight),
                    modifier = Modifier.border(1.dp, BorderColor, RoundedCornerShape(14.dp))
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Slider(
                            value = threshold,
                            onValueChange = { threshold = it },
                            valueRange = 0.50f..0.99f,
                            colors = SliderDefaults.colors(
                                thumbColor = Emerald600,
                                activeTrackColor = Emerald600
                            )
                        )
                        Text(
                            text = "Nilai lebih tinggi mengurangi false positive pada pantulan bayangan.",
                            fontSize = 11.sp,
                            color = TextSecondary
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun AlertToggleRow(
    title: String,
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit
) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(
            text = title,
            fontSize = 13.sp,
            fontWeight = FontWeight.Medium,
            color = DarkSlate900,
            modifier = Modifier.weight(1f)
        )
        Switch(
            checked = checked,
            onCheckedChange = onCheckedChange,
            colors = SwitchDefaults.colors(
                checkedThumbColor = Emerald600,
                checkedTrackColor = Emerald100
            )
        )
    }
}
