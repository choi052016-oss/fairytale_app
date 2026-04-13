import 'package:flutter/material.dart';
import 'dart:math';

class PsychPage extends StatelessWidget {
  const PsychPage({super.key});

  Widget _buildStatBar(
    String icon,
    String label,
    String pct,
    double width,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$icon $label',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                pct,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: width,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
    String icon,
    String story,
    String choice,
    String tag,
    Color tagBg,
    Color tagColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  choice,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: tagBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: tagColor,
                    ),
                  ),
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
          '🧠 심리 분석',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '최근 30일',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                Text(
                  '선택 42회',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            '민준이의 선택 패턴 분석',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF5B21B6), Color(0x66EC4899)],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Text('🦁', style: TextStyle(fontSize: 40)),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '용감한 탐험가 유형',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '새로운 것을 두려워하지 않고 도전을 즐기는 성격이에요. 친구들을 잘 도와주는 따뜻한 마음도 가지고 있어요!',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0x1A8B5CF6),
              border: Border.all(color: const Color(0x408B5CF6)),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '📊 성격 특성',
                  style: TextStyle(
                    color: Color(0xFFA78BFA),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildStatBar(
                  '🌟',
                  '모험적',
                  '88%',
                  0.88,
                  const Color(0xFFA78BFA),
                ),
                _buildStatBar(
                  '💝',
                  '친절함',
                  '75%',
                  0.75,
                  const Color(0xFFEC4899),
                ),
                _buildStatBar(
                  '🔥',
                  '용감함',
                  '82%',
                  0.82,
                  const Color(0xFFF59E0B),
                ),
                _buildStatBar(
                  '🎨',
                  '창의적',
                  '70%',
                  0.70,
                  const Color(0xFF14B8A6),
                ),
                _buildStatBar(
                  '🤝',
                  '협동심',
                  '65%',
                  0.65,
                  const Color(0xFF0EA5E9),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF160F38),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0x338B5CF6)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CustomPaint(painter: RadarChartPainter()),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF8B5CF6),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '현재',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '모험과 용기 지수가\n특히 높아요! 🌟\n\n친구와의 협동 능력도\n꾸준히 성장 중이에요.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '📝 최근 선택 기록',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          _buildHistoryItem(
            '🧚',
            '작은 요정 이야기',
            '마법 지팡이로 친구를 구해준다',
            '친절함 +5',
            const Color(0x338B5CF6),
            const Color(0xFFA78BFA),
          ),
          _buildHistoryItem(
            '🐉',
            '용의 왕국',
            '혼자서 용감하게 성에 들어간다',
            '용감함 +8',
            const Color(0x33FBBF24),
            const Color(0xFFFCD34D),
          ),
          _buildHistoryItem(
            '🦊',
            '여우 마법사',
            '새로운 마법을 발명해서 해결한다',
            '창의적 +6',
            const Color(0x3314B8A6),
            const Color(0xFF34D399),
          ),
        ],
      ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.5;

    final bgPaint = Paint()
      ..color = const Color(0x338B5CF6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final fillPaint = Paint()
      ..color = const Color(0x408B5CF6)
      ..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..color = const Color(0xFF8B5CF6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final dotPaint = Paint()
      ..color = const Color(0xFFA78BFA)
      ..style = PaintingStyle.fill;

    Path buildPolygon(double scale) {
      final path = Path();
      for (int i = 0; i < 5; i++) {
        final angle = (i * 2 * pi / 5) - pi / 2;
        final x = center.dx + radius * scale * cos(angle);
        final y = center.dy + radius * scale * sin(angle);
        if (i == 0)
          path.moveTo(x, y);
        else
          path.lineTo(x, y);
      }
      path.close();
      return path;
    }

    canvas.drawPath(buildPolygon(1.0), bgPaint);
    canvas.drawPath(buildPolygon(0.7), bgPaint);
    canvas.drawPath(buildPolygon(0.4), bgPaint);

    final values = [0.9, 0.8, 0.6, 0.75, 0.85];
    final valuePath = Path();
    final points = <Offset>[];

    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * pi / 5) - pi / 2;
      final x = center.dx + radius * values[i] * cos(angle);
      final y = center.dy + radius * values[i] * sin(angle);
      points.add(Offset(x, y));
      if (i == 0)
        valuePath.moveTo(x, y);
      else
        valuePath.lineTo(x, y);
    }
    valuePath.close();

    canvas.drawPath(valuePath, fillPaint);
    canvas.drawPath(valuePath, linePaint);
    for (var point in points) {
      canvas.drawCircle(point, 3, dotPaint);
    }

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final labels = ['모험', '용기', '창의', '친절', '협동'];
    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * pi / 5) - pi / 2;
      final x = center.dx + (radius + 12) * cos(angle);
      final y = center.dy + (radius + 12) * sin(angle);

      textPainter.text = TextSpan(
        text: labels[i],
        style: const TextStyle(color: Colors.white70, fontSize: 9),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
