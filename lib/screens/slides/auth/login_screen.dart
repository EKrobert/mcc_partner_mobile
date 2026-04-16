import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcc_partners/screens/slides/main_nav.dart';
import 'package:mcc_partners/theme/mcc_theme.dart';
import 'package:mcc_partners/widgets/shared_widgets.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChinese = false;
  bool _loading   = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MainNav()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _isChinese ? MCCColors.red : MCCColors.green;
    return Scaffold(
      backgroundColor: MCCColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 56),
              // Logo
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('M',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 60, fontWeight: FontWeight.w700,
                      color: MCCColors.red, letterSpacing: -3, height: 1,
                    )),
                  Text('CC',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 48, fontWeight: FontWeight.w300,
                      color: MCCColors.ink, letterSpacing: -1, height: 1,
                    )),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text('PARTNERS',
                      style: GoogleFonts.poppins(
                        fontSize: 14, letterSpacing: 4,
                        color: MCCColors.inkMid, fontWeight: FontWeight.w300,
                      )),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // Tricolor bar
              Row(children: [
                Container(width: 20, height: 3, color: MCCColors.green),
                Container(width: 20, height: 3, color: MCCColors.red),
                Container(width: 20, height: 3, color: MCCColors.yellow),
              ]),
              const SizedBox(height: 48),
              Text('Connexion',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 34, fontWeight: FontWeight.w500, color: MCCColors.ink,
                )),
              const SizedBox(height: 4),
              Text('Accédez à votre espace MCC Partners',
                style: GoogleFonts.poppins(
                  fontSize: 13, color: MCCColors.muted, fontWeight: FontWeight.w300,
                )),
              const SizedBox(height: 32),

              // Toggle Marocain / Chinois
              Container(
                decoration: BoxDecoration(
                  color: MCCColors.bgSoft,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MCCColors.border),
                ),
                child: Row(
                  children: [
                    _ProfileToggle(
                      flag: '🇲🇦', label: 'Marocain',
                      selected: !_isChinese,
                      color: MCCColors.green,
                      onTap: () => setState(() => _isChinese = false),
                    ),
                    _ProfileToggle(
                      flag: '🇨🇳', label: 'Chinois',
                      selected: _isChinese,
                      color: MCCColors.red,
                      onTap: () => setState(() => _isChinese = true),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Fields
              const MCCTextField(label: 'Email', hint: 'votre@email.com'),
              const SizedBox(height: 16),
              const MCCTextField(label: 'Mot de passe', hint: '••••••••', obscureText: true),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Mot de passe oublié ?',
                    style: GoogleFonts.poppins(
                      fontSize: 12, color: accent, fontWeight: FontWeight.w400,
                    )),
                ),
              ),
              const SizedBox(height: 24),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: MCCColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    disabledBackgroundColor: accent.withOpacity(0.5),
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 22, height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2.5),
                        )
                      : Text('Se connecter',
                          style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w600,
                          )),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pas encore de compte ? ",
                    style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.muted)),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    ),
                    child: Text('S\'inscrire',
                      style: GoogleFonts.poppins(
                        fontSize: 13, color: accent, fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      )),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Center(
                child: Text('🇲🇦  ✦  🇨🇳',
                  style: TextStyle(
                    fontSize: 22, color: MCCColors.muted.withOpacity(0.4),
                  )),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileToggle extends StatelessWidget {
  final String flag, label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _ProfileToggle({
    required this.flag, required this.label,
    required this.selected, required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: selected ? Border.all(color: color.withOpacity(0.4)) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(flag, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: selected ? color : MCCColors.muted,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w300,
                )),
            ],
          ),
        ),
      ),
    );
  }
}