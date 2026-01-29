import 'package:flutter/material.dart';
import 'package:my_app/models/news_models.dart';
import 'package:my_app/screens/news_detail_screen.dart';
import '../data/news_data.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trendingNewsItems.length,
            itemBuilder: (context, index) {
              final trendingNews = trendingNewsItems[index];
              return GestureDetector(
                onTap: () {
                  _showTrendingNewsDetail(context, trendingNews);
                },
                child: _buildTrendingCard(trendingNews, index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingCard(TrendingNewsItem trendingNews, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank indicator
          Container(
            width: 50,
            height: 80,
            decoration: BoxDecoration(
              color: index < 3
                  ? Colors.deepPurple.withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: index < 3 ? Colors.deepPurple : Colors.grey,
                ),
              ),
            ),
          ),
          // News content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trendingNews.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trendingNews.category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        _getTrendingIcon(trendingNews.trendingStatus),
                        size: 14,
                        color: _getTrendingColor(trendingNews.trendingStatus),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        trendingNews.trendingStatus,
                        style: TextStyle(
                          fontSize: 12,
                          color: _getTrendingColor(trendingNews.trendingStatus),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${trendingNews.views} ទស្សនា',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTrendingIcon(String status) {
    switch (status) {
      case 'កំពុងល្បី':
        return Icons.whatshot_rounded;
      case 'កើនឡើង':
        return Icons.trending_up_rounded;
      case 'ពេញនិយម':
        return Icons.favorite_rounded;
      case 'កំពុងលូតលាស់':
        return Icons.arrow_upward_rounded;
      case 'ទាក់ទាញ':
        return Icons.star_rounded;
      case 'កំពុងពិភាក្សា':
        return Icons.forum_rounded;
      default:
        return Icons.trending_up_rounded;
    }
  }

  Color _getTrendingColor(String status) {
    switch (status) {
      case 'កំពុងល្បី':
        return Colors.red;
      case 'កើនឡើង':
        return Colors.green;
      case 'ពេញនិយម':
        return Colors.orange;
      case 'កំពុងលូតលាស់':
        return Colors.blue;
      case 'ទាក់ទាញ':
        return Colors.purple;
      case 'កំពុងពិភាក្សា':
        return Colors.teal;
      default:
        return Colors.green;
    }
  }

  void _showTrendingNewsDetail(BuildContext context, TrendingNewsItem trendingNews) {
    // Find the corresponding NewsItem from trending news
    // Since TrendingNewsItem doesn't have full news data,
    // we need to find matching news or use default news
    
    // Method 1: Try to find matching news by title or category
    NewsItem? matchingNews;
    
    // First try to find by title (exact match)
    for (var news in newsItems) {
      if (news.title == trendingNews.title) {
        matchingNews = news;
        break;
      }
    }
    
    // If not found by title, try to find first news in same category
    if (matchingNews == null) {
      matchingNews = newsItems.firstWhere(
        (news) => news.category == trendingNews.category,
        orElse: () => newsItems.first, // Fallback to first news
      );
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailScreen(newsId: matchingNews!.id),
      ),
    );
  }
}