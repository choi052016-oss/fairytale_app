import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _selectedTab = 0;

  List<Map<String, dynamic>> posts = [
    {
      'emoji': '🌸',
      'user': '별빛소녀_지아',
      'time': '2시간 전',
      'tag': '판타지',
      'storyEmoji': '🧚‍♀️',
      'title': '요정의 마법 정원 🌺',
      'preview': '작은 요정 소라가 황금 씨앗을 심어 마법의 정원을 만드는 이야기...',
      'likes': 142,
      'isLiked': false,
      'comments': 28,
      'views': '1.2k',
    },
    {
      'emoji': '🦊',
      'user': '용감한_도준',
      'time': '5시간 전',
      'tag': '모험',
      'storyEmoji': '🦊',
      'title': '여우 마법사의 비밀 🔮',
      'preview': '숲속에 사는 여우 마법사가 잃어버린 마법 책을 찾아 떠나는 모험...',
      'likes': 87,
      'isLiked': false,
      'comments': 15,
      'views': '856',
    },
  ];

  void _toggleLike(int index) {
    setState(() {
      if (posts[index]['isLiked']) {
        posts[index]['likes'] -= 1;
        posts[index]['isLiked'] = false;
      } else {
        posts[index]['likes'] += 1;
        posts[index]['isLiked'] = true;
      }
    });
  }

  Widget _buildTab(int index, String title) {
    bool isActive = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF7C3AED) : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedCard(int index) {
    final post = posts[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF160F38),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0x338B5CF6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF7C3AED),
                  child: Text(
                    post['emoji'],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['user'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        post['time'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x338B5CF6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    post['tag'],
                    style: const TextStyle(
                      color: Color(0xFFA78BFA),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 140,
            color: const Color(0xFF0D0520),
            alignment: Alignment.center,
            child: Text(
              post['storyEmoji'],
              style: const TextStyle(fontSize: 60),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  post['preview'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0x338B5CF6), height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _toggleLike(index),
                  child: Row(
                    children: [
                      Icon(
                        post['isLiked']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: post['isLiked']
                            ? const Color(0xFFEC4899)
                            : Colors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${post['likes']}',
                        style: TextStyle(
                          color: post['isLiked']
                              ? const Color(0xFFEC4899)
                              : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.grey,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  '${post['comments']}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const Spacer(),
                Text(
                  '조회 ${post['views']}',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
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
    return Scaffold(
      backgroundColor: const Color(0xFF06041A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF06041A),
        title: const Text(
          '커뮤니티',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                '✏️ 공유하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF160F38),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x338B5CF6)),
              ),
              child: Row(
                children: [
                  _buildTab(0, '최신'),
                  _buildTab(1, '인기'),
                  _buildTab(2, '팔로잉'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: posts.length,
              itemBuilder: (context, index) => _buildFeedCard(index),
            ),
          ),
        ],
      ),
    );
  }
}
