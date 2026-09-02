package com.example.protect.navigation

import androidx.compose.runtime.Composable
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.example.protect.ui.screens.*
import com.example.protect.viewmodel.AppViewModel

@Composable
fun AppNavHost(
    navController: NavHostController = rememberNavController(),
    appViewModel: AppViewModel = viewModel()
) {
    NavHost(
        navController = navController,
        startDestination = Routes.SPLASH
    ) {
        composable(Routes.SPLASH) {
            SplashScreen(
                onNavigateNext = {
                    navController.navigate(Routes.ONBOARDING) {
                        popUpTo(Routes.SPLASH) { inclusive = true }
                    }
                }
            )
        }

        composable(Routes.ONBOARDING) {
            OnboardingScreen(
                onFinish = {
                    navController.navigate(Routes.MAIN) {
                        popUpTo(Routes.ONBOARDING) { inclusive = true }
                    }
                }
            )
        }

        composable(Routes.MAIN) {
            MainWrapperScreen(
                viewModel = appViewModel,
                onNavigateToBooking = { navController.navigate(Routes.BOOKING) },
                onNavigateToLiveTracker = { navController.navigate(Routes.LIVE_TRACKER) },
                onNavigateToWarranty = { navController.navigate(Routes.DIGITAL_WARRANTY) },
                onNavigateToChat = { navController.navigate(Routes.CS_CHAT) },
                onNavigateToIncident = { incidentId ->
                    navController.navigate(Routes.incidentDetail(incidentId))
                },
                onNavigateToHaccp = { navController.navigate(Routes.EXPORT_HACCP) },
                onNavigateToCameras = { navController.navigate(Routes.CAMERA_MANAGEMENT) },
                onNavigateToEsg = { navController.navigate(Routes.ESG_METRICS) },
                onNavigateToTechBoard = { navController.navigate(Routes.TECH_JOB_BOARD) }
            )
        }

        composable(Routes.BOOKING) {
            BookingScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() },
                onProceedToPayment = { navController.navigate(Routes.PAYMENT) }
            )
        }

        composable(Routes.PAYMENT) {
            PaymentScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() },
                onNavigateToWarranty = { navController.navigate(Routes.DIGITAL_WARRANTY) },
                onNavigateToLiveTracker = { navController.navigate(Routes.LIVE_TRACKER) }
            )
        }

        composable(Routes.LIVE_TRACKER) {
            LiveTrackerScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() },
                onNavigateToChat = { navController.navigate(Routes.CS_CHAT) }
            )
        }

        composable(Routes.DIGITAL_WARRANTY) {
            DigitalWarrantyScreen(
                onBack = { navController.popBackStack() },
                onClaimWarranty = { navController.navigate(Routes.CS_CHAT) }
            )
        }

        composable(Routes.CS_CHAT) {
            CsChatScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() }
            )
        }

        composable(
            route = Routes.INCIDENT_DETAIL,
            arguments = listOf(navArgument("incidentId") { type = NavType.StringType })
        ) { backStackEntry ->
            val incidentId = backStackEntry.arguments?.getString("incidentId") ?: ""
            IncidentDetailScreen(
                incidentId = incidentId,
                viewModel = appViewModel,
                onBack = { navController.popBackStack() },
                onNavigateToResolve = { id ->
                    navController.navigate(Routes.resolveTicket(id))
                },
                onNavigateToRoiEditor = { navController.navigate(Routes.ROI_EDITOR) }
            )
        }

        composable(
            route = Routes.RESOLVE_TICKET,
            arguments = listOf(navArgument("incidentId") { type = NavType.StringType })
        ) { backStackEntry ->
            val incidentId = backStackEntry.arguments?.getString("incidentId") ?: ""
            ResolveTicketScreen(
                incidentId = incidentId,
                viewModel = appViewModel,
                onBack = { navController.popBackStack() }
            )
        }

        composable(Routes.EXPORT_HACCP) {
            ExportHaccpScreen(
                onBack = { navController.popBackStack() }
            )
        }

        composable(Routes.CAMERA_MANAGEMENT) {
            CameraManagementScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() },
                onNavigateToRoi = { navController.navigate(Routes.ROI_EDITOR) },
                onNavigateToAlertSettings = { navController.navigate(Routes.ALERT_SETTINGS) }
            )
        }

        composable(Routes.ROI_EDITOR) {
            B2bRoiEditorScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() }
            )
        }

        composable(Routes.ALERT_SETTINGS) {
            B2bAlertSettingsScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() }
            )
        }

        composable(Routes.ESG_METRICS) {
            B2bEsgMetricsScreen(
                onBack = { navController.popBackStack() }
            )
        }

        composable(Routes.TECH_JOB_BOARD) {
            TechnicianJobBoardScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() },
                onNavigateToJobDetail = { jobId ->
                    navController.navigate(Routes.techJobDetail(jobId))
                }
            )
        }

        composable(
            route = Routes.TECH_JOB_DETAIL,
            arguments = listOf(navArgument("jobId") { type = NavType.StringType })
        ) { backStackEntry ->
            val jobId = backStackEntry.arguments?.getString("jobId") ?: ""
            TechnicianJobDetailScreen(
                jobId = jobId,
                viewModel = appViewModel,
                onBack = { navController.popBackStack() },
                onNavigateToSop = { navController.navigate(Routes.TECH_SOP) },
                onNavigateToChemicalLog = { navController.navigate(Routes.TECH_CHEMICAL_LOG) },
                onNavigateToSignoff = { navController.navigate(Routes.TECH_SIGNOFF) }
            )
        }

        composable(Routes.TECH_SOP) {
            TechnicianSopScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() },
                onNavigateToChemicalLog = { navController.navigate(Routes.TECH_CHEMICAL_LOG) }
            )
        }

        composable(Routes.TECH_CHEMICAL_LOG) {
            TechnicianChemicalLogScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() },
                onNavigateToSignoff = { navController.navigate(Routes.TECH_SIGNOFF) }
            )
        }

        composable(Routes.TECH_SIGNOFF) {
            TechnicianSignoffScreen(
                viewModel = appViewModel,
                onBack = { navController.popBackStack() },
                onFinishJob = {
                    navController.navigate(Routes.MAIN) {
                        popUpTo(Routes.MAIN) { inclusive = true }
                    }
                }
            )
        }
    }
}
