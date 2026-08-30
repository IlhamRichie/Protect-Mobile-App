import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../data/models/app_models.dart';

class CsChatController extends GetxController {
  final textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxList<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      id: '1',
      sender: 'cs',
      text: 'Halo! Selamat datang di Layanan Konsultasi PROTECT. Saya Maya (CS Specialist). Boleh dikirimkan foto/video bagian bangunan yang mengalami kerusakan atau tanda hama?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ].obs;

  final Rxn<SurveyTicket> approvedTicket = Rxn<SurveyTicket>();
  final RxBool isTicketIssued = false.obs;

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: 'user',
        text: text,
        timestamp: DateTime.now(),
      ),
    );
    textController.clear();
    _scrollToBottom();

    // Auto CS Triage Response
    Future.delayed(const Duration(milliseconds: 800), () {
      messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          sender: 'cs',
          text: 'Terima kasih atas informasinya! Tim teknis kami sedang memverifikasi foto lokasi Anda...',
          timestamp: DateTime.now(),
        ),
      );
      _scrollToBottom();
    });
  }

  void simulatePhotoUpload() {
    // User uploads photo of damaged termite wood
    messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: 'user',
        text: 'Ini foto kosen pintu kayu rumah saya yang terkelupas dan berongga terkena rayap. Luas area rumah sekitar 140 m².',
        imagePath: 'https://via.placeholder.com/400x300/10B981/FFFFFF?text=Foto+Kerusakan+Rayap+Kayu',
        timestamp: DateTime.now(),
      ),
    );
    _scrollToBottom();

    // CS Verifies and Issues Free Survey Ticket
    Future.delayed(const Duration(seconds: 1), () {
      final ticket = SurveyTicket(
        ticketId: 'SRV-20260827-001',
        clientName: 'Bpk. Hendra Kurniawan',
        address: 'Jl. Raya Kebayoran Baru No. 45, Jakarta Selatan',
        pestType: 'Rayap Tanah & Wood Borer',
        areaSize: '140 m²',
        surveyorName: 'Bpk. Doni (Senior Pest Specialist)',
        status: 'Approved',
        scheduledTime: DateTime.now().add(const Duration(hours: 3)),
      );
      approvedTicket.value = ticket;
      isTicketIssued.value = true;

      messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          sender: 'cs',
          text: '✅ S&K Terpenuhi! Kategori Rayap dengan Luas Area >= 100 m² (140 m²).\n\nTIKET FREE SURVEY APPROVED telah diterbitkan!\nSurveyor: Bpk. Doni (Senior Pest Specialist) siap mengunjungi lokasi Anda hari ini.',
          timestamp: DateTime.now(),
        ),
      );
      _scrollToBottom();
    });
  }

  void goToDigitalQuotation() {
    Get.toNamed(Routes.B2C_QUOTE);
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
