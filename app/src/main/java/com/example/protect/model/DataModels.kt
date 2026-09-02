package com.example.protect.model

import androidx.compose.ui.graphics.vector.ImageVector

enum class UserRole(
    val title: String,
    val shortName: String,
    val subtitle: String,
    val iconEmoji: String,
    val businessModel: String
) {
    B2C_RETAIL(
        title = "Pengguna Retail (B2C)",
        shortName = "Retail B2C",
        subtitle = "Rumah, Ruko & Apartemen • Pemesanan Cepat & E-Garansi",
        iconEmoji = "🏠",
        businessModel = "Model Transaksional: Bayar per-kunjungan treatment atau langganan pencegahan berkala."
    ),
    B2B_ENTERPRISE(
        title = "Perusahaan Korporat (B2B)",
        shortName = "Enterprise B2B",
        subtitle = "Pabrik, Gudang & F&B • CCTV ProViewAI, HACCP & ESG",
        iconEmoji = "🏢",
        businessModel = "Model SaaS + Hardware: Biaya langganan software AI monitoring CCTV & audit berkala."
    ),
    FIELD_TECHNICIAN(
        title = "Eksekutor Lapangan (Teknisi)",
        shortName = "Field Tech",
        subtitle = "Petugas Pest Control • GPS Check-In, SOP & E-Sign",
        iconEmoji = "👷‍♂️",
        businessModel = "Operasional Lapangan: Pelaksanaan SOP keselamatan, chemical logging, dan berita acara digital."
    )
}

data class ServiceItem(
    val id: String,
    val title: String,
    val subtitle: String,
    val price: Long,
    val description: String = ""
)

data class IncidentItem(
    val id: String,
    val code: String,
    val title: String,
    val timestamp: String,
    val location: String,
    val severity: SeverityLevel,
    val status: IncidentStatus,
    val confidence: Int,
    val species: String,
    val cameraName: String,
    val detectionZone: String,
    val recommendedAction: String
)

enum class SeverityLevel {
    CRITICAL, WARNING, INFO
}

enum class IncidentStatus {
    ACTIVE_BREACH, RESOLVING, RESOLVED
}

data class OrderItem(
    val id: String,
    val orderNumber: String,
    val serviceTitle: String,
    val status: OrderStatus,
    val date: String,
    val time: String,
    val address: String,
    val price: Long,
    val technicianName: String,
    val warrantyUntil: String? = null
)

enum class OrderStatus {
    PENDING, IN_PROGRESS, EN_ROUTE, COMPLETED, CANCELLED
}

data class TechnicianJob(
    val id: String,
    val code: String,
    val clientName: String,
    val address: String,
    val serviceType: String,
    val pestType: String,
    val severity: String,
    val status: JobStatus,
    val scheduleTime: String,
    val phone: String,
    val notes: String
)

enum class JobStatus {
    ASSIGNED, IN_PROGRESS, COMPLETED
}

data class ArticleItem(
    val id: String,
    val title: String,
    val snippet: String,
    val category: String,
    val readTime: String,
    val date: String
)

data class ChatMessage(
    val id: String,
    val text: String,
    val isUser: Boolean,
    val timestamp: String
)

data class CameraItem(
    val id: String,
    val name: String,
    val rtspUrl: String,
    val location: String,
    val status: String,
    val fps: Int,
    val resolution: String,
    val sensitivity: Float,
    val isAiActive: Boolean
)

data class EsgMetric(
    val label: String,
    val value: String,
    val change: String,
    val unit: String,
    val isPositive: Boolean
)

data class OnboardingSlide(
    val title: String,
    val description: String,
    val badgeText: String
)

data class PointF2D(
    val x: Float,
    val y: Float
)
