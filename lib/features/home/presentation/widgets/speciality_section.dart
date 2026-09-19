import 'package:flutter/material.dart';
import 'package:docdoc/core/theme/colors.dart';
import 'package:docdoc/core/utils/app_images.dart';
import 'package:docdoc/core/widgets/app_image.dart';
import 'package:docdoc/features/home/data/models/home_model.dart';

class SpecialitySection extends StatelessWidget {
  final List<SpecializationModel> specializations;
  const SpecialitySection({super.key, required this.specializations});

  static const Map<String, String> _assetMap = {
    'general': AppImages.specialityGeneral,
    'neurolog': AppImages.specialityNeurologic,
    'pediatric': AppImages.specialityPediatric,
    'radiology': AppImages.specialityRadiology,
  };

  // Fallback colors when no image match
  static const List<Color> _bgColors = [
    Color(0xFFEAF1FF),
    Color(0xFFFFEAEA),
    Color(0xFFEAFFEF),
    Color(0xFFFFF5EA),
    Color(0xFFF0EAFF),
    Color(0xFFEAFFF9),
  ];

  static const List<IconData> _fallbackIcons = [
    Icons.local_hospital_outlined,
    Icons.psychology_outlined,
    Icons.child_care_outlined,
    Icons.biotech_outlined,
    Icons.favorite_border,
    Icons.accessibility_new_outlined,
  ];

  String? _resolveAsset(String name) {
    final lower = name.toLowerCase();
    for (final key in _assetMap.keys) {
      if (lower.contains(key)) return _assetMap[key];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Build display list: use API data or fallback
    final List<(String, String?)> displayItems = specializations.isEmpty
        ? [
            ('General', AppImages.specialityGeneral),
            ('Neurologic', AppImages.specialityNeurologic),
            ('Pediatric', AppImages.specialityPediatric),
            ('Radiology', AppImages.specialityRadiology),
          ]
        : specializations
              .map((s) => (s.name, s.image ?? _resolveAsset(s.name)))
              .toList();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Doctor Speciality',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'See All',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: displayItems.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final (name, assetPath) = displayItems[index];
              final i = index % _bgColors.length;
              return _SpecialityChip(
                label: name,
                assetPath: assetPath,
                bgColor: _bgColors[i],
                fallbackIcon: _fallbackIcons[i],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SpecialityChip extends StatelessWidget {
  final String label;
  final String? assetPath;
  final Color bgColor;
  final IconData fallbackIcon;

  const _SpecialityChip({
    required this.label,
    required this.assetPath,
    required this.bgColor,
    required this.fallbackIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: assetPath != null
              ? Padding(
                  padding: const EdgeInsets.all(14),
                  child: AppImage(imagePath: assetPath!),
                )
              : Icon(fallbackIcon, size: 28),
        ),
        const SizedBox(height: 7),
        SizedBox(
          width: 66,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF444444),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
