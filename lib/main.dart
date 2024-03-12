import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reccuring_reminder/common/values/colors.dart';
import 'package:flutter_reccuring_reminder/pages/input/bloc/input_bloc.dart';
import 'package:flutter_reccuring_reminder/pages/input/input_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InputBloc>(
          create: (context) => InputBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, chid) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainTheme),
            useMaterial3: true,
          ),
          home: const InputPage(),
        ),
      ),
    );
  }
}
