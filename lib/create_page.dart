import 'package:flutter/material.dart';
import 'story_page.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String selectedGenre = '판타지';
  String selectedAge = '5-7세';
  final TextEditingController _heroController = TextEditingController();
  bool isGenerating = false;

  Widget _buildGenreChip(String label) {
    bool isSelected = selectedGenre == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGenre = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7C3AED) : const Color(0xFF160F38),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF7C3AED)
                : const Color(0x338B5CF6),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFFA78BFA),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF06041A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF06041A),
        elevation: 0,
        title: const Text(
          '새 동화 만들기',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '어떤 이야기를 원하시나요?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              '장르 선택',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildGenreChip('판타지'),
                  _buildGenreChip('모험'),
                  _buildGenreChip('SF'),
                  _buildGenreChip('일상'),
                  _buildGenreChip('전래동화'),
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              '주인공 설정',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF160F38),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0x338B5CF6)),
              ),
              child: TextField(
                controller: _heroController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '예: 용감한 꼬마 마법사',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              '아이 연령대 (어휘 수준 조절)',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF160F38),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0x338B5CF6)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedAge,
                  dropdownColor: const Color(0xFF160F38),
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white),
                  items: <String>['3-4세', '5-7세', '8-10세'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedAge = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: isGenerating
                    ? null
                    : () async {
                        if (_heroController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('주인공 이름을 입력해주세요!'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        setState(() => isGenerating = true);

                        print(
                          '🚀 서버로 데이터 전송 중... (장르: $selectedGenre, 주인공: ${_heroController.text}, 연령: $selectedAge)',
                        );

                        await Future.delayed(const Duration(seconds: 2));

                        if (mounted) {
                          setState(() => isGenerating = false);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StoryPage(),
                            ),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: isGenerating
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        '동화 생성하기 ✨',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
