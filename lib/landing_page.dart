import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/navbar.dart';
import 'components/hero_section.dart';
import 'components/about_section.dart';
import 'components/menu_section.dart';
import 'components/location_section.dart';
import 'components/gallery_section.dart';
import 'components/footer.dart';
import 'components/fade_in_reveal.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _locationKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  final Set<int> _revealedSections = {0}; // Hero is revealed immediately

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    _checkVisibility();
  }

  bool _isElementVisible(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return false;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final double elementTop = position.dy;
    final double elementHeight = renderBox.size.height;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Trigger reveal when the top of the element is within 85% of screen height
    return elementTop < screenHeight - 60 && (elementTop + elementHeight) > 0;
  }

  void _checkVisibility() {
    final sections = [_heroKey, _aboutKey, _menuKey, _locationKey, _galleryKey];
    bool updated = false;
    for (int i = 0; i < sections.length; i++) {
      if (!_revealedSections.contains(i)) {
        if (_isElementVisible(sections[i])) {
          _revealedSections.add(i);
          updated = true;
        }
      }
    }

    if (!_revealedSections.contains(5)) {
      if (_scrollController.hasClients &&
          _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 150) {
        _revealedSections.add(5);
        updated = true;
      }
    }

    if (updated) {
      setState(() {});
    }
  }

  void _scrollToSection(int index) {
    GlobalKey targetKey;
    switch (index) {
      case 0:
        targetKey = _heroKey;
        break;
      case 1:
        targetKey = _aboutKey;
        break;
      case 2:
        targetKey = _menuKey;
        break;
      case 3:
        targetKey = _locationKey;
        break;
      case 4:
        targetKey = _galleryKey;
        break;
      default:
        return;
    }

    final ctx = targetKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }

    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 950;
        final TargetPlatform platform = Theme.of(context).platform;
        final bool isDesktop = platform == TargetPlatform.windows ||
            platform == TargetPlatform.macOS ||
            platform == TargetPlatform.linux;

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xFFF8F5F0),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Navbar(
              isMobile: isMobile,
              onSectionTap: _scrollToSection,
              onDrawerTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          drawer: isMobile ? _buildMobileDrawer() : null,
          body: SingleChildScrollView(
            controller: _scrollController,
            physics: isDesktop ? const ClampingScrollPhysics() : null,
            child: SmoothScrollWrapper(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(
                    key: _heroKey,
                    child: FadeInReveal(
                      animate: _revealedSections.contains(0),
                      slideOffset: 0.0, // Hero has its own internal staggered transitions
                      child: HeroSection(
                        isMobile: isMobile,
                        onExploreMenu: () => _scrollToSection(2),
                        onExploreLocation: () => _scrollToSection(3),
                      ),
                    ),
                  ),
                  Container(
                    key: _aboutKey,
                    child: FadeInReveal(
                      animate: _revealedSections.contains(1),
                      child: AboutSection(isMobile: isMobile),
                    ),
                  ),
                  Container(
                    key: _menuKey,
                    child: FadeInReveal(
                      animate: _revealedSections.contains(2),
                      child: MenuSection(isMobile: isMobile),
                    ),
                  ),
                  Container(
                    key: _locationKey,
                    child: FadeInReveal(
                      animate: _revealedSections.contains(3),
                      child: LocationSection(isMobile: isMobile),
                    ),
                  ),
                  Container(
                    key: _galleryKey,
                    child: FadeInReveal(
                      animate: _revealedSections.contains(4),
                      child: GallerySection(isMobile: isMobile),
                    ),
                  ),
                  FadeInReveal(
                    animate: _revealedSections.contains(5) || _revealedSections.contains(4),
                    child: Footer(isMobile: isMobile),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileDrawer() {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isShortScreen = screenHeight < 700;

    final drawerLinkStyle = GoogleFonts.outfit(
      color: const Color(0xFF1A1A1A),
      fontSize: isShortScreen ? 16 : 18,
      fontWeight: FontWeight.bold,
    );

    return Drawer(
      backgroundColor: const Color(0xFFF8F5F0),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: isShortScreen ? 16 : 40),
            // Logo
            Image.asset(
              'assets/images/logo.png',
              height: isShortScreen ? 60 : 90,
              width: isShortScreen ? 60 : 90,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(height: isShortScreen ? 8 : 16),
            Text(
              'BLACK CAB BURGER',
              style: TextStyle(
                fontFamily: 'WhiskeyTown',
                color: const Color(0xFFAD0F0F),
                fontSize: isShortScreen ? 20 : 26,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: isShortScreen ? 6 : 8),
            // Decorative dot row under brand name
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: _SquareDotRow(),
            ),
            SizedBox(height: isShortScreen ? 16 : 32),

            // Links
            ListTile(
              dense: isShortScreen,
              leading: const Icon(Icons.home, color: Color(0xFFAD0F0F)),
              title: Text('Kezdőlap', style: drawerLinkStyle),
              onTap: () => _scrollToSection(0),
            ),
            ListTile(
              dense: isShortScreen,
              leading: const Icon(Icons.restaurant, color: Color(0xFFAD0F0F)),
              title: Text('Rólunk', style: drawerLinkStyle),
              onTap: () => _scrollToSection(1),
            ),
            ListTile(
              dense: isShortScreen,
              leading: const Icon(Icons.menu_book, color: Color(0xFFAD0F0F)),
              title: Text('Menü', style: drawerLinkStyle),
              onTap: () => _scrollToSection(2),
            ),
            ListTile(
              dense: isShortScreen,
              leading: const Icon(Icons.location_on, color: Color(0xFFAD0F0F)),
              title: Text('Helyszín', style: drawerLinkStyle),
              onTap: () => _scrollToSection(3),
            ),
            ListTile(
              dense: isShortScreen,
              leading: const Icon(Icons.photo_library, color: Color(0xFFAD0F0F)),
              title: Text('Galéria', style: drawerLinkStyle),
              onTap: () => _scrollToSection(4),
            ),

            const Spacer(),

            // Order buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildMobileOrderLink('Wolt', const Color(0xFF00C2E8),
                      'https://wolt.com/hu/hun/budapest/restaurant/black-cab-burger-i-mester', isShortScreen),
                  SizedBox(height: isShortScreen ? 8 : 12),
                  _buildMobileOrderLink('Foodora', const Color(0xFFD60265),
                      'https://www.foodora.hu/restaurant/g0ye/black-cab-burger-mester-utca', isShortScreen),
                ],
              ),
            ),
            SizedBox(height: isShortScreen ? 16 : 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileOrderLink(String platform, Color color, String url, bool isShortScreen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: isShortScreen ? 12 : 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text('Rendelés $platform-ról',
            style: GoogleFonts.outfit(
              fontSize: isShortScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}

/// Shared square dot row decoration (reused in drawer and sections)
class _SquareDotRow extends StatelessWidget {
  const _SquareDotRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: CustomPaint(painter: _SquareDotPainter()),
    );
  }
}

class _SquareDotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;
    const squareSize = 5.0;
    const gap = 4.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawRect(
        Rect.fromLTWH(x, (size.height - squareSize) / 2, squareSize, squareSize),
        paint,
      );
      x += squareSize + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SmoothScrollWrapper extends StatefulWidget {
  final Widget child;
  final ScrollController controller;

  const SmoothScrollWrapper({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<SmoothScrollWrapper> createState() => _SmoothScrollWrapperState();
}

class _SmoothScrollWrapperState extends State<SmoothScrollWrapper>
    with SingleTickerProviderStateMixin {
  double _scrollTarget = 0.0;
  double _currentPos = 0.0;
  late Ticker _ticker;
  DateTime? _lastTickTime;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
  }

  void _onTick(Duration elapsed) {
    if (!widget.controller.hasClients) {
      _ticker.stop();
      _lastTickTime = null;
      return;
    }

    final double actual = widget.controller.position.pixels;
    // If the actual scroll position deviates from our internal target (e.g., someone clicked a navbar link),
    // immediately cancel smooth scroll and sync with the new position.
    if ((actual - _currentPos).abs() > 1.0) {
      _ticker.stop();
      _currentPos = actual;
      _scrollTarget = actual;
      _lastTickTime = null;
      return;
    }

    final DateTime now = DateTime.now();
    if (_lastTickTime == null) {
      _lastTickTime = now;
      return;
    }

    final int dtMs = now.difference(_lastTickTime!).inMilliseconds;
    _lastTickTime = now;

    if (dtMs == 0) return;

    final double diff = _scrollTarget - _currentPos;
    
    // Stop the ticker and jump directly to target if we're extremely close
    if (diff.abs() < 0.2) {
      _currentPos = _scrollTarget;
      widget.controller.jumpTo(_currentPos);
      _ticker.stop();
      _lastTickTime = null;
    } else {
      // Time-independent decay:
      // At dt = 16.67ms (60fps), we want factor = 0.15.
      // -k * 16.67 = ln(1 - 0.15) = ln(0.85)  =>  k = -ln(0.85)/16.67 = 0.00975
      const double k = 0.00975;
      final double factor = 1.0 - math.exp(-k * dtMs);
      
      _currentPos = _currentPos + diff * factor;
      widget.controller.jumpTo(_currentPos);
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    final bool isDesktop = platform == TargetPlatform.windows ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.linux;

    if (!isDesktop) {
      return widget.child;
    }

    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          final double delta = pointerSignal.scrollDelta.dy;
          if (delta == 0) return;

          if (!widget.controller.hasClients) return;

          GestureBinding.instance.pointerSignalResolver.register(pointerSignal, (event) {
            final double currentActual = widget.controller.position.pixels;
            final double maxScroll = widget.controller.position.maxScrollExtent;
            final double minScroll = widget.controller.position.minScrollExtent;

            if (!_ticker.isActive) {
              _currentPos = currentActual;
              _scrollTarget = currentActual;
            }

            _scrollTarget = (_scrollTarget + delta).clamp(minScroll, maxScroll);

            if (!_ticker.isActive && _scrollTarget != _currentPos) {
              _lastTickTime = null;
              _ticker.start();
            }
          });
        }
      },
      child: widget.child,
    );
  }
}
