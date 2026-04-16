import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcc_partners/screens/slides/auth/login_screen.dart';
import 'package:mcc_partners/screens/slides/main_nav.dart';
import 'package:mcc_partners/theme/mcc_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isChinese = false;
  bool _loading   = false;
  bool _submitted = false;
  int  _step      = 0; // 0 = infos perso, 1 = infos entreprise, 2 = confirmation

  // Contrôleurs étape 1
  final _nomCtrl         = TextEditingController();
  final _emailCtrl       = TextEditingController();
  final _telCtrl         = TextEditingController();
  final _passwordCtrl    = TextEditingController();
  final _confirmCtrl     = TextEditingController();

  // Contrôleurs étape 2
  final _entrepriseCtrl  = TextEditingController();
  final _posteCtrl       = TextEditingController();

  String? _pays;
  String? _secteur;
  String? _profil;

  bool _obscurePwd     = true;
  bool _obscureConfirm = true;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    _nomCtrl.dispose(); _emailCtrl.dispose(); _telCtrl.dispose();
    _passwordCtrl.dispose(); _confirmCtrl.dispose();
    _entrepriseCtrl.dispose(); _posteCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    setState(() { _loading = false; _submitted = true; });
  }

  Future<void> _goToApp() async {
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => const MainNav()));
  }

  @override
  Widget build(BuildContext context) {
    final accent = _isChinese ? MCCColors.red : MCCColors.green;

    return Scaffold(
      backgroundColor: MCCColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header fixe ───────────────────────────────────────
            _buildHeader(accent),

            // ── Contenu scrollable ────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: _submitted
                    ? _buildSuccess(accent)
                    : _step == 0
                        ? _buildStep1(accent)
                        : _buildStep2(accent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── HEADER ─────────────────────────────────────────────────────
  Widget _buildHeader(Color accent) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
      color: MCCColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo + back
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('M', style: GoogleFonts.cormorantGaramond(
                    fontSize: 44, fontWeight: FontWeight.w700,
                    color: MCCColors.red, letterSpacing: -2, height: 1,
                  )),
                  Text('CC', style: GoogleFonts.cormorantGaramond(
                    fontSize: 34, fontWeight: FontWeight.w300,
                    color: MCCColors.ink, letterSpacing: -1, height: 1,
                  )),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('PARTNERS', style: GoogleFonts.poppins(
                      fontSize: 11, letterSpacing: 3,
                      color: MCCColors.inkMid, fontWeight: FontWeight.w300,
                    )),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                child: Text('Connexion', style: GoogleFonts.poppins(
                  fontSize: 13, color: accent, fontWeight: FontWeight.w500,
                )),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Tricolor bar
          Row(children: [
            Container(width: 20, height: 3, color: MCCColors.green),
            Container(width: 20, height: 3, color: MCCColors.red),
            Container(width: 20, height: 3, color: MCCColors.yellow),
          ]),
          const SizedBox(height: 20),
          // Titre
          Text('Créer un compte', style: GoogleFonts.cormorantGaramond(
            fontSize: 30, fontWeight: FontWeight.w500, color: MCCColors.ink,
          )),
          const SizedBox(height: 4),
          Text('Rejoignez l\'écosystème MCC Partners', style: GoogleFonts.poppins(
            fontSize: 13, color: MCCColors.muted, fontWeight: FontWeight.w300,
          )),
          const SizedBox(height: 20),

          // Toggle profil
          Container(
            decoration: BoxDecoration(
              color: MCCColors.bgSoft,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MCCColors.border),
            ),
            child: Row(children: [
              _ProfileToggle(
                flag: '🇲🇦', label: 'Marocain',
                selected: !_isChinese, color: MCCColors.green,
                onTap: () => setState(() => _isChinese = false),
              ),
              _ProfileToggle(
                flag: '🇨🇳', label: 'Chinois',
                selected: _isChinese, color: MCCColors.red,
                onTap: () => setState(() => _isChinese = true),
              ),
            ]),
          ),
          const SizedBox(height: 20),

          // Indicateur d'étapes
          if (!_submitted) _buildStepIndicator(accent),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── STEP INDICATOR ─────────────────────────────────────────────
  Widget _buildStepIndicator(Color accent) {
    return Row(
      children: [
        _StepDot(num: 1, label: 'Identité', active: _step == 0, done: _step > 0, color: accent),
        Expanded(child: Container(height: 2, color: _step > 0 ? accent : MCCColors.border)),
        _StepDot(num: 2, label: 'Entreprise', active: _step == 1, done: _step > 1, color: accent),
        Expanded(child: Container(height: 2, color: MCCColors.border)),
        _StepDot(num: 3, label: 'Validation', active: false, done: false, color: accent),
      ],
    );
  }

  // ── ÉTAPE 1 — Informations personnelles ────────────────────────
  Widget _buildStep1(Color accent) {
    return Form(
      key: _formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _SectionTitle('Vos informations personnelles'),

          // Nom complet
          _FieldLabel('Prénom & Nom *'),
          _InputField(
            controller: _nomCtrl,
            hint: 'Votre nom complet',
            accent: accent,
            validator: (v) => (v == null || v.isEmpty) ? 'Champ requis' : null,
          ),
          const SizedBox(height: 16),

          // Email
          _FieldLabel('Email *'),
          _InputField(
            controller: _emailCtrl,
            hint: 'votre@email.com',
            accent: accent,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Champ requis';
              if (!v.contains('@')) return 'Email invalide';
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Téléphone
          _FieldLabel('Téléphone'),
          _InputField(
            controller: _telCtrl,
            hint: _isChinese ? '+86...' : '+212...',
            accent: accent,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),

          // Pays
          _FieldLabel('Pays *'),
          _DropdownField(
            hint: 'Sélectionner',
            value: _pays,
            accent: accent,
            items: _isChinese
                ? ['Chine', 'Hong Kong', 'Taïwan', 'Autre']
                : ['Maroc', 'France', 'Belgique', 'Canada', 'Autre pays africain', 'Autre'],
            onChanged: (v) => setState(() => _pays = v),
          ),
          const SizedBox(height: 16),

          // Mot de passe
          _FieldLabel('Mot de passe *'),
          TextFormField(
            controller: _passwordCtrl,
            obscureText: _obscurePwd,
            style: GoogleFonts.poppins(fontSize: 14, color: MCCColors.ink),
            decoration: _inputDeco(
              hint: '8 caractères minimum',
              accent: accent,
              suffix: IconButton(
                icon: Icon(
                  _obscurePwd ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 20, color: MCCColors.muted,
                ),
                onPressed: () => setState(() => _obscurePwd = !_obscurePwd),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Champ requis';
              if (v.length < 8) return '8 caractères minimum';
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Confirmation mot de passe
          _FieldLabel('Confirmer le mot de passe *'),
          TextFormField(
            controller: _confirmCtrl,
            obscureText: _obscureConfirm,
            style: GoogleFonts.poppins(fontSize: 14, color: MCCColors.ink),
            decoration: _inputDeco(
              hint: 'Répétez votre mot de passe',
              accent: accent,
              suffix: IconButton(
                icon: Icon(
                  _obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 20, color: MCCColors.muted,
                ),
                onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Champ requis';
              if (v != _passwordCtrl.text) return 'Les mots de passe ne correspondent pas';
              return null;
            },
          ),
          const SizedBox(height: 32),

          // Bouton suivant
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey1.currentState!.validate()) {
                  setState(() => _step = 1);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: MCCColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Continuer →', style: GoogleFonts.poppins(
                fontSize: 15, fontWeight: FontWeight.w600,
              )),
            ),
          ),
          const SizedBox(height: 20),
          _LoginLink(accent: accent),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ── ÉTAPE 2 — Informations entreprise ──────────────────────────
  Widget _buildStep2(Color accent) {
    return Form(
      key: _formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _SectionTitle('Votre entreprise'),

          // Nom entreprise
          _FieldLabel('Nom de l\'entreprise *'),
          _InputField(
            controller: _entrepriseCtrl,
            hint: 'Raison sociale',
            accent: accent,
            validator: (v) => (v == null || v.isEmpty) ? 'Champ requis' : null,
          ),
          const SizedBox(height: 16),

          // Poste
          _FieldLabel('Poste / Fonction'),
          _InputField(
            controller: _posteCtrl,
            hint: 'Directeur, CEO, Responsable Export...',
            accent: accent,
          ),
          const SizedBox(height: 16),

          // Secteur
          _FieldLabel('Secteur d\'activité *'),
          _DropdownField(
            hint: 'Sélectionner',
            value: _secteur,
            accent: accent,
            items: const [
              'Industrie & Manufacturing',
              'Commerce & Distribution',
              'Agroalimentaire',
              'Logistique & Transport',
              'Finance & Investissement',
              'Technologie & Innovation',
              'Énergie Renouvelable',
              'Construction & BTP',
              'Cosmétique & Bien-être',
              'Autre',
            ],
            onChanged: (v) => setState(() => _secteur = v),
          ),
          const SizedBox(height: 16),

          // Profil
          _FieldLabel('Votre profil'),
          _DropdownField(
            hint: 'Sélectionner',
            value: _profil,
            accent: accent,
            items: const [
              'Chef d\'entreprise / Dirigeant',
              'Directeur Commercial / Export',
              'Investisseur',
              'Responsable Partenariats',
              'Consultant / Conseiller',
              'Institutionnel / Représentant',
              'Autre',
            ],
            onChanged: (v) => setState(() => _profil = v),
          ),
          const SizedBox(height: 16),

          // Objectifs
          _FieldLabel('Vos objectifs (optionnel)'),
          Container(
            decoration: BoxDecoration(
              color: MCCColors.bgSoft,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: MCCColors.border),
            ),
            child: TextFormField(
              maxLines: 3,
              style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                hintText: _isChinese
                    ? 'Investir au Maroc, accéder au marché africain...'
                    : 'Exporter vers la Chine, trouver des partenaires...',
                hintStyle: GoogleFonts.poppins(fontSize: 13, color: MCCColors.mutedLight),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                filled: false,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Boutons
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _step = 0),
                style: OutlinedButton.styleFrom(
                  foregroundColor: accent,
                  side: BorderSide(color: accent),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('← Retour', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _loading ? null : () {
                  if (_formKey2.currentState!.validate()) _submit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: MCCColors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledBackgroundColor: accent.withOpacity(0.5),
                ),
                child: _loading
                    ? const SizedBox(width: 22, height: 22,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                    : Text('Créer mon compte', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            ),
          ]),
          const SizedBox(height: 20),
          _LoginLink(accent: accent),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ── SUCCÈS ─────────────────────────────────────────────────────
  Widget _buildSuccess(Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            width: 88, height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MCCColors.green.withOpacity(0.1),
              border: Border.all(color: MCCColors.green.withOpacity(0.3), width: 2),
            ),
            child: const Center(child: Icon(Icons.check, color: MCCColors.green, size: 40)),
          ),
          const SizedBox(height: 28),
          Text('Compte Créé !', style: GoogleFonts.cormorantGaramond(
            fontSize: 36, color: MCCColors.green, fontWeight: FontWeight.w500,
          )),
          const SizedBox(height: 12),
          Text(
            'Bienvenue dans l\'écosystème MCC Partners.\nVotre compte a été créé avec succès.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14, color: MCCColors.muted,
              fontWeight: FontWeight.w300, height: 1.7,
            ),
          ),
          const SizedBox(height: 8),
          Text(_emailCtrl.text,
            style: GoogleFonts.poppins(
              fontSize: 13, color: accent, fontWeight: FontWeight.w500,
            )),
          const SizedBox(height: 40),
          // Infos compte
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: MCCColors.bgSoft,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MCCColors.border),
            ),
            child: Column(children: [
              _SuccessRow('Nom', _nomCtrl.text),
              _SuccessRow('Entreprise', _entrepriseCtrl.text.isEmpty ? '—' : _entrepriseCtrl.text),
              _SuccessRow('Profil', _isChinese ? '🇨🇳 Entreprise Chinoise' : '🇲🇦 Entreprise Marocaine'),
              _SuccessRow('Secteur', _secteur ?? '—'),
            ]),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _goToApp,
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: MCCColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Accéder à l\'application', style: GoogleFonts.poppins(
                fontSize: 15, fontWeight: FontWeight.w600,
              )),
            ),
          ),
          const SizedBox(height: 24),
          Center(child: Text('🇲🇦  ✦  🇨🇳',
            style: TextStyle(fontSize: 22, color: MCCColors.muted.withOpacity(0.4)))),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ── HELPERS UI ─────────────────────────────────────────────────
  InputDecoration _inputDeco({required String hint, required Color accent, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(fontSize: 13, color: MCCColors.mutedLight),
      filled: true,
      fillColor: MCCColors.bgSoft,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MCCColors.border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MCCColors.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: accent, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MCCColors.red)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MCCColors.red, width: 1.5)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      suffixIcon: suffix,
    );
  }
}

// ── WIDGETS LOCAUX ──────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(children: [
      Container(width: 4, height: 18, color: MCCColors.red, margin: const EdgeInsets.only(right: 10)),
      Text(text, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: MCCColors.ink, letterSpacing: 0.3)),
    ]),
  );
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: MCCColors.inkMid)),
  );
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Color accent;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.accent,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.poppins(fontSize: 14, color: MCCColors.ink, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontSize: 13, color: MCCColors.mutedLight),
        filled: true,
        fillColor: MCCColors.bgSoft,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MCCColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MCCColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: accent, width: 1.5)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MCCColors.red)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MCCColors.red, width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String hint;
  final String? value;
  final Color accent;
  final List<String> items;
  final Function(String?) onChanged;

  const _DropdownField({
    required this.hint, required this.value, required this.accent,
    required this.items, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: MCCColors.bgSoft,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MCCColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: MCCColors.white,
          style: GoogleFonts.poppins(fontSize: 14, color: MCCColors.ink),
          hint: Text(hint, style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.mutedLight)),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  final int num;
  final String label;
  final bool active, done;
  final Color color;

  const _StepDot({
    required this.num, required this.label,
    required this.active, required this.done, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 32, height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done || active ? color : MCCColors.border,
          ),
          child: Center(
            child: done
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : Text('$num', style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: active ? Colors.white : MCCColors.muted,
                    fontWeight: FontWeight.w600,
                  )),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.poppins(
          fontSize: 10, letterSpacing: 0.5,
          color: active ? color : MCCColors.mutedLight,
          fontWeight: active ? FontWeight.w600 : FontWeight.w300,
        )),
      ],
    );
  }
}

class _SuccessRow extends StatelessWidget {
  final String label, value;
  const _SuccessRow(this.label, this.value);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.muted, fontWeight: FontWeight.w300)),
        Text(value, style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

class _LoginLink extends StatelessWidget {
  final Color accent;
  const _LoginLink({required this.accent});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Déjà un compte ? ', style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.muted)),
      GestureDetector(
        onTap: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen())),
        child: Text('Se connecter', style: GoogleFonts.poppins(
          fontSize: 13, color: accent, fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        )),
      ),
    ],
  );
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
              Text(label, style: GoogleFonts.poppins(
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