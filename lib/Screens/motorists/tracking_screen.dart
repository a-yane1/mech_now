import 'package:flutter/material.dart';
import '../../app_theme.dart';
import 'home_screen.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _moveController;
  late Animation<Offset> _mechPosition;

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _mechPosition = Tween<Offset>(
      begin: const Offset(0.25, 0.35),
      end: const Offset(0.55, 0.6),
    ).animate(CurvedAnimation(
        parent: _moveController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _steps = [
    {'label': 'Requested', 'done': true, 'active': false},
    {'label': 'Accepted', 'done': true, 'active': false},
    {'label': 'En Route', 'done': false, 'active': true},
    {'label': 'Fixing', 'done': false, 'active': false},
    {'label': 'Done', 'done': false, 'active': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Map ──
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  // Map BG
                  Container(
                    color: AppColors.surface,
                    child: CustomPaint(
                      size: const Size(double.infinity, 300),
                      painter: _TrackingMapPainter(),
                    ),
                  ),

                  // Route dashes
                  CustomPaint(
                    size: const Size(double.infinity, 300),
                    painter: _RoutePainter(),
                  ),

                  // Moving mechanic
                  AnimatedBuilder(
                    animation: _mechPosition,
                    builder: (_, __) {
                      return Positioned(
                        left: _mechPosition.value.dx *
                            MediaQuery.of(context).size.width,
                        top: _mechPosition.value.dy * 300,
                        child: const Text('🚗',
                            style: TextStyle(fontSize: 28)),
                      );
                    },
                  ),

                  // User pin
                  const Positioned(
                    bottom: 55,
                    right: 60,
                    child: Text('📍', style: TextStyle(fontSize: 32)),
                  ),

                  // ETA badge
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            '8',
                            style: TextStyle(
                              fontFamily: 'Syne',
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                              color: AppColors.orange,
                              height: 1,
                            ),
                          ),
                          Text(
                            'min away',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDim,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Status badge
                  Positioned(
                    top: 16,
                    right: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.circle,
                              color: AppColors.green, size: 8),
                          SizedBox(width: 6),
                          Text(
                            'En Route',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable info ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Progress Steps
                    Row(
                      children: List.generate(_steps.length * 2 - 1, (i) {
                        if (i.isOdd) {
                          final prev = _steps[i ~/ 2];
                          return Expanded(
                            child: Container(
                              height: 2,
                              color: prev['done']
                                  ? AppColors.orange
                                  : AppColors.border,
                            ),
                          );
                        }
                        final step = _steps[i ~/ 2];
                        return Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: step['done']
                                    ? AppColors.orange
                                    : step['active']
                                    ? AppColors.orangeDim
                                    : AppColors.surface,
                                border: Border.all(
                                  color: step['done'] || step['active']
                                      ? AppColors.orange
                                      : AppColors.border,
                                ),
                              ),
                              child: Center(
                                child: step['done']
                                    ? const Icon(Icons.check,
                                    color: Colors.white, size: 14)
                                    : step['active']
                                    ? const Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.orange,
                                    size: 12)
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              step['label'],
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: step['done'] || step['active']
                                    ? AppColors.textPrimary
                                    : AppColors.textMuted,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 16),

                    // ── Mechanic Card ──
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.orange,
                                  Color(0xFFFF9A5C)
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Text('👨‍🔧',
                                  style: TextStyle(fontSize: 26)),
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Chukwuemeka B.',
                                  style: TextStyle(
                                    fontFamily: 'Syne',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Certified Auto Technician',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textDim),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '⭐⭐⭐⭐⭐  4.8 · 124 jobs',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textDim),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              _actionBtn(Icons.phone_outlined),
                              const SizedBox(width: 8),
                              _actionBtn(Icons.chat_bubble_outline),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // ── Job Summary ──
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'JOB SUMMARY',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textMuted,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...[
                            ['Service', 'Tyre Change'],
                            ['Location', 'Ozumba Mbadiwe, VI'],
                            ['Est. Cost', '₦3,500 – ₦5,000'],
                          ].map((row) => Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(row[0],
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textDim)),
                                Text(
                                  row[1],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: row[0] == 'Est. Cost'
                                        ? AppColors.orange
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Cancel
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                              const MotoristrHomeScreen()),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.red,
                          side: BorderSide(
                              color: AppColors.red.withOpacity(0.4)),
                        ),
                        child: const Text('Cancel Request'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(icon, color: AppColors.textDim, size: 18),
    );
  }
}

class _TrackingMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withOpacity(0.3)
      ..strokeWidth = 0.7;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    final roadPaint = Paint()
      ..color = AppColors.border.withOpacity(0.6)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(0, size.height * 0.65),
        Offset(size.width, size.height * 0.65),
        roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.4, 0),
        Offset(size.width * 0.4, size.height),
        roadPaint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.orange
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(size.width * 0.3, size.height * 0.4)
      ..lineTo(size.width * 0.4, size.height * 0.4)
      ..lineTo(size.width * 0.4, size.height * 0.65)
      ..lineTo(size.width * 0.72, size.height * 0.65);

    const dashWidth = 10.0;
    const dashSpace = 6.0;
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double dist = 0;
      while (dist < metric.length) {
        canvas.drawPath(
          metric.extractPath(dist, dist + dashWidth),
          paint,
        );
        dist += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
