import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:my_app/models/news_models.dart';
import '../data/news_data.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  void _showVideoDetail(BuildContext context, VideoItem video) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VideoDetailSheet(video: video),
    );
  }

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
              childAspectRatio: 0.8,
            ),
            itemCount: videoItems.length,
            itemBuilder: (context, index) {
              final video = videoItems[index];
              return GestureDetector(
                onTap: () => _showVideoDetail(context, video),
                child: _buildVideoCard(video),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoCard(VideoItem video) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video thumbnail
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(video.thumbnailUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.deepPurple,
                  size: 32,
                ),
              ),
            ),
          ),
          // Video info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye_rounded,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      video.views,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      video.duration,
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
        ],
      ),
    );
  }
}

class VideoDetailSheet extends StatefulWidget {
  final VideoItem video;
  
  const VideoDetailSheet({
    super.key,
    required this.video,
  });

  @override
  State<VideoDetailSheet> createState() => _VideoDetailSheetState();
}

class _VideoDetailSheetState extends State<VideoDetailSheet> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    // Using sample video URL since VideoItem doesn't have videoUrl
    // You might want to add videoUrl to VideoItem model
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      // Using sample video - you should add videoUrl to VideoItem model
      final sampleVideoUrls = [
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      ];
      
      final index = int.tryParse(widget.video.id.substring(1)) ?? 0;
      final videoUrl = sampleVideoUrls[index % sampleVideoUrls.length];
      
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      
      await _videoPlayerController.initialize();
      
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          looping: false,
          allowFullScreen: true,
          fullScreenByDefault: false,
          allowPlaybackSpeedChanging: true,
          allowedScreenSleep: false,
          showControlsOnInitialize: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.deepPurple,
            handleColor: Colors.deepPurple,
            backgroundColor: Colors.grey[300]!,
            bufferedColor: Colors.grey[200]!,
          ),
          placeholder: Container(
            color: Colors.black,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            ),
          ),
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                'មិនអាចលេងវីដេអូបានទេ: $errorMessage',
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
        _isVideoInitialized = true;
      });
    } catch (e) {
      print('Error initializing video: $e');
      setState(() {
        _isVideoInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          
          // Close button
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          
          // Video title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.video.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Video player
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _buildVideoPlayer(),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Video stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.remove_red_eye_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  '${widget.video.views} ទស្សនា',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 20),
                const Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.video.duration,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Description title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ការពិពណ៌នា',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Scrollable description
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  _getVideoDescription(widget.video.title),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (!_isVideoInitialized) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ),
        ),
      );
    }

    if (_chewieController == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Text(
            'មិនអាចផ្ទុកវីដេអូបានទេ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Chewie(
      controller: _chewieController!,
    );
  }

  String _getVideoDescription(String title) {
    // Generate description based on title
    // In real app, you should add description field to VideoItem model
    final descriptions = {
      'ព័ត៌មានថ្ងៃនេះ៖ ការអភិវឌ្ឍន៍ទីក្រុងថ្មី': '''
ការអភិវឌ្ឍន៍ទីក្រុងថ្មីកំពុងដំណើរការនៅតំបន់ផ្សេងៗទូទាំងប្រទេស។ គម្រោងនេះរួមមានការសាងសង់អគារសាធារណៈ ប្រព័ន្ធដឹកជញ្ជូន និងសេវាកម្មសាធារណៈថ្មីៗ។

គម្រោងសំខាន់ៗ៖
- ការសាងសង់ស្ពានថ្មីឆ្លងកាត់ទនេ្ល
- ការអភិវឌ្ឍតំបន់ឧស្សាហកម្មថ្មី
- ការកសាងសាលារៀន និងមន្ទីរពេទ្យ
- ការពង្រីកបណ្តាញផ្លូវថ្នល់

ការអភិវឌ្ឍនេះនឹងជួយលើកកំពស់គុណភាពជីវិតរបស់ប្រជាពលរដ្ឋ និងទាក់ទាញការវិនិយោគពីបរទេស។
''',
      'សម្ភាសន៍ជាមួយអ្នកជំនាញសេដ្ឋកិច្ច': '''
សម្ភាសន៍ពិសេសជាមួយអ្នកជំនាញសេដ្ឋកិច្ចអន្តរជាតិ លោក ជេមស៍ ស្មីត អំពីទិសដៅសេដ្ឋកិច្ចកម្ពុជានាពេលខាងមុខ។

ក្នុងការសម្ភាសន៍នេះ លោកបានចែករំលែក៖
- ទស្សនៈពីកំណើនសេដ្ឋកិច្ចកម្ពុជា
- ឱកាសការវិនិយោគក្នុងតំបន់
- បញ្ហាប្រឈម និងដំណោះស្រាយ
- ការព្យាករណ៍សម្រាប់ឆ្នាំក្រោយ

លោកបានណែនាំឲ្យរដ្ឋាភិបាលបន្តវិនិយោគក្នុងវិស័យអប់រំ និងបច្ចេកវិទ្យា ដើម្បីធានាការអភិវឌ្ឍន៍ប្រកបដោយចីរភាព។
''',
      'ការប្រកួតកីឡាជាតិឆ្នាំ២០២៤': '''
ការប្រកួតកីឡាជាតិឆ្នាំ២០២៤ ដែលប្រារព្ធឡើងនៅទីក្រុងភ្នំពេញ បានទទួលជោគជ័យយ៉ាងធំធេង។

ព្រឹត្តិការណ៍សំខាន់ៗ៖
- កីឡាបាល់ទាត់៖ ក្រុមជាតិទទួលបានជ័យជំនះ
- ប្រដាល់៖ កីឡាករជាតិទទួលមេដាយមាស ៣
- កីឡាហែលទឹក៖ កំណត់ត្រាថ្មីជាច្រើនត្រូវបានបង្កើត
- កីឡាវាយសី៖ អ្នកចំណាត់ថ្នាក់ពិភពលោកចូលរួម

ការប្រកួតនេះបានទាក់ទាញកីឡាករជាង ២,០០០ នាក់ ពីគ្រប់ខេត្តក្រុងទូទាំងប្រទេស។
''',
    };

    return descriptions[title] ?? '''
វីដេអូនេះបង្ហាញពីព័ត៌មានថ្មីៗ និងចំណុចសំខាន់ៗនៅក្នុងប្រទេសកម្ពុជា។ យើងនឹងយកលំអិតពីហេតុការណ៍សំខាន់ៗ ការអភិវឌ្ឍន៍ថ្មីៗ និងការវិភាគពីអ្នកជំនាញ។

សូមទស្សនាវីដេអូដើម្បីទទួលបានព័ត៌មានពេញលេញ និងការយល់ដឹងជ្រៅជ្រះអំពីប្រធានបទនេះ។

សម្រាប់ព័ត៌មានបន្ថែម សូមតាមដានទំព័រផ្លូវការរបស់យើង។
''';
  }
}