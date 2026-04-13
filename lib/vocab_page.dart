import 'package:flutter/material.dart';

class VocabPage extends StatefulWidget {
  const VocabPage({super.key});

  @override
  State<VocabPage> createState() => _VocabPageState();
}

class _VocabPageState extends State<VocabPage> {
  // 💡 1. DB에서 불러올 단어 리스트 데이터의 형태
  List<Map<String, dynamic>> allVocabs = [
    {
      'id': 1,
      'easy': '노닐다',
      'hard': '유희(遊戲)하다',
      'def': '즐겁게 놀면서 돌아다니다. 마음껏 즐기며 놀다.',
      'story': '작은 요정 이야기',
    },
    {
      'id': 2,
      'easy': '가시덤불',
      'hard': '형극총(荊棘叢)',
      'def': '가시가 많은 나무나 풀이 엉켜 자란 수풀.',
      'story': '작은 요정 이야기',
    },
    {
      'id': 3,
      'easy': '용감하게',
      'hard': '씩씩하게',
      'def': '겁내지 않고 씩씩하고 대담하게.',
      'story': '용의 왕국',
    },
    {
      'id': 4,
      'easy': '깜깜한',
      'hard': '칠흑(漆黑)같은',
      'def': '매우 어둡고 캄캄한 상태.',
      'story': '밤하늘의 별빛',
    },
    {
      'id': 5,
      'easy': '반짝이다',
      'hard': '명멸(明滅)하다',
      'def': '빛이 잠깐 나타났다가 사라지기를 반복하다.',
      'story': '밤하늘의 별빛',
    },
  ];

  List<Map<String, dynamic>> filteredVocabs = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredVocabs = List.from(allVocabs); // 처음엔 전체 데이터를 다 보여줌
  }

  void _filterWords(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredVocabs = List.from(allVocabs);
      } else {
        filteredVocabs = allVocabs
            .where(
              (v) =>
                  v['easy'].toString().contains(query) ||
                  v['hard'].toString().contains(query) ||
                  v['def'].toString().contains(query),
            )
            .toList();
      }
    });
  }

  void _deleteWord(int id) {
    setState(() {
      allVocabs.removeWhere((v) => v['id'] == id);
      _filterWords(_searchController.text);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('단어가 삭제되었습니다 🗑️'),
        backgroundColor: Color(0xFFEC4899),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Widget _buildVocabItem(Map<String, dynamic> vocab, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF160F38),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x338B5CF6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0x338B5CF6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Color(0xFFA78BFA),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      vocab['easy'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('→', style: TextStyle(color: Colors.grey)),
                    ),
                    Text(
                      vocab['hard'],
                      style: const TextStyle(
                        color: Color(0xFFA78BFA),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  vocab['def'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '📖 ${vocab['story']} 에서 저장됨',
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _deleteWord(vocab['id']),
            child: const Icon(Icons.close, color: Colors.grey, size: 20),
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
          '📚 내 단어장',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0x268B5CF6), Color(0x1AEC4899)],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0x338B5CF6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '${allVocabs.length}',
                        style: const TextStyle(
                          color: Color(0xFFA78BFA),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '저장된 단어',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      Text(
                        '8',
                        style: TextStyle(
                          color: Color(0xFFA78BFA),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '오늘 복습',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      Text(
                        '95%',
                        style: TextStyle(
                          color: Color(0xFFA78BFA),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '암기율',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF160F38),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0x338B5CF6)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterWords,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey, size: 18),
                  hintText: '단어 검색...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: filteredVocabs.isEmpty
                  ? const Center(
                      child: Text(
                        '단어가 없습니다.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredVocabs.length,
                      itemBuilder: (context, index) {
                        return _buildVocabItem(filteredVocabs[index], index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
