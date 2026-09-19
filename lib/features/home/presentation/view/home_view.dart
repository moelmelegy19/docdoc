import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:docdoc/core/routing/route_names.dart';
import 'package:docdoc/core/theme/colors.dart';
import 'package:docdoc/features/home/manager/cubit/home_cubit.dart';
import 'package:docdoc/features/home/manager/cubit/home_state.dart';
import 'package:docdoc/features/home/presentation/widgets/home_app_bar.dart';
import 'package:docdoc/features/home/presentation/widgets/home_banner.dart';
import 'package:docdoc/features/home/presentation/widgets/speciality_section.dart';
import 'package:docdoc/features/home/presentation/widgets/doctor_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeFailure) {
              if (state.errorMessage.contains('authenticated')) {
                context.go(RouteNames.signIn);
              }
            }
          },
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue),
              );
            }

            if (state is HomeFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off_rounded, size: 64, color: AppColors.greyText),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.greyText, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.read<HomeCubit>().fetchHome(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Retry', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeSuccess) {
              return RefreshIndicator(
                color: AppColors.primaryBlue,
                onRefresh: () => context.read<HomeCubit>().fetchHome(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // App Bar
                      HomeAppBar(username: state.username),
                      const SizedBox(height: 24),

                      // Banner
                      const HomeBanner(),
                      const SizedBox(height: 28),

                      // Speciality section
                      SpecialitySection(specializations: state.homeData.specializations),
                      const SizedBox(height: 28),

                      // Recommended Doctors header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recommendation Doctor',
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

                      // Doctors list
                      if (state.homeData.doctors.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'No doctors available',
                              style: TextStyle(color: AppColors.greyText),
                            ),
                          ),
                        )
                      else
                        ...state.homeData.doctors
                            .map((doctor) => DoctorCard(doctor: doctor)),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: _BottomNav(),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_outlined, isActive: true, onTap: () {}),
          _NavItem(icon: Icons.chat_bubble_outline_rounded, badge: true, onTap: () {}),
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search_rounded, color: Colors.white, size: 24),
          ),
          _NavItem(icon: Icons.calendar_today_outlined, onTap: () {}),
          _NavItem(
            icon: Icons.person_outline_rounded,
            onTap: () => context.push(RouteNames.profile),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final bool badge;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    this.isActive = false,
    this.badge = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            icon,
            size: 26,
            color: isActive ? AppColors.primaryBlue : AppColors.greyText,
          ),
          if (badge)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
