import 'package:flutter/material.dart';
import '../data/news_data.dart';
import '../widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'ទាំងអស់';

  @override
  Widget build(BuildContext context) {
    // Filter news items based on selected category
    final filteredNewsItems = _selectedCategory == 'ទាំងអស់'
        ? newsItems
        : newsItems.where((news) => news.category == _selectedCategory).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Breaking News Banner
          _buildBreakingNewsBanner(),
          
          // Categories Horizontal List
          _buildCategoriesList(),
          
          // News List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: filteredNewsItems.length,
            itemBuilder: (context, index) {
              final news = filteredNewsItems[index];
              return NewsCard(news: news);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBreakingNewsBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF673AB7), const Color(0xFF9C27B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.campaign_rounded, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ព័ត៌មានថ្មី',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const Text(
                  'ព័ត៌មានសំខាន់ៗនាពេលនេះ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: newsCategories.length,
        itemBuilder: (context, index) {
          final category = newsCategories[index];
          final isSelected = category == _selectedCategory;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Chip(
                label: Text(category),
                backgroundColor: isSelected ? Colors.deepPurple : Colors.grey[100],
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: isSelected 
                      ? BorderSide.none 
                      : BorderSide(color: Colors.grey[300]!),
                ),
                avatar: isSelected 
                    ? const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}