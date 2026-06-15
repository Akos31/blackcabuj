import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/menu_data.dart';

class MenuSection extends StatefulWidget {
  final bool isMobile;

  const MenuSection({super.key, required this.isMobile});

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  int _activeCategoryIndex = 0;
  int? _hoveredCategoryIndex;
  late final List<GlobalKey> _tabKeys;

  @override
  void initState() {
    super.initState();
    _tabKeys = List.generate(menuCategories.length, (_) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool useMobileLayout = widget.isMobile || screenWidth < 1206;
    final double paddingVal = useMobileLayout ? 24.0 : 80.0;
    final activeCategory = menuCategories[_activeCategoryIndex];

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F5F0), // Cream paper
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Section header – menu style
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
                          '★  KÍNÁLATUNK  ★',
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
                      'BLACK CAB SELECTION',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'WhiskeyTown',
                        color: Color(0xFF1A1A1A),
                        fontSize: 42,
                        letterSpacing: 3,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 200,
                      height: 4,
                      color: const Color(0xFF1A1A1A),
                    ),
                    const SizedBox(height: 40),

                    // Category Tabs
                    _buildCategoryTabs(useMobileLayout),
                    const SizedBox(height: 40),

                    // Menu Grid
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        layoutBuilder:
                            (
                              Widget? currentChild,
                              List<Widget> previousChildren,
                            ) {
                              return Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  ...previousChildren.map(
                                    (child) => Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: child,
                                    ),
                                  ),
                                  if (currentChild != null) currentChild,
                                ],
                              );
                            },
                        child: KeyedSubtree(
                          key: ValueKey<int>(_activeCategoryIndex),
                          child: useMobileLayout
                              ? _buildMobileList(activeCategory.items)
                              : _buildDesktopGrid(activeCategory.items),
                        ),
                      ),
                    ),
                    if (activeCategory.subtitle == 'Smash' ||
                        activeCategory.subtitle == 'Klasszikus' ||
                        activeCategory.subtitle == 'Specialitások') ...[
                      const SizedBox(height: 36),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF1A1A1A).withOpacity(0.06),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          activeCategory.subtitle == 'Smash'
                              ? 'Single: 1 hús + 1 sajt   •   Double: 2 hús + 2 sajt   •   Triple: 3 hús + 3 sajt'
                              : 'Normál: 100g hús, 10cm zsemle   •   Nagy: 150g hús, 12.5cm zsemle   •   Normál dupla: 200g hús, 10cm zsemle   •   Nagy dupla: 300g hús, 12.5cm zsemle',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF888888),
                            fontSize: useMobileLayout ? 11.5 : 12.5,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildCategoryTabs(bool useMobileLayout) {
    final List<Widget> tabs = List.generate(menuCategories.length, (index) {
      final category = menuCategories[index];
      final isActive = index == _activeCategoryIndex;
      final isHovered = index == _hoveredCategoryIndex;

      Color bgColor;
      Color borderColor;
      Color contentColor;

      if (isActive) {
        bgColor = const Color(0xFFAD0F0F);
        borderColor = const Color(0xFFAD0F0F);
        contentColor = Colors.white;
      } else if (isHovered) {
        bgColor = Colors.white; // Keeps background white on hover
        borderColor = const Color(0xFFAD0F0F); // Theme red border on hover
        contentColor = const Color(0xFFAD0F0F); // Theme red text/icon on hover
      } else {
        bgColor = Colors.white;
        borderColor = const Color(0xFF1A1A1A);
        contentColor = const Color(0xFF1A1A1A);
      }

      return GestureDetector(
        key: _tabKeys[index],
        onTap: () {
          setState(() => _activeCategoryIndex = index);
          if (useMobileLayout) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final context = _tabKeys[index].currentContext;
              if (context != null) {
                try {
                  final scrollable = Scrollable.of(context);
                  final renderObject = context.findRenderObject();
                  if (renderObject != null) {
                    scrollable.position.ensureVisible(
                      renderObject,
                      alignment: 0.5,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                } catch (_) {}
              }
            });
          }
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hoveredCategoryIndex = index),
          onExit: (_) => setState(() => _hoveredCategoryIndex = null),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getCategoryIcon(category.icon),
                  color: contentColor,
                  size: 15,
                ),
                const SizedBox(width: 10),
                Text(
                  category.subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                    color: contentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });

    if (useMobileLayout) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: tabs.map((tab) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: tab,
            );
          }).toList(),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: tabs,
    );
  }

  Widget _buildDesktopGrid(List<MenuItem> items) {
    final bool isFourItems = items.length == 4;
    final int crossAxisCount = isFourItems ? 2 : 3;

    final double spacing = 24.0;
    final List<Widget> rows = [];

    for (int i = 0; i < items.length; i += crossAxisCount) {
      final List<MenuItem> rowItems = items.sublist(
        i,
        (i + crossAxisCount) < items.length
            ? (i + crossAxisCount)
            : items.length,
      );

      // Determine the card height for this row
      double rowCardHeight = 215.0;

      final List<Widget> cardWidgets = rowItems.map((item) {
        return Expanded(
          child: _MenuCard(
            item: item,
            height: rowCardHeight - 24.0, // vertical padding
          ),
        );
      }).toList();

      // Pad out incomplete rows with empty spacers
      while (cardWidgets.length < crossAxisCount) {
        cardWidgets.add(const Expanded(child: SizedBox()));
      }

      final List<Widget> rowChildren = [];
      for (int j = 0; j < cardWidgets.length; j++) {
        rowChildren.add(cardWidgets[j]);
        if (j < cardWidgets.length - 1) {
          rowChildren.add(SizedBox(width: spacing));
        }
      }

      rows.add(
        SizedBox(
          height: rowCardHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowChildren,
          ),
        ),
      );

      if (i + crossAxisCount < items.length) {
        rows.add(SizedBox(height: spacing));
      }
    }

    return Column(mainAxisSize: MainAxisSize.min, children: rows);
  }

  Widget _buildMobileList(List<MenuItem> items) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _MenuCard(item: item),
        );
      }).toList(),
    );
  }

  IconData _getCategoryIcon(String name) {
    switch (name) {
      case 'hamburger':
        return FontAwesomeIcons.burger;
      case 'star':
        return FontAwesomeIcons.star;
      case 'utensils':
        return FontAwesomeIcons.utensils;
      case 'drink':
        return FontAwesomeIcons.glassWater;
      case 'hotdog':
        return FontAwesomeIcons.hotdog;
      default:
        return FontAwesomeIcons.burger;
    }
  }
}

class _MenuCard extends StatefulWidget {
  final MenuItem item;
  final double? height;

  const _MenuCard({required this.item, this.height});

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard> {
  late String _selectedSize;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.item.prices.keys.first;
  }

  @override
  void didUpdateWidget(covariant _MenuCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.name != widget.item.name) {
      _selectedSize = widget.item.prices.keys.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int activePrice = widget.item.prices[_selectedSize] ?? 0;
    final String activeDescription =
        widget.item.descriptions?[_selectedSize] ?? widget.item.description;

    Widget cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Icon box
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xFFF8F5F0),
              child: _getItemIconWidget(widget.item.baseIcon),
            ),
            const SizedBox(width: 18),

            // Right: Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Price row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF1A1A1A),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: GoogleFonts.outfit(
                          color: const Color(0xFFAD0F0F),
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                        child: Text('$activePrice'),
                      ),
                    ],
                  ),
                  // Price label
                  Text(
                    'Ft',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFFAD0F0F),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Description
                  Text(
                    activeDescription,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF666666),
                      fontSize: 14,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (widget.height != null) const Spacer(),
        if (widget.height == null) const SizedBox(height: 10),

        // Size selectors
        if (widget.item.prices.length > 1)
          _buildSizeSelector()
        else
          const SizedBox(height: 12),
      ],
    );

    if (widget.height != null) {
      cardContent = SizedBox(height: widget.height, child: cardContent);
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: _isHovered ? 12 : 14,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: _isHovered
                  ? const Color(0xFFAD0F0F)
                  : const Color(0xFF1A1A1A),
              width: _isHovered ? 4 : 2,
            ),
            left: const BorderSide(color: Color(0xFF1A1A1A), width: 1),
            right: const BorderSide(color: Color(0xFF1A1A1A), width: 1),
            bottom: const BorderSide(color: Color(0xFF1A1A1A), width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? const Color(0xFFAD0F0F).withOpacity(0.10)
                  : Colors.black.withOpacity(0.06),
              blurRadius: _isHovered ? 16 : 8,
              offset: const Offset(3, 4),
            ),
          ],
        ),
        child: cardContent,
      ),
    );
  }

  Widget _buildSizeSelector() {
    final bool isCompact = widget.item.prices.length >= 4;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: widget.item.prices.keys.map((sizeKey) {
        return _SizeButton(
          label: sizeKey,
          isSelected: sizeKey == _selectedSize,
          isCompact: isCompact,
          onTap: () => setState(() => _selectedSize = sizeKey),
        );
      }).toList(),
    );
  }

  Widget _getItemIconWidget(String name) {
    const Color iconColor = Color(0xFFAD0F0F);
    const double iconSize = 30.0;

    switch (name) {
      case 'cow':
        return const Icon(
          FontAwesomeIcons.cow,
          color: iconColor,
          size: iconSize,
        );
      case 'chicken':
        return const Icon(
          FontAwesomeIcons.dove,
          color: iconColor,
          size: iconSize,
        );
      case 'fish':
        return const Icon(
          FontAwesomeIcons.fish,
          color: iconColor,
          size: iconSize,
        );
      case 'hotdog':
        return const Icon(
          FontAwesomeIcons.hotdog,
          color: iconColor,
          size: iconSize,
        );
      case 'drink':
        return const Icon(
          FontAwesomeIcons.glassWater,
          color: iconColor,
          size: iconSize,
        );
      case 'salad':
        return const Icon(
          FontAwesomeIcons.bowlFood,
          color: iconColor,
          size: iconSize,
        );
      case 'pineapple':
        return SizedBox(
          width: iconSize,
          height: iconSize,
          child: CustomPaint(painter: _PineapplePainter(iconColor)),
        );
      case 'fries':
        return SizedBox(
          width: iconSize,
          height: iconSize,
          child: CustomPaint(painter: _FriesPainter(iconColor)),
        );
      case 'onion_rings':
        return SizedBox(
          width: iconSize,
          height: iconSize,
          child: CustomPaint(painter: _OnionRingsPainter(iconColor)),
        );
      default:
        return const Icon(
          FontAwesomeIcons.utensils,
          color: iconColor,
          size: iconSize,
        );
    }
  }
}

class _SizeButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool isCompact;
  final VoidCallback onTap;

  const _SizeButton({
    required this.label,
    required this.isSelected,
    this.isCompact = false,
    required this.onTap,
  });

  @override
  State<_SizeButton> createState() => _SizeButtonState();
}

class _SizeButtonState extends State<_SizeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.isSelected;
    Color bgColor;
    Color borderColor;
    Color textColor;

    if (isSelected) {
      bgColor = const Color(0xFFAD0F0F);
      borderColor = const Color(0xFFAD0F0F);
      textColor = Colors.white;
    } else if (_isHovered) {
      bgColor = Colors.white; // Keeps background white on hover
      borderColor = const Color(0xFFAD0F0F); // Theme red border on hover
      textColor = const Color(0xFFAD0F0F); // Theme red text on hover
    } else {
      bgColor = Colors.white;
      borderColor = const Color(0xFF888888);
      textColor = const Color(0xFF555555);
    }

    final double horizontalPadding = widget.isCompact ? 7.0 : 10.0;
    final double fontSize = widget.isCompact ? 11.5 : 12.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.outfit(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: widget.isCompact ? 0.2 : 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _PineapplePainter extends CustomPainter {
  final Color color;
  const _PineapplePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final Rect bodyRect = Rect.fromLTWH(
      size.width * 0.15,
      size.height * 0.35,
      size.width * 0.7,
      size.height * 0.6,
    );
    canvas.drawOval(bodyRect, paint);

    final path = Path()..addOval(bodyRect);
    canvas.save();
    canvas.clipPath(path);
    for (double i = -size.width; i < size.width * 2; i += 7) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
      canvas.drawLine(
        Offset(i, size.height),
        Offset(i + size.height, 0),
        paint,
      );
    }
    canvas.restore();

    final leafPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    final leafPath = Path();
    leafPath.moveTo(size.width * 0.5, size.height * 0.05);
    leafPath.quadraticBezierTo(
      size.width * 0.45,
      size.height * 0.25,
      size.width * 0.5,
      size.height * 0.35,
    );
    leafPath.quadraticBezierTo(
      size.width * 0.55,
      size.height * 0.25,
      size.width * 0.5,
      size.height * 0.05,
    );

    leafPath.moveTo(size.width * 0.5, size.height * 0.35);
    leafPath.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.15,
      size.width * 0.25,
      size.height * 0.1,
    );
    leafPath.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.25,
      size.width * 0.5,
      size.height * 0.35,
    );

    leafPath.moveTo(size.width * 0.5, size.height * 0.35);
    leafPath.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.15,
      size.width * 0.75,
      size.height * 0.1,
    );
    leafPath.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.25,
      size.width * 0.5,
      size.height * 0.35,
    );

    canvas.drawPath(leafPath, leafPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FriesPainter extends CustomPainter {
  final Color color;
  const _FriesPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final boxPath = Path()
      ..moveTo(size.width * 0.2, size.height * 0.45)
      ..lineTo(size.width * 0.25, size.height * 0.95)
      ..lineTo(size.width * 0.75, size.height * 0.95)
      ..lineTo(size.width * 0.8, size.height * 0.45)
      ..close();
    canvas.drawPath(boxPath, paint);

    final lipPath = Path()
      ..moveTo(size.width * 0.2, size.height * 0.45)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.55,
        size.width * 0.8,
        size.height * 0.45,
      );
    canvas.drawPath(lipPath, paint);

    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.48),
      Offset(size.width * 0.28, size.height * 0.15),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.38, size.height * 0.48),
      Offset(size.width * 0.36, size.height * 0.1),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.48, size.height * 0.48),
      Offset(size.width * 0.49, size.height * 0.08),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.58, size.height * 0.48),
      Offset(size.width * 0.56, size.height * 0.12),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.67, size.height * 0.48),
      Offset(size.width * 0.7, size.height * 0.05),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.74, size.height * 0.48),
      Offset(size.width * 0.77, size.height * 0.2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OnionRingsPainter extends CustomPainter {
  final Color color;
  const _OnionRingsPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.65),
        width: size.width * 0.4,
        height: size.height * 0.4,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.65),
        width: size.width * 0.22,
        height: size.height * 0.22,
      ),
      paint,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.65, size.height * 0.48),
        width: size.width * 0.45,
        height: size.height * 0.45,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.65, size.height * 0.48),
        width: size.width * 0.25,
        height: size.height * 0.25,
      ),
      paint,
    );
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
