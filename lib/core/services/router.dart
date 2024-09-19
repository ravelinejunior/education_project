import 'package:education_project/core/common/views/page_under_construction.dart';
import 'package:education_project/core/extensions/context_extensions.dart';
import 'package:education_project/core/services/injection_container.dart';
import 'package:education_project/src/auth/data/model/user_model.dart';
import 'package:education_project/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:education_project/src/auth/presentation/views/sign_in_screen.dart';
import 'package:education_project/src/auth/presentation/views/sign_up_screen.dart';
import 'package:education_project/src/dashboard/presentation/views/dashboard_screen.dart';
import 'package:education_project/src/on_boarding/data/datasource/local_data_source.dart';
import 'package:education_project/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_project/src/on_boarding/presentation/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router_main.dart';
