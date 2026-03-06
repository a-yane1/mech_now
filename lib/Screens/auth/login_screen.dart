import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../../common_widgets.dart';
import '../mechanic/mech_home_screen.dart';
import '../motorists/home_screen.dart';
import 'register_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _role = 0; // 0 = motorist, 1 = mechanic
  bool _obscure = true;
  bool _loading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signIn() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
        _role == 0 ? const MotoristrHomeScreen() : const MechHomeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              // ── Eyebrow ──
              const Text(
                'WELCOME BACK',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.orange,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 6),

              // ── Title ──
              const Text(
                'Sign in to\nyour account',
                style: TextStyle(
                  fontFamily: 'Syne',
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  letterSpacing: -0.5,
                  height: 1.15,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 28),

              // ── Role Toggle ──
              RoleToggle(
                options: const ['🚗  Motorist', '🔧  Mechanic'],
                onChanged: (i) => setState(() => _role = i),
              ),
              const SizedBox(height: 20),

              // ── Email ──
              AppTextField(
                label: 'Email Address',
                hint: 'you@email.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // ── Password ──
              AppTextField(
                label: 'Password',
                hint: 'Enter password',
                controller: _passwordController,
                obscure: _obscure,
                suffix: GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textDim,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // ── Forgot ──
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.orange),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Sign In Button ──
              PrimaryButton(
                label: 'Sign In',
                isLoading: _loading,
                onTap: _signIn,
              ),
              const SizedBox(height: 20),

              // ── Divider ──
              const LabelDivider(label: 'or continue with'),
              const SizedBox(height: 16),

              // ── Google Button ──
              SecondaryButton(
                label: '  Continue with Google',
                onTap: () {},
              ),
              const SizedBox(height: 28),

              // ── Register Link ──
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const RegisterScreen()),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 13, color: AppColors.textDim),
                      children: [
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Create one →',
                          style: TextStyle(
                              color: AppColors.orange,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
