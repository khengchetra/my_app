import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'video_screen.dart';
import 'category_screen.dart';
import 'trending_screen.dart';
import 'search_screen.dart';
import '../utils/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const HomeScreen(),
    const VideoScreen(),
    const CategoryScreen(),
    const TrendingScreen(),
  ];

  // Function to get current page title
  String _getCurrentPageTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'ព័ត៌មានថ្មីៗ';
      case 1:
        return 'វីដេអូព័ត៌មាន';
      case 2:
        return 'ប្រភេទព័ត៌មាន';
      case 3:
        return 'ព័ត៌មានពេញនិយម';
      default:
        return 'ព័ត៌មានថ្មីៗ';
    }
  }

  // Function to get current page subtitle
  String _getCurrentPageSubtitle() {
    switch (_selectedIndex) {
      case 0:
        return 'ព័ត៌មានពេលថ្មីៗ';
      case 1:
        return 'ព័ត៌មានថ្មីៗតាមរយៈវីដេអូ';
      case 2:
        return 'ព័ត៌មានតាមប្រភេទផ្សេងៗ';
      case 3:
        return 'ព័ត៌មានកំពុងល្បីនៅពេលនេះ';
      default:
        return 'ព័ត៌មានពេលថ្មីៗ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getPageIcon(),
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getCurrentPageTitle(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getCurrentPageSubtitle(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            tooltip: 'ស្វែងរកព័ត៌មាន',
            color: Colors.deepPurple,
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
          items: List.generate(navIcons.length, (index) {
            return BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _selectedIndex == index
                      ? Colors.deepPurple.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Icon(
                  navIcons[index],
                  size: 24,
                ),
              ),
              label: navLabels[index],
            );
          }),
        ),
      ),
    );
  }

  IconData _getPageIcon() {
    switch (_selectedIndex) {
      case 0:
        return Icons.newspaper_rounded;
      case 1:
        return Icons.videocam_rounded;
      case 2:
        return Icons.category_rounded;
      case 3:
        return Icons.trending_up_rounded;
      default:
        return Icons.newspaper_rounded;
    }
  }
}