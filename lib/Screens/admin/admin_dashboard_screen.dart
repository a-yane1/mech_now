import 'package:flutter/material.dart';
import '../../app_theme.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _tab = 0; // 0=Overview, 1=Mechanics, 2=Requests

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
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
                        'ADMIN PANEL',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.orange,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'MechNow Control',
                        style: TextStyle(
                          fontFamily: 'Syne',
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Center(
                      child: Text('🛡️', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Tab Bar ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    _tab('Overview', 0),
                    _tab('Mechanics', 1),
                    _tab('Requests', 2),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),

            // ── Content ──
            Expanded(
              child: _tab == 0
                  ? _OverviewTab()
                  : _tab == 1
                  ? _MechanicsTab()
                  : _RequestsTab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String label, int index) {
    final active = _tab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? AppColors.orange : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: active ? Colors.white : AppColors.textDim,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Overview Tab ─────────────────────────────────────────────────
class _OverviewTab extends StatelessWidget {
  final _stats = const [
    {'icon': '👥', 'val': '2,410', 'lbl': 'Total Users'},
    {'icon': '🔧', 'val': '183', 'lbl': 'Mechanics'},
    {'icon': '📋', 'val': '1,204', 'lbl': 'Jobs Done'},
    {'icon': '💰', 'val': '₦4.2M', 'lbl': 'Platform Revenue'},
    {'icon': '⭐', 'val': '4.7', 'lbl': 'Avg Rating'},
    {'icon': '🟢', 'val': '47', 'lbl': 'Online Now'},
  ];

  final _recentActivity = const [
    {
      'icon': '✅',
      'text': 'New mechanic registered',
      'sub': 'Yusuf Bello · 2m ago',
      'color': 0xFF2ECC71,
    },
    {
      'icon': '🆘',
      'text': 'Job request in Lekki',
      'sub': 'Ada Okonkwo · 5m ago',
      'color': 0xFFFF6B2C,
    },
    {
      'icon': '⚠️',
      'text': 'Mechanic flagged for review',
      'sub': 'Benson A. · 18m ago',
      'color': 0xFFFFCC00,
    },
    {
      'icon': '✅',
      'text': 'Job completed — rated 5★',
      'sub': 'Chukwuemeka B. · 22m ago',
      'color': 0xFF2ECC71,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats grid
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _stats.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (_, i) {
              final s = _stats[i];
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(s['icon']!,
                        style: const TextStyle(fontSize: 22)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s['val']!,
                          style: const TextStyle(
                            fontFamily: 'Syne',
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                            color: AppColors.orange,
                          ),
                        ),
                        Text(
                          s['lbl']!.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDim,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          const Text(
            'RECENT ACTIVITY',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.textDim,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          ...(_recentActivity.map((a) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color:
                      Color(a['color'] as int).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(a['icon'] as String,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a['text'] as String,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                        Text(a['sub'] as String,
                            style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textDim)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ))),
        ],
      ),
    );
  }
}

// ── Mechanics Tab ─────────────────────────────────────────────────
class _MechanicsTab extends StatelessWidget {
  final _mechanics = const [
    {
      'name': 'Chukwuemeka Bello',
      'specialty': 'Engine & Electrical',
      'jobs': '124',
      'rating': '4.8',
      'status': 'verified',
      'online': true,
    },
    {
      'name': 'Fatima Abubakar',
      'specialty': 'Tyre & Battery',
      'jobs': '87',
      'rating': '4.6',
      'status': 'verified',
      'online': false,
    },
    {
      'name': 'Yusuf Bello',
      'specialty': 'General Auto',
      'jobs': '3',
      'rating': 'N/A',
      'status': 'pending',
      'online': false,
    },
    {
      'name': 'Benson Adeyemi',
      'specialty': 'Electrical',
      'jobs': '52',
      'rating': '3.9',
      'status': 'flagged',
      'online': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: _mechanics.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final m = _mechanics[i];
        final statusColor = m['status'] == 'verified'
            ? AppColors.green
            : m['status'] == 'pending'
            ? const Color(0xFFFFCC00)
            : AppColors.red;

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Center(
                      child: Text('👨‍🔧',
                          style: TextStyle(fontSize: 22)),
                    ),
                  ),
                  if (m['online'] as bool)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.surface, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m['name'] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    Text(m['specialty'] as String,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textDim)),
                    const SizedBox(height: 4),
                    Text(
                      '${m['jobs']} jobs · ⭐ ${m['rating']}',
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textDim),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      (m['status'] as String).toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: statusColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (m['status'] == 'pending')
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.orangeDim,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Review',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.orange),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Requests Tab ─────────────────────────────────────────────────
class _RequestsTab extends StatelessWidget {
  final _requests = const [
    {
      'service': '🛞 Tyre Change',
      'user': 'Ada Okonkwo',
      'location': 'Ozumba Mbadiwe, VI',
      'mechanic': 'Chukwuemeka B.',
      'status': 'active',
      'time': '9:47 AM',
    },
    {
      'service': '🔋 Battery Jump',
      'user': 'Tunde Okafor',
      'location': 'Adeola Odeku, VI',
      'mechanic': 'Unassigned',
      'status': 'searching',
      'time': '9:50 AM',
    },
    {
      'service': '⚡ Electrical',
      'user': 'Ngozi Eze',
      'location': 'Allen Ave, Ikeja',
      'mechanic': 'Emeka Nwosu',
      'status': 'completed',
      'time': '9:01 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: _requests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final r = _requests[i];
        final statusColor = r['status'] == 'active'
            ? AppColors.orange
            : r['status'] == 'searching'
            ? const Color(0xFFFFCC00)
            : AppColors.green;

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: r['status'] == 'active'
                  ? AppColors.orange.withOpacity(0.4)
                  : AppColors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(r['service'] as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        (r['status'] as String).toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${r['user']} · ${r['location']}',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textDim),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text('🔧',
                      style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 4),
                  Text(r['mechanic'] as String,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textDim)),
                  const Spacer(),
                  Text(r['time'] as String,
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
