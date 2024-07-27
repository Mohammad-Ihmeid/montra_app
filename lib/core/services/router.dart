import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/common/views/page_under_construction.dart';
import 'package:montra_app/core/services/injection_container.dart';
import 'package:montra_app/src/add_transaction/presentation/views/expense_screen.dart';
import 'package:montra_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:montra_app/src/auth/presentation/views/email_verify_screen.dart';
import 'package:montra_app/src/auth/presentation/views/sign_in_screen.dart';
import 'package:montra_app/src/auth/presentation/views/sign_up_screen.dart';
import 'package:montra_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:montra_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:montra_app/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:montra_app/src/on_boarding/presentation/views/splash_screen.dart';

part 'router.main.dart';
