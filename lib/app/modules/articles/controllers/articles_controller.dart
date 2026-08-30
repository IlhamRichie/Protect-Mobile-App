import 'package:get/get.dart';

class Article {
  final String id;
  final String title;
  final String category;
  final String readTime;
  final String snippet;

  Article({
    required this.id,
    required this.title,
    required this.category,
    required this.readTime,
    required this.snippet,
  });
}

class ArticlesController extends GetxController {
  final RxList<Article> articles = <Article>[
    Article(
      id: 'art-1',
      title: '5 Tanda Awal Serangan Rayap Kayu di Rumah Anda',
      category: 'Pencegahan Rayap',
      readTime: '3 min baca',
      snippet: 'Pelajari cara mendeteksi kelembaban tinggi dan serbuk kayu halus sebelum struktur pintu rusak parah.',
    ),
    Article(
      id: 'art-2',
      title: 'Tips Menjaga Dapur Bersih Bebas Hama Tikus',
      category: 'Tips Pemukiman',
      readTime: '4 min baca',
      snippet: 'Metode sanitasi sederhana dan penggunaan perangkap mekanis aman untuk area dapur keluarga.',
    ),
    Article(
      id: 'art-3',
      title: 'Mengapa Disinfeksi Ruangan Penting Setelah Musim Hujan?',
      category: 'Disinfeksi & Sterilisasi',
      readTime: '5 min baca',
      snippet: 'Kuman dan spora jamur berkembang biak cepat saat kelembaban meningkat usai hujan deras.',
    ),
  ].obs;
}
