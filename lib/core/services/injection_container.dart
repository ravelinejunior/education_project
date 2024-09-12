import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_project/src/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:education_project/src/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:education_project/src/auth/domain/repository/auth_repository.dart';
import 'package:education_project/src/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/signin_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/signup_use_case.dart';
import 'package:education_project/src/auth/domain/use_cases/update_user_use_case.dart';
import 'package:education_project/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:education_project/src/on_boarding/data/datasource/local_data_source.dart';
import 'package:education_project/src/on_boarding/data/repository_impl/on_boarding_repository_impl.dart';
import 'package:education_project/src/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:education_project/src/on_boarding/domain/use_cases/cache_user_first_timer.dart';
import 'package:education_project/src/on_boarding/domain/use_cases/check_user_is_first_timer.dart';
import 'package:education_project/src/on_boarding/presentation/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';
