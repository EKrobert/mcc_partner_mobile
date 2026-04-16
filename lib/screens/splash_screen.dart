import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mcc_theme.dart';
import './slides/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
 
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _slide;
 
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<double>(begin: 20, end: 0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
    Future.delayed(const Duration(milliseconds: 2600), () {
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
      }
    });
  }
 
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: AnimatedBuilder(
            animation: _slide,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, _slide.value), child: child),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'M',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 88, fontWeight: FontWeight.w700,
                        color: MCCColors.red, height: 1,
                        letterSpacing: -4,
                      ),
                    ),
                    TextSpan(
                      text: 'CC',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 72, fontWeight: FontWeight.w300,
                        color: MCCColors.ink, height: 1,
                        letterSpacing: -2,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 4),
                Text(
                  'PARTNERS',
                  style: GoogleFonts.poppins(
                    fontSize: 18, letterSpacing: 10,
                    color: MCCColors.inkMid, fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 32),
                // Tricolor bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 48, height: 4, color: MCCColors.green),
                      Container(width: 48, height: 4, color: MCCColors.red),
                      Container(width: 48, height: 4, color: MCCColors.yellow),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Maroc China Connect',
                  style: GoogleFonts.poppins(
                    fontSize: 13, letterSpacing: 2,
                    color: MCCColors.muted, fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 
// ─── ONBOARDING ──────────────────────────────────────────────────────────────
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}
 
class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageCtrl = PageController();
  int _current = 0;
 
  final List<_OnboardData> _pages = const [
    _OnboardData(
      emoji: '🌉',
      accentColor: MCCColors.red,
      title: 'Le Pont Stratégique',
      subtitle: 'Maroc — Chine',
      desc: 'MCC Partners connecte les entreprises marocaines et chinoises en trajectoires économiques durables, fondées sur la confiance et l\'intelligence culturelle.',
    ),
    _OnboardData(
      emoji: '🏛',
      accentColor: MCCColors.green,
      title: 'Événements B2B',
      subtitle: 'Webinaire & Salon',
      desc: 'Participez au Webinaire du 11 Mai et au Salon MCC dans la région de l\'Oriental. Deux rendez-vous majeurs pour bâtir les partenariats de demain.',
    ),
    _OnboardData(
      emoji: '🤝',
      accentColor: MCCColors.goldDark,
      title: 'Mise en Relation',
      subtitle: 'Annuaire & Messagerie',
      desc: 'Trouvez des partenaires qualifiés, échangez des messages et prenez des rendez-vous directement dans l\'application.',
    ),
  ];
 
  @override
  Widget build(BuildContext context) {
    final accent = _pages[_current].accentColor;
    return Scaffold(
      backgroundColor: MCCColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: _goLogin,
                  child: Text('Passer',
                    style: GoogleFonts.poppins(
                      fontSize: 13, color: MCCColors.muted, fontWeight: FontWeight.w400,
                    )),
                ),
              ),
            ),
            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageCtrl,
                onPageChanged: (i) => setState(() => _current = i),
                itemCount: _pages.length,
                itemBuilder: (_, i) => _buildPage(_pages[i]),
              ),
            ),
            // Indicators + CTA
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (i) {
                      final active = i == _current;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 28 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: active ? _pages[i].accentColor : MCCColors.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_current < _pages.length - 1) {
                          _pageCtrl.nextPage(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut);
                        } else {
                          _goLogin();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: accent == MCCColors.yellow ? MCCColors.ink : MCCColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        _current < _pages.length - 1 ? 'Suivant →' : 'Commencer',
                        style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _buildPage(_OnboardData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon circle
          Container(
            width: 130, height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: data.accentColor.withOpacity(0.08),
              border: Border.all(color: data.accentColor.withOpacity(0.2), width: 1.5),
            ),
            child: Center(
              child: Text(data.emoji, style: const TextStyle(fontSize: 56)),
            ),
          ),
          const SizedBox(height: 48),
          Text(data.title,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 36, fontWeight: FontWeight.w500,
              color: MCCColors.ink, height: 1.1,
            )),
          const SizedBox(height: 8),
          Text(data.subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12, letterSpacing: 2.5,
              color: data.accentColor, fontWeight: FontWeight.w500,
            )),
          const SizedBox(height: 24),
          Text(data.desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14, color: MCCColors.muted,
              fontWeight: FontWeight.w300, height: 1.8,
            )),
        ],
      ),
    );
  }
 
  void _goLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
}
 
class _OnboardData {
  final String emoji, title, subtitle, desc;
  final Color accentColor;
  const _OnboardData({
    required this.emoji, required this.accentColor,
    required this.title, required this.subtitle, required this.desc,
  });
}