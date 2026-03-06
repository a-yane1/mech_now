import 'package:flutter/material.dart';
import 'package:mechnow/Screens/motorists/request_service_screen.dart';
import 'package:mechnow/Screens/motorists/service_history_screen.dart';
import 'package:mechnow/Screens/motorists/tracking_screen.dart';
import '../../app_theme.dart';
import '../../common_widgets.dart';
import '../profile_screen.dart';

class MotoristrHomeScreen extends StatefulWidget {
  const MotoristrHomeScreen({super.key});

  @override
  State<MotoristrHomeScreen> createState() => _MotoristrHomeScreenState();
}

class _MotoristrHomeScreenState extends State<MotoristrHomeScreen> {
  int _navIndex = 0;

  final List<Map<String, String>> _services = [
    {'icon': '🔋', 'name': 'Battery\nJump'},
    {'icon': '🛞', 'name': 'Tyre\nChange'},
    {'icon': '🌡️', 'name': 'Over-\nheating'},
    {'icon': '⚡', 'name': 'Electrical'},
    {'icon': '🔩', 'name': 'Engine'},
    {'icon': '💨', 'name': 'Fuel\nAssist'},
  ];

  final List<Map<String, dynamic>> _mechanics = [
    {
      'name': 'Chukwuemeka B.',
      'skill': 'Engine & Electrical',
      'dist': '1.2 km',
      'rating': '4.8',
      'jobs': '124',
      'available': true,
      'emoji': '👨‍🔧',
    },
    {
      'name': 'Fatima Abubakar',
      'skill': 'Tyre & Battery',
      'dist': '2.7 km',
      'rating': '4.6',
      'jobs': '87',
      'available': false,
      'emoji': '👩‍🔧',
    },
    {
      'name': 'Emeka Nwosu',
      'skill': 'General Auto',
      'dist': '3.1 km',
      'rating': '4.5',
      'jobs': '63',
      'available': true,
      'emoji': '👨‍🔧',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good morning 👋',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.textDim),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Ada Okonkwo',
                          style: TextStyle(
                            fontFamily: 'Syne',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    // Avatar
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfileScreen())),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [AppColors.orange, Color(0xFFFF9A5C)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'AO',
                            style: TextStyle(
                                fontFamily: 'Syne',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Map Placeholder ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _MapPlaceholder(),
              ),

              // ── SOS / Quick Help Banner ──
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const RequestServiceScreen()),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.orange,
                          AppColors.orange.withOpacity(0.7)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.orange.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('🆘',
                                style: TextStyle(fontSize: 22)),
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Need help now?',
                                style: TextStyle(
                                  fontFamily: 'Syne',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Tap to request a mechanic immediately',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Services ──
              SectionHeader(
                title: 'Services',
                action: 'See all',
                onAction: () {},
              ),
              SizedBox(
                height: 108,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: _services.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, i) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RequestServiceScreen(
                              preselectedService: _services[i]['name']!)),
                    ),
                    child: Container(
                      width: 82,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_services[i]['icon']!,
                              style: const TextStyle(fontSize: 26)),
                          const SizedBox(height: 6),
                          Text(
                            _services[i]['name']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDim,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ── Nearby Mechanics ──
              SectionHeader(
                title: 'Nearby Mechanics',
                action: 'View map',
                onAction: () {},
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _mechanics.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final m = _mechanics[i];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TrackingScreen()),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppColors.surface2,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(m['emoji'],
                                  style: const TextStyle(fontSize: 22)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  m['skill'],
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textDim),
                                ),
                                const SizedBox(height: 5),
                                AvailabilityBadge(available: m['available']),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                m['dist'],
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.orange),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '⭐ ${m['rating']} (${m['jobs']})',
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textDim),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      // ── Bottom Nav ──
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(0, '🏠', 'Home'),
            _navItem(1, '🔧', 'Request', onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const RequestServiceScreen()),
            )),
            _navItem(2, '📋', 'History', onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ServiceHistoryScreen()),
            )),
            _navItem(3, '👤', 'Profile', onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            )),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index, String icon, String label,
      {VoidCallback? onTap}) {
    final active = _navIndex == index;
    return GestureDetector(
      onTap: onTap ?? () => setState(() => _navIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: active ? AppColors.orange : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Map Placeholder Widget ────────────────────────────────────────
class _MapPlaceholder extends StatefulWidget {
  @override
  State<_MapPlaceholder> createState() => _MapPlaceholderState();
}

class _MapPlaceholderState extends State<_MapPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
    _pulseAnim = Tween<double>(begin: 0, end: 1).animate(_pulse);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Grid lines
          CustomPaint(
            size: const Size(double.infinity, 180),
            painter: _GridPainter(),
          ),
          // SVG-style roads
          CustomPaint(
            size: const Size(double.infinity, 180),
            painter: _RoadPainter(),
          ),
          // Pulse ring
          Center(
            child: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (_, __) => Transform.scale(
                scale: 1 + _pulseAnim.value * 1.5,
                child: Opacity(
                  opacity: (1 - _pulseAnim.value).clamp(0, 1),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.orange.withOpacity(0.25),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Pin
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('📍', style: TextStyle(fontSize: 30)),
                SizedBox(height: 30),
              ],
            ),
          ),
          // Mechanic dots
          const Positioned(
              top: 55, left: 68,
              child: _MechanicDot()),
          const Positioned(
              bottom: 48, right: 72,
              child: _MechanicDot()),
          const Positioned(
              top: 28, right: 100,
              child: _MechanicDot()),
          // Bottom label
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  Icon(Icons.circle, color: AppColors.green, size: 8),
                  SizedBox(width: 6),
                  Text(
                    '3 mechanics nearby',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MechanicDot extends StatelessWidget {
  const _MechanicDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: AppColors.green,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.bg, width: 2),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withOpacity(0.4)
      ..strokeWidth = 0.8;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withOpacity(0.7)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(0, size.height * 0.6),
        Offset(size.width, size.height * 0.6),
        paint);
    canvas.drawLine(
        Offset(size.width * 0.45, 0),
        Offset(size.width * 0.45, size.height),
        paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
