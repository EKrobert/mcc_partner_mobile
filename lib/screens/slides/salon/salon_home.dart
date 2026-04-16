import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcc_partners/theme/mcc_theme.dart';
import 'package:mcc_partners/widgets/shared_widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ─── SALON HOME ───────────────────────────────────────────────────────────────
class SalonHome extends StatelessWidget {
  const SalonHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: MCCAppBar(title: 'Salon MCC', showBack: false, accentColor: MCCColors.green),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [MCCColors.green, MCCColors.greenDark],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(
                  color: MCCColors.green.withOpacity(0.25),
                  blurRadius: 20, offset: const Offset(0, 6),
                )],
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
                        child: Text('FIN 2026',
                          style: GoogleFonts.poppins(
                            fontSize: 10, letterSpacing: 1.5, color: Colors.white, fontWeight: FontWeight.w600,
                          )),
                      ),
                      const Text('🏛', style: TextStyle(fontSize: 36)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text('Salon Maroc\nChina Connect',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 34, fontWeight: FontWeight.w500, color: Colors.white, height: 1.1,
                    )),
                  const SizedBox(height: 8),
                  Text('Région de l\'Oriental • Nador West Med',
                    style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w300,
                    )),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const MCCSectionLabel('Choisissez votre parcours', color: MCCColors.green),
            const SizedBox(height: 14),

            // Chinese route
            _RouteCard(
              flag: '🇨🇳',
              tagText: '企业 · Entreprises Chinoises',
              title: 'Réservation de Stand',
              subtitle: 'Exposition + paiement en ligne • Reçu numérique',
              color: MCCColors.red,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SalonChinoisScreen())),
            ),
            const SizedBox(height: 12),

            // Moroccan route
            _RouteCard(
              flag: '🇲🇦',
              tagText: 'شركات · Entreprises Marocaines',
              title: 'Invitation Visiteur',
              subtitle: 'Accès gratuit • Badge QR code officiel',
              color: MCCColors.green,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SalonMarocainScreen())),
            ),

            const SizedBox(height: 20),
            MCCButton(
              label: 'Plan du Salon',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SalonPlanScreen())),
              color: MCCColors.green,
              outline: true,
              icon: Icons.map_outlined,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _RouteCard extends StatelessWidget {
  final String flag, tagText, title, subtitle;
  final Color color;
  final VoidCallback onTap;

  const _RouteCard({
    required this.flag, required this.tagText, required this.title,
    required this.subtitle, required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MCCCard(
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      borderColor: color.withOpacity(0.2),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.08),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Center(child: Text(flag, style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(tagText,
                style: GoogleFonts.poppins(
                  fontSize: 9, letterSpacing: 1.5, color: color, fontWeight: FontWeight.w600,
                )),
              const SizedBox(height: 4),
              Text(title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 20, color: MCCColors.ink, fontWeight: FontWeight.w500,
                )),
              Text(subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 11, color: MCCColors.muted, fontWeight: FontWeight.w300,
                )),
            ]),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle, color: color.withOpacity(0.08),
            ),
            child: Icon(Icons.arrow_forward, size: 16, color: color),
          ),
        ],
      ),
    );
  }
}

// ─── SALON CHINOIS ────────────────────────────────────────────────────────────
class SalonChinoisScreen extends StatefulWidget {
  const SalonChinoisScreen({super.key});
  @override
  State<SalonChinoisScreen> createState() => _SalonChinoisState();
}

class _SalonChinoisState extends State<SalonChinoisScreen> {
  int _step = 0;
  int _selectedStand = -1;
  bool _paid = false;

  final List<_StandOption> _stands = const [
    _StandOption('Stand Standard',  '9 m² (3×3)',  '1 table + 2 chaises + électricité', '2 500€', MCCColors.muted),
    _StandOption('Stand Prestige',  '18 m² (3×6)', 'Aménagement premium + wifi dédié',  '4 500€', MCCColors.goldDark),
    _StandOption('Stand Signature', '36 m²',       'Emplacement prioritaire + branding', '8 500€', MCCColors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: MCCAppBar(title: 'Réservation de Stand', accentColor: MCCColors.red),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: _step == 0 ? _step0() : _step == 1 ? _step1() : _step2(),
      ),
    );
  }

  // Step indicator
  Widget _stepIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: List.generate(3, (i) {
          final done   = i < _step;
          final active = i == _step;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: done || active ? MCCColors.red : MCCColors.border,
                  ),
                  child: Center(
                    child: done
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : Text('${i + 1}',
                            style: GoogleFonts.poppins(
                              fontSize: 12, color: active ? Colors.white : MCCColors.muted,
                              fontWeight: FontWeight.w600,
                            )),
                  ),
                ),
                if (i < 2)
                  Expanded(child: Container(height: 2, color: done ? MCCColors.red : MCCColors.border)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _step0() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _stepIndicator(),
      FlagBadge(flag: '🇨🇳', label: 'Entreprises Chinoises', color: MCCColors.red),
      const SizedBox(height: 16),
      Text('Choisissez votre stand',
        style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w500, color: MCCColors.ink)),
      const SizedBox(height: 20),
      ..._stands.asMap().entries.map((e) {
        final i = e.key; final s = e.value;
        final sel = _selectedStand == i;
        return GestureDetector(
          onTap: () => setState(() => _selectedStand = i),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: sel ? s.color.withOpacity(0.06) : MCCColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: sel ? s.color : MCCColors.border, width: sel ? 1.5 : 1),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2))],
            ),
            child: Row(
              children: [
                Container(
                  width: 4, height: 52,
                  decoration: BoxDecoration(
                    color: sel ? s.color : MCCColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s.name, style: GoogleFonts.poppins(fontSize: 14, color: MCCColors.ink, fontWeight: FontWeight.w500)),
                    Text(s.size, style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.muted, fontWeight: FontWeight.w300)),
                    Text(s.details, style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.muted, fontWeight: FontWeight.w300)),
                  ]),
                ),
                Text(s.price,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 24, color: sel ? s.color : MCCColors.muted, fontWeight: FontWeight.w400,
                  )),
              ],
            ),
          ),
        );
      }),
      const SizedBox(height: 24),
      MCCButton(
        label: 'Continuer',
        onPressed: _selectedStand < 0 ? () {} : () => setState(() => _step = 1),
        color: MCCColors.red,
      ),
      const SizedBox(height: 32),
    ],
  );

  Widget _step1() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _stepIndicator(),
      FlagBadge(flag: '🇨🇳', label: _stands[_selectedStand].name, color: MCCColors.red),
      const SizedBox(height: 16),
      Text('Vos coordonnées',
        style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w500, color: MCCColors.ink)),
      const SizedBox(height: 20),
      MCCCard(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const MCCTextField(label: 'Nom de l\'entreprise *', hint: 'Raison sociale'),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Nom du contact *', hint: 'Prénom Nom'),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Email *', hint: 'email@company.cn'),
          const SizedBox(height: 16),
          const MCCTextField(label: 'WeChat / Téléphone', hint: '+86...'),
          const SizedBox(height: 16),
          MCCDropdown(label: 'Secteur *', items: const ['Industrie', 'Commerce', 'Agroalimentaire', 'Logistique', 'Finance', 'Technologie', 'Autre'], onChanged: (_) {}),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Produits exposés', hint: 'Décrivez ce que vous souhaitez présenter...', maxLines: 3),
        ]),
      ),
      const SizedBox(height: 20),
      MCCButton(label: 'Procéder au Paiement', onPressed: () => setState(() => _step = 2), color: MCCColors.red),
      const SizedBox(height: 10),
      MCCButton(label: '← Modifier le stand', onPressed: () => setState(() => _step = 0), color: MCCColors.red, outline: true),
      const SizedBox(height: 32),
    ],
  );

  Widget _step2() {
    final s = _stands[_selectedStand];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stepIndicator(),
        Text('Récapitulatif & Paiement',
          style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w500, color: MCCColors.ink)),
        const SizedBox(height: 20),
        MCCCard(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            _receiptRow('Stand sélectionné', s.name),
            _receiptRow('Prix total', s.price),
            const Divider(height: 24),
            _receiptRow('Acompte (30%)', s.acompte, bold: true, color: MCCColors.red),
          ]),
        ),
        const SizedBox(height: 20),
        Text('Mode de paiement',
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: MCCColors.inkMid)),
        const SizedBox(height: 12),
        ...['Alipay 💙', 'WeChat Pay 💚', 'Virement bancaire 🏦'].map((m) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: m.contains('Alipay') ? MCCColors.red.withOpacity(0.05) : MCCColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: m.contains('Alipay') ? MCCColors.red.withOpacity(0.4) : MCCColors.border,
              width: m.contains('Alipay') ? 1.5 : 1,
            ),
          ),
          child: Row(children: [
            Text(m, style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w300)),
            const Spacer(),
            if (m.contains('Alipay'))
              Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: MCCColors.red)),
          ]),
        )),
        const SizedBox(height: 24),
        if (!_paid)
          MCCButton(
            label: 'Confirmer et Payer l\'Acompte',
            onPressed: () => setState(() => _paid = true),
            color: MCCColors.red,
          )
        else
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: MCCColors.green.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MCCColors.green.withOpacity(0.3)),
            ),
            child: Column(children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, color: MCCColors.green.withOpacity(0.1),
                ),
                child: const Icon(Icons.check, color: MCCColors.green, size: 28),
              ),
              const SizedBox(height: 14),
              Text('Réservation Confirmée !',
                style: GoogleFonts.cormorantGaramond(fontSize: 24, color: MCCColors.green, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Text('Reçu n° MCC-2026-0042',
                style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.muted, letterSpacing: 1.5)),
              const SizedBox(height: 12),
              Text('Votre stand sera confirmé par email sous 48h.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.muted, fontWeight: FontWeight.w300)),
            ]),
          ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _receiptRow(String label, String value, {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.muted)),
          Text(value, style: GoogleFonts.poppins(
            fontSize: 13, color: color ?? MCCColors.ink,
            fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
          )),
        ],
      ),
    );
  }
}

class _StandOption {
  final String name, size, details, price;
  final Color color;
  const _StandOption(this.name, this.size, this.details, this.price, this.color);
  String get acompte {
    if (price == '2 500€') return '750€';
    if (price == '4 500€') return '1 350€';
    return '2 550€';
  }
}

// ─── SALON MAROCAIN ───────────────────────────────────────────────────────────
class SalonMarocainScreen extends StatefulWidget {
  const SalonMarocainScreen({super.key});
  @override
  State<SalonMarocainScreen> createState() => _SalonMarocainState();
}

class _SalonMarocainState extends State<SalonMarocainScreen> {
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: MCCAppBar(title: 'Invitation Visiteur', accentColor: MCCColors.green),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: _submitted ? _badge() : _form(),
      ),
    );
  }

  Widget _form() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      FlagBadge(flag: '🇲🇦', label: 'Entreprises Marocaines', color: MCCColors.green),
      const SizedBox(height: 16),
      Text('Demande d\'Invitation',
        style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w500, color: MCCColors.ink)),
      const SizedBox(height: 4),
      Text('Accès gratuit • Badge QR nominatif',
        style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.green, fontWeight: FontWeight.w400)),
      const SizedBox(height: 24),
      MCCCard(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const MCCTextField(label: 'Prénom & Nom *', hint: 'Votre nom complet'),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Entreprise *', hint: 'Raison sociale'),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Email *', hint: 'email@entreprise.ma'),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Téléphone *', hint: '+212...'),
          const SizedBox(height: 16),
          MCCDropdown(label: 'Ville *', items: const ['Oujda', 'Nador', 'Casablanca', 'Rabat', 'Tanger', 'Autre'], onChanged: (_) {}),
          const SizedBox(height: 16),
          MCCDropdown(label: 'Secteur *', items: const ['Agroalimentaire', 'Artisanat', 'Industrie', 'Commerce', 'Logistique', 'Finance', 'Autre'], onChanged: (_) {}),
          const SizedBox(height: 16),
          MCCDropdown(label: 'Profil', items: const ['Chef d\'entreprise', 'Directeur Commercial', 'Investisseur', 'Responsable Export', 'Autre'], onChanged: (_) {}),
          const SizedBox(height: 16),
          const MCCTextField(label: 'Objectifs', hint: 'Trouver des partenaires, présenter mes produits...', maxLines: 3),
        ]),
      ),
      const SizedBox(height: 20),
      MCCButton(label: 'Demander Mon Invitation', onPressed: () => setState(() => _submitted = true), color: MCCColors.green),
      const SizedBox(height: 12),
      Center(child: Text('Places limitées • Confirmation sous 72h',
        style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.muted, fontWeight: FontWeight.w300))),
      const SizedBox(height: 32),
    ],
  );

  Widget _badge() => Column(
    children: [
      const SizedBox(height: 16),
      Text('Votre Badge Officiel',
        style: GoogleFonts.cormorantGaramond(fontSize: 28, color: MCCColors.green, fontWeight: FontWeight.w500)),
      const SizedBox(height: 4),
      Text('Salon MCC Partners 2026',
        style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.muted, letterSpacing: 1)),
      const SizedBox(height: 28),
      MCCCard(
        padding: const EdgeInsets.all(28),
        borderColor: MCCColors.green.withOpacity(0.35),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('M', style: GoogleFonts.cormorantGaramond(fontSize: 32, color: MCCColors.red, fontWeight: FontWeight.w700)),
                  Text('CC', style: GoogleFonts.cormorantGaramond(fontSize: 26, color: MCCColors.ink, fontWeight: FontWeight.w300)),
                ],
              ),
              const Text('🇲🇦', style: TextStyle(fontSize: 28)),
            ]),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: QrImageView(
                data: 'MCC-SALON-2026-MA-YOUSSEF-BENALI-AFRIKHUB',
                version: QrVersions.auto,
                size: 180,
                backgroundColor: Colors.white,
                eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF111111)),
                dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Color(0xFF111111)),
              ),
            ),
            const SizedBox(height: 20),
            Text('Youssef Benali',
              style: GoogleFonts.cormorantGaramond(fontSize: 24, color: MCCColors.ink, fontWeight: FontWeight.w500)),
            Text('AfrikHub Maroc',
              style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.green, fontWeight: FontWeight.w500, letterSpacing: 0.5)),
            Text('Logistique & Commerce',
              style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.muted, fontWeight: FontWeight.w300)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: MCCColors.green.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: MCCColors.green.withOpacity(0.3)),
              ),
              child: Text('VISITEUR • MCC-2026-MA-0127',
                style: GoogleFonts.poppins(fontSize: 10, letterSpacing: 1.5, color: MCCColors.green, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Text('Présentez ce QR code à l\'entrée du salon.',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.muted, fontWeight: FontWeight.w300)),
      const SizedBox(height: 20),
      MCCButton(label: 'Ajouter au Wallet', onPressed: () {}, color: MCCColors.green, icon: Icons.wallet),
      const SizedBox(height: 32),
    ],
  );
}

// ─── PLAN ─────────────────────────────────────────────────────────────────────
class SalonPlanScreen extends StatelessWidget {
  const SalonPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: MCCAppBar(title: 'Plan du Salon', accentColor: MCCColors.green),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MCCSectionLabel('Carte interactive', color: MCCColors.green),
            const SizedBox(height: 14),
            // Legend
            Wrap(spacing: 12, runSpacing: 8, children: [
              _LegendItem(MCCColors.red,     'Stands Chinois'),
              _LegendItem(MCCColors.green,   'Stands Marocains'),
              _LegendItem(MCCColors.goldDark,'Conférence'),
              _LegendItem(MCCColors.muted,   'Services'),
            ]),
            const SizedBox(height: 16),
            // Map
            MCCCard(
              padding: EdgeInsets.zero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 340, width: double.infinity,
                  child: Stack(
                    children: [
                      // Grid
                      CustomPaint(
                        size: const Size(double.infinity, 340),
                        painter: _GridPainter(),
                      ),
                      Positioned(left: 12, top: 12,   child: _Hall('HALL A', MCCColors.red, 120, 90)),
                      Positioned(right: 12, top: 12,  child: _Hall('HALL B', MCCColors.red, 120, 90)),
                      Positioned(left: 12, bottom: 56, child: _Hall('HALL C', MCCColors.green, 120, 90)),
                      Positioned(right: 12, bottom: 56, child: _Hall('HALL D', MCCColors.green, 120, 90)),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: MCCColors.goldDark.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: MCCColors.goldDark.withOpacity(0.4)),
                          ),
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Text('SCÈNE', style: GoogleFonts.poppins(fontSize: 10, letterSpacing: 2, color: MCCColors.goldDark, fontWeight: FontWeight.w600)),
                            Text('CONFÉRENCE', style: GoogleFonts.poppins(fontSize: 9, color: MCCColors.muted)),
                          ]),
                        ),
                      ),
                      // Stand pins
                      Positioned(left: 20, top: 22,   child: _Pin('A-12', MCCColors.red)),
                      Positioned(left: 60, top: 22,   child: _Pin('A-07', MCCColors.red)),
                      Positioned(right: 20, top: 22,  child: _Pin('B-05', MCCColors.red)),
                      Positioned(left: 20, bottom: 68, child: _Pin('C-01', MCCColors.green)),
                      Positioned(left: 58, bottom: 68, child: _Pin('C-03', MCCColors.green)),
                      // Entrance
                      Positioned(
                        bottom: 0, left: 0, right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: MCCColors.green.withOpacity(0.08),
                          child: Center(
                            child: Text('ENTRÉE PRINCIPALE ▲',
                              style: GoogleFonts.poppins(fontSize: 10, letterSpacing: 2, color: MCCColors.green, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const MCCSectionLabel('Stands réservés', color: MCCColors.green),
            const SizedBox(height: 12),
            ...['A-12 • Shenzhen Tech Solutions', 'A-07 • Hunan Green Agriculture',
                'B-05 • Guangzhou Trade Co.', 'C-01 • BYD Maghreb', 'C-03 • AfrikHub Maroc']
              .asMap().entries.map((e) {
                final isChinese = e.key < 4;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: MCCCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    borderColor: (isChinese ? MCCColors.red : MCCColors.green).withOpacity(0.2),
                    child: Row(children: [
                      Text(isChinese ? '🇨🇳' : '🇲🇦', style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 12),
                      Text(e.value, style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w300)),
                    ]),
                  ),
                );
              }),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

Widget _LegendItem(Color color, String label) => Row(mainAxisSize: MainAxisSize.min, children: [
  Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
  const SizedBox(width: 6),
  Text(label, style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.muted)),
]);

class _Hall extends StatelessWidget {
  final String label; final Color color; final double w, h;
  const _Hall(this.label, this.color, this.w, this.h);
  @override
  Widget build(_) => Container(
    width: w, height: h,
    decoration: BoxDecoration(
      color: color.withOpacity(0.07),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Center(child: Text(label,
      style: GoogleFonts.poppins(fontSize: 10, letterSpacing: 1.5, color: color.withOpacity(0.8), fontWeight: FontWeight.w600))),
  );
}

class _Pin extends StatelessWidget {
  final String label; final Color color;
  const _Pin(this.label, this.color);
  @override
  Widget build(_) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Text(label, style: GoogleFonts.poppins(fontSize: 8, color: color, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
  );
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFEEEEEE)..strokeWidth = 0.8;
    for (double x = 0; x < size.width;  x += 28) canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    for (double y = 0; y < size.height; y += 28) canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
  }
  @override
  bool shouldRepaint(_) => false;
}