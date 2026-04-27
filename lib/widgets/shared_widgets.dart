import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mcc_theme.dart';

// ─── APP BAR ─────────────────────────────────────────────────────────────────
class MCCAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final Color? accentColor;
 
  const MCCAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    this.accentColor,
  });
 
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MCCColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: MCCColors.ink),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Row(
        children: [
          if (accentColor != null) ...[
            Container(
              width: 4, height: 22,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
          ],
          Text(title,
            style: GoogleFonts.poppins(
              fontSize: 22, fontWeight: FontWeight.w500,
              color: MCCColors.ink, letterSpacing: 0.3,
            )),
        ],
      ),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: MCCColors.border),
      ),
    );
  }
 
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
 
// ─── CARD ─────────────────────────────────────────────────────────────────────
class MCCCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double radius;
 
  const MCCCard({
    super.key,
    required this.child,
    this.padding,
    this.borderColor,
    this.onTap,
    this.backgroundColor,
    this.radius = 12,
  });
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? MCCColors.white,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor ?? MCCColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8, offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
 
// ─── BUTTON ──────────────────────────────────────────────────────────────────
class MCCButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final bool outline;
  final double? width;
  final IconData? icon;
 
  const MCCButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
    this.outline = false,
    this.width,
    this.icon,
  });
 
  @override
  Widget build(BuildContext context) {
    final bg = color ?? MCCColors.red;
    final style = outline
        ? OutlinedButton.styleFrom(
            foregroundColor: bg,
            side: BorderSide(color: bg),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 15),
            textStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.2),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: textColor ?? MCCColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 15),
            textStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.2),
          );
 
    final child = icon != null
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 16), const SizedBox(width: 8), Text(label),
          ])
        : Text(label);
 
    return SizedBox(
      width: width ?? double.infinity,
      child: outline
          ? OutlinedButton(onPressed: onPressed, style: style, child: child)
          : ElevatedButton(onPressed: onPressed, style: style, child: child),
    );
  }
}
 
// ─── SECTION LABEL ───────────────────────────────────────────────────────────
class MCCSectionLabel extends StatelessWidget {
  final String text;
  final Color? color;
 
  const MCCSectionLabel(this.text, {super.key, this.color});
 
  @override
  Widget build(BuildContext context) {
    final c = color ?? MCCColors.red;
    return Row(
      children: [
        Container(
          width: 3, height: 14,
          decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(
          text.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 10, letterSpacing: 2.5, color: c, fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
 
// ─── TEXT FIELD ──────────────────────────────────────────────────────────────
class MCCTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool obscureText;
 
  const MCCTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText = false,
  });
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12, fontWeight: FontWeight.w500, color: MCCColors.inkMid,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          obscureText: obscureText,
          style: GoogleFonts.poppins(fontSize: 14, color: MCCColors.ink, fontWeight: FontWeight.w400),
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}
 
// ─── DROPDOWN ────────────────────────────────────────────────────────────────
class MCCDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
 
  const MCCDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    required this.onChanged,
  });
 
  @override
  State<MCCDropdown> createState() => _MCCDropdownState();
}
 
class _MCCDropdownState extends State<MCCDropdown> {
  String? _selected;
 
  @override
  void initState() {
    super.initState();
    _selected = widget.value;
  }
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: MCCColors.inkMid)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: MCCColors.bgSoft,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: MCCColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selected,
              isExpanded: true,
              dropdownColor: MCCColors.white,
              style: GoogleFonts.poppins(fontSize: 14, color: MCCColors.ink),
              hint: Text('Sélectionner',
                style: GoogleFonts.poppins(fontSize: 13, color: MCCColors.mutedLight)),
              items: widget.items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                setState(() => _selected = v);
                widget.onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}
 
// ─── FLAG BADGE ──────────────────────────────────────────────────────────────
class FlagBadge extends StatelessWidget {
  final String flag;
  final String label;
  final Color color;
 
  const FlagBadge({
    super.key, required this.flag, required this.label, required this.color,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(flag, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(label,
            style: GoogleFonts.poppins(
              fontSize: 11, letterSpacing: 1, color: color, fontWeight: FontWeight.w600,
            )),
        ],
      ),
    );
  }
}
 
// ─── INFO CHIP ───────────────────────────────────────────────────────────────
class MCCChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
 
  const MCCChip({super.key, required this.label, required this.color, this.icon});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(label,
            style: GoogleFonts.poppins(
              fontSize: 11, color: color, fontWeight: FontWeight.w500,
            )),
        ],
      ),
    );
  }
}
