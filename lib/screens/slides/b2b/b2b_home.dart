import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcc_partners/data/fake_data.dart';
import 'package:mcc_partners/theme/mcc_theme.dart';
import 'package:mcc_partners/widgets/shared_widgets.dart';

// ─── B2B HOME ─────────────────────────────────────────────────────────────────
class B2BHome extends StatefulWidget {
  const B2BHome({super.key});
  @override
  State<B2BHome> createState() => _B2BHomeState();
}

class _B2BHomeState extends State<B2BHome> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: AppBar(
        backgroundColor: MCCColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Row(children: [
          Container(width: 4, height: 22,
            decoration: BoxDecoration(color: MCCColors.goldDark, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 10),
          Text('Mise en Relation B2B',
            style: GoogleFonts.poppins(
              fontSize: 22, fontWeight: FontWeight.w500, color: MCCColors.ink,
            )),
        ]),
        bottom: TabBar(
          controller: _tab,
          indicatorColor: MCCColors.goldDark,
          indicatorWeight: 2.5,
          labelColor: MCCColors.goldDark,
          unselectedLabelColor: MCCColors.muted,
          labelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w300),
          tabs: const [
            Tab(text: 'Annuaire'),
            Tab(text: 'Messages'),
            Tab(text: 'RDV'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [_AnnuaireTab(), _MessagesTab(), _RdvTab()],
      ),
    );
  }
}

// ─── ANNUAIRE ─────────────────────────────────────────────────────────────────
class _AnnuaireTab extends StatefulWidget {
  const _AnnuaireTab();
  @override
  State<_AnnuaireTab> createState() => _AnnuaireTabState();
}

class _AnnuaireTabState extends State<_AnnuaireTab> {
  String _filter = 'Tous';

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'Tous'
        ? FakeData.companies
        : _filter == 'Chine'
            ? FakeData.companies.where((c) => c.isChinese).toList()
            : FakeData.companies.where((c) => !c.isChinese).toList();

    return Column(
      children: [
        Container(
          color: MCCColors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            children: [
              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: MCCColors.bgSoft,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MCCColors.border),
                ),
                child: Row(children: [
                  const Icon(Icons.search, color: MCCColors.muted, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink),
                      decoration: InputDecoration(
                        hintText: 'Rechercher une entreprise...',
                        hintStyle: GoogleFonts.poppins(fontSize: 13, color: MCCColors.mutedLight),
                        border: InputBorder.none, filled: false,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 10),
              // Filter chips
              Row(
                children: ['Tous', 'Chine', 'Maroc'].map((f) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _filter = f),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      decoration: BoxDecoration(
                        color: _filter == f
                            ? (f == 'Chine' ? MCCColors.red : f == 'Maroc' ? MCCColors.green : MCCColors.goldDark).withOpacity(0.1)
                            : MCCColors.bgSoft,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _filter == f
                              ? (f == 'Chine' ? MCCColors.red : f == 'Maroc' ? MCCColors.green : MCCColors.goldDark).withOpacity(0.4)
                              : MCCColors.border,
                        ),
                      ),
                      child: Text(f,
                        style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: _filter == f ? FontWeight.w600 : FontWeight.w300,
                          color: _filter == f
                              ? (f == 'Chine' ? MCCColors.red : f == 'Maroc' ? MCCColors.green : MCCColors.goldDark)
                              : MCCColors.muted,
                        )),
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final c = filtered[i];
              final accent = c.isChinese ? MCCColors.red : MCCColors.green;
              return MCCCard(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CompanyDetailScreen(company: c))),
                borderColor: accent.withOpacity(0.15),
                child: Row(children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accent.withOpacity(0.08),
                      border: Border.all(color: accent.withOpacity(0.2)),
                    ),
                    child: Center(child: Text(c.flag, style: const TextStyle(fontSize: 24))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.name,
                        style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w500)),
                      Text(c.sector,
                        style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.muted, fontWeight: FontWeight.w300)),
                      if (c.standNumber != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: MCCChip(label: 'Stand ${c.standNumber}', color: MCCColors.goldDark),
                        ),
                    ],
                  )),
                  Icon(Icons.arrow_forward_ios, size: 12, color: MCCColors.muted),
                ]),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── COMPANY DETAIL ───────────────────────────────────────────────────────────
class CompanyDetailScreen extends StatelessWidget {
  final Company company;
  const CompanyDetailScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final accent = company.isChinese ? MCCColors.red : MCCColors.green;
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: MCCAppBar(title: 'Profil Entreprise', accentColor: accent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            MCCCard(
              borderColor: accent.withOpacity(0.2),
              child: Column(children: [
                Row(children: [
                  Container(
                    width: 64, height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accent.withOpacity(0.08),
                      border: Border.all(color: accent.withOpacity(0.25)),
                    ),
                    child: Center(child: Text(company.flag, style: const TextStyle(fontSize: 32))),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(company.name,
                      style: GoogleFonts.poppins(fontSize: 22, color: MCCColors.ink, fontWeight: FontWeight.w500)),
                    Text(company.sector,
                      style: GoogleFonts.poppins(fontSize: 12, color: accent, fontWeight: FontWeight.w500)),
                    if (company.standNumber != null)
                      MCCChip(label: 'Stand ${company.standNumber}', color: MCCColors.goldDark),
                  ])),
                ]),
              ]),
            ),
            const SizedBox(height: 16),

            // Description
            const MCCSectionLabel('À propos'),
            const SizedBox(height: 12),
            MCCCard(
              child: Text(company.description,
                style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.inkMid, fontWeight: FontWeight.w300, height: 1.7)),
            ),
            const SizedBox(height: 16),

            // Contact
            const MCCSectionLabel('Contact'),
            const SizedBox(height: 12),
            MCCCard(
              child: Column(children: [
                _ContactRow(Icons.person_outline, 'Contact', company.contact),
                const Divider(height: 24),
                _ContactRow(Icons.email_outlined, 'Email', company.email),
                const Divider(height: 24),
                _ContactRow(Icons.flag_outlined, 'Pays', '${company.flag} ${company.country}'),
              ]),
            ),
            const SizedBox(height: 24),

            MCCButton(label: 'Envoyer un Message', onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(company: company))),
              color: accent),
            const SizedBox(height: 10),
            MCCButton(label: 'Prendre un Rendez-vous', onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (_) => BookRdvScreen(company: company))),
              color: accent, outline: true),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

Widget _ContactRow(IconData icon, String label, String value) => Row(children: [
  Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: MCCColors.bgSoft, borderRadius: BorderRadius.circular(8)),
    child: Icon(icon, size: 18, color: MCCColors.muted),
  ),
  const SizedBox(width: 12),
  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: GoogleFonts.poppins(fontSize: 10, letterSpacing: 1.5, color: MCCColors.muted)),
    Text(value, style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w400)),
  ]),
]);

// ─── MESSAGES TAB ─────────────────────────────────────────────────────────────
class _MessagesTab extends StatelessWidget {
  const _MessagesTab();

  @override
  Widget build(BuildContext context) {
    final convos = FakeData.companies.where((c) => c.isChinese).take(4).toList();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: convos.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 78),
      itemBuilder: (context, i) {
        final c = convos[i];
        final previews = [
          'Proposons un RDV au stand A-12 ?',
          'Merci pour les informations !',
          'Envoyez le catalogue SVP',
          'Très intéressé par vos produits',
        ];
        final times = ['10:05', 'Hier', 'Lun', '30/03'];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          leading: Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MCCColors.red.withOpacity(0.08),
              border: Border.all(color: MCCColors.red.withOpacity(0.2)),
            ),
            child: Center(child: Text(c.flag, style: const TextStyle(fontSize: 22))),
          ),
          title: Text(c.name,
            style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w500)),
          subtitle: Text(previews[i],
            style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.muted, fontWeight: FontWeight.w300),
            maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(times[i], style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.muted)),
              if (i == 0) ...[
                const SizedBox(height: 4),
                Container(
                  width: 20, height: 20,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: MCCColors.red),
                  child: Center(child: Text('2',
                    style: GoogleFonts.poppins(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w700))),
                ),
              ],
            ],
          ),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => ChatScreen(company: c))),
        );
      },
    );
  }
}

// ─── CHAT ────────────────────────────────────────────────────────────────────
class ChatScreen extends StatefulWidget {
  final Company company;
  const ChatScreen({super.key, required this.company});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _ctrl = TextEditingController();
  final List<Message> _msgs = List.from(FakeData.chatMessages);

  void _send() {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _msgs.add(Message(
        sender: 'Moi', text: _ctrl.text,
        time: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2,'0')}',
        isMe: true,
      ));
      _ctrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.company.isChinese ? MCCColors.red : MCCColors.green;
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: AppBar(
        backgroundColor: MCCColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: MCCColors.ink),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withOpacity(0.08),
              border: Border.all(color: accent.withOpacity(0.25)),
            ),
            child: Center(child: Text(widget.company.flag, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.company.name,
              style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w600)),
            Text(widget.company.contact,
              style: GoogleFonts.poppins(fontSize: 11, color: MCCColors.muted)),
          ]),
        ]),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today_outlined, color: accent, size: 20),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => BookRdvScreen(company: widget.company))),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: MCCColors.border),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _msgs.length,
              itemBuilder: (_, i) {
                final m = _msgs[i];
                return Align(
                  alignment: m.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: m.isMe ? accent : MCCColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: m.isMe ? const Radius.circular(16) : const Radius.circular(4),
                        bottomRight: m.isMe ? const Radius.circular(4) : const Radius.circular(16),
                      ),
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2),
                      )],
                    ),
                    child: Column(
                      crossAxisAlignment: m.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(m.text,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: m.isMe ? Colors.white : MCCColors.ink,
                            fontWeight: FontWeight.w300, height: 1.5,
                          )),
                        const SizedBox(height: 4),
                        Text(m.time,
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            color: m.isMe ? Colors.white60 : MCCColors.muted,
                          )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Input bar
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
            decoration: const BoxDecoration(
              color: MCCColors.white,
              border: Border(top: BorderSide(color: MCCColors.border)),
            ),
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: MCCColors.bgSoft,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: MCCColors.border),
                  ),
                  child: TextField(
                    controller: _ctrl,
                    style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink),
                    decoration: InputDecoration(
                      hintText: 'Écrire un message...',
                      hintStyle: GoogleFonts.poppins(fontSize: 13, color: MCCColors.mutedLight),
                      border: InputBorder.none, filled: false,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _send,
                child: Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: accent),
                  child: const Icon(Icons.send, color: Colors.white, size: 18),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// ─── RDV TAB ─────────────────────────────────────────────────────────────────
class _RdvTab extends StatelessWidget {
  const _RdvTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        MCCButton(
          label: 'Nouveau Rendez-vous',
          onPressed: () {},
          color: MCCColors.goldDark,
          icon: Icons.add,
        ),
        const SizedBox(height: 24),
        const MCCSectionLabel('Mes Rendez-vous', color: MCCColors.goldDark),
        const SizedBox(height: 14),
        ...FakeData.appointments.map((a) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: MCCCard(
            borderColor: (a.confirmed ? MCCColors.green : MCCColors.goldDark).withOpacity(0.25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(a.flag, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(a.company,
                        style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w500)),
                    ),
                    MCCChip(
                      label: a.confirmed ? 'Confirmé' : 'En attente',
                      color: a.confirmed ? MCCColors.green : MCCColors.goldDark,
                      icon: a.confirmed ? Icons.check : Icons.access_time,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(height: 1, color: MCCColors.border),
                const SizedBox(height: 10),
                Row(children: [
                  const Icon(Icons.person_outline, size: 14, color: MCCColors.muted),
                  const SizedBox(width: 6),
                  Text(a.contact, style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.muted, fontWeight: FontWeight.w300)),
                  const SizedBox(width: 20),
                  const Icon(Icons.access_time, size: 14, color: MCCColors.muted),
                  const SizedBox(width: 6),
                  Text(a.time, style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.goldDark, fontWeight: FontWeight.w500)),
                ]),
                const SizedBox(height: 6),
                Row(children: [
                  const Icon(Icons.location_on_outlined, size: 14, color: MCCColors.muted),
                  const SizedBox(width: 6),
                  Text(a.stand, style: GoogleFonts.poppins(fontSize: 12, color: MCCColors.muted, fontWeight: FontWeight.w300)),
                ]),
              ],
            ),
          ),
        )),
      ],
    );
  }
}

// ─── BOOK RDV ─────────────────────────────────────────────────────────────────
class BookRdvScreen extends StatefulWidget {
  final Company company;
  const BookRdvScreen({super.key, required this.company});
  @override
  State<BookRdvScreen> createState() => _BookRdvState();
}

class _BookRdvState extends State<BookRdvScreen> {
  String? _slot;
  bool _confirmed = false;

  final List<String> _slots = [
    'Jour 1 — 10:00', 'Jour 1 — 11:30', 'Jour 1 — 14:00', 'Jour 1 — 15:30',
    'Jour 2 — 09:30', 'Jour 2 — 11:00', 'Jour 2 — 14:30', 'Jour 2 — 16:00',
  ];

  @override
  Widget build(BuildContext context) {
    final accent = widget.company.isChinese ? MCCColors.red : MCCColors.green;
    return Scaffold(
      backgroundColor: MCCColors.bgSoft,
      appBar: MCCAppBar(title: 'Prendre un RDV', accentColor: accent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: _confirmed ? _confirm(accent) : _form(accent),
      ),
    );
  }

  Widget _form(Color accent) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MCCCard(
        borderColor: accent.withOpacity(0.2),
        child: Row(children: [
          Text(widget.company.flag, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.company.name,
              style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.ink, fontWeight: FontWeight.w500)),
            if (widget.company.standNumber != null)
              Text('Stand ${widget.company.standNumber}',
                style: GoogleFonts.poppins(fontSize: 11, color: accent, fontWeight: FontWeight.w400)),
          ])),
        ]),
      ),
      const SizedBox(height: 24),
      const MCCSectionLabel('Choisir un créneau'),
      const SizedBox(height: 14),
      GridView.count(
        shrinkWrap: true, crossAxisCount: 2,
        crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 3,
        physics: const NeverScrollableScrollPhysics(),
        children: _slots.map((s) {
          final sel = _slot == s;
          return GestureDetector(
            onTap: () => setState(() => _slot = s),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: sel ? accent.withOpacity(0.08) : MCCColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: sel ? accent : MCCColors.border, width: sel ? 1.5 : 1),
              ),
              child: Center(child: Text(s,
                style: GoogleFonts.poppins(
                  fontSize: 11, color: sel ? accent : MCCColors.muted,
                  fontWeight: sel ? FontWeight.w600 : FontWeight.w300,
                ))),
            ),
          );
        }).toList(),
      ),
      const SizedBox(height: 24),
      const MCCTextField(label: 'Note (optionnel)', hint: 'Sujet du rendez-vous...', maxLines: 3),
      const SizedBox(height: 24),
      MCCButton(
        label: 'Confirmer le Rendez-vous',
        onPressed: _slot == null ? () {} : () => setState(() => _confirmed = true),
        color: accent,
      ),
      const SizedBox(height: 32),
    ],
  );

  Widget _confirm(Color accent) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 40),
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
        Text('Rendez-vous Confirmé !',
          style: GoogleFonts.poppins(fontSize: 28, color: MCCColors.green, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        Text('${widget.company.name}\n$_slot',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.muted, fontWeight: FontWeight.w300, height: 1.7)),
        if (widget.company.standNumber != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: MCCChip(label: 'Stand ${widget.company.standNumber}', color: MCCColors.goldDark),
          ),
        const SizedBox(height: 32),
        MCCButton(label: 'Retour', onPressed: () => Navigator.pop(context), color: accent),
      ]),
    ),
  );
}
