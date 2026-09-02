package com.example.protect.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material.icons.outlined.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.unit.dp
import com.example.protect.model.UserRole
import com.example.protect.theme.*
import com.example.protect.viewmodel.AppViewModel

@Composable
fun MainWrapperScreen(
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
    val currentRole by viewModel.currentRole.collectAsState()
    var selectedTab by remember { mutableIntStateOf(0) }

    // Reset tab when role changes to avoid confusion
    LaunchedEffect(currentRole) {
        selectedTab = 0
    }

    Scaffold(
        bottomBar = {
            NavigationBar(
                containerColor = SurfaceLight,
                tonalElevation = 8.dp,
                modifier = Modifier.navigationBarsPadding()
            ) {
                // Tab 0: Home / Main Hub for active role
                NavigationBarItem(
                    selected = selectedTab == 0,
                    onClick = { selectedTab = 0 },
                    icon = {
                        Icon(
                            imageVector = when (currentRole) {
                                UserRole.B2C_RETAIL -> if (selectedTab == 0) Icons.Filled.Home else Icons.Outlined.Home
                                UserRole.B2B_ENTERPRISE -> if (selectedTab == 0) Icons.Filled.Dashboard else Icons.Outlined.Dashboard
                                UserRole.FIELD_TECHNICIAN -> if (selectedTab == 0) Icons.Filled.Engineering else Icons.Outlined.Engineering
                            },
                            contentDescription = "Beranda"
                        )
                    },
                    label = {
                        Text(
                            when (currentRole) {
                                UserRole.B2C_RETAIL -> "Beranda"
                                UserRole.B2B_ENTERPRISE -> "Command"
                                UserRole.FIELD_TECHNICIAN -> "Job Board"
                            }
                        )
                    },
                    colors = NavigationBarItemDefaults.colors(
                        selectedIconColor = Emerald600,
                        selectedTextColor = Emerald600,
                        indicatorColor = Emerald50
                    ),
                    modifier = Modifier.testTag("tab_home")
                )

                // Tab 1: Orders (B2C) / Live AI Vision (B2B) / SOP & Chemical (Tech)
                NavigationBarItem(
                    selected = selectedTab == 1,
                    onClick = { selectedTab = 1 },
                    icon = {
                        Icon(
                            imageVector = when (currentRole) {
                                UserRole.B2C_RETAIL -> if (selectedTab == 1) Icons.Filled.Assignment else Icons.Outlined.Assignment
                                UserRole.B2B_ENTERPRISE -> if (selectedTab == 1) Icons.Filled.Videocam else Icons.Outlined.Videocam
                                UserRole.FIELD_TECHNICIAN -> if (selectedTab == 1) Icons.Filled.HealthAndSafety else Icons.Outlined.HealthAndSafety
                            },
                            contentDescription = "Modul Utama"
                        )
                    },
                    label = {
                        Text(
                            when (currentRole) {
                                UserRole.B2C_RETAIL -> "Pesanan"
                                UserRole.B2B_ENTERPRISE -> "AI Vision"
                                UserRole.FIELD_TECHNICIAN -> "SOP APD"
                            }
                        )
                    },
                    colors = NavigationBarItemDefaults.colors(
                        selectedIconColor = Emerald600,
                        selectedTextColor = Emerald600,
                        indicatorColor = Emerald50
                    ),
                    modifier = Modifier.testTag("tab_primary")
                )

                // Tab 2: Live AI Vision (B2C) / HACCP & ESG (B2B) / Chemical Log (Tech)
                NavigationBarItem(
                    selected = selectedTab == 2,
                    onClick = { selectedTab = 2 },
                    icon = {
                        Icon(
                            imageVector = when (currentRole) {
                                UserRole.B2C_RETAIL -> if (selectedTab == 2) Icons.Filled.Videocam else Icons.Outlined.Videocam
                                UserRole.B2B_ENTERPRISE -> if (selectedTab == 2) Icons.Filled.FileDownload else Icons.Outlined.FileDownload
                                UserRole.FIELD_TECHNICIAN -> if (selectedTab == 2) Icons.Filled.Science else Icons.Outlined.Science
                            },
                            contentDescription = "Modul Tambahan"
                        )
                    },
                    label = {
                        Text(
                            when (currentRole) {
                                UserRole.B2C_RETAIL -> "AI Vision"
                                UserRole.B2B_ENTERPRISE -> "HACCP"
                                UserRole.FIELD_TECHNICIAN -> "Chemical"
                            }
                        )
                    },
                    colors = NavigationBarItemDefaults.colors(
                        selectedIconColor = Emerald600,
                        selectedTextColor = Emerald600,
                        indicatorColor = Emerald50
                    ),
                    modifier = Modifier.testTag("tab_secondary")
                )

                // Tab 3: Edukasi / Articles (or Signoff in Tech mode)
                NavigationBarItem(
                    selected = selectedTab == 3,
                    onClick = { selectedTab = 3 },
                    icon = {
                        Icon(
                            imageVector = when (currentRole) {
                                UserRole.FIELD_TECHNICIAN -> if (selectedTab == 3) Icons.Filled.Draw else Icons.Outlined.Draw
                                else -> if (selectedTab == 3) Icons.Filled.MenuBook else Icons.Outlined.MenuBook
                            },
                            contentDescription = "Edukasi / E-Sign"
                        )
                    },
                    label = {
                        Text(
                            when (currentRole) {
                                UserRole.FIELD_TECHNICIAN -> "E-Sign Pad"
                                else -> "Edukasi"
                            }
                        )
                    },
                    colors = NavigationBarItemDefaults.colors(
                        selectedIconColor = Emerald600,
                        selectedTextColor = Emerald600,
                        indicatorColor = Emerald50
                    ),
                    modifier = Modifier.testTag("tab_articles")
                )

                // Tab 4: Profil & Switcher
                NavigationBarItem(
                    selected = selectedTab == 4,
                    onClick = { selectedTab = 4 },
                    icon = {
                        Icon(
                            imageVector = if (selectedTab == 4) Icons.Filled.Person else Icons.Outlined.Person,
                            contentDescription = "Profil"
                        )
                    },
                    label = { Text("Profil") },
                    colors = NavigationBarItemDefaults.colors(
                        selectedIconColor = Emerald600,
                        selectedTextColor = Emerald600,
                        indicatorColor = Emerald50
                    ),
                    modifier = Modifier.testTag("tab_profile")
                )
            }
        }
    ) { innerPadding ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
        ) {
            when (currentRole) {
                UserRole.B2C_RETAIL -> {
                    when (selectedTab) {
                        0 -> HomeScreen(
                            viewModel = viewModel,
                            onNavigateToBooking = onNavigateToBooking,
                            onNavigateToLiveTracker = onNavigateToLiveTracker,
                            onNavigateToWarranty = onNavigateToWarranty,
                            onNavigateToChat = onNavigateToChat,
                            onNavigateToIncident = onNavigateToIncident,
                            onNavigateToHaccp = onNavigateToHaccp,
                            onNavigateToCameras = onNavigateToCameras,
                            onNavigateToEsg = onNavigateToEsg,
                            onNavigateToTechBoard = onNavigateToTechBoard
                        )
                        1 -> OrdersScreen(
                            viewModel = viewModel,
                            onNavigateToLiveTracker = onNavigateToLiveTracker,
                            onNavigateToWarranty = onNavigateToWarranty,
                            onNavigateToBooking = onNavigateToBooking
                        )
                        2 -> LiveFeedScreen(viewModel = viewModel)
                        3 -> ArticlesScreen()
                        4 -> ProfileScreen(
                            viewModel = viewModel,
                            onNavigateToChat = onNavigateToChat
                        )
                    }
                }
                UserRole.B2B_ENTERPRISE -> {
                    when (selectedTab) {
                        0 -> HomeScreen(
                            viewModel = viewModel,
                            onNavigateToBooking = onNavigateToBooking,
                            onNavigateToLiveTracker = onNavigateToLiveTracker,
                            onNavigateToWarranty = onNavigateToWarranty,
                            onNavigateToChat = onNavigateToChat,
                            onNavigateToIncident = onNavigateToIncident,
                            onNavigateToHaccp = onNavigateToHaccp,
                            onNavigateToCameras = onNavigateToCameras,
                            onNavigateToEsg = onNavigateToEsg,
                            onNavigateToTechBoard = onNavigateToTechBoard
                        )
                        1 -> LiveFeedScreen(viewModel = viewModel)
                        2 -> ExportHaccpScreen(onBackClick = { selectedTab = 0 })
                        3 -> ArticlesScreen()
                        4 -> ProfileScreen(
                            viewModel = viewModel,
                            onNavigateToChat = onNavigateToChat
                        )
                    }
                }
                UserRole.FIELD_TECHNICIAN -> {
                    when (selectedTab) {
                        0 -> HomeScreen(
                            viewModel = viewModel,
                            onNavigateToBooking = onNavigateToBooking,
                            onNavigateToLiveTracker = onNavigateToLiveTracker,
                            onNavigateToWarranty = onNavigateToWarranty,
                            onNavigateToChat = onNavigateToChat,
                            onNavigateToIncident = onNavigateToIncident,
                            onNavigateToHaccp = onNavigateToHaccp,
                            onNavigateToCameras = onNavigateToCameras,
                            onNavigateToEsg = onNavigateToEsg,
                            onNavigateToTechBoard = onNavigateToTechBoard
                        )
                        1 -> TechnicianSopScreen(
                            viewModel = viewModel,
                            onBack = { selectedTab = 0 },
                            onNavigateToChemicalLog = { selectedTab = 2 }
                        )
                        2 -> TechnicianChemicalLogScreen(
                            viewModel = viewModel,
                            onBack = { selectedTab = 1 },
                            onNavigateToSignoff = { selectedTab = 3 }
                        )
                        3 -> TechnicianSignoffScreen(
                            viewModel = viewModel,
                            onBack = { selectedTab = 2 },
                            onFinishJob = { selectedTab = 0 }
                        )
                        4 -> ProfileScreen(
                            viewModel = viewModel,
                            onNavigateToChat = onNavigateToChat
                        )
                    }
                }
            }
        }
    }
}
