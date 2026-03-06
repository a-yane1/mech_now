import 'package:flutter/material.dart';

import '../../app_theme.dart';

class ServiceHistoryScreen extends StatelessWidget {
  const ServiceHistoryScreen({super.key});

  static const _jobs = [
    {
      'service': '🛞 Tyre Change',
      'date': 'Feb 28, 2026 · 2:14 PM',
      'mechanic': 'Chukwuemeka B.',
      'location': 'Victoria Island',
      'price': '₦4,200',
      'stars': 5,
      'status': 'completed',
    },
    {
      'service': '🔋 Battery Jump',
      'date': 'Feb 15, 2026 · 8:45 AM',
      'mechanic': 'Fatima Abubakar',
      'location': 'Lekki Phase 1',
      'price': '₦2,000',
      'stars': 4,
      'status': 'completed',
    },
    {
      'service': '⚡ Electrical Fault',
      'date': 'Jan 30, 2026 · 5:20 PM',
      'mechanic': 'Emeka Nwosu',
      'location': 'Surulere',
      'price': '₦0',
      'stars': 3,
      'status': 'cancelled',
    },
    {
      'service': '🔩 Engine Check',
      'date': 'Jan 10, 2026 · 11:00 AM',
      'mechanic': 'Chukwuemeka B.',
      'location': 'Ikeja',
      'price': '₦8,500',
      'stars': 5,
      'status': 'completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Service History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: _jobs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final job = _jobs[i];
            final completed = job['status'] == 'completed';
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job['service'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              job['date'] as String,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textDim),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: List.generate(
                                5,
                                    (si) => Icon(
                                  si < (job['stars'] as int)
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  color: const Color(0xFFFFCC00),
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: completed
                              ? AppColors.greenDim
                              : AppColors.red.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          completed ? 'Completed' : 'Cancelled',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: completed
                                ? AppColors.green
                                : AppColors.red,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: AppColors.border, height: 1),
                  const SizedBox(height: 12),

                  // Bottom row
                  Row(
                    children: [
                      const Text('👨‍🔧', style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job['mechanic'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              job['location'] as String,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textDim),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        job['price'] as String,
                        style: TextStyle(
                          fontFamily: 'Syne',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: completed
                              ? AppColors.green
                              : AppColors.textDim,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
