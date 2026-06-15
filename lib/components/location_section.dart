import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationSection extends StatefulWidget {
  final bool isMobile;

  const LocationSection({super.key, required this.isMobile});

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  late String _statusText;
  late Color _statusColor;

  @override
  void initState() {
    super.initState();
    _checkOpeningStatus();
  }

  void _checkOpeningStatus() {
    final now = DateTime.now();
    final double currentHourFloat = now.hour + (now.minute / 60.0);
    if (currentHourFloat >= 11.5 && currentHourFloat < 22.0) {
      _statusText = '● NYITVA VAGYUNK!';
      _statusColor = const Color(0xFF2E7D32);
    } else {
      _statusText = '● ZÁRVA VAGYUNK  (Nyitás: 11:30)';
      _statusColor = const Color(0xFF888888);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double paddingVal = widget.isMobile ? 24.0 : 80.0;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          const _SquareDotBorderRow(thick: true),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVal, vertical: 80.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    // Section header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 32, height: 3, color: const Color(0xFFAD0F0F)),
                        const SizedBox(width: 14),
                        Text('★  ELÉRHETŐSÉG  ★',
                            style: GoogleFonts.outfit(
                              color: const Color(0xFFAD0F0F),
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 3.0,
                            )),
                        const SizedBox(width: 14),
                        Container(width: 32, height: 3, color: const Color(0xFFAD0F0F)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Helyszín & Nyitvatartás',
                      style: GoogleFonts.outfit(
                        color: const Color(0xFF1A1A1A),
                        fontSize: widget.isMobile ? 32 : 46,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(width: 160, height: 4, color: const Color(0xFF1A1A1A)),
                    const SizedBox(height: 48),
                    widget.isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
                  ],
                ),
              ),
            ),
          ),
          const _SquareDotBorderRow(thick: true),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 10, child: _buildInfoPanel()),
          const Expanded(flex: 2, child: SizedBox()),
          Expanded(flex: 12, child: _buildMapCard()),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildInfoPanel(),
        const SizedBox(height: 40),
        _buildMapCard(height: 380),
      ],
    );
  }

  Widget _buildInfoPanel() {
    return Column(
      crossAxisAlignment: widget.isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Live Status Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _statusColor.withOpacity(0.08),
            border: Border.all(color: _statusColor, width: 1.5),
          ),
          child: Text(
            _statusText,
            style: GoogleFonts.outfit(
              color: _statusColor,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 32),

        _buildDetailCard(
          icon: Icons.location_on,
          title: 'CIMÜNK',
          body: 'Budapest, Mester u. 46, 1095',
          onTap: () async {
            const url =
                'https://www.google.com/maps/place/Black+Cab+Burger/@47.4785033,19.0737965,17z/data=!4m6!3m5!1s0x4741dcfe9ee30977:0xa7b9b540fee30ffe!8m2!3d47.4785952!4d19.0739253!16s%2Fg%2F1pp2xbp7p?hl=hu&entry=ttu&g_ep=EgoyMDI2MDUyNy4wIKXMDSoASAFQAw%3D%3D';
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
        ),
        const SizedBox(height: 16),
        _buildDetailCard(
          icon: Icons.access_time,
          title: 'NYITVATARTÁS',
          body: 'Hétfő - Vasárnap\n11:30 - 22:00',
        ),
        const SizedBox(height: 16),
        _buildDetailCard(
          icon: Icons.email,
          title: 'E-MAIL',
          body: 'info@blackcabburger.hu',
        ),
      ],
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String body,
    VoidCallback? onTap,
  }) {
    final cardContent = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F5F0),
        border: Border(
          left: BorderSide(color: Color(0xFFAD0F0F), width: 4),
          top: BorderSide(color: Color(0xFF1A1A1A), width: 1),
          right: BorderSide(color: Color(0xFF1A1A1A), width: 1),
          bottom: BorderSide(color: Color(0xFF1A1A1A), width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFAD0F0F), size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF888888),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    )),
                const SizedBox(height: 6),
                Text(body,
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF1A1A1A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    )),
              ],
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }

  Widget _buildMapCard({double? height}) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1A1A1A), width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Light street map background
          Positioned.fill(child: CustomPaint(painter: _LightMapPainter())),

          // Map info overlay
          Positioned(
            left: 20,
            bottom: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.10),
                      blurRadius: 12, offset: const Offset(2, 4)),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Black Cab Burger',
                            style: GoogleFonts.outfit(
                              color: const Color(0xFF1A1A1A),
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            )),
                        const SizedBox(height: 4),
                        Text('Mester u. 46, Budapest',
                            style: GoogleFonts.outfit(
                              color: const Color(0xFF666666),
                              fontSize: 13,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () async {
                      const url =
                          'https://www.google.com/maps/place/Black+Cab+Burger/@47.4785033,19.0737965,17z/data=!4m6!3m5!1s0x4741dcfe9ee30977:0xa7b9b540fee30ffe!8m2!3d47.4785952!4d19.0739253!16s%2Fg%2F1pp2xbp7p?hl=hu&entry=ttu&g_ep=EgoyMDI2MDUyNy4wIKXMDSoASAFQAw%3D%3D';
                      final uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) await launchUrl(uri);
                    },
                    icon: const Icon(Icons.navigation, size: 16),
                    label: Text('ÚTVONAL',
                        style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                            letterSpacing: 1.0)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAD0F0F),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 16),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Light-mode street map painter
class _LightMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Cream paper map background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFF0EBE3),
    );

    // Block fills (city blocks)
    final blockPaint = Paint()
      ..color = const Color(0xFFE8E0D6)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width * 0.38, size.height * 0.28), blockPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.52, 0, size.width * 0.48, size.height * 0.28), blockPaint);
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.42, size.width * 0.38, size.height * 0.58), blockPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.52, size.height * 0.42, size.width * 0.48, size.height * 0.58), blockPaint);

    // Roads (white on cream = streets)
    final roadMain = Paint()
      ..color = Colors.white
      ..strokeWidth = 28
      ..style = PaintingStyle.stroke;
    final roadSide = Paint()
      ..color = Colors.white
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, size.height * 0.33), Offset(size.width, size.height * 0.33), roadMain);
    canvas.drawLine(Offset(size.width * 0.44, 0), Offset(size.width * 0.44, size.height), roadMain);
    canvas.drawLine(Offset(0, size.height * 0.68), Offset(size.width, size.height * 0.68), roadSide);
    canvas.drawLine(Offset(size.width * 0.75, 0), Offset(size.width * 0.75, size.height), roadSide);

    // Road outlines
    final roadOutline = Paint()
      ..color = const Color(0xFFD4C8BC)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, size.height * 0.33 - 14), Offset(size.width, size.height * 0.33 - 14), roadOutline);
    canvas.drawLine(Offset(0, size.height * 0.33 + 14), Offset(size.width, size.height * 0.33 + 14), roadOutline);
    canvas.drawLine(Offset(size.width * 0.44 - 14, 0), Offset(size.width * 0.44 - 14, size.height), roadOutline);
    canvas.drawLine(Offset(size.width * 0.44 + 14, 0), Offset(size.width * 0.44 + 14, size.height), roadOutline);

    // Location pin glow
    final pinCenter = Offset(size.width * 0.44, size.height * 0.33);
    canvas.drawCircle(pinCenter, 40,
        Paint()..color = const Color(0xFFAD0F0F).withOpacity(0.12));
    canvas.drawCircle(pinCenter, 22,
        Paint()..color = const Color(0xFFAD0F0F).withOpacity(0.22));
    canvas.drawCircle(pinCenter, 12, Paint()..color = const Color(0xFFAD0F0F));
    canvas.drawCircle(pinCenter, 5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
