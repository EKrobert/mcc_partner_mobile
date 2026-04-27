import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcc_partners/theme/mcc_theme.dart';
import "package:mcc_partners/widgets/shared_widgets.dart";
import 'package:mcc_partners/data/fake_data.dart';

// ─── WEBINAIRE HOME ───────────────────────────────────────────────────────────
class WebinaireHome extends StatelessWidget {
  const WebinaireHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: MCCAppBar(
        title: 'Webinaire',
        showBack: false,
        accentColor: MCCColors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: MCCColors.inkMid),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            // ── HERO CARD ────────────────────────────────────────────────
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [MCCColors.red, MCCColors.redDark],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: MCCColors.red.withOpacity(0.25),
                    blurRadius: 20, offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('11 MAI 2026',
                          style: GoogleFonts.poppins(
                            fontSize: 10, letterSpacing: 1.5,
                            color: Colors.white, fontWeight: FontWeight.w600,
                          )),
                      ),
                      const Text('📡', style: TextStyle(fontSize: 32)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Webinaire\nStratégique',
                    style: GoogleFonts.poppins(
                      fontSize: 38, fontWeight: FontWeight.w500,
                      color: Colors.white, height: 1.1,
                    )),
                  const SizedBox(height: 6),
                  Text('10e anniversaire du partenariat Morocco - China',
                    style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.white.withOpacity(0.75),
                      fontWeight: FontWeight.w300,
                    )),
                  const SizedBox(height: 24),
                  // Countdown
                  Row(children: [
                    _CountdownBox('40', 'Jours'),
                    const SizedBox(width: 8),
                    _CountdownBox('11', 'Heures'),
                    const SizedBox(width: 8),
                    _CountdownBox('30', 'Min'),
                  ]),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── INFO CHIPS ───────────────────────────────────────────────
            MCCCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _InfoItem(label: 'Statut', value: 'Inscrit ✓', color: MCCColors.green),
                  Container(width: 1, height: 36, color: MCCColors.border),
                  _InfoItem(label: 'Format', value: 'En ligne', color: MCCColors.red),
                  Container(width: 1, height: 36, color: MCCColors.border),
                  _InfoItem(label: 'Durée', value: '2h00', color: MCCColors.goldDark),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── ACTIONS ──────────────────────────────────────────────────
            MCCButton(
              label: 'Rejoindre le Live',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const WebinaireLiveScreen())),
              color: MCCColors.red,
              icon: Icons.play_circle_outline,
            ),
            const SizedBox(height: 10),
            MCCButton(
              label: 'Modifier mon inscription',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const WebinaireInscriptionScreen())),
              color: MCCColors.red,
              outline: true,
            ),

            const SizedBox(height: 24),

            // ── SPEAKERS ─────────────────────────────────────────────────
            const MCCSectionLabel('Intervenants', color: MCCColors.red),
            const SizedBox(height: 14),
            ...FakeData.webinaireSpeakers.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MCCCard(
                padding: const EdgeInsets.all(14),
                child: Row(children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MCCColors.red.withOpacity(0.08),
                    ),
                    child: Center(
                      child: Text(s['flag']!, style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(s['name']!,
                        style: GoogleFonts.poppins(
                          fontSize: 14, color: MCCColors.ink, fontWeight: FontWeight.w500,
                        )),
                      Text(s['role']!,
                        style: GoogleFonts.poppins(
                          fontSize: 11, color: MCCColors.muted, fontWeight: FontWeight.w300,
                        )),
                    ]),
                  ),
                ]),
              ),
            )),

            const SizedBox(height: 24),

            // ── REPLAY ───────────────────────────────────────────────────
            const MCCSectionLabel('Replays disponibles', color: MCCColors.red),
            const SizedBox(height: 14),
            MCCCard(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const WebinaireReplayScreen())),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: MCCColors.red.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.play_circle_outline, color: MCCColors.red, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Webinaire MCC — Janvier 2026',
                      style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w500)),
                    Text('1h45 • 342 vues',
                      style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.muted, fontWeight: FontWeight.w300)),
                  ]),
                ),
                const Icon(Icons.arrow_forward_ios, size: 14, color: MCCColors.muted),
              ]),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ─── INSCRIPTION ─────────────────────────────────────────────────────────────
class WebinaireInscriptionScreen extends StatefulWidget {
  const WebinaireInscriptionScreen({super.key});
  @override
  State<WebinaireInscriptionScreen> createState() => _WebinaireInscriptionState();
}

class _WebinaireInscriptionState extends State<WebinaireInscriptionScreen> {
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: MCCAppBar(title: 'Inscription Webinaire', accentColor: MCCColors.red),
      body: _done ? _success() : _form(),
    );
  }

  Widget _form() => SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Webinaire du 11 Mai 2026',
        style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w500, color: MCCColors.ink)),
      const SizedBox(height: 4),
      Text('Inscription gratuite — Confirmation par email',
        style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.muted, fontWeight: FontWeight.w300)),
      const SizedBox(height: 24),
      MCCCard(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const MCCTextField(label: 'Prénom & Nom *', hint: 'Votre nom complet'),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Email *', hint: 'votre@email.com'),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Téléphone', hint: '+212 / +86'),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Entreprise *', hint: 'Nom de votre entreprise'),
          const SizedBox(height: 16),
          MCCDropdown(label: 'Pays *', items: const ['Maroc', 'Chine', 'France', 'Autre'], onChanged: (_) {}),
          const SizedBox(height: 16),
          MCCDropdown(label: 'Secteur', items: const ['Industrie', 'Commerce', 'Agroalimentaire', 'Finance', 'Technologie', 'Autre'], onChanged: (_) {}),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Message (optionnel)', hint: 'Vos attentes pour ce webinaire...', maxLines: 3),
        ]),
      ),
      const SizedBox(height: 20),
      MCCButton(label: 'Confirmer Mon Inscription', onPressed: () => setState(() => _done = true), color: MCCColors.red),
      const SizedBox(height: 32),
    ]),
  );

  Widget _success() => Center(
    child: Padding(
      padding: const EdgeInsets.all(40),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MCCColors.green.withOpacity(0.1),
            border: Border.all(color: MCCColors.green.withOpacity(0.3)),
          ),
          child: const Icon(Icons.check, color: MCCColors.green, size: 36),
        ),
        const SizedBox(height: 24),
        Text('Inscription Confirmée !',
          style: GoogleFonts.poppins(fontSize: 30, color: MCCColors.green, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        Text('Vous recevrez vos informations de connexion par email avant le 11 Mai.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.muted, fontWeight: FontWeight.w300, height: 1.7)),
        const SizedBox(height: 32),
        MCCButton(label: 'Retour', onPressed: () => Navigator.pop(context), color: MCCColors.red),
      ]),
    ),
  );
}

// ─── LIVE ─────────────────────────────────────────────────────────────────────
class WebinaireLiveScreen extends StatelessWidget {
  const WebinaireLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: MCCColors.red)),
          const SizedBox(width: 8),
          Text('EN DIRECT',
            style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.red, letterSpacing: 2, fontWeight: FontWeight.w600)),
        ]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text('342 👁',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
          ),
        ],
      ),
      body: Column(children: [
        // Video player
        Container(
          height: 230,
          color: const Color(0xFF0A0A0A),
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.play_circle_fill, size: 72, color: MCCColors.red.withOpacity(0.8)),
              const SizedBox(height: 14),
              Text('Webinaire MCC Partners',
                style: GoogleFonts.poppins(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400)),
              Text('10e anniversaire Morocco - China',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54, fontWeight: FontWeight.w300)),
            ]),
          ),
        ),
        // Controls
        Container(
          color: const Color(0xFF111111),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _LiveControl(Icons.mic_off,          'Micro',        MCCColors.red),
            _LiveControl(Icons.videocam_off,     'Caméra',       Colors.white54),
            _LiveControl(Icons.chat_bubble_outline, 'Chat',      MCCColors.yellow),
            _LiveControl(Icons.people_outline,   'Participants', MCCColors.green),
          ]),
        ),
        // Chat
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              _LiveMsg('Wang Lei 🇨🇳', '非常感谢！ Very informative session.', '10:12'),
              _LiveMsg('Fatima Ouali 🇲🇦', 'Question sur les droits de douane 0% Chine-Afrique ?', '10:14'),
              _LiveMsg('Hassan Khattabi 🇲🇦', 'Excellent point sur Nador West Med !', '10:18'),
              _LiveMsg('Li Mei 🇨🇳', 'We are very interested in Moroccan argan export.', '10:22'),
            ],
          ),
        ),
        // Input
        Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 28),
          color: const Color(0xFF111111),
          child: Row(children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF333333)),
                ),
                child: TextField(
                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Écrire dans le chat...',
                    hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.white38),
                    border: InputBorder.none, filled: false,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(shape: BoxShape.circle, color: MCCColors.red),
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ]),
        ),
      ]),
    );
  }
}

class _LiveControl extends StatelessWidget {
  final IconData icon; final String label; final Color color;
  const _LiveControl(this.icon, this.label, this.color);
  @override
  Widget build(BuildContext context) => Column(children: [
    Icon(icon, color: color, size: 24),
    const SizedBox(height: 4),
    Text(label, style: GoogleFonts.poppins(fontSize: 9, color: color)),
  ]);
}

class _LiveMsg extends StatelessWidget {
  final String name, msg, time;
  const _LiveMsg(this.name, this.msg, this.time);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(name, style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.yellow, fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Text(time, style: GoogleFonts.poppins(fontSize: 10, color: Colors.white38)),
      ]),
      const SizedBox(height: 4),
      Text(msg, style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w300)),
    ]),
  );
}

// ─── REPLAY ──────────────────────────────────────────────────────────────────
class WebinaireReplayScreen extends StatelessWidget {
  const WebinaireReplayScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: MCCAppBar(title: 'Replays', accentColor: MCCColors.red),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const MCCSectionLabel('Disponibles', color: MCCColors.red),
          const SizedBox(height: 14),
          ...['Webinaire MCC — Janvier 2026 • 1h45',
              'Session export argan — Déc 2025 • 55 min',
              'Forum B2B Oujda — Nov 2025 • 2h10']
            .map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MCCCard(
                padding: const EdgeInsets.all(14),
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: MCCColors.red.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.play_arrow, color: MCCColors.red, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(r, style: GoogleFonts.poppins(
                      fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w300,
                    ))),
                  const Icon(Icons.download_outlined, color: MCCColors.muted, size: 18),
                ]),
              ),
            )),
        ],
      ),
    );
  }
}

// ─── HELPERS ─────────────────────────────────────────────────────────────────
class _CountdownBox extends StatelessWidget {
  final String value, label;
  const _CountdownBox(this.value, this.label);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(children: [
      Text(value, style: GoogleFonts.poppins(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w300)),
      Text(label, style: GoogleFonts.poppins(fontSize: 9, color: Colors.white70, letterSpacing: 1)),
    ]),
  );
}

class _InfoItem extends StatelessWidget {
  final String label, value; final Color color;
  const _InfoItem({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(label, style: GoogleFonts.poppins(fontSize: 10, color: MCCColors.muted)),
    const SizedBox(height: 4),
    Text(value, style: GoogleFonts.poppins(fontSize: 13, color: color, fontWeight: FontWeight.w600)),
  ]);
}
