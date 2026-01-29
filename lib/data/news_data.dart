import '../models/news_models.dart';

// Sample Data
final List<String> newsCategories = [
  'ទាំងអស់',
  'ការប្រាស្រ័យ',
  'កីឡា',
  'បច្ចេកវិទ្យា',
  'សុខភាព',
  'ការប្រកួត',
  'សេដ្ឋកិច្ច',
  'កម្សាន្ត',
];

// Generate 50 news items
final List<NewsItem> newsItems = List.generate(50, (index) {
  final id = (index + 1).toString();
  final categoryIndex = index % 8;
  final category = newsCategories[categoryIndex == 0 ? 1 : categoryIndex]; // Skip 'ទាំងអស់'
  
  // Sample data templates
  final List<Map<String, dynamic>> templates = [
    {
      'title': 'ការអភិវឌ្ឍន៍កម្មវិធីថ្មី នឹងផ្លាស់ប្តូរពិភពលោកនាពេលខាងមុខ',
      'description': 'កម្មវិធីថ្មីនឹងជួយសម្រួលដល់ការងាររបស់អ្នកប្រើប្រាស់',
      'category': 'បច្ចេកវិទ្យា',
      'tags': ['កម្មវិធី', 'AI', 'បច្ចេកវិទ្យា', 'ការអភិវឌ្ឍ'],
    },
    {
      'title': 'កីឡាករជាតិ ទទួលបានជ័យជំនះនៅក្នុងការប្រកួតអន្តរជាតិ',
      'description': 'កីឡាករកម្ពុជាទទួលបានមេដាយមាសចំនួន៣',
      'category': 'កីឡា',
      'tags': ['កីឡាករ', 'មេដាយមាស', 'ប្រកួតអន្តរជាតិ', 'កម្ពុជា'],
    },
    {
      'title': 'សុខភាព៖ វិធីសាស្រ្តថ្មីក្នុងការព្យាបាលជំងឺរលាក',
      'description': 'អ្នកវិទ្យាសាស្រ្តបានរកឃើញវិធីសាស្រ្តថ្មី',
      'category': 'សុខភាព',
      'tags': ['សុខភាព', 'ព្យាបាល', 'វិទ្យាសាស្រ្ត', 'ឱសថសកល'],
    },
    {
      'title': 'សេដ្ឋកិច្ចកម្ពុជា កំពុងលូតលាស់យ៉ាងរហ័ស',
      'description': 'កំណើនសេដ្ឋកិច្ចបានកើនឡើងច្រើនជាងការរំពឹងទុក',
      'category': 'សេដ្ឋកិច្ច',
      'tags': ['សេដ្ឋកិច្ច', 'កំណើន', 'ការវិនិយោគ', 'កម្ពុជា'],
    },
    {
      'title': 'ការប្រាស្រ័យទាន់សម័យនៅទីក្រុងភ្នំពេញ',
      'description': 'ប្រព័ន្ធដឹកជញ្ជូនថ្មីនឹងចាប់ផ្តើមនៅឆ្នាំក្រោយ',
      'category': 'ការប្រាស្រ័យ',
      'tags': ['ការប្រាស្រ័យ', 'ភ្នំពេញ', 'រថភ្លើង', 'ដឹកជញ្ជូន'],
    },
    {
      'title': 'ការប្រកួតអន្តរជាតិដ៏ធំបំផុតនៅកម្ពុជា',
      'description': 'ព្រឹត្តិការណ៍ចំនួន ១០ នឹងត្រូវប្រារព្ធឡើងនាពេលខាងមុខ',
      'category': 'ការប្រកួត',
      'tags': ['ការប្រកួត', 'អន្តរជាតិ', 'ព្រឹត្តិការណ៍', 'កម្ពុជា'],
    },
    {
      'title': 'ការកំសាន្តថ្មីនៅតំបន់សៀមរាប',
      'description': 'ឧទ្យានទេសចរណ៍ថ្មីនឹងបើកទ្វារនាពេលខាងមុខ',
      'category': 'កម្សាន្ត',
      'tags': ['កម្សាន្ត', 'សៀមរាប', 'ទេសចរណ៍', 'ឧទ្យាន'],
    },
    {
      'title': 'កសិកម្មទំនើបនៅកម្ពុជា',
      'description': 'ការប្រើប្រាស់បច្ចេកវិទ្យាថ្មីក្នុងវិស័យកសិកម្ម',
      'category': 'បច្ចេកវិទ្យា',
      'tags': ['កសិកម្ម', 'បច្ចេកវិទ្យា', 'អភិវឌ្ឍន៍', 'កម្ពុជា'],
    },
  ];

  final template = templates[index % templates.length];
  final imageNumber = (index * 3) + 1; // Generate unique image numbers
  
  return NewsItem(
    id: id,
    title: '${template['title']} - ផ្នែកទី $id',
    description: '${template['description']} - ការបន្ថែមព័ត៌មានលម្អិត',
    fullContent: '''
នេះជាខ្លឹមសារពេញលេញសម្រាប់ព័ត៌មានលេខ $id។
${template['title']}

**ព័ត៌មានលម្អិត៖**
- ព័ត៌មាននេះផ្តល់ជូនដោយសារព័ត៌មានជាតិ
- កាលបរិច្ឆេទ៖ ខែទី ${(index % 12) + 1} ឆ្នាំ ២០២៤
- ទីកន្លែង៖ ទីក្រុងភ្នំពេញ
- ប្រភេទ៖ ${template['category']}

ព័ត៌មាននេះមានសារៈសំខាន់ខ្លាំងណាស់សម្រាប់សង្គមខ្មែរ។ យើងសង្ឃឹមថាព័ត៌មាននេះនឹងជួយដល់ប្រជាពលរដ្ឋកម្ពុជាគ្រប់រូប។
''',
    imageUrl: 'https://picsum.photos/400/300?random=$imageNumber',
    thumbnailImages: List.generate(3, (i) => 'https://picsum.photos/200/150?random=${imageNumber + i + 10}'),
    videoUrl: index % 4 == 0 ? 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4' : null,
    category: category,
    author: 'អ្នកយកព័ត៌មាន លេខ $id',
    time: 'ម៉ោងមុន ${index + 1}',
    tags: template['tags'] as List<String>,
  );
})..addAll([
  // Keep your original 7 news items (now they will be items 51-57)
  NewsItem(
    id: '51',
    title: 'ការអភិវឌ្ឍន៍កម្មវិធីថ្មី នឹងផ្លាស់ប្តូរពិភពលោកនាពេលខាងមុខ',
    description: 'កម្មវិធីថ្មីនឹងជួយសម្រួលដល់ការងាររបស់អ្នកប្រើប្រាស់',
    fullContent: '''
កម្មវិធីថ្មីដែលអភិវឌ្ឍដោយក្រុមអ្នកវិទ្យាសាស្ត្រខ្មែរ នឹងផ្លាស់ប្តូរវិធីដែលយើងធ្វើការនៅក្នុងពិភពលោកទាំងមូល។ កម្មវិធីនេះប្រើប្រាស់បច្ចេកវិទ្យា AI ទំនើបជំនាន់ថ្មី ដើម្បីជួយសម្រួលដល់ការងារជាច្រើនប្រភេទ។

**លក្ខណៈពិសេសសំខាន់ៗ៖**
- ការគ្រប់គ្រងទិន្នន័យដោយស្វ័យប្រវត្តិ
- ការវិភាគទិន្នន័យពេលជាក់ស្តែង
- ប្រព័ន្ធសុវត្ថិភាពកម្រិតខ្ពស់
- ការភ្ជាប់ទៅកាន់ប្រព័ន្ធផ្សេងៗដោយងាយស្រួល

អ្នកអភិវឌ្ឍន៍បានថ្លែងថា កម្មវិធីនេះនឹងជួយសន្សំសំចៃពេលវេលារបស់អ្នកប្រើប្រាស់បានរហូតដល់ ៤០% និងបង្កើនផលិតភាពការងារបានយ៉ាងច្រើន។
''',
    imageUrl: 'https://picsum.photos/400/300?random=1',
    thumbnailImages: [
      'https://picsum.photos/200/150?random=21',
      'https://picsum.photos/200/150?random=22',
      'https://picsum.photos/200/150?random=23',
      'https://picsum.photos/200/150?random=24',
    ],
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    category: 'បច្ចេកវិទ្យា',
    author: 'អ្នកយកព័ត៌មាន',
    time: 'ម៉ោងមុន ១',
    tags: ['កម្មវិធី', 'AI', 'បច្ចេកវិទ្យា', 'ការអភិវឌ្ឍ'],
  ),
  NewsItem(
    id: '52',
    title: 'កីឡាករជាតិ ទទួលបានជ័យជំនះនៅក្នុងការប្រកួតអន្តរជាតិ',
    description: 'កីឡាករកម្ពុជាទទួលបានមេដាយមាសចំនួន៣',
    fullContent: '''
កីឡាករជាតិខ្មែរបានធ្វើឲ្យជាតិមានកិត្តិយសយ៉ាងខ្ពស់ ដោយបានទទួលមេដាយមាសចំនួន ៣ នៅក្នុងការប្រកួតអន្តរជាតិដ៏សំខាន់មួយ។

**លទ្ធផលសំខាន់ៗ៖**
- មេដាយមាសក្នុងព្រឹត្តិការណ៍ប្រដាល់សេរី
- មេដាយមាសក្នុងកីឡាវាយសី
- មេដាយមាសក្នុងកីឡាអត្តពលិក
- មេដាយប្រាក់ចំនួន ២
- មេដាយសំរិទ្ធចំនួន ៣

លោកគ្រូចាត់ការ សុខ សំណាង បានថ្លែងថា៖ "នេះជាលទ្ធផលដ៏អស្ចារ្យមួយសម្រាប់កីឡាកម្ពុជា។ យើងបានហាត់ប្រាណយ៉ាងខ្លាំងក្លា ហើយឥឡូវនេះលទ្ធផលបានបង្ហាញឲ្យឃើញ"។
''',
    imageUrl: 'https://picsum.photos/400/300?random=3',
    thumbnailImages: [
      'https://picsum.photos/200/150?random=25',
      'https://picsum.photos/200/150?random=26',
    ],
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    category: 'កីឡា',
    author: 'សារព័ត៌មានថ្មី',
    time: 'ម៉ោងមុន ២',
    tags: ['កីឡាករ', 'មេដាយមាស', 'ប្រកួតអន្តរជាតិ', 'កម្ពុជា'],
  ),
  NewsItem(
    id: '53',
    title: 'សុខភាព៖ វិធីសាស្រ្តថ្មីក្នុងការព្យាបាលជំងឺរលាក',
    description: 'អ្នកវិទ្យាសាស្រ្តបានរកឃើញវិធីសាស្រ្តថ្មី',
    fullContent: '''
អ្នកវិទ្យាសាស្រ្តខ្មែរបានរកឃើញវិធីសាស្រ្តថ្មីក្នុងការព្យាបាលជំងឺរលាក ដែលមានប្រសិទ្ធភាពខ្ពស់ជាងវិធីសាស្រ្តប្រពៃណី។

**អត្ថប្រយោជន៍សំខាន់ៗ៖**
- ពេលព្យាបាលខ្លីជាងមុន ៥០%
- អត្រាជោគជ័យកើនឡើង ៦៥%
- ផលរំខានកាន់តែតិច
- ថ្លៃព្យាបាលត្រឹមតែ ៣០% នៃថ្លៃព្យាបាលបរទេស

វិធីសាស្រ្តថ្មីនេះផ្អែកលើឱសថសកល ដែលអាចរកឃើញនៅក្នុងរុក្ខជាតិធម្មជាតិនៅកម្ពុជា។ នេះនឹងជួយសម្រួលដល់អ្នកជំងឺដែលមានបញ្ហាសុខភាព។
''',
    imageUrl: 'https://picsum.photos/400/300?random=5',
    thumbnailImages: [
      'https://picsum.photos/200/150?random=27',
      'https://picsum.photos/200/150?random=28',
      'https://picsum.photos/200/150?random=29',
    ],
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    category: 'សុខភាព',
    author: 'សុខភាពថ្ងៃនេះ',
    time: 'ម៉ោងមុន ៣',
    tags: ['សុខភាព', 'ព្យាបាល', 'វិទ្យាសាស្រ្ត', 'ឱសថសកល'],
  ),
  NewsItem(
    id: '54',
    title: 'សេដ្ឋកិច្ចកម្ពុជា កំពុងលូតលាស់យ៉ាងរហ័ស',
    description: 'កំណើនសេដ្ឋកិច្ចបានកើនឡើងច្រើនជាងការរំពឹងទុក',
    fullContent: '''
សេដ្ឋកិច្ចកម្ពុជាកំពុងលូតលាស់យ៉ាងរហ័ស ដោយកំណើនសេដ្ឋកិច្ចបានកើនឡើងដល់ ៧.២% នៅក្នុងត្រីមាសទីមួយនៃឆ្នាំ២០២៤។

**កត្តាចម្បងនៃកំណើន៖**
- វិស័យសំណង់កំពុងរីកចម្រើន
- វិស័យទេសចរណ៍កំពុងរស់ឡើងវិញ
- ការវិនិយោគផ្ទាល់ពីបរទេសកំពុងកើនឡើង
- កសិកម្មទទួលបានគ្រាប់ធញ្ញជាតិល្អ

អ្នកជំនាញសេដ្ឋកិច្ចព្យាករណ៍ថា ប្រសិនបើកំណើននេះបន្ត កម្ពុជាអាចសម្រេចបាននូវគោលដៅកំណើនសេដ្ឋកិច្ចឆ្នាំ២០២៤ មុនពេលកំណត់។
''',
    imageUrl: 'https://picsum.photos/400/300?random=7',
    thumbnailImages: [
      'https://picsum.photos/200/150?random=30',
      'https://picsum.photos/200/150?random=31',
    ],
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    category: 'សេដ្ឋកិច្ច',
    author: 'សេដ្ឋកិច្ចថ្ងៃនេះ',
    time: 'ម៉ោងមុន ៤',
    tags: ['សេដ្ឋកិច្ច', 'កំណើន', 'ការវិនិយោគ', 'កម្ពុជា'],
  ),
  NewsItem(
    id: '55',
    title: 'ការប្រាស្រ័យទាន់សម័យនៅទីក្រុងភ្នំពេញ',
    description: 'ប្រព័ន្ធដឹកជញ្ជូនថ្មីនឹងចាប់ផ្តើមនៅឆ្នាំក្រោយ',
    fullContent: '''
ទីក្រុងភ្នំពេញនឹងមានប្រព័ន្ធដឹកជញ្ជូនទាន់សម័យថ្មីដែលនឹងជួយសម្រួលដល់ការធ្វើដំណើររបស់ប្រជាពលរដ្ឋ។ គម្រោងនេះរួមមានការសាងសង់រថភ្លើងអគ្គិសនី និងការពង្រីកបណ្តាញផ្លូវ។

**គម្រោងសំខាន់ៗ៖**
- រថភ្លើងអគ្គិសនីពីអាកាសយានដ្ឋានទៅកណ្តាលទីក្រុង
- ការពង្រីកផ្លូវថ្នល់សំខាន់ៗ
- ការសាងសង់ស្ថានីយ៍ឈប់សំរាកទំនើប
- ប្រព័ន្ធចំណាយសន្លឹកដោយស្វ័យប្រវត្តិ

គម្រោងនេះនឹងធ្វើឲ្យការធ្វើដំណើរនៅទីក្រុងភ្នំពេញកាន់តែងាយស្រួល និងរហ័សជាងមុន។
''',
    imageUrl: 'https://picsum.photos/400/300?random=15',
    thumbnailImages: [
      'https://picsum.photos/200/150?random=32',
      'https://picsum.photos/200/150?random=33',
      'https://picsum.photos/200/150?random=34',
    ],
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    category: 'ការប្រាស្រ័យ',
    author: 'ក្រុមអ្នកយកព័ត៌មាន',
    time: 'ម៉ោងមុន ៥',
    tags: ['ការប្រាស្រ័យ', 'ភ្នំពេញ', 'រថភ្លើង', 'ដឹកជញ្ជូន'],
  ),
  NewsItem(
    id: '56',
    title: 'ការប្រកួតអន្តរជាតិដ៏ធំបំផុតនៅកម្ពុជា',
    description: 'ព្រឹត្តិការណ៍ចំនួន ១០ នឹងត្រូវប្រារព្ធឡើងនាពេលខាងមុខ',
    fullContent: '''
កម្ពុជានឹងធ្វើជាម្ចាស់ផ្ទះធ្វើព្រឹត្តិការណ៍អន្តរជាតិចំនួន ១០ ក្នុងឆ្នាំក្រោយ ដែលនឹងទាក់ទាញអ្នកចូលរួមជាង ៥០,០០០ នាក់ពីទូទាំងពិភពលោក។

**ព្រឹត្តិការណ៍សំខាន់ៗ៖**
- សន្និសីទអាស៊ានលើបច្ចេកវិទ្យា
- ការប្រកួតកីឡាអាស៊ាន
- ពិព័រណ៍ស្ថាបត្យកម្មអន្តរជាតិ
- សន្និសីទសេដ្ឋកិច្ចតំបន់

ព្រឹត្តិការណ៍ទាំងនេះនឹងជួយលើកស្ទួយឈ្មោះរបស់កម្ពុជានៅលើឆាកអន្តរជាតិ និងទាក់ទាញភ្ញៀវទេសចរបរទេស។
''',
    imageUrl: 'https://picsum.photos/400/300?random=17',
    thumbnailImages: [
      'https://picsum.photos/200/150?random=35',
      'https://picsum.photos/200/150?random=36',
    ],
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    category: 'ការប្រកួត',
    author: 'ក្រុមអ្នកយកព័ត៌មានអន្តរជាតិ',
    time: 'ម៉ោងមុន ៦',
    tags: ['ការប្រកួត', 'អន្តរជាតិ', 'ព្រឹត្តិការណ៍', 'កម្ពុជា'],
  ),
  NewsItem(
    id: '57',
    title: 'ការកំសាន្តថ្មីនៅតំបន់សៀមរាប',
    description: 'ឧទ្យានទេសចរណ៍ថ្មីនឹងបើកទ្វារនាពេលខាងមុខ',
    fullContent: '''
តំបន់សៀមរាបនឹងមានឧទ្យានទេសចរណ៍ថ្មីមួយដែលនឹងជួយទាក់ទាញភ្ញៀវទេសចរបន្ថែមទៀត។ ឧទ្យាននេះរួមមានកន្លែងកម្សាន្តជាច្រើនប្រភេទសម្រាប់គ្រួសារ។

**កន្លែងកម្សាន្ត៖**
- សួនសត្វធម្មជាតិ
- ទឹកធ្លាក់សិល្បៈ
- កន្លែងជិះសេះ
- ភោជនីយដ្ឋានបែបប្រពៃណី
- កន្លែងដាក់ជម្រកព្រៃ

ឧទ្យាននេះនឹងបង្កើតការងារឲ្យប្រជាពលរដ្ឋក្នុងតំបន់ និងជួយអភិវឌ្ឍន៍សេដ្ឋកិច្ចក្នុងស្រុក។
''',
    imageUrl: 'https://picsum.photos/400/300?random=19',
    thumbnailImages: [
      'https://picsum.photos/200/150?random=37',
      'https://picsum.photos/200/150?random=38',
      'https://picsum.photos/200/150?random=39',
    ],
    videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
    category: 'កម្សាន្ត',
    author: 'ក្រុមទេសចរណ៍',
    time: 'ម៉ោងមុន ៧',
    tags: ['កម្សាន្ត', 'សៀមរាប', 'ទេសចរណ៍', 'ឧទ្យាន'],
  ),
]);

// Video Data
final List<VideoItem> videoItems = [
  VideoItem(
    id: 'v1',
    title: 'ព័ត៌មានថ្ងៃនេះ៖ ការអភិវឌ្ឍន៍ទីក្រុងថ្មី',
    thumbnailUrl: 'https://picsum.photos/200/150?random=9',
    views: '12K',
    duration: '5:30',
  ),
  VideoItem(
    id: 'v2',
    title: 'សម្ភាសន៍ជាមួយអ្នកជំនាញសេដ្ឋកិច្ច',
    thumbnailUrl: 'https://picsum.photos/200/150?random=10',
    views: '8.5K',
    duration: '7:45',
  ),
  VideoItem(
    id: 'v3',
    title: 'ការប្រកួតកីឡាជាតិឆ្នាំ២០២៤',
    thumbnailUrl: 'https://picsum.photos/200/150?random=11',
    views: '15.2K',
    duration: '10:20',
  ),
  VideoItem(
    id: 'v4',
    title: 'វិធីថ្មីក្នុងការធ្វើកសិកម្ម',
    thumbnailUrl: 'https://picsum.photos/200/150?random=12',
    views: '6.3K',
    duration: '6:15',
  ),
  VideoItem(
    id: 'v5',
    title: 'ទស្សនារោងចក្របច្ចេកវិទ្យាខ្ពស់',
    thumbnailUrl: 'https://picsum.photos/200/150?random=13',
    views: '9.7K',
    duration: '8:40',
  ),
  VideoItem(
    id: 'v6',
    title: 'ការបណ្តុះបណ្តាលជំនាញថ្មីសម្រាប់យុវជន',
    thumbnailUrl: 'https://picsum.photos/200/150?random=14',
    views: '11.4K',
    duration: '9:10',
  ),
];

// Generate trending news from the first 30 news items
final List<TrendingNewsItem> trendingNewsItems = List.generate(30, (index) {
  final newsId = (index + 1).toString();
  final newsItem = newsItems.firstWhere((item) => item.id == newsId);
  
  final List<String> trendingStatuses = [
    'កំពុងល្បី',
    'កើនឡើង',
    'ពេញនិយម',
    'កំពុងលូតលាស់',
    'ទាក់ទាញ',
    'កំពុងពិភាក្សា',
    'ថ្មី',
    'ប្រជាប្រិយ',
  ];
  
  return TrendingNewsItem(
    id: 't${index + 1}',
    newsId: newsId,
    title: newsItem.title,
    category: newsItem.category,
    trendingStatus: trendingStatuses[index % trendingStatuses.length],
    views: '${(index + 10) * 1.3}K',
  );
});