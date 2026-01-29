// Data Models
class NewsItem {
  final String id;
  final String title;
  final String description;
  final String fullContent;
  final String imageUrl;
  final List<String> thumbnailImages;
  final String? videoUrl;
  final String category;
  final String author;
  final String time;
  final List<String> tags;

  NewsItem({
    required this.id,
    required this.title,
    required this.description,
    required this.fullContent,
    required this.imageUrl,
    this.thumbnailImages = const [],
    this.videoUrl,
    required this.category,
    required this.author,
    required this.time,
    this.tags = const [],
  });
}

// Video Model
class VideoItem {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String views;
  final String duration;

  VideoItem({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.views,
    required this.duration,
  });
}

// Trending News Model
class TrendingNewsItem {
  final String id;
  final String newsId; // Add reference to NewsItem
  final String title;
  final String category;
  final String trendingStatus;
  final String views;

  TrendingNewsItem({
    required this.id,
    required this.newsId, // Add this
    required this.title,
    required this.category,
    required this.trendingStatus,
    required this.views,
  });
}