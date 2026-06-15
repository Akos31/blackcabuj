import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final bool isMobile;

  const Footer({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final double paddingVal = isMobile ? 24.0 : 80.0;

    return Container(
      width: double.infinity,
      color: const Color(0xFFEDEAE4), // Warm light cream footer
      padding: EdgeInsets.symmetric(horizontal: paddingVal, vertical: 60.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Grid split
              isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
              const SizedBox(height: 48),

              // Divider
              Divider(color: const Color(0xFF1A1A1A).withOpacity(0.15)),
              const SizedBox(height: 24),

              // Bottom row
              Row(
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© ${DateTime.now().year} Black Cab Burger. Minden jog fenntartva.',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF888888),
                      fontSize: 12,
                    ),
                  ),
                  if (!isMobile)
                    Text(
                      'Weboldalt készítette: Kelemen Ákos',
                      style: GoogleFonts.outfit(
                        color: const Color(0xFF888888),
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              if (isMobile) ...[
                const SizedBox(height: 8),
                Text(
                  'Weboldalt készítette: Kelemen Ákos',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF888888),
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column 1: Branding
        Expanded(flex: 8, child: _buildBranding()),
        const Expanded(flex: 2, child: SizedBox()),

        // Column 2: Hours & Details
        Expanded(flex: 6, child: _buildHoursAndContact()),
        const Expanded(flex: 2, child: SizedBox()),

        // Column 3: Orders & Socials
        Expanded(flex: 6, child: _buildDeliveryAndSocials()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBranding(),
        const SizedBox(height: 40),
        _buildHoursAndContact(),
        const SizedBox(height: 40),
        _buildDeliveryAndSocials(),
      ],
    );
  }

  Widget _buildBranding() {
    final align = isMobile
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    return Column(
      crossAxisAlignment: align,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 80,
          width: 80,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
        const SizedBox(height: 12),
        Text(
          'BLACK CAB BURGER',
          style: const TextStyle(
            fontFamily: 'WhiskeyTown',
            color: Color(0xFFAD0F0F),
            fontSize: 30,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 0),
        Transform.translate(
          offset: const Offset(0, -8),
          child: Text(
            'NICE TO MEAT YOU!',
            style: const TextStyle(
              fontFamily: 'WhiskeyTown',
              color: Color(0xFF1A1A1A),
              fontSize: 22,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 280,
          child: Text(
            'Londoni minőség és sebesség Ferencváros szívében. Szaftos marhahús, egyedi kiegészítők és barátságos környezet vár rád.',
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.outfit(
              color: const Color(0xFF555555),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHoursAndContact() {
    final align = isMobile
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textStyleTitle = GoogleFonts.outfit(
      color: const Color(0xFF1A1A1A),
      fontWeight: FontWeight.bold,
      fontSize: 14,
      letterSpacing: 1.0,
    );
    final textStyleBody = GoogleFonts.outfit(
      color: const Color(0xFF555555),
      fontSize: 13,
      height: 1.5,
    );

    return Column(
      crossAxisAlignment: align,
      children: [
        Text('ELÉRHETŐSÉGEK', style: textStyleTitle),
        const SizedBox(height: 16),
        Text('Cím: Budapest, Mester u. 46, 1095', style: textStyleBody),
        Text('E-mail: info@blackcabburger.hu', style: textStyleBody),
        const SizedBox(height: 24),
        Text('NYITVATARTÁS', style: textStyleTitle),
        const SizedBox(height: 12),
        Text('Hétfő - Vasárnap\n11:30 - 22:00', style: textStyleBody),
      ],
    );
  }

  Widget _buildDeliveryAndSocials() {
    final align = isMobile
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          'GYORS RENDELÉS',
          style: GoogleFonts.outfit(
            color: const Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSocialIcon(
              FontAwesomeIcons.facebookF,
              'https://www.facebook.com/blackcabburger/',
            ),
            const SizedBox(width: 12),
            _buildSocialIcon(
              FontAwesomeIcons.instagram,
              'https://www.instagram.com/blackcabburger/',
            ),
            const SizedBox(width: 12),
            _buildSocialIcon(
              FontAwesomeIcons.globe,
              'https://www.blackcabburger.hu/',
            ),
          ],
        ),
        const SizedBox(height: 28),
        Text(
          'Rendelj házhoz a népszerű szállítási partnereinken keresztül.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.outfit(
            color: const Color(0xFF555555),
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF1A1A1A), width: 1.5),
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFFAD0F0F), size: 16),
        onPressed: () async {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
      ),
    );
  }
}
