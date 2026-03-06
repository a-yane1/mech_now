import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../../common_widgets.dart';
import '../motorists/service_history_screen.dart';
import '../motorists/tracking_screen.dart';
import '../profile_screen.dart';


class MechHomeScreen extends StatefulWidget {
  const MechHomeScreen({super.key});

  @override
  State<MechHomeScreen> createState() => _MechHomeScreenState();
}

class _MechHomeScreenState extends State<MechHomeScreen> {
  bool _isOnline = true;
  bool _jobVisible = true;

  final _recentJobs = [
    {
      'icon': '🔋',
      'title': 'Battery Jump — Lekki Phase 1',
      'sub': 'Today · 8:15 AM · Bola A.',
      'amount': '+₦2,500',
    },
    {
      'icon': '⚡',
      'title': 'Electrical Fault — Ikeja',
      'sub': 'Yesterday · 4:30 PM · Tunde O.',
      'amount': '+₦7,000',
    },
    {
      'icon': '🛞',
      'title': 'Tyre Change — Surulere',
      'sub': 'Feb 26 · 2:00 PM · Chioma N.',
      'amount': '+₦4,200',
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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ready to work 🔧',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.textDim),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Chukwuemeka B.',
                          style: TextStyle(
                            fontFamily: 'Syne',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    // Online Toggle
                    GestureDetector(
                      onTap: () => setState(() => _isOnline = !_isOnline),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _isOnline
                                ? AppColors.green.withOpacity(0.5)
                                : AppColors.border,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _isOnline
                                    ? AppColors.green
                                    : AppColors.textMuted,
                              ),
                              child: const Center(
                                child: Text('✓',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isOnline ? 'Online' : 'Offline',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: _isOnline
                                    ? AppColors.green
                                    : AppColors.textDim,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // ── Stats ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Expanded(
                        child: StatCard(
                            icon: '💼', value: '124', label: 'Total Jobs')),
                    SizedBox(width: 10),
                    Expanded(
                        child: StatCard(
                            icon: '⭐', value: '4.8', label: 'Rating')),
                    SizedBox(width: 10),
                    Expanded(
                        child: StatCard(
                            icon: '💰', value: '₦48k', label: 'This Month')),
                  ],
                ),
              ),
              const SizedBox(height: 6),

              // ── Incoming Job ──
              if (_jobVisible) ...[
                SectionHeader(
                  title: '⚡ New Job Request',
                  action: '1 pending',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _JobRequestCard(
                    onAccept: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TrackingScreen()),),
                    onDecline: () => setState(() => _jobVisible = false),
                  ),
                ),
              ],

              // ── Recent Jobs ──
              SectionHeader(
                title: 'Recent Jobs',
                action: 'View all',
                onAction: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ServiceHistoryScreen()),
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _recentJobs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final j = _recentJobs[i];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Text(j['icon']!,
                            style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(j['title']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                              const SizedBox(height: 2),
                              Text(j['sub']!,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textDim)),
                            ],
                          ),
                        ),
                        Text(
                          j['amount']!,
                          style: const TextStyle(
                            fontFamily: 'Syne',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.green,
                          ),
                        ),
                      ],
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
            _navItem('🏠', 'Home', active: true),
            _navItem('🗺️', 'Map'),
            _navItem('📋', 'Jobs', onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ServiceHistoryScreen()),
            )),
            _navItem('👤', 'Profile', onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            )),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String icon, String label,
      {bool active = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
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

// ── Job Request Card ─────────────────────────────────────────────
class _JobRequestCard extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _JobRequestCard(
      {required this.onAccept, required this.onDecline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.orange, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.orangeDim,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '🛞  Tyre Change',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  ),
                ),
              ),
              const Text(
                '1.2 km away',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDim),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Description
          const Text(
            'Flat tyre — needs immediate help',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.location_on_outlined,
                  color: AppColors.textDim, size: 14),
              SizedBox(width: 4),
              Text(
                'Ozumba Mbadiwe Ave, Victoria Island',
                style: TextStyle(fontSize: 12, color: AppColors.textDim),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Client info
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF5B8DEF), Color(0xFF9B5BEF)],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'AO',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ada Okonkwo',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                      Text('Toyota Camry 2019 · Silver',
                          style: TextStyle(
                              fontSize: 11, color: AppColors.textDim)),
                    ],
                  ),
                ),
                const Text(
                  '2 min ago',
                  style: TextStyle(
                      fontSize: 11, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Buttons
          Row(
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: onDecline,
                  child: const Text('Decline'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: onAccept,
                  child: const Text('✓  Accept Job'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
