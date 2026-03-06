import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../../common_widgets.dart';
import 'tracking_screen.dart';

class RequestServiceScreen extends StatefulWidget {
  final String? preselectedService;
  const RequestServiceScreen({super.key, this.preselectedService});

  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  int _selected = 0;
  bool _searching = false;
  final _descController = TextEditingController();

  final List<Map<String, String>> _services = [
    {'icon': '🛞', 'name': 'Tyre Change', 'desc': 'Flat or burst tyre'},
    {'icon': '🔋', 'name': 'Battery Jump', 'desc': 'Dead battery start'},
    {'icon': '🌡️', 'name': 'Overheating', 'desc': 'Engine overheat'},
    {'icon': '⚡', 'name': 'Electrical', 'desc': 'Wiring & electrics'},
    {'icon': '🔩', 'name': 'Engine', 'desc': 'Engine trouble'},
    {'icon': '💨', 'name': 'Fuel Assist', 'desc': 'Out of fuel'},
  ];

  void _findMechanic() async {
    setState(() => _searching = true);
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const TrackingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Request Service'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),

                    // ── Section title ──
                    const Text(
                      'SELECT ISSUE TYPE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDim,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ── Service Grid ──
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _services.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.55,
                      ),
                      itemBuilder: (_, i) {
                        final s = _services[i];
                        final active = _selected == i;
                        return GestureDetector(
                          onTap: () => setState(() => _selected = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: active
                                  ? AppColors.orangeDim
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: active
                                    ? AppColors.orange
                                    : AppColors.border,
                                width: active ? 1.5 : 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(s['icon']!,
                                    style:
                                    const TextStyle(fontSize: 24)),
                                const Spacer(),
                                Text(
                                  s['name']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: active
                                        ? AppColors.orange
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  s['desc']!,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textDim),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // ── Description ──
                    AppTextField(
                      label: 'Describe the problem',
                      hint:
                      'e.g. Left rear tyre completely flat on Third Mainland Bridge...',
                      controller: _descController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),

                    // ── Location Box ──
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Text('📍',
                              style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'YOUR LOCATION',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textDim,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'Ozumba Mbadiwe Ave, VI',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '✓ GPS accurate to 8m',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.green),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: AppColors.orange),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Searching indicator ──
                    if (_searching) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 36,
                              height: 36,
                              child: CircularProgressIndicator(
                                color: AppColors.orange,
                                strokeWidth: 3,
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Finding mechanics...',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Searching within 2km radius',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textDim),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ── Bottom CTA ──
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: PrimaryButton(
                label: _searching
                    ? 'Searching...'
                    : 'Find Nearest Mechanic',
                isLoading: _searching,
                onTap: _searching ? null : _findMechanic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
