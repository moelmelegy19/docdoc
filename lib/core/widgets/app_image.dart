import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders a local asset image (SVG or raster) detected by file extension.
/// No fixed size — let the parent widget control dimensions.
class AppImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const AppImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
  });

  bool get _isSvg => imagePath.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    }
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      color: color,
      errorBuilder: (_, _, _) => const SizedBox.shrink(),
    );
  }
}
