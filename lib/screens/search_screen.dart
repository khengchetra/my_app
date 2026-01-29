import 'package:flutter/material.dart';
import '../data/news_data.dart';
import '../widgets/news_card.dart';
import '../models/news_models.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<NewsItem> _searchResults = [];
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
        _isSearching = false;
        _searchQuery = '';
      });
      return;
    }

    setState(() {
      _searchQuery = query;
      _isSearching = true;
    });

    // Perform search after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_searchQuery == query) {
        _performSearch(query);
      }
    });
  }

  void _performSearch(String query) {
    final results = newsItems.where((news) {
      return news.title.toLowerCase().contains(query.toLowerCase()) ||
             news.description.toLowerCase().contains(query.toLowerCase()) ||
             news.category.toLowerCase().contains(query.toLowerCase()) ||
             news.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase())) ||
             news.author.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchResults.clear();
      _isSearching = false;
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'ស្វែងរកព័ត៌មាន...',
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search_rounded, color: Colors.white),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: _clearSearch,
                  )
                : null,
          ),
          style: const TextStyle(color: Colors.white),
          autofocus: true,
          cursorColor: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_searchQuery.isEmpty) {
      return _buildRecentSearches();
    }

    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.deepPurple,
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              'រកមិនឃើញព័ត៌មាន "$_searchQuery"',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'សូមសាកស្វែងរកពាក្យផ្សេងទៀត',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Search results header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Colors.deepPurple,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'លទ្ធផលស្វែងរក: "$_searchQuery"',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text('${_searchResults.length} លទ្ធផល'),
                  backgroundColor: Colors.deepPurple,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          
          // Search results list
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final news = _searchResults[index];
                return NewsCard(news: news);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches() {
    // You can implement recent searches functionality here
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent searches header
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: const Text(
              'ស្វែងរកព័ត៌មានដោយ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Search suggestions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildSearchChip('កម្មវិធី'),
                _buildSearchChip('កីឡាករ'),
                _buildSearchChip('សេដ្ឋកិច្ច'),
                _buildSearchChip('បច្ចេកវិទ្យា'),
                _buildSearchChip('សុខភាព'),
                _buildSearchChip('កម្ពុជា'),
                _buildSearchChip('ទីក្រុងភ្នំពេញ'),
                _buildSearchChip('អាស៊ាន'),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Popular categories
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: const Text(
              'ប្រភេទព័ត៌មានពេញនិយម',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Popular categories list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: newsCategories.map((category) {
                if (category == 'ទាំងអស់') return const SizedBox.shrink();
                
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      _getCategoryIcon(category),
                      color: Colors.deepPurple,
                      size: 20,
                    ),
                  ),
                  title: Text(category),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onTap: () {
                    _searchController.text = category;
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchChip(String text) {
    return GestureDetector(
      onTap: () {
        _searchController.text = text;
      },
      child: Chip(
        label: Text(text),
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
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