import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onSectionTap;
  final VoidCallback onDrawerTap;
  final bool isMobile;

  const Navbar({
    super.key,
    required this.onSectionTap,
    required this.onDrawerTap,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallDesktop = !isMobile && screenWidth < 1150;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          height: preferredSize.height,
          padding: EdgeInsets.symmetric(
            horizontal: isSmallDesktop ? 12 : 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFF1A1A1A).withOpacity(0.15),
                width: 1.0,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Brand Logo
              GestureDetector(
                onTap: () => onSectionTap(0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BLACK CAB BURGER',
                        style: TextStyle(
                          fontFamily: 'WhiskeyTown',
                          fontSize: isMobile ? 22 : (isSmallDesktop ? 24 : 32),
                          letterSpacing: isSmallDesktop ? 1.0 : 2.0,
                          color: const Color(0xFFAD0F0F),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Transform.translate(
                        offset: const Offset(0, -5),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: isMobile ? 3.0 : (isSmallDesktop ? 3.5 : 5.0),
                          ),
                          child: Text(
                            '★',
                            style: TextStyle(
                              fontFamily: 'sans-serif',
                              color: const Color(0xFF1A1A1A),
                              fontSize: isMobile
                                  ? 11
                                  : (isSmallDesktop ? 13 : 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Menu Items (Desktop only)
              if (!isMobile)
                Row(
                  children: [
                    _NavLink(
                      title: 'Rólunk',
                      onTap: () => onSectionTap(1),
                      isSmallDesktop: isSmallDesktop,
                    ),
                    _NavLink(
                      title: 'Menü',
                      onTap: () => onSectionTap(2),
                      isSmallDesktop: isSmallDesktop,
                    ),
                    _NavLink(
                      title: 'Helyszín',
                      onTap: () => onSectionTap(3),
                      isSmallDesktop: isSmallDesktop,
                    ),
                    _NavLink(
                      title: 'Galéria',
                      onTap: () => onSectionTap(4),
                      isSmallDesktop: isSmallDesktop,
                    ),
                    SizedBox(width: isSmallDesktop ? 12 : 24),
                    _OrderButton(
                      label: isSmallDesktop ? 'Wolt' : 'Rendelj Wolt-ról',
                      color: const Color(0xFF00C2E8),
                      url:
                          'https://wolt.com/hu/hun/budapest/restaurant/black-cab-burger-i-mester',
                      isSmallDesktop: isSmallDesktop,
                    ),
                    const SizedBox(width: 12),
                    _OrderButton(
                      label: isSmallDesktop ? 'Foodora' : 'Rendelj Foodora-ról',
                      color: const Color(0xFFD60265),
                      url:
                          'https://www.foodora.hu/restaurant/g0ye/black-cab-burger-mester-utca',
                      isSmallDesktop: isSmallDesktop,
                    ),
                  ],
                )
              else
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Color(0xFF1A1A1A),
                    size: 28,
                  ),
                  onPressed: onDrawerTap,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _NavLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSmallDesktop;

  const _NavLink({
    required this.title,
    required this.onTap,
    this.isSmallDesktop = false,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isSmallDesktop ? 10 : 16,
            vertical: 8,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: widget.isSmallDesktop ? 2 : 4,
          ),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFAD0F0F).withOpacity(0.06)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: _isHovered
                ? Border.all(
                    color: const Color(0xFFAD0F0F).withOpacity(0.2),
                    width: 1,
                  )
                : null,
          ),
          child: Text(
            widget.title,
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _isHovered
                  ? const Color(0xFFAD0F0F)
                  : const Color(0xFF333333),
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderButton extends StatefulWidget {
  final String label;
  final Color color;
  final String url;
  final bool isSmallDesktop;

  const _OrderButton({
    required this.label,
    required this.color,
    required this.url,
    this.isSmallDesktop = false,
  });

  @override
  State<_OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<_OrderButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.35),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: ElevatedButton(
          onPressed: () async {
            final Uri uri = Uri.parse(widget.url);
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: widget.isSmallDesktop ? 12 : 18,
              vertical: widget.isSmallDesktop ? 12 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: _isHovered ? 6 : 2,
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
