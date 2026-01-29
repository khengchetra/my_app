import 'package:flutter/material.dart';
import '../data/news_data.dart';
import '../widgets/news_card.dart';
import '../models/news_models.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: newsCategories.length,
            itemBuilder: (context, index) {
              final category = newsCategories[index];
              return GestureDetector(
                onTap: () {
                  _showCategoryNews(context, category);
                },
                child: _buildCategoryCard(category, index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String category, int index) {
    // Count how many news items in this category
    final newsCount = category == 'ទាំងអស់'
        ? newsItems.length
        : newsItems.where((news) => news.category == category).length;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              _getCategoryIcon(category),
              color: Colors.deepPurple,
              size: 30,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            category,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '$newsCount អត្ថបទ',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'ទាំងអស់':
        return Icons.all_inclusive_rounded;
      case 'ការប្រាស្រ័យ':
        return Icons.chat_rounded;
      case 'កីឡា':
        return Icons.sports_soccer_rounded;
      case 'បច្ចេកវិទ្យា':
        return Icons.computer_rounded;
      case 'សុខភាព':
        return Icons.health_and_safety_rounded;
      case 'ការប្រកួត':
        return Icons.emoji_events_rounded;
      case 'សេដ្ឋកិច្ច':
        return Icons.attach_money_rounded;
      case 'កម្សាន្ត':
        return Icons.movie_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  void _showCategoryNews(BuildContext context, String category) {
    // Filter news by category
    final filteredNews = category == 'ទាំងអស់'
        ? newsItems
        : newsItems.where((news) => news.category == category).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryNewsScreen(
          category: category,
          newsList: filteredNews,
        ),
      ),
    );
  }
}

// New screen for showing news by category
class CategoryNewsScreen extends StatelessWidget {
  final String category;
  final List<NewsItem> newsList;

  const CategoryNewsScreen({
    super.key,
    required this.category,
    required this.newsList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: newsList.isEmpty
          ? const Center(
              child: Text(
                'មិនមានព័ត៌មាននៅក្នុងប្រភេទនេះទេ',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Category header
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            _getCategoryIcon(category),
                            color: Colors.deepPurple,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${newsList.length} អត្ថបទ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // News list
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: newsList.length,
                      itemBuilder: (context, index) {
                        final news = newsList[index];
                        return NewsCard(news: news);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'ទាំងអស់':
        return Icons.all_inclusive_rounded;
      case 'ការប្រាស្រ័យ':
        return Icons.chat_rounded;
      case 'កីឡា':
        return Icons.sports_soccer_rounded;
      case 'បច្ចេកវិទ្យា':
        return Icons.computer_rounded;
      case 'សុខភាព':
        return Icons.health_and_safety_rounded;
      case 'ការប្រកួត':
        return Icons.emoji_events_rounded;
      case 'សេដ្ឋកិច្ច':
        return Icons.attach_money_rounded;
      case 'កម្សាន្ត':
        return Icons.movie_rounded;
      default:
        return Icons.category_rounded;
    }
  }
}