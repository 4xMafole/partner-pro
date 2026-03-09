import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/theme/app_colors.dart';
import '../../data/models/property_model.dart';

/// Captures a branded property card as a PNG image and shares it.
Future<void> sharePropertyCard(
  BuildContext context,
  PropertyDataClass property,
  String propertyId,
) async {
  final repaintKey = GlobalKey();

  final overlay = OverlayEntry(
    builder: (_) => Material(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 16.h),
            Text(
              'Preparing share card…',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    ),
  );

  final card = _ShareCardContent(property: property, propertyId: propertyId);

  // Render off-screen so RepaintBoundary can capture it.
  final offstageOverlay = OverlayEntry(
    builder: (_) => Positioned(
      left: -2000,
      top: -2000,
      child: RepaintBoundary(
        key: repaintKey,
        child: MediaQuery(
          data: const MediaQueryData(
            size: Size(400, 600),
            devicePixelRatio: 3.0,
          ),
          child: Material(
            color: Colors.transparent,
            child: SizedBox(width: 400, child: card),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlay);
  Overlay.of(context).insert(offstageOverlay);

  try {
    // Give time for the network image to load and widget to layout.
    await Future.delayed(const Duration(milliseconds: 1200));

    final boundary =
        repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) {
      offstageOverlay.remove();
      overlay.remove();
      return;
    }

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    offstageOverlay.remove();

    if (byteData == null) {
      overlay.remove();
      return;
    }

    final pngBytes = byteData.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/property_share.png');
    await file.writeAsBytes(pngBytes);

    overlay.remove();

    final address = _shareAddress(property);
    final price = _sharePrice(property.listPrice);
    final caption = '$price · $address\nShared via PartnerPro Real Estate';

    await Share.shareXFiles([XFile(file.path)], text: caption);
  } catch (e) {
    offstageOverlay.remove();
    overlay.remove();
    debugPrint('Share card error: $e');
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────

String _shareAddress(PropertyDataClass p) {
  final parts = [p.address.streetName, p.address.city, p.address.state]
      .where((s) => s.isNotEmpty);
  return parts.isNotEmpty ? parts.join(', ') : p.propertyName;
}

String _sharePrice(int price) {
  return '\$${price.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]},',
      )}';
}

// ── Card Widget (rendered into an image) ─────────────────────────────────────

class _ShareCardContent extends StatelessWidget {
  final PropertyDataClass property;
  final String propertyId;

  const _ShareCardContent({
    required this.property,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    final address = _shareAddress(property);
    final price = _sharePrice(property.listPrice);
    final imageUrl = property.media.isNotEmpty ? property.media.first : '';

    // Status
    String statusLabel = 'FOR SALE';
    Color statusColor = const Color(0xFF2E7D32);
    if (property.isSold) {
      statusLabel = 'SOLD';
      statusColor = const Color(0xFFC62828);
    } else if (property.isPending) {
      statusLabel = 'PENDING';
      statusColor = const Color(0xFFF57F17);
    } else if (property.inContract) {
      statusLabel = 'IN CONTRACT';
      statusColor = const Color(0xFF1565C0);
    }

    // Features
    final features = <_Feature>[];
    if (property.bedrooms > 0) {
      features.add(_Feature('${property.bedrooms}', 'Beds'));
    }
    if (property.bathrooms > 0) {
      features.add(_Feature('${property.bathrooms}', 'Baths'));
    }
    if (property.squareFootage > 0) {
      features.add(_Feature(
        property.squareFootage.toString().replaceAllMapped(
              RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
              (m) => '${m[1]},',
            ),
        'Sqft',
      ));
    }
    if (property.yearBuilt > 0) {
      features.add(_Feature('${property.yearBuilt}', 'Year'));
    }

    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image section ──
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (imageUrl.isNotEmpty)
                  Image.network(imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _imagePlaceholder())
                else
                  _imagePlaceholder(),

                // Bottom gradient
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                ),

                // Status badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(statusLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        )),
                  ),
                ),

                // Price
                Positioned(
                  bottom: 14,
                  left: 16,
                  child: Text(price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        shadows: [Shadow(color: Colors.black54, blurRadius: 8)],
                      )),
                ),

                // Photo count
                if (property.media.length > 1)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.camera,
                              size: 12, color: Colors.white),
                          const SizedBox(width: 4),
                          Text('${property.media.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── Details section ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Address
                Text(address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF14181B),
                      height: 1.3,
                    )),
                const SizedBox(height: 4),

                if (property.propertyType.isNotEmpty)
                  Text(property.propertyType,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF57636C),
                      )),
                const SizedBox(height: 14),

                // Stats row
                if (features.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: features
                          .map((f) => _featureColumn(f.value, f.label))
                          .toList(),
                    ),
                  ),
                const SizedBox(height: 14),

                // Branding footer
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD0B27D),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text('P',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            )),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PartnerPro',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF14181B),
                            )),
                        Text('Real Estate',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF95A1AC),
                            )),
                      ],
                    ),
                    const Spacer(),
                    if (property.mlsId.isNotEmpty)
                      Text('MLS# ${property.mlsId}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF95A1AC),
                          )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _imagePlaceholder() => Container(
        color: const Color(0xFFF1F4F8),
        child: const Center(
          child: Icon(LucideIcons.image, size: 48, color: Color(0xFF95A1AC)),
        ),
      );

  static Widget _featureColumn(String value, String label) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF14181B),
              )),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFF57636C),
              )),
        ],
      );
}

class _Feature {
  final String value;
  final String label;
  const _Feature(this.value, this.label);
}
