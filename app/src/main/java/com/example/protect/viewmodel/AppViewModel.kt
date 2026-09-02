package com.example.protect.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.protect.data.SampleDataProvider
import com.example.protect.model.*
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class AppViewModel : ViewModel() {

    // Incidents State
    private val _incidents = MutableStateFlow(SampleDataProvider.initialIncidents)
    val incidents: StateFlow<List<IncidentItem>> = _incidents.asStateFlow()

    // Orders State
    private val _orders = MutableStateFlow(SampleDataProvider.initialOrders)
    val orders: StateFlow<List<OrderItem>> = _orders.asStateFlow()

    // Technician Jobs State
    private val _jobs = MutableStateFlow(SampleDataProvider.initialJobs)
    val jobs: StateFlow<List<TechnicianJob>> = _jobs.asStateFlow()

    // Cameras State
    private val _cameras = MutableStateFlow(SampleDataProvider.initialCameras)
    val cameras: StateFlow<List<CameraItem>> = _cameras.asStateFlow()

    // Booking State
    val selectedService = MutableStateFlow(SampleDataProvider.services.first())
    val bookingAddress = MutableStateFlow("Jl. Senopati Raya No. 88, Jakarta Selatan")
    val bookingDate = MutableStateFlow("Besok, 03 Sep 2026")
    val bookingTime = MutableStateFlow("10:00 WIB")
    val bookingNotes = MutableStateFlow("")

    // Payment & Checkout State
    val voucherCode = MutableStateFlow("")
    val discount = MutableStateFlow(0L)
    val selectedPaymentMethod = MutableStateFlow("QRIS Instant Settlement")
    val paymentMethods = listOf(
        "QRIS Instant Settlement",
        "Virtual Account BCA / Mandiri",
        "Kartu Kredit / Debit Online",
        "Tunai ke Teknisi Lapangan"
    )
    val treatmentProgressStep = MutableStateFlow(0) // 0: Checkout, 1: Paid, 2: En Route, 3: Completed/Warranty

    // Live Feed AI Vision State
    val liveFps = MutableStateFlow(30)
    val liveLatency = MutableStateFlow("18ms")
    val liveModel = MutableStateFlow("YOLO-Pest-v8")
    val detectedSpecies = MutableStateFlow("Rattus Norvegicus")
    val detectionConfidence = MutableStateFlow(98)
    val detectedId = MutableStateFlow(89)

    // Live Tracker State
    val trackerProgress = MutableStateFlow(0.65f) // 0.0 to 1.0 along the path
    val trackerEtaMinutes = MutableStateFlow(12)
    val trackerDistanceKm = MutableStateFlow(2.4f)
    val trackerStatusText = MutableStateFlow("Teknisi Bpk. Doni sedang menuju alamat Anda")

    // Chat CS State
    private val _chatMessages = MutableStateFlow(
        listOf(
            ChatMessage(
                id = "m1",
                text = "Halo! Saya Asisten AI PROTECT. Ada yang bisa kami bantu terkait proteksi hama atau audit HACCP hari ini?",
                isUser = false,
                timestamp = "09:30"
            )
        )
    )
    val chatMessages: StateFlow<List<ChatMessage>> = _chatMessages.asStateFlow()

    // ROI Editor Points
    val roiPoints = MutableStateFlow(
        listOf(
            PointF2D(0.20f, 0.25f),
            PointF2D(0.80f, 0.25f),
            PointF2D(0.85f, 0.75f),
            PointF2D(0.15f, 0.75f)
        )
    )

    // Alert Settings
    val alertWebhookUrl = MutableStateFlow("https://api.protect-ai.cloud/v1/webhooks/haccp-alerts")
    val alertTelegramEnabled = MutableStateFlow(true)
    val alertSlackEnabled = MutableStateFlow(true)
    val alertEmailEnabled = MutableStateFlow(true)
    val alertSmsEnabled = MutableStateFlow(false)
    val alertSensitivityThreshold = MutableStateFlow(0.85f)

    // SOP Checklist State
    val apdChecklist = MutableStateFlow(List(5) { false })
    val inspectionChecklist = MutableStateFlow(List(4) { false })

    // Chemical Log State
    val chemicalAgent = MutableStateFlow("Eco-Gel Fipronil 0.05% (Botanical)")
    val chemicalDosage = MutableStateFlow("25")
    val chemicalUnit = MutableStateFlow("Gram (g)")
    val chemicalNotes = MutableStateFlow("Dipasang pada station baiting perimeter underground sudut utara.")
    val chemicalLoggedSuccess = MutableStateFlow(false)

    // Signature Pad State
    val signaturePoints = MutableStateFlow<List<PointF2D>>(emptyList())
    val signatureSaved = MutableStateFlow(false)

    init {
        startLiveSimulation()
    }

    private fun startLiveSimulation() {
        viewModelScope.launch {
            while (true) {
                delay(3000)
                liveFps.value = (28..32).random()
                liveLatency.value = "${(14..24).random()}ms"
                detectionConfidence.value = (94..99).random()
            }
        }
    }

    // Actions
    fun applyVoucher(code: String): Boolean {
        return if (code.trim().equals("PROTECTFREE", ignoreCase = true) ||
            code.trim().equals("DISKON50", ignoreCase = true) ||
            code.trim().equals("PROTECT50", ignoreCase = true)
        ) {
            discount.value = 50000L
            true
        } else {
            discount.value = 0L
            false
        }
    }

    fun processPayment() {
        viewModelScope.launch {
            treatmentProgressStep.value = 1
            delay(1500)
            treatmentProgressStep.value = 2
            delay(2000)
            treatmentProgressStep.value = 3
        }
    }

    fun resolveIncident(incidentId: String, note: String) {
        _incidents.update { list ->
            list.map { item ->
                if (item.id == incidentId || item.code == incidentId) {
                    item.copy(
                        status = IncidentStatus.RESOLVED,
                        recommendedAction = "Tindakan Selesai: $note"
                    )
                } else item
            }
        }
    }

    fun assignIncidentToTechnician(incidentId: String, techName: String) {
        _incidents.update { list ->
            list.map { item ->
                if (item.id == incidentId || item.code == incidentId) {
                    item.copy(
                        status = IncidentStatus.RESOLVING,
                        recommendedAction = "Sedang ditangani oleh teknisi $techName."
                    )
                } else item
            }
        }
    }

    fun updateJobStatus(jobId: String, newStatus: JobStatus) {
        _jobs.update { list ->
            list.map { job ->
                if (job.id == jobId || job.code == jobId) {
                    job.copy(status = newStatus)
                } else job
            }
        }
    }

    fun sendChatMessage(text: String) {
        if (text.isBlank()) return
        val userMsg = ChatMessage(
            id = "user_${System.currentTimeMillis()}",
            text = text,
            isUser = true,
            timestamp = "Sekarang"
        )
        _chatMessages.update { it + userMsg }

        viewModelScope.launch {
            delay(1000)
            val replyText = when {
                text.contains("jadwal", ignoreCase = true) || text.contains("booking", ignoreCase = true) ->
                    "Anda dapat memilih layanan dan menjadwalkan kunjungan inspeksi teknisi langsung melalui menu Pesan Layanan di Beranda."
                text.contains("garansi", ignoreCase = true) ->
                    "Semua layanan kami dilindungi sertifikat garansi digital 12 bulan berstandar HACCP dengan jaminan re-treatment gratis jika hama kembali."
                text.contains("haccp", ignoreCase = true) || text.contains("audit", ignoreCase = true) ->
                    "Laporan audit HACCP dapat diunduh dalam format PDF/Excel resmi langsung dari menu Laporan & Audit HACCP."
                else ->
                    "Terima kasih atas pesan Anda! Tim CS & Teknisi Siaga PROTECT siap membantu. Tiket konsultasi #TKT-${(1000..9999).random()} telah dibuka."
            }
            val botMsg = ChatMessage(
                id = "bot_${System.currentTimeMillis()}",
                text = replyText,
                isUser = false,
                timestamp = "Sekarang"
            )
            _chatMessages.update { it + botMsg }
        }
    }

    fun addRoiPoint(x: Float, y: Float) {
        if (roiPoints.value.size < 8) {
            roiPoints.update { it + PointF2D(x, y) }
        }
    }

    fun clearRoiPoints() {
        roiPoints.value = emptyList()
    }

    fun resetRoiPoints() {
        roiPoints.value = listOf(
            PointF2D(0.20f, 0.25f),
            PointF2D(0.80f, 0.25f),
            PointF2D(0.85f, 0.75f),
            PointF2D(0.15f, 0.75f)
        )
    }

    fun addCamera(name: String, rtspUrl: String, location: String) {
        val newCam = CameraItem(
            id = "cam-${System.currentTimeMillis()}",
            name = name,
            rtspUrl = rtspUrl,
            location = location,
            status = "Online • 30 FPS",
            fps = 30,
            resolution = "1080p FHD",
            sensitivity = 0.85f,
            isAiActive = true
        )
        _cameras.update { it + newCam }
    }

    fun toggleCameraAi(camId: String) {
        _cameras.update { list ->
            list.map {
                if (it.id == camId) it.copy(isAiActive = !it.isAiActive) else it
            }
        }
    }

    fun updateCameraSensitivity(camId: String, newSens: Float) {
        _cameras.update { list ->
            list.map {
                if (it.id == camId) it.copy(sensitivity = newSens) else it
            }
        }
    }
}
