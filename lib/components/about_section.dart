import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  final bool isMobile;

  const AboutSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final double paddingVal = isMobile ? 24.0 : 80.0;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = isMobile || screenWidth < 1150;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // Top dot border
          const _SquareDotBorderRow(thick: true),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingVal,
              vertical: 80.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isMobile
                    ? _buildMobileLayout(isSmallScreen)
                    : _buildDesktopLayout(isSmallScreen),
              ),
            ),
          ),
          // Bottom dot border
          const _SquareDotBorderRow(thick: true),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(bool isSmallScreen) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 11, child: _buildPhotoGrid()),
        const Expanded(flex: 2, child: SizedBox()),
        Expanded(flex: 11, child: _buildStoryContent(isSmallScreen)),
      ],
    );
  }

  Widget _buildMobileLayout(bool isSmallScreen) {
    return Column(
      children: [
        _buildStoryContent(isSmallScreen),
        const SizedBox(height: 56),
        _buildPhotoGrid(),
      ],
    );
  }

  Widget _buildPhotoGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final isNarrow = availableWidth < 680;
        final photo1Width = isNarrow ? availableWidth * 0.58 : 320.0;
        final photo2Width = isNarrow ? availableWidth * 0.58 : 320.0;
        final photo1Height = photo1Width;
        final photo2Height = photo2Width;
        final gridHeight = isNarrow ? (photo1Height * 1.4) : 440.0;
        final double totalWidth = isNarrow ? availableWidth : 520.0;

        return Center(
          child: SizedBox(
            height: gridHeight,
            width: totalWidth,
            child: Stack(
              children: [
                // Main interior photo
                Positioned(
                  left: 0,
                  top: 0,
                  width: photo1Width,
                  height: photo1Height,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF1A1A1A),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.14),
                          blurRadius: 20,
                          offset: const Offset(4, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1),
                      child: Image.asset(
                        'assets/images/restaurant_interior.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Overlapping burger photo
                Positioned(
                  right: 0,
                  bottom: 0,
                  width: photo2Width,
                  height: photo2Height,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFAD0F0F),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 24,
                          offset: const Offset(-4, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1),
                      child: Image.asset(
                        'assets/images/gourmet_burger_rustic.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStoryContent(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Section eyebrow label
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 24, height: 3, color: const Color(0xFFAD0F0F)),
            const SizedBox(width: 10),
            Text(
              isMobile ? '★  RÓLUNK  ★' : '★  RÓLUNK',
              style: GoogleFonts.outfit(
                color: const Color(0xFFAD0F0F),
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 3.0,
              ),
            ),
            if (isMobile) ...[
              const SizedBox(width: 10),
              Container(width: 24, height: 3, color: const Color(0xFFAD0F0F)),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Üdvözlünk a\nBlack Cab-ben',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.outfit(
            color: const Color(0xFF1A1A1A),
            fontSize: isMobile ? 34 : 46,
            fontWeight: FontWeight.w900,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 100,
          height: 4,
          color: const Color(0xFF1A1A1A),
          margin: EdgeInsets.only(left: isMobile ? 0 : 0),
        ),
        const SizedBox(height: 28),
        // Quote card – white with thick black border (menu-style)
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F5F0),
            border: const Border(
              left: BorderSide(color: Color(0xFFAD0F0F), width: 4),
              top: BorderSide(color: Color(0xFF1A1A1A), width: 2),
              right: BorderSide(color: Color(0xFF1A1A1A), width: 2),
              bottom: BorderSide(color: Color(0xFF1A1A1A), width: 2),
            ),
          ),
          child: Column(
            children: [
              Text(
                '\"Habár a Black Cab fogalma az Urániánál lévő hamburgerező megjelenésével vált ismertté Budapesten, az első egység Ferencvárosban, a Mester utcában nyílt meg, Tóth József és az ő londoni tapasztalatai jóvoltából.\n\nAz étterem gyors, ez tény, de emellett minden frissen, az orrunk előtt készül. A húsokat több méretben is kérhetjük, alá és fölé akár mi magunk is kiválaszthatjuk a feltéteket.\"',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  color: const Color(0xFF333333),
                  height: 1.7,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '— We Love Budapest',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFAD0F0F),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        // Stats grid - Always keep in a single Row with IntrinsicHeight
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildStatCard(
                  isSmallScreen,
                  '15+',
                  'ÉV A GASZTRONÓMIÁBAN',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  isSmallScreen,
                  '20+',
                  'KÉZMŰVES BURGER VARIÁCIÓ',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(bool isSmallScreen, String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFAD0F0F), width: 3),
          left: BorderSide(color: Color(0xFF1A1A1A), width: 2),
          right: BorderSide(color: Color(0xFF1A1A1A), width: 2),
          bottom: BorderSide(color: Color(0xFF1A1A1A), width: 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              color: const Color(0xFFAD0F0F),
              fontSize: 36,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: const Color(0xFF1A1A1A),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryBadge({
    required Color logoColor,
    required String platform,
    required String url,
  }) {
    return ElevatedButton.icon(
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      icon: Icon(Icons.delivery_dining, color: Colors.white, size: 18),
      label: Text(
        'RENDELÉS $platform-ON',
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          fontSize: 13,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: logoColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
    );
  }
}

/// Square dot border row – vintage print menu style
class _SquareDotBorderRow extends StatelessWidget {
  final bool thick;
  const _SquareDotBorderRow({this.thick = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thick ? 10 : 7,
      child: CustomPaint(painter: _SquareDotPainter(thick: thick)),
    );
  }
}

class _SquareDotPainter extends CustomPainter {
  final bool thick;
  const _SquareDotPainter({this.thick = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;
    final double sq = thick ? 8.0 : 5.0;
    final double gap = thick ? 5.0 : 4.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawRect(Rect.fromLTWH(x, (size.height - sq) / 2, sq, sq), paint);
      x += sq + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
