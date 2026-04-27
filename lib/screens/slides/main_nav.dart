import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/mcc_theme.dart';
import 'home_screen.dart';
import 'webinaire/webinaire_home.dart';
import 'salon/salon_home.dart';
import 'b2b/b2b_home.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}
 
class _MainNavState extends State<MainNav> {
  int _idx = 0;
 
  final List<Widget> _screens = const [
    HomeScreen(),
    WebinaireHome(),
    SalonHome(),
    B2BHome(),
  ];
 
  final List<_NavItem> _items = const [
    _NavItem(icon: Icons.home_outlined,    active: Icons.home,    label: 'Accueil',   color: MCCColors.inkMid),
    _NavItem(icon: Icons.videocam_outlined, active: Icons.videocam, label: 'Webinaire', color: MCCColors.red),
    _NavItem(icon: Icons.store_outlined,   active: Icons.store,   label: 'Salon',     color: MCCColors.green),
    _NavItem(icon: Icons.people_outline,   active: Icons.people,  label: 'B2B',       color: MCCColors.goldDark),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCCColors.white,
      body: IndexedStack(index: _idx, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: MCCColors.white,
          border: Border(top: BorderSide(color: MCCColors.border)),
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 68,
            child: Row(
              children: List.generate(_items.length, (i) {
                final item  = _items[i];
                final active = _idx == i;
                final color  = active ? item.color : MCCColors.mutedLight;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _idx = i),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Active indicator dot
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: active ? 4 : 0,
                          height: active ? 4 : 0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: item.color,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Icon(
                          active ? item.active : item.icon,
                          size: 23, color: color,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: color,
                            fontWeight: active ? FontWeight.w600 : FontWeight.w300,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
 
class _NavItem {
  final IconData icon, active;
  final String label;
  final Color color;
  const _NavItem({
    required this.icon, required this.active,
    required this.label, required this.color,
  });
}
