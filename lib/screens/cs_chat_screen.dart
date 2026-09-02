import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../theme/app_theme.dart';

class CsChatScreen extends StatefulWidget {
  const CsChatScreen({super.key});

  @override
  State<CsChatScreen> createState() => _CsChatScreenState();
}

class _CsChatScreenState extends State<CsChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    const ChatMessage(
      id: 'm1',
      text: 'Halo! Saya Asisten AI & Konsultan Entomologi PROTECT. Ada yang bisa kami bantu terkait proteksi hama atau audit HACCP hari ini?',
      isUser: false,
      timestamp: '09:30',
    ),
  ];

  final List<String> _quickChips = [
    'Jadwalkan Kunjungan',
    'Klaim Garansi 12 Bln',
    'Unduh Audit HACCP',
    'Konsultasi Dosis Eco-Bait',
  ];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(
        id: 'u_${DateTime.now().millisecondsSinceEpoch}',
        text: text,
        isUser: true,
        timestamp: 'Sekarang',
      ));
      _textController.clear();
    });

    _scrollToBottom();

    // Simulated Intelligent Bot Response
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        String botReply;
        final lower = text.toLowerCase();
        if (lower.contains('jadwal') || lower.contains('kunjungan')) {
          botReply = 'Kunjungan inspeksi dapat dijadwalkan langsung melalui menu Pesan Layanan di Beranda. Teknisi berlisensi kami siap melayani hari ini!';
        } else if (lower.contains('garansi')) {
          botReply = 'Seluruh treatment dilindungi Garansi Digital 12 Bulan. Jika ada tanda hama kembali, Anda berhak mendapatkan re-treatment gratis.';
        } else if (lower.contains('haccp') || lower.contains('audit')) {
          botReply = 'Laporan kepatuhan audit HACCP siap diunduh dalam format PDF/Excel resmi langsung dari menu Laporan & Audit HACCP.';
        } else {
          botReply = 'Terima kasih telah menghubungi PROTECT. Konsultan siaga kami telah menerima tiket #TKT-${1000 + Random().nextInt(9000)} dan siap memberikan solusi terbaik!';
        }

        setState(() {
          _messages.add(ChatMessage(
            id: 'b_${DateTime.now().millisecondsSinceEpoch}',
            text: botReply,
            isUser: false,
            timestamp: 'Sekarang',
          ));
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.emerald600,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.support_agent, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('PROTECT AI Support', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text('Online • Respon Cepat < 1 mnt', style: TextStyle(fontSize: 10, color: AppColors.emerald700)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Quick Suggestion Chips
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _quickChips.map((chip) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(chip, style: const TextStyle(fontSize: 11, color: AppColors.emerald800, fontWeight: FontWeight.bold)),
                    backgroundColor: AppColors.emerald50,
                    side: const BorderSide(color: AppColors.emerald200),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    onPressed: () => _sendMessage(chip),
                  ),
                );
              }).toList(),
            ),
          ),

          // Message Bubbles List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: msg.isUser ? AppColors.emerald600 : AppColors.surfaceLight,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(msg.isUser ? 16 : 4),
                        bottomRight: Radius.circular(msg.isUser ? 4 : 16),
                      ),
                      border: msg.isUser ? null : Border.all(color: AppColors.borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: msg.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg.text,
                          style: TextStyle(
                            fontSize: 13,
                            color: msg.isUser ? Colors.white : AppColors.darkSlate900,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg.timestamp,
                          style: TextStyle(
                            fontSize: 9,
                            color: msg.isUser ? Colors.white70 : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Input Bar
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              border: const Border(top: BorderSide(color: AppColors.borderColor)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan atau pertanyaan...',
                        filled: true,
                        fillColor: AppColors.backgroundLight,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.emerald600,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                      onPressed: () => _sendMessage(_textController.text),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
