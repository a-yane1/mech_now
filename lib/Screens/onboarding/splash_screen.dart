import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../../common_widgets.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideUp = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Glow background
          Positioned(
            top: -60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 340,
                height: 340,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0x33FF6B2C), Colors.transparent],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── Center Content ──
                Expanded(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeIn.value,
                        child: Transform.translate(
                          offset: Offset(0, _slideUp.value),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFF6B2C), Color(0xFFFF9A5C)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.orange.withOpacity(0.4),
                                blurRadius: 40,
                                offset: const Offset(0, 16),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text('🔧', style: TextStyle(fontSize: 44)),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Title
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: 'Syne',
                              fontWeight: FontWeight.w800,
                              fontSize: 42,
                              letterSpacing: -1.5,
                            ),
                            children: [
                              TextSpan(
                                text: 'Mech',
                                style: TextStyle(color: AppColors.orange),
                              ),
                              TextSpan(
                                text: 'Now',
                                style:
                                TextStyle(color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Subtitle
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48),
                          child: Text(
                            'Roadside help, on‑demand.\nReal mechanics, real fast.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textDim,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _dot(active: true),
                            const SizedBox(width: 8),
                            _dot(),
                            const SizedBox(width: 8),
                            _dot(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Bottom CTAs ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  child: Column(
                    children: [
                      PrimaryButton(
                        label: 'Get Started',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SecondaryButton(
                        label: 'Sign In',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Already trusted by 2,400+ motorists in Lagos',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textMuted),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot({bool active = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? AppColors.orange : AppColors.border,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
