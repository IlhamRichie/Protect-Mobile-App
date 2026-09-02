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
    var selectedTab by remember { mutableIntStateOf(0) }

    Scaffold(
        bottomBar = {
            NavigationBar(
                containerColor = SurfaceLight,
                tonalElevation = 8.dp,
                modifier = Modifier.navigationBarsPadding()
            ) {
                NavigationBarItem(
                    selected = selectedTab == 0,
                    onClick = { selectedTab = 0 },
                    icon = {
                        Icon(
                            imageVector = if (selectedTab == 0) Icons.Filled.Home else Icons.Outlined.Home,
                            contentDescription = "Beranda"
                        )
                    },
                    label = { Text("Beranda") },
                    colors = NavigationBarItemDefaults.colors(
                        selectedIconColor = Emerald600,
                        selectedTextColor = Emerald600,
                        indicatorColor = Emerald50
                    ),
                    modifier = Modifier.testTag("tab_home")
                )
                NavigationBarItem(
                    selected = selectedTab == 1,
                    onClick = { selectedTab = 1 },
                    icon = {
                        Icon(
                            imageVector = if (selectedTab == 1) Icons.Filled.Assignment else Icons.Outlined.Assignment,
                            contentDescription = "Pesanan"
                        )
                    },
                    label = { Text("Pesanan") },
                    colors = NavigationBarItemDefaults.colors(
                        selectedIconColor = Emerald600,
                        selectedTextColor = Emerald600,
                        indicatorColor = Emerald50
                    ),
                    modifier = Modifier.testTag("tab_orders")
                )
                NavigationBarItem(
                    selected = selectedTab == 2,
                    onClick = { selectedTab = 2 },
                    icon = {
                        Icon(
                            imageVector = if (selectedTab == 2) Icons.Filled.Videocam else Icons.Outlined.Videocam,
                            contentDescription = "AI Vision"
                        )
                    },
                    label = { Text("AI Vision") },
                    colors = NavigationBarItemDefaults.colors(
                        selectedIconColor = Emerald600,
                        selectedTextColor = Emerald600,
                        indicatorColor = Emerald50
                    ),
                    modifier = Modifier.testTag("tab_live_feed")
                )
                NavigationBarItem(
                    selected = selectedTab == 3,
                    onClick = { selectedTab = 3 },
                    icon = {
                        Icon(
                            imageVector = if (selectedTab == 3) Icons.Filled.MenuBook else Icons.Outlined.MenuBook,
                            contentDescription = "Edukasi"
                        )
                    },
                    label = { Text("Edukasi") },
                    colors = NavigationBarItemDefaults.colors(
                        selectedIconColor = Emerald600,
                        selectedTextColor = Emerald600,
                        indicatorColor = Emerald50
                    ),
                    modifier = Modifier.testTag("tab_articles")
                )
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
                2 -> LiveFeedScreen(
                    viewModel = viewModel
                )
                3 -> ArticlesScreen()
                4 -> ProfileScreen(
                    onNavigateToChat = onNavigateToChat
                )
            }
        }
    }
}
