import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../../common_widgets.dart';
import '../motorists/home_screen.dart';
// import '../motorist/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _role = 0;
  bool _loading = false;

  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _vehicleController = TextEditingController();
  final _specialtyController = TextEditingController();

  bool _obscure = true;

  void _register() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MotoristrHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Create Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // ── Role Toggle ──
              RoleToggle(
                options: const ['🚗  Motorist', '🔧  Mechanic'],
                onChanged: (i) => setState(() => _role = i),
              ),
              const SizedBox(height: 20),

              // ── Name Row ──
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                        label: 'First Name', hint: 'Ada'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppTextField(
                        label: 'Last Name', hint: 'Okonkwo'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Email Address',
                hint: 'you@email.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Phone Number',
                hint: '+234 800 000 0000',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Password',
                hint: 'Min. 8 characters',
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
              const SizedBox(height: 16),

              // ── Conditional Field ──
              if (_role == 0)
                AppTextField(
                  label: 'Vehicle (Optional)',
                  hint: 'e.g. Toyota Camry 2019',
                  controller: _vehicleController,
                )
              else ...[
                AppTextField(
                  label: 'Specialty',
                  hint: 'e.g. Engine & Electrical',
                  controller: _specialtyController,
                ),
                const SizedBox(height: 16),
                // Upload cert hint
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.orange.withOpacity(0.4),
                        style: BorderStyle.solid),
                  ),
                  child: Row(
                    children: [
                      const Text('📄', style: TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload Certification',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: AppColors.textPrimary),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'PDF or image of your trade cert',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.textDim),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: AppColors.orangeDim,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Browse',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.orange),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 28),

              PrimaryButton(
                label: 'Create Account',
                isLoading: _loading,
                onTap: _register,
              ),
              const SizedBox(height: 16),

              // ── Terms note ──
              const Center(
                child: Text(
                  'By registering you agree to our Terms & Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11, color: AppColors.textMuted),
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
