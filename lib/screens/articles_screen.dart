import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/data_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  String _searchQuery = '';
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Semua', 'Kepatuhan HACCP', 'ESG & Eco', 'Tips & Edukasi', 'Teknologi AI'];

  @override
  Widget build(BuildContext context) {
    final filtered = SampleData.articles.where((art) {
      final matchesSearch = art.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          art.snippet.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCat = _selectedCategoryIndex == 0 || art.category == _categories[_selectedCategoryIndex];
      return matchesSearch && matchesCat;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Pusat Edukasi & HACCP Insights'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search Field
          TextField(
            onChanged: (val) => setState(() => _searchQuery = val),
            decoration: InputDecoration(
              hintText: 'Cari panduan, artikel, atau regulasi...',
              prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
              filled: true,
              fillColor: AppColors.surfaceLight,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.borderColor),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_categories.length, (idx) {
                final isSelected = _selectedCategoryIndex == idx;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(_categories[idx]),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedCategoryIndex = idx),
                    selectedColor: AppColors.emerald600,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    backgroundColor: AppColors.surfaceLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.emerald600 : AppColors.borderColor,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),

          ...filtered.map((article) => Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _showArticleDetail(context, article);
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatusBadge(
                            text: article.category.toUpperCase(),
                            backgroundColor: AppColors.emerald50,
                            textColor: AppColors.emerald700,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined, size: 12, color: AppColors.textMuted),
                              const SizedBox(width: 4),
                              Text(
                                article.readTime,
                                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkSlate900,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        article.snippet,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            article.date,
                            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                          ),
                          const Row(
                            children: [
                              Text(
                                'Baca Selengkapnya',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.emerald600,
                                ),
                              ),
                              Icon(Icons.chevron_right, size: 16, color: AppColors.emerald600),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _showArticleDetail(BuildContext context, ArticleItem article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                StatusBadge(
                  text: article.category.toUpperCase(),
                  backgroundColor: AppColors.emerald50,
                  textColor: AppColors.emerald700,
                ),
                const SizedBox(height: 12),
                Text(
                  article.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                ),
                const SizedBox(height: 6),
                Text(
                  'Diterbitkan ${article.date} • ${article.readTime}',
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
                const Divider(height: 24),
                Text(
                  article.snippet,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkSlate800, height: 1.5),
                ),
                const SizedBox(height: 16),
                const Text(
                  '1. Integrasi Standar HACCP & Sanitasi Pangan\n'
                  'Dalam industri pengolahan pangan modern, zero-tolerance terhadap hama adalah kewajiban hukum. PCO (Pest Control Operator) wajib menyediakan dokumentasi digital yang mencakup identifikasi spesies hama, tingkat keparahan, serta koordinat titik temuan.\n\n'
                  '2. Penggunaan Agen Hayati vs Kimia Konvensional\n'
                  'Dengan pendekatan Integrated Pest Management (IPM), PROTECT menerapkan formula bio-pesticide berbahan dasar pyrethrum alami yang dapat terurai secara hayati dalam 24 jam tanpa meninggalkan residu beracun pada rantai makanan.\n\n'
                  '3. Sertifikasi Digital dan Audit Terintegrasi\n'
                  'Setiap tindakan pengendalian langsung tercatat di blockchain audit trail kami, siap disajikan kapan saja kepada auditor ISO 22000, BPOM, maupun BRCGS.',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.6),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.emerald600,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Tutup Artikel', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
