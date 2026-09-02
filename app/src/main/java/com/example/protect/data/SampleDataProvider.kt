package com.example.protect.data

import com.example.protect.model.*

object SampleDataProvider {

    val services = listOf(
        ServiceItem(
            id = "s1",
            title = "Termite Control Specialist",
            subtitle = "Proteksi rayap struktural dengan barrier ramah lingkungan.",
            price = 450000,
            description = "Perlindungan anti-rayap bergaransi 12 bulan menggunakan chemical non-repellent eco-grade."
        ),
        ServiceItem(
            id = "s2",
            title = "Rodent Intelligent Baiting",
            subtitle = "Sistem umpan tikus terintegrasi IoT & HACCP audit standard.",
            price = 350000,
            description = "Penempatan stasiun umpan pintar dengan tamper-proof casing dan sensor monitoring."
        ),
        ServiceItem(
            id = "s3",
            title = "Eco-Friendly Fogging & Spray",
            subtitle = "Pengasapan cold fogging tanpa residu berbahaya untuk serangga.",
            price = 280000,
            description = "Efektif membasmi nyamuk, lalat, dan kecoa dengan ekstrak botani pyrethrum ramah anak."
        ),
        ServiceItem(
            id = "s4",
            title = "HACCP & B2B Audit Assessment",
            subtitle = "Inspeksi menyeluruh standar audit sanitasi industri F&B.",
            price = 750000,
            description = "Audit sertifikasi kepatuhan ekspor, analisa heat map hama, dan rekomendasi corrective action."
        )
    )

    val initialIncidents = listOf(
        IncidentItem(
            id = "inc-1",
            code = "INC-2025-089",
            title = "Deteksi Hama Kritis: Tikus Got (Rattus Norvegicus)",
            timestamp = "Hari ini • 02:14 WIB",
            location = "Central Kitchen - Processing Area A",
            severity = SeverityLevel.CRITICAL,
            status = IncidentStatus.ACTIVE_BREACH,
            confidence = 98,
            species = "Rattus Norvegicus",
            cameraName = "CCTV-04 Kitchen Thermal Edge",
            detectionZone = "ROI-01 Critical Food Prep",
            recommendedAction = "Segera aktifkan penutupan jalur ingress pipa bawah sink dan pasang Eco-Bait Station #3."
        ),
        IncidentItem(
            id = "inc-2",
            code = "INC-2025-084",
            title = "Aktivitas Kecoa Amerika (Periplaneta)",
            timestamp = "Kemarin • 23:45 WIB",
            location = "Gudang Bahan Baku Kering #2",
            severity = SeverityLevel.WARNING,
            status = IncidentStatus.RESOLVING,
            confidence = 91,
            species = "Periplaneta Americana",
            cameraName = "CCTV-02 Dry Storage Hub",
            detectionZone = "ROI-02 Pallet Racking B",
            recommendedAction = "Pemberian gel umpan eco-bait dan pembersihan celah perimeter."
        ),
        IncidentItem(
            id = "inc-3",
            code = "INC-2025-079",
            title = "Koloni Rayap Kayu Kering Terdeteksi",
            timestamp = "2 hari lalu • 14:10 WIB",
            location = "Kantor Sayap Barat - Plafon Lt 2",
            severity = SeverityLevel.INFO,
            status = IncidentStatus.RESOLVED,
            confidence = 89,
            species = "Cryptotermes Brevis",
            cameraName = "CCTV-01 Office Hallway",
            detectionZone = "ROI-03 Ceiling Beam",
            recommendedAction = "Injeksi termitisida hayati selesai dilakukan teknisi Doni Pratama."
        )
    )

    val initialOrders = listOf(
        OrderItem(
            id = "ord-1",
            orderNumber = "ORD-8821-JKT",
            serviceTitle = "Termite Control Specialist",
            status = OrderStatus.EN_ROUTE,
            date = "Hari ini, 02 Sep 2026",
            time = "10:00 WIB",
            address = "Jl. Raya Kebayoran Baru No. 45, Jakarta Selatan",
            price = 450000,
            technicianName = "Doni Pratama (Senior Tech)",
            warrantyUntil = "02 Sep 2027"
        ),
        OrderItem(
            id = "ord-2",
            orderNumber = "ORD-8712-BSD",
            serviceTitle = "Eco-Friendly Fogging & Spray",
            status = OrderStatus.COMPLETED,
            date = "28 Agu 2026",
            time = "14:30 WIB",
            address = "Cluster Anggrek Loka Blok B4, BSD City",
            price = 280000,
            technicianName = "Agus Kurniawan",
            warrantyUntil = "28 Agu 2027"
        ),
        OrderItem(
            id = "ord-3",
            orderNumber = "ORD-8601-PIK",
            serviceTitle = "Rodent Intelligent Baiting",
            status = OrderStatus.COMPLETED,
            date = "15 Agu 2026",
            time = "09:00 WIB",
            address = "Ruko Golf Island Blok D, PIK Jakarta",
            price = 350000,
            technicianName = "Budi Santoso",
            warrantyUntil = "15 Agu 2027"
        )
    )

    val initialJobs = listOf(
        TechnicianJob(
            id = "job-1",
            code = "JOB-2025-041",
            clientName = "PT. Boga Lestari Prima (Restoran)",
            address = "Jl. Senopati Raya No. 88, Jakarta Selatan",
            serviceType = "Termite Control & Barrier Treatment",
            pestType = "Coptotermes Formosanus (Rayap Tanah)",
            severity = "Kritis (Area Produksi Pangan)",
            status = JobStatus.ASSIGNED,
            scheduleTime = "09:00 - 11:30 WIB",
            phone = "+62 812-3456-7890",
            notes = "Target area dapur utama & gudang bahan basah. Pastikan APD lengkap dan cek ventilasi."
        ),
        TechnicianJob(
            id = "job-2",
            code = "JOB-2025-042",
            clientName = "Gudang Logistik Delta 3",
            address = "Kawasan Industri MM2100 Blok C-12, Cikarang",
            serviceType = "Rodent Station Re-stock & Sensor Check",
            pestType = "Rattus Rattus (Tikus Atap)",
            severity = "Sedang (Perimeter Luar)",
            status = JobStatus.IN_PROGRESS,
            scheduleTime = "13:00 - 15:00 WIB",
            phone = "+62 813-9876-5432",
            notes = "Periksa 14 stasiun umpan tamper-proof, ganti baterai sensor LoRa."
        ),
        TechnicianJob(
            id = "job-3",
            code = "JOB-2025-039",
            clientName = "Bapak Hendra Wijaya",
            address = "Jl. Kartika Utama No. 12, Pondok Indah",
            serviceType = "Residential Eco Cold Fogging",
            pestType = "Aedes Aegypti (Nyamuk)",
            severity = "Ringan (Taman & Garasi)",
            status = JobStatus.COMPLETED,
            scheduleTime = "Kemarin • 15:30 WIB",
            phone = "+62 811-2233-4455",
            notes = "Selesai ditangani. Tanda tangan berita acara tersimpan di sertifikat digital."
        )
    )

    val articles = listOf(
        ArticleItem(
            id = "art-1",
            title = "Standar HACCP 2026: Mengapa AI Vision Menggantikan Lem Tikus Konvensional",
            snippet = "Regulasi audit keamanan pangan global kini melarang penggunaan lem terbuka di area steril. Simak penerapan kamera termal cerdas yang higienis.",
            category = "Kepatuhan HACCP",
            readTime = "4 mnt baca",
            date = "01 Sep 2026"
        ),
        ArticleItem(
            id = "art-2",
            title = "Panduan Dosis Ramah Lingkungan: Mengurangi Jejak Karbon Pengendalian Hama",
            snippet = "Cara optimal mengombinasikan botani pyrethrum dan feromon organik untuk hasil maksimal tanpa residu beracun bagi lingkungan kerja.",
            category = "ESG & Eco",
            readTime = "3 mnt baca",
            date = "29 Agu 2026"
        ),
        ArticleItem(
            id = "art-3",
            title = "Mengenal Tanda Awal Serangan Rayap Kayu Kering pada Bangunan Komersial",
            snippet = "Pelajari pola butiran frass, hollow sound pada kusen, dan bagaimana detektor akustik kami menemukan sarang rayap sedalam 5 meter.",
            category = "Tips & Edukasi",
            readTime = "5 mnt baca",
            date = "25 Agu 2026"
        ),
        ArticleItem(
            id = "art-4",
            title = "Integrasi Edge AI RTSP CCTV untuk Deteksi Hama Real-Time 24/7",
            snippet = "Bagaimana model YOLO-Pest kami memproses frame rate tinggi di edge device untuk memberikan peringatan dini sebelum hama berkembang biak.",
            category = "Teknologi AI",
            readTime = "6 mnt baca",
            date = "20 Agu 2026"
        )
    )

    val initialCameras = listOf(
        CameraItem(
            id = "cam-1",
            name = "CCTV-01 Kitchen North Zone",
            rtspUrl = "rtsp://192.168.1.101:554/live/stream1",
            location = "Dapur Utama Lt. 1",
            status = "Online • 30 FPS",
            fps = 30,
            resolution = "1080p FHD",
            sensitivity = 0.85f,
            isAiActive = true
        ),
        CameraItem(
            id = "cam-2",
            name = "CCTV-02 Dry Storage Hub",
            rtspUrl = "rtsp://192.168.1.102:554/live/stream1",
            location = "Gudang Bahan Kering",
            status = "Online • 25 FPS",
            fps = 25,
            resolution = "1080p FHD",
            sensitivity = 0.90f,
            isAiActive = true
        ),
        CameraItem(
            id = "cam-3",
            name = "CCTV-03 Loading Dock Gate",
            rtspUrl = "rtsp://192.168.1.103:554/live/stream1",
            location = "Pintu Penerimaan Barang",
            status = "Standby • 15 FPS",
            fps = 15,
            resolution = "720p HD",
            sensitivity = 0.70f,
            isAiActive = false
        )
    )

    val esgMetrics = listOf(
        EsgMetric(
            label = "Pengurangan Bahan Kimia Beracun",
            value = "42.5%",
            change = "+12.3% MoM",
            unit = "vs Metode Konvensional",
            isPositive = true
        ),
        EsgMetric(
            label = "Total Skor Kepatuhan ESG & HACCP",
            value = "94.8 / 100",
            change = "Grade A+ Audit Ready",
            unit = "Sertifikasi Standar 2026",
            isPositive = true
        ),
        EsgMetric(
            label = "Reduksi Emisi Karbon Penanganan",
            value = "-18.2%",
            change = "142 kg CO2 Saved",
            unit = "Rute Cerdas Teknisi",
            isPositive = true
        ),
        EsgMetric(
            label = "Adopsi Bio-Pesticide & Eco-Bait",
            value = "88.0%",
            change = "+5.0% vs Kuartal Lalu",
            unit = "Formula 100% Biodegradable",
            isPositive = true
        )
    )

    val onboardingSlides = listOf(
        OnboardingSlide(
            title = "ProViewAI Computer Vision",
            description = "Monitoring hama 24/7 berbasis kecerdasan buatan melalui CCTV RTSP dengan deteksi akurat dan boundary intrusion alert.",
            badgeText = "AI REAL-TIME DETECTION"
        ),
        OnboardingSlide(
            title = "Live GPS Tracking Teknisi",
            description = "Pantau pergerakan teknisi berlisensi secara langsung dari peta interaktif hingga tiba tepat waktu di lokasi Anda.",
            badgeText = "SMART DISPATCH & ROUTE"
        ),
        OnboardingSlide(
            title = "Garansi 12 Bulan & Audit ESG",
            description = "Dapatkan sertifikat garansi digital resmi dengan barcode verifikasi dan laporan kepatuhan sanitasi berstandar HACCP.",
            badgeText = "ECO-FRIENDLY & CERTIFIED"
        )
    )
}
