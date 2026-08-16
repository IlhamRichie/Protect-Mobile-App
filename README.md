# PROTECT Mobile 📱 

> Autonomous AI Pest Intelligence in your pocket. Real-time E-Tilang alerts, live CCTV monitoring, and HACCP compliance audits for Enterprise Supply Chains.

[![Version](https://img.shields.io/badge/version-1.0.0--beta-blue.svg)]()
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20Android-lightgrey.svg)]()
[![License: MIT](https://img.shields.io/badge/License-Proprietary-red.svg)]()

PROTECT Mobile is the companion application for the **ProViewAI Engine**, designed specifically for Facility Managers and Pest Control Operators (PCOs). It brings sub-second incident alerts, spatial ingress mapping, and automated audit logs directly to your mobile device.

## ✨ Core Features

- **🚨 Real-Time E-Tilang Alerts:** Receive instant push notifications (< 800ms latency) the moment a perimeter breach is detected by the Edge AI.
- **🎥 Live CCTV Gateway:** Securely access live ONVIF/RTSP streams of your facility's restricted zones directly from your phone.
- **🗺️ Hotspot Heatmaps:** Visualize historical detection data to identify exact pest entry points and structural vulnerabilities.
- **📑 Digital HACCP Audits:** Log corrective actions, upload photo evidence, and export compliance reports with a single tap.
- **🔐 Enterprise Security:** TLS 1.3 End-to-End Encryption with biometric authentication (FaceID/TouchID) to ensure total data privacy.

## 🛠️ Tech Stack

- **Framework:** React Native / Expo *(Ganti dengan Flutter jika pakai Flutter)*
- **State Management:** Zustand / Redux Toolkit
- **Networking:** Axios + React Query (REST API) & WebSockets for Live Alerts
- **Maps/Spatial:** React Native Maps
- **CI/CD:** Fastlane & GitHub Actions

## 🚀 Getting Started

### Prerequisites
- Node.js >= 18.x
- iOS Simulator (Xcode) or Android Studio
- Active API Key from PROTECT ProViewAI Backend

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-org/protect-mobile.git
   cd protect-mobile
   ```

2. Install dependencies:
   ```bash
   npm install
   # or
   yarn install
   ```

3. Setup environment variables:
   ```bash
   cp .env.example .env
   # Add your PROTECT_API_KEY and WS_ENDPOINT
   ```

4. Run the app:
   ```bash
   npx expo start
   ```

## 📂 Project Structure

```
protect-mobile/
├── src/
│   ├── api/            # API clients and WebSocket integrations
│   ├── assets/         # Images, fonts, and icons
│   ├── components/     # Reusable UI components (Buttons, Cards, Alerts)
│   ├── navigation/     # React Navigation stacks and tabs
│   ├── screens/        # Main app screens (Dashboard, Alerts, LiveFeed, Profile)
│   ├── store/          # Global state management
│   └── utils/          # Helper functions and constants
├── App.tsx             # Application entry point
└── app.json            # Expo/React Native configuration
```

## 🤝 Contributing
Access to this repository is restricted to authorized PROTECT engineering personnel only. For access requests, please contact `protectpestsolution@gmail.com`.

## 📄 License
© 2026 PROTECT Indonesia. All Rights Reserved. Proprietary and confidential.