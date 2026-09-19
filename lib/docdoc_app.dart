import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:docdoc/core/api/api_service.dart';
import 'package:docdoc/core/routing/app_router.dart';
import 'package:docdoc/features/sign_in/manager/cubit/sign_in_cubit.dart';
import 'package:docdoc/features/sign_in/data/repos/sign_in_repo_impl.dart';
import 'package:docdoc/features/sign_up/manager/cubit/sign_up_cubit.dart';
import 'package:docdoc/features/sign_up/data/repos/sign_up_repo_impl.dart';

class DocdocApp extends StatelessWidget {
  const DocdocApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(Dio());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInCubit(SignInRepoImpl(apiService)),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(SignUpRepoImpl(apiService)),
        ),
      ],
      child: MaterialApp.router(
        title: 'Docdoc App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}