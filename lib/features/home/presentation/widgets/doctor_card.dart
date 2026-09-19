import 'package:flutter/material.dart';
import 'package:docdoc/core/theme/colors.dart';
import 'package:docdoc/core/utils/app_images.dart';
import 'package:docdoc/features/home/data/models/home_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Doctor avatar
                Container(
                  width: 76,
                  height: 86,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFFEAF3FF),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: _resolveAvatar(),
                ),
                const SizedBox(width: 14),

                // Doctor info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${doctor.name}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      // Specialization + Hospital row
                      Row(
                        children: [
                          if (doctor.specialization != null)
                            Flexible(
                              child: Text(
                                doctor.specialization!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.greyText,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          if (doctor.specialization != null &&
                              doctor.hospital != null)
                            const Text(
                              ' | ',
                              style: TextStyle(
                                  color: AppColors.greyText, fontSize: 12),
                            ),
                          if (doctor.hospital != null)
                            Flexible(
                              child: Text(
                                doctor.hospital!,
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.greyText),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Rating row
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8E1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star_rounded,
                                    color: Colors.amber, size: 15),
                                const SizedBox(width: 3),
                                Text(
                                  doctor.rating != null
                                      ? doctor.rating!.toStringAsFixed(1)
                                      : '—',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1A1A2E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (doctor.reviewsCount != null) ...[
                            const SizedBox(width: 6),
                            Text(
                              '(${doctor.reviewsCount} reviews)',
                              style: const TextStyle(
                                  fontSize: 11, color: AppColors.greyText),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow button
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.primaryBlue,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _resolveAvatar() {
    // Try network image first (API provided)
    if (doctor.image != null && doctor.image!.isNotEmpty) {
      return Image.network(
        doctor.image!,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primaryBlue,
            ),
          );
        },
        errorBuilder: (_, _, _) => _localPlaceholder(),
      );
    }
    return _localPlaceholder();
  }

  // Use the bundled "Recommendation Doctor.png" as placeholder
  Widget _localPlaceholder() {
    return Image.asset(
      AppImages.recommendationDoctor,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => const Center(
        child: Icon(Icons.person_rounded, size: 36, color: AppColors.primaryBlue),
      ),
    );
  }
}
