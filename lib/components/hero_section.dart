import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fade_in_reveal.dart';

class HeroSection extends StatefulWidget {
  final bool isMobile;
  final VoidCallback onExploreMenu;
  final VoidCallback onExploreLocation;

  const HeroSection({
    super.key,
    required this.isMobile,
    required this.onExploreMenu,
    required this.onExploreLocation,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _entranceController;

  // Staggered animations driven by the single entrance controller
  late final Animation<double> _badgeOpacity;
  late final Animation<double> _badgeSlide;

  late final Animation<double> _titleOpacity;
  late final Animation<double> _titleSlide;

  late final Animation<double> _descOpacity;
  late final Animation<double> _descSlide;

  late final Animation<double> _buttonOpacity;
  late final Animation<double> _buttonSlide;

  late final Animation<double> _imageOpacity;
  late final Animation<double> _imageSlide;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Badge: 0ms to 500ms (0.0 to 0.35)
    _badgeOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );
    _badgeSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
      ),
    );

    // Title: 150ms to 750ms (0.1 to 0.55)
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.1, 0.55, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.1, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    // Image: 200ms to 900ms (0.14 to 0.64)
    _imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.14, 0.64, curve: Curves.easeOut),
      ),
    );
    _imageSlide = Tween<double>(begin: 45.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.14, 0.64, curve: Curves.easeOutCubic),
      ),
    );

    // Desc: 300ms to 1000ms (0.21 to 0.71)
    _descOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.21, 0.71, curve: Curves.easeOut),
      ),
    );
    _descSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.21, 0.71, curve: Curves.easeOutCubic),
      ),
    );

    // Buttons: 450ms to 1200ms (0.32 to 0.85)
    _buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.32, 0.85, curve: Curves.easeOut),
      ),
    );
    _buttonSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.32, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    // Delay start of the entrance animation to allow loading screen to fade out
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) {
        _entranceController.forward();
      }
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double paddingVal = widget.isMobile ? 24.0 : 80.0;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double targetHeight = screenHeight - 80.0 - statusBarHeight;
    final double minHeroHeight = widget.isMobile ? 700.0 : 600.0;
    final double heroHeight = targetHeight > minHeroHeight
        ? targetHeight
        : minHeroHeight;

    // Show borders only if the screen height is 800px or greater
    final bool showBorders = screenHeight >= 800;
    final double verticalPaddingTop = showBorders
        ? 60.0
        : (widget.isMobile ? 32.0 : 60.0);
    final double verticalPaddingBottom = showBorders
        ? (widget.isMobile ? 40.0 : 60.0)
        : (widget.isMobile ? 32.0 : 60.0);

    return Container(
      width: double.infinity,
      height: widget.isMobile ? null : heroHeight,
      constraints: BoxConstraints(minHeight: heroHeight),
      color: const Color(0xFFF8F5F0), // Cream paper background
      child: Stack(
        children: [
          // Top dot border decoration
          if (showBorders)
            const Positioned(
              left: 0,
              right: 0,
              top: 20,
              child: _SquareDotBorderRow(thick: true),
            ),
          // Bottom dot border decoration
          if (showBorders)
            const Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: _SquareDotBorderRow(thick: true),
            ),

          // Main content
          Container(
            constraints: BoxConstraints(minHeight: heroHeight),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: paddingVal,
                  right: paddingVal,
                  top: verticalPaddingTop,
                  bottom: verticalPaddingBottom,
                ),
                child: widget.isMobile
                    ? _buildMobileLayout()
                    : _buildDesktopLayout(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        return Row(
          children: [
            // Left Column: Text & CTA
            Expanded(
              flex: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: _badgeOpacity.value,
                    child: Transform.translate(
                      offset: Offset(0, _badgeSlide.value),
                      child: _buildBadge(),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Opacity(
                    opacity: _titleOpacity.value,
                    child: Transform.translate(
                      offset: Offset(0, _titleSlide.value),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'WhiskeyTown',
                            fontSize: 76,
                            height: 1.1,
                            color: Color(0xFF1A1A1A),
                            letterSpacing: 2,
                          ),
                          children: [
                            TextSpan(text: 'NICE TO\n'),
                            TextSpan(
                              text: 'MEAT',
                              style: TextStyle(color: Color(0xFFAD0F0F)),
                            ),
                            TextSpan(text: ' YOU!'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Red underline accent and description text
                  Opacity(
                    opacity: _descOpacity.value,
                    child: Transform.translate(
                      offset: Offset(0, _descSlide.value),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 4,
                            color: const Color(0xFFAD0F0F),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            'A legendás londoni burger élmény Ferencváros szívében. Friss alapanyagok, prémium cheddar sajt, és a szemed előtt piruló szaftos marhahús.',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF555555),
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Opacity(
                    opacity: _buttonOpacity.value,
                    child: Transform.translate(
                      offset: Offset(0, _buttonSlide.value),
                      child: _buildCTAButtons(),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(flex: 2, child: SizedBox()),
            // Right Column: Floating burger image
            Expanded(
              flex: 10,
              child: Center(
                child: Opacity(
                  opacity: _imageOpacity.value,
                  child: Transform.translate(
                    offset: Offset(0, _imageSlide.value),
                    child: AnimatedBuilder(
                      animation: _floatController,
                      builder: (context, child) {
                        final double floatOffset =
                            math.sin(_floatController.value * 2 * math.pi) * 14;
                        final double rotOffset =
                            math.cos(_floatController.value * 2 * math.pi) *
                            0.025;
                        return Transform.translate(
                          offset: Offset(0, floatOffset),
                          child: Transform.rotate(
                            angle: rotOffset,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.18),
                                    blurRadius: 40,
                                    spreadRadius: 4,
                                    offset: const Offset(0, 12),
                                  ),
                                ],
                                border: Border.all(
                                  color: const Color(0xFF1A1A1A),
                                  width: 3.0,
                                ),
                              ),
                              child: AspectRatio(
                                aspectRatio: 1.4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1),
                                  child: Image.asset(
                                    'assets/images/hero_burger.png',
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    frameBuilder:
                                        (
                                          context,
                                          child,
                                          frame,
                                          wasSynchronouslyLoaded,
                                        ) {
                                          if (wasSynchronouslyLoaded)
                                            return child;
                                          final bool isLoaded = frame != null;
                                          return TweenAnimationBuilder<double>(
                                            tween: Tween<double>(
                                              begin: 1.0,
                                              end: isLoaded ? 0.0 : 1.0,
                                            ),
                                            duration: const Duration(
                                              milliseconds: 1200,
                                            ),
                                            curve: Curves.easeOutCubic,
                                            builder: (context, value, child) {
                                              if (value == 1.0)
                                                return const SizedBox.shrink();
                                              return ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: value * 15.0,
                                                  sigmaY: value * 15.0,
                                                ),
                                                child: Opacity(
                                                  opacity: (1.0 - value).clamp(
                                                    0.0,
                                                    1.0,
                                                  ),
                                                  child: child,
                                                ),
                                              );
                                            },
                                            child: child,
                                          );
                                        },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: _badgeOpacity.value,
              child: Transform.translate(
                offset: Offset(0, _badgeSlide.value),
                child: _buildBadge(),
              ),
            ),
            const SizedBox(height: 24),
            Opacity(
              opacity: _imageOpacity.value,
              child: Transform.translate(
                offset: Offset(0, _imageSlide.value),
                child: AnimatedBuilder(
                  animation: _floatController,
                  builder: (context, child) {
                    final double floatOffset =
                        math.sin(_floatController.value * 2 * math.pi) * 10;
                    return Transform.translate(
                      offset: Offset(0, floatOffset),
                      child: Center(
                        child: Container(
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFF1A1A1A),
                              width: 2.5,
                            ),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1.4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Image.asset(
                                'assets/images/hero_burger.png',
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                frameBuilder:
                                    (
                                      context,
                                      child,
                                      frame,
                                      wasSynchronouslyLoaded,
                                    ) {
                                      if (wasSynchronouslyLoaded) return child;
                                      final bool isLoaded = frame != null;
                                      return TweenAnimationBuilder<double>(
                                        tween: Tween<double>(
                                          begin: 1.0,
                                          end: isLoaded ? 0.0 : 1.0,
                                        ),
                                        duration: const Duration(
                                          milliseconds: 1200,
                                        ),
                                        curve: Curves.easeOutCubic,
                                        builder: (context, value, child) {
                                          if (value == 1.0)
                                            return const SizedBox.shrink();
                                          return ImageFiltered(
                                            imageFilter: ImageFilter.blur(
                                              sigmaX: value * 15.0,
                                              sigmaY: value * 15.0,
                                            ),
                                            child: Opacity(
                                              opacity: (1.0 - value).clamp(
                                                0.0,
                                                1.0,
                                              ),
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: child,
                                      );
                                    },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 28),
            Opacity(
              opacity: _titleOpacity.value,
              child: Transform.translate(
                offset: Offset(0, _titleSlide.value),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'WhiskeyTown',
                      fontSize: 44,
                      height: 1.1,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: 1.5,
                    ),
                    children: [
                      TextSpan(text: 'NICE TO\n'),
                      TextSpan(
                        text: 'MEAT',
                        style: TextStyle(color: Color(0xFFAD0F0F)),
                      ),
                      TextSpan(text: ' YOU!'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Opacity(
              opacity: _descOpacity.value,
              child: Transform.translate(
                offset: Offset(0, _descSlide.value),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 3,
                      color: const Color(0xFFAD0F0F),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'A legendás londoni burger élmény Ferencváros szívében. Friss alapanyagok, prémium cheddar sajt, és a szemed előtt piruló szaftos marhahús.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF555555),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            Opacity(
              opacity: _buttonOpacity.value,
              child: Transform.translate(
                offset: Offset(0, _buttonSlide.value),
                child: _buildCTAButtons(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFAD0F0F),
        border: Border.all(color: const Color(0xFFAD0F0F), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.white, size: 14),
          const SizedBox(width: 8),
          Text(
            '15+ ÉVE FERENCVÁROSBAN',
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButtons() {
    final bool isMobile = widget.isMobile;
    final double paddingHorizontal = isMobile ? 16 : 36;
    final double paddingVertical = isMobile ? 16 : 22;

    final Widget button1 = ElevatedButton(
      onPressed: widget.onExploreMenu,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFAD0F0F),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '★  ÉTLAP',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            letterSpacing: isMobile ? 1.5 : 2.0,
          ),
        ),
      ),
    );

    final Widget button2 = OutlinedButton(
      onPressed: widget.onExploreLocation,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF1A1A1A),
        side: const BorderSide(color: Color(0xFF1A1A1A), width: 2),
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'HELYSZÍN',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            letterSpacing: isMobile ? 1.5 : 2.0,
          ),
        ),
      ),
    );

    if (isMobile) {
      return Row(
        children: [
          Expanded(child: button1),
          const SizedBox(width: 12),
          Expanded(child: button2),
        ],
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.start,
      children: [button1, button2],
    );
  }
}

/// Square dot border decoration row – vintage print menu style
class _SquareDotBorderRow extends StatelessWidget {
  final bool thick;
  const _SquareDotBorderRow({this.thick = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thick ? 24 : 14,
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
    final double sq = thick ? 20.0 : 10.0;
    final double gap = thick ? 30.0 : 14.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawRect(Rect.fromLTWH(x, (size.height - sq) / 2, sq, sq), paint);
      x += sq + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
