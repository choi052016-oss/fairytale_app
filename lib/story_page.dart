import 'package:flutter/material.dart';
import 'dart:math';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with TickerProviderStateMixin {
  bool isPlaying = false;
  List<String> storyLogs = [];
  bool showNewChoices = false;
  late AnimationController _animController;
  final Random _random = Random();
  final TextEditingController _customInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _customInputController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _animController.repeat(reverse: true);
      } else {
        _animController.stop();
      }
    });
  }

  void _showVocabModal(
    BuildContext context,
    String easy,
    String hard,
    String def,
    String ex,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        bool isSaved = false;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1645),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                border: Border(
                  top: BorderSide(color: Color(0x408B5CF6), width: 1),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        easy,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '→',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFA78BFA),
                          ),
                        ),
                      ),
                      Text(
                        hard,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA78BFA),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    def,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0x1A8B5CF6),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border(
                        left: BorderSide(color: Color(0xFF8B5CF6), width: 3),
                      ),
                    ),
                    child: Text(
                      '예문: $ex',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setModalState(() => isSaved = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('📚 단어장에 저장되었어요!'),
                            backgroundColor: Color(0xFF7C3AED),
                          ),
                        );
                        Future.delayed(
                          const Duration(seconds: 1),
                          () => Navigator.pop(context),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSaved
                            ? const Color(0xFF059669)
                            : const Color(0xFF7C3AED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: Icon(
                        isSaved ? Icons.check : Icons.bookmark_add,
                        color: Colors.white,
                      ),
                      label: Text(
                        isSaved ? '저장되었어요!' : '단어장에 저장하기',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _makeChoice(int index) {
    setState(() {
      if (index == 1) {
        storyLogs.add(
          '[마법 지팡이로 구출]\n\n마법 지팡이를 휘두르자 눈부신 빛이 쏟아지며 가시덤불이 사라졌어요! 릴리는 개구리 친구들을 구할 수 있었어요. 🌸✨',
        );
      } else if (index == 2) {
        storyLogs.add('[나비와 함께 구출]\n\n나비 친구들이 힘을 합쳐 가시덤불을 서서히 밀어냈어요! 🦋💜');
      }
      showNewChoices = true;
    });
  }

  void _makeCustomChoice() {
    if (_customInputController.text.trim().isEmpty) return;
    setState(() {
      storyLogs.add(
        '[직접 행동하기]\n\n"${_customInputController.text}"\n새로운 이야기가 마법처럼 펼쳐집니다! ✨',
      );
      _customInputController.clear();
      showNewChoices = true;
    });
  }

  Widget _buildChoiceBtn(String emoji, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1645),
            border: Border.all(color: const Color(0x338B5CF6)),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A8B5CF6),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0x338B5CF6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(emoji, style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF06041A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: const Color(0xFF06041A),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1a0d40), Color(0xFF0d0520)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Text('🧚‍♀️', style: TextStyle(fontSize: 100)),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border, color: Colors.white),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '⏱ 읽기 4분 · 판타지',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '작은 요정 이야기',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF160F38),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0x338B5CF6)),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _togglePlay,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _animController,
                            builder: (context, child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(20, (index) {
                                  double height = 4.0;
                                  if (isPlaying) {
                                    height = 4.0 + _random.nextDouble() * 16.0;
                                  }
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    width: 3,
                                    height: height,
                                    decoration: BoxDecoration(
                                      color: isPlaying
                                          ? const Color(0xFFA78BFA)
                                          : const Color(
                                              0xFF8B5CF6,
                                            ).withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x268B5CF6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '1.0x',
                            style: TextStyle(
                              color: Color(0xFFA78BFA),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    children: [
                      const Text(
                        '옛날 옛적에, 마법의 숲속에 ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.8,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showVocabModal(
                          context,
                          '작은',
                          '소(小)의',
                          '크기가 크지 않은. 규모나 양이 많지 않은 상태.',
                          '"릴리는 작은(소小의) 체구를 가진 요정이었어요."',
                        ),
                        child: const Text(
                          '작은',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFC4B5FD),
                            decoration: TextDecoration.underline,
                            height: 1.8,
                          ),
                        ),
                      ),
                      const Text(
                        ' 요정 릴리가 살고 있었어요. 릴리는 반짝이는 날개를 가지고 있었고, 숲속의 모든 동물 친구들과 함께 ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.8,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showVocabModal(
                          context,
                          '노닐다',
                          '유희하다',
                          '즐겁게 놀면서 돌아다니다.',
                          '"릴리는 숲속을 자유롭게 노닐며 하루를 보냈어요."',
                        ),
                        child: const Text(
                          '노닐며',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFC4B5FD),
                            decoration: TextDecoration.underline,
                            height: 1.8,
                          ),
                        ),
                      ),
                      const Text(
                        ' 살았답니다.\n\n어느 날, 커다란 소리를 듣고 가보니 개구리 친구들이 ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.8,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showVocabModal(
                          context,
                          '가시덤불',
                          '형극총(荊棘叢)',
                          '가시가 많은 나무나 풀이 엉켜 자란 수풀.',
                          '"개구리들이 가시덤불 속에 갇히고 말았어요."',
                        ),
                        child: const Text(
                          '가시덤불',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFC4B5FD),
                            decoration: TextDecoration.underline,
                            height: 1.8,
                          ),
                        ),
                      ),
                      const Text(
                        '에 갇혀 있었어요!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                  for (var log in storyLogs) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0x1A8B5CF6),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        border: Border(
                          left: BorderSide(color: Color(0xFF8B5CF6), width: 4),
                        ),
                      ),
                      child: Text(
                        log,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.8,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      '🎭 다음 이야기를 이어가세요',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (!showNewChoices) ...[
                    _buildChoiceBtn(
                      '🌸',
                      '마법 지팡이로 가시덤불을 없앤다',
                      () => _makeChoice(1),
                    ),
                    _buildChoiceBtn(
                      '🦋',
                      '나비 친구들에게 도움을 요청한다',
                      () => _makeChoice(2),
                    ),
                  ] else ...[
                    _buildChoiceBtn('🌙', '마법의 열매를 찾아 개구리를 치료한다', () {}),
                    _buildChoiceBtn('🏰', '요정 여왕에게 도움을 청하러 간다', () {}),
                  ],
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF160F38),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0x338B5CF6)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _customInputController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: '직접 상상한 행동을 입력해 보세요!',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Color(0xFFEC4899),
                          ),
                          onPressed: _makeCustomChoice,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
