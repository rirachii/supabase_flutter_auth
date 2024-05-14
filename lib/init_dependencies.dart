import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/secrets/app_secrets.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:blog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/usecases/current_user.dart';
import 'package:blog/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog/features/auth/domain/usecases/logout_usecase.dart';
import 'package:blog/features/auth/domain/usecases/signup_usecase.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // need <AuthRemoteDataSource> since registerFactory needs a AuthRemoteDataSource
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      // brand new instance of AuthSupabaseDataSourceImpl
      () => AuthSupabaseDataSourceImpl(
        // it will get the supabase client from above
        serviceLocator(),
      ),
    )

    // repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )

    // usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignOut(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        userSignOut: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
