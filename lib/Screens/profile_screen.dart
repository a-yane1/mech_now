import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../common_widgets.dart';
import 'motorists/service_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Hero ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    bottom: BorderSide(color: AppColors.border),
                  ),
                ),
                child: Column(
                  children: [
                    // Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.orange, Color(0xFFFF9A5C)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.orange.withOpacity(0.35),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'AO',
                          style: TextStyle(
                            fontFamily: 'Syne',
                            fontWeight: FontWeight.w800,
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Ada Okonkwo',
                      style: TextStyle(
                        fontFamily: 'Syne',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'ada.okonkwo@email.com',
                      style: TextStyle(
                          fontSize: 13, color: AppColors.textDim),
                    ),
                    const SizedBox(height: 16),

                    // Stats
                    Row(
                      children: [
                        _profileStat('12', 'Jobs'),
                        _divider(),
                        _profileStat('4.9', 'Rating'),
                        _divider(),
                        _profileStat('6mo', 'Member'),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Menu ──
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Account'),
                    const SizedBox(height: 8),
                    MenuItemRow(icon: '👤', label: 'Personal Information'),
                    const SizedBox(height: 8),
                    MenuItemRow(icon: '🚗', label: 'My Vehicles'),
                    const SizedBox(height: 8),
                    MenuItemRow(icon: '💳', label: 'Payment Methods'),

                    _sectionTitle('Activity'),
                    const SizedBox(height: 8),
                    MenuItemRow(
                      icon: '📋',
                      label: 'Service History',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                            const ServiceHistoryScreen()),
                      ),
                    ),
                    const SizedBox(height: 8),
                    MenuItemRow(icon: '⭐', label: 'My Reviews'),

                    _sectionTitle('Preferences'),
                    const SizedBox(height: 8),
                    MenuItemRow(icon: '🔔', label: 'Notifications'),
                    const SizedBox(height: 8),
                    MenuItemRow(icon: '🔒', label: 'Privacy & Security'),
                    const SizedBox(height: 8),
                    MenuItemRow(
                      icon: '🚪',
                      label: 'Sign Out',
                      isDanger: true,
                      onTap: () => Navigator.popUntil(
                          context, (r) => r.isFirst),
                    ),
                    const SizedBox(height: 32),

                    // App version
                    Center(
                      child: Text(
                        'MechNow v1.0.0',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textMuted),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileStat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Syne',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.orange,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textDim),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
        width: 1, height: 36, color: AppColors.border);
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.textMuted,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
