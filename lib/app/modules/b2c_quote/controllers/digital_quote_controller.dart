import 'package:get/get.dart';
import 'package:protect/app/routes/app_pages.dart';
import '../../../data/models/app_models.dart';

class DigitalQuoteController extends GetxController {
  final Rxn<DigitalQuote> quote = Rxn<DigitalQuote>();

  @override
  void onInit() {
    super.onInit();
    // Simulate Surveyor Digital Inspection Data
    quote.value = DigitalQuote(
      quoteId: 'QUO-20260827-88',
      ticketId: 'SRV-20260827-001',
      moistureMeterReading: 78.4, // Moisture meter reading %
      findings:
          'Ditemukan kelembaban tinggi (78.4%) di fondasi kayu kosen pintu & struktur dapur. Teridentifikasi titik masuk aktif koloni Rayap Tanah (Coptotermes gestroi).',
      items: [
        QuoteItem(
          title: 'Termite Baiting System (Exterra)',
          description: 'Pemasangan 6 unit umpan rayap underground & 4 unit indoor station',
          price: 1500000,
        ),
        QuoteItem(
          title: 'Chemical Barrier Injection (Fipronil 2.5L)',
          description: 'Injeksi perimeter pondasi tanah & perlindungan struktur kayu',
          price: 1000000,
        ),
        QuoteItem(
          title: 'Garansi 12 Bulan & Monitoring Rutin',
          description: 'Inspeksi berkala setiap 3 bulan & e-sertifikat garansi resmi',
          price: 500000,
        ),
      ],
      discountAmount: 300000,
      promoCode: 'PROTECTFREE (-Rp 300.000 Promo Free Survey)',
    );
  }

  void approveQuoteAndPay() {
    Get.toNamed(
      Routes.B2C_PAYMENT,
      arguments: {'amount': quote.value?.grandTotal ?? 2700000},
    );
  }
}
