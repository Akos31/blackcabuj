import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GallerySection extends StatelessWidget {
  final bool isMobile;

  GallerySection({super.key, required this.isMobile});

  final List<String> images = [
    'assets/images/gallery_1.jpg',
    'assets/images/gallery_2.jpg',
    'assets/images/gallery_3.jpg',
  ];

  final List<String> captions = [
    'Klasszikus Black Cab Burger & krumpli',
    'Prémium kéksajtos burger baconnel és ketchup-pal',
    'Legendás, extra erős kézműves chiliszószok',
  ];

  @override
  Widget build(BuildContext context) {
    final double paddingVal = isMobile ? 24.0 : 80.0;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F5F0),
      child: Column(
        children: [
          const _SquareDotBorderRow(thick: true),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingVal,
              vertical: 80.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    // Section header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32,
                          height: 3,
                          color: const Color(0xFFAD0F0F),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          '★  GALÉRIA  ★',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFFAD0F0F),
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3.0,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Container(
                          width: 32,
                          height: 3,
                          color: const Color(0xFFAD0F0F),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Ínycsiklandó Pillanatok',
                      style: GoogleFonts.outfit(
                        color: const Color(0xFF1A1A1A),
                        fontSize: isMobile ? 32 : 46,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 140,
                      height: 4,
                      color: const Color(0xFF1A1A1A),
                    ),
                    const SizedBox(height: 48),

                    // Layout
                    isMobile
                        ? _buildMobileCarousel(context)
                        : _buildDesktopGrid(context),
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

  Widget _buildDesktopGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 4 / 3,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) => _GalleryCard(
        imagePath: images[index],
        caption: captions[index],
        index: index + 1,
        onTap: () => _openLightbox(context, index),
      ),
    );
  }

  Widget _buildMobileCarousel(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 16),
            child: _GalleryCard(
              imagePath: images[index],
              caption: captions[index],
              index: index + 1,
              onTap: () => _openLightbox(context, index),
            ),
          );
        },
      ),
    );
  }

  void _openLightbox(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) => _LightboxModal(
        images: images,
        captions: captions,
        initialIndex: initialIndex,
      ),
    );
  }
}

class _GalleryCard extends StatefulWidget {
  final String imagePath;
  final String caption;
  final int index;
  final VoidCallback onTap;

  const _GalleryCard({
    required this.imagePath,
    required this.caption,
    required this.index,
    required this.onTap,
  });

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
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
          duration: const Duration(milliseconds: 350),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isHovered ? const Color(0xFFAD0F0F) : Colors.transparent,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? const Color(0xFFAD0F0F).withOpacity(0.15)
                    : Colors.black.withOpacity(0.10),
                blurRadius: _isHovered ? 20 : 8,
                offset: const Offset(3, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Image with zoom effect
              Positioned.fill(
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  scale: _isHovered ? 1.06 : 1.0,
                  child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                ),
              ),

              // Dark gradient overlay (bottom)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.80),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // Photo number badge (top-left) – menu style
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  color: const Color(0xFFAD0F0F),
                  child: Text(
                    '${widget.index}.',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              // Caption overlay (bottom)
              Positioned(
                left: 16,
                bottom: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.caption,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _isHovered ? 1.0 : 0.0,
                      child: Text(
                        '★ Kattints a nagyításhoz',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFFAD0F0F),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LightboxModal extends StatefulWidget {
  final List<String> images;
  final List<String> captions;
  final int initialIndex;

  const _LightboxModal({
    required this.images,
    required this.captions,
    required this.initialIndex,
  });

  @override
  State<_LightboxModal> createState() => _LightboxModalState();
}

class _LightboxModalState extends State<_LightboxModal> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Navigation & image
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white60,
                      size: 28,
                    ),
                    onPressed: _currentIndex > 0
                        ? () => setState(() => _currentIndex--)
                        : null,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Image.asset(
                          widget.images[_currentIndex],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white60,
                      size: 28,
                    ),
                    onPressed: _currentIndex < widget.images.length - 1
                        ? () => setState(() => _currentIndex++)
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Caption
              Text(
                widget.captions[_currentIndex],
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${_currentIndex + 1} / ${widget.images.length}',
                style: GoogleFonts.outfit(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Square dot border row
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
