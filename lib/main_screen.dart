import 'package:flutter/material.dart';
import 'create_page.dart';
import 'story_page.dart';
import 'vocab_page.dart';
import 'community_page.dart';
import 'psych_page.dart';
import 'profile_page.dart';

// --- 데이터 모델 ---
class StoryModel {
  final String id;
  final String emoji;
  final String title;
  final String tag;

  StoryModel({
    required this.id,
    required this.emoji,
    required this.title,
    required this.tag,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['_id'] ?? 'unknown_id',
      emoji: json['emoji'] ?? '📖',
      title: json['title'] ?? '제목 없음',
      tag: json['tag'] ?? '일반',
    );
  }
}

final List<Map<String, dynamic>> mockMongoStories = [
  {"_id": "65f9a1b2_001", "emoji": "🐉", "title": "용감한 꼬마 드래곤", "tag": "모험"},
  {"_id": "65f9a1b2_002", "emoji": "🚀", "title": "우주로 간 토끼", "tag": "SF"},
  {"_id": "65f9a1b2_003", "emoji": "🦊", "title": "여우 마법사의 비밀", "tag": "판타지"},
  {"_id": "65f9a1b2_004", "emoji": "👑", "title": "황금 사과를 찾아서", "tag": "전래동화"},
  {"_id": "65f9a1b2_005", "emoji": "🧜‍♀️", "title": "바다 탐험대", "tag": "모험"},
];

// --- 하단 네비게이션 바 화면 ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CommunityPage(),
    const CreatePage(),
    const VocabPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0x338B5CF6))),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF08061A),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFA78BFA),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: '탐색',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, size: 36, color: Color(0xFFEC4899)),
              label: '만들기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              activeIcon: Icon(Icons.menu_book),
              label: '단어장',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '프로필',
            ),
          ],
        ),
      ),
    );
  }
}

// --- 홈 화면 ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String userName = "choi";
  final ScrollController _recommendScrollController = ScrollController();
  late List<StoryModel> displayStories;

  @override
  void initState() {
    super.initState();
    displayStories = mockMongoStories
        .map((json) => StoryModel.fromJson(json))
        .toList();
  }

  @override
  void dispose() {
    _recommendScrollController.dispose();
    super.dispose();
  }

  Widget _buildMenuCard(
    String title,
    Color color,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: const Color(0xFF160F38),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryCard(StoryModel story) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1645),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0x338B5CF6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0D0520),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            alignment: Alignment.center,
            child: Text(story.emoji, style: const TextStyle(fontSize: 45)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x338B5CF6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    story.tag,
                    style: const TextStyle(
                      color: Color(0xFFA78BFA),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  story.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '안녕하세요, $userName님 👋',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '동화 AI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildMenuCard(
                          '새 동화 만들기',
                          const Color(0xFF7C3AED),
                          Icons.auto_stories,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreatePage(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMenuCard(
                          '내 단어장',
                          const Color(0xFF14B8A6),
                          Icons.spellcheck,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VocabPage(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '🌟 오늘의 추천 동화',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Scrollbar(
              controller: _recommendScrollController,
              thumbVisibility: true,
              thickness: 4,
              radius: const Radius.circular(10),
              child: SingleChildScrollView(
                controller: _recommendScrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                child: Row(
                  children: displayStories
                      .map((story) => _buildStoryCard(story))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
