import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcc_partners/screens/slides/b2b/b2b_home.dart';
import 'package:mcc_partners/screens/slides/salon/salon_home.dart';
import 'package:mcc_partners/screens/slides/webinaire/webinaire_home.dart';
import 'package:mcc_partners/theme/mcc_theme.dart';
import 'package:mcc_partners/widgets/shared_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── HEADER ─────────────────────────────────────────────────
              Container(
                color: MCCColors.white,
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo compact
                        Image.asset(
                          'assets/logo/mcc.png',
                          width: 48,
                          height: 48,
                        ),
                        // Avatar
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MCCColors.green.withOpacity(0.1),
                            border: Border.all(
                              color: MCCColors.green.withOpacity(0.3),
                            ),
                          ),
                          child: const Center(
                            child: Text('🇲🇦', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Bonjour, Youssef 👋',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: MCCColors.ink,
                      ),
                    ),
                    Text(
                      'Bienvenue sur MCC Partners',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: MCCColors.muted,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              // Tricolor accent bar
              Row(
                children: [
                  Expanded(child: Container(height: 3, color: MCCColors.green)),
                  Expanded(child: Container(height: 3, color: MCCColors.red)),
                  Expanded(
                    child: Container(height: 3, color: MCCColors.yellow),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── WEBINAIRE BANNER ───────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [MCCColors.red, MCCColors.redDark],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: MCCColors.red.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'EN LIGNE',
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      letterSpacing: 2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Webinaire Stratégique',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '11 Mai 2026 • Dans 40 jours',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "S'inscrire",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: MCCColors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text('📡', style: TextStyle(fontSize: 52)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── QUICK ACCESS ───────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MCCSectionLabel('Accès rapide'),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _QuickCard(
                            emoji: '🏛',
                            label: 'Salon MCC',
                            sublabel: 'Oriental 2026',
                            color: MCCColors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _QuickCard(
                            emoji: '📋',
                            label: 'Annuaire',
                            sublabel: '8 entreprises',
                            color: MCCColors.goldDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _QuickCard(
                            emoji: '📅',
                            label: 'Mes RDV',
                            sublabel: '3 prévus',
                            color: MCCColors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── STATS ─────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        value: '3',
                        label: 'RDV confirmés',
                        color: MCCColors.red,
                        icon: Icons.calendar_today,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        value: '2',
                        label: 'Messages',
                        color: MCCColors.green,
                        icon: Icons.chat_bubble_outline,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        value: '1',
                        label: 'Badge actif',
                        color: MCCColors.goldDark,
                        icon: Icons.qr_code,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── RDV À VENIR ───────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MCCSectionLabel('Prochains rendez-vous'),
                        Text(
                          'Voir tout',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: MCCColors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _RdvCard(
                      flag: '🇨🇳',
                      company: 'Shenzhen Tech Solutions',
                      time: 'Demain • 14:00',
                      stand: 'Stand A-12',
                      confirmed: true,
                    ),
                    const SizedBox(height: 8),
                    _RdvCard(
                      flag: '🇨🇳',
                      company: 'Guangzhou Trade Co.',
                      time: 'Demain • 16:30',
                      stand: 'Stand B-05',
                      confirmed: true,
                    ),
                    const SizedBox(height: 8),
                    _RdvCard(
                      flag: '🇨🇳',
                      company: 'Hunan Green Agriculture',
                      time: 'J+2 • 10:00',
                      stand: 'Stand A-07',
                      confirmed: false,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── ABOUT LINK ────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MCCCard(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: MCCColors.red.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('🌐', style: TextStyle(fontSize: 22)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'En savoir plus sur MCC Partners',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: MCCColors.ink,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'mcc-partners.ma',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: MCCColors.red,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.open_in_new,
                        size: 16,
                        color: MCCColors.muted,
                      ),
                    ],
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

class _QuickCard extends StatelessWidget {
  final String emoji, label, sublabel;
  final Color color;
  const _QuickCard({
    required this.emoji,
    required this.label,
    required this.sublabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: MCCColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MCCColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.1),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: MCCColors.ink,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            sublabel,
            style: GoogleFonts.poppins(
              fontSize: 9,
              color: MCCColors.muted,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value, label;
  final Color color;
  final IconData icon;
  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: MCCColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MCCColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: color.withOpacity(0.7)),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 30,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 9,
              color: MCCColors.muted,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _RdvCard extends StatelessWidget {
  final String flag, company, time, stand;
  final bool confirmed;
  const _RdvCard({
    required this.flag,
    required this.company,
    required this.time,
    required this.stand,
    required this.confirmed,
  });

  @override
  Widget build(BuildContext context) {
    return MCCCard(
      padding: const EdgeInsets.all(14),
      borderColor: confirmed
          ? MCCColors.green.withOpacity(0.2)
          : MCCColors.border,
      child: Row(
        children: [
          Text(flag, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: MCCColors.ink,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '$time • $stand',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: MCCColors.muted,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          MCCChip(
            label: confirmed ? 'Confirmé' : 'En attente',
            color: confirmed ? MCCColors.green : MCCColors.goldDark,
            icon: confirmed ? Icons.check : Icons.access_time,
          ),
        ],
      ),
    );
  }
}
