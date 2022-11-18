import 'package:diaries_or_notes/layout/app_layout/app_layout.dart';
import 'package:diaries_or_notes/shared/cubit/cubit.dart';
import 'package:diaries_or_notes/shared/cubit/states.dart';
import 'package:diaries_or_notes/shared/network/local/cache_helper.dart';
import 'package:diaries_or_notes/shared/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: "isDark")?? false;
  runApp( MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {
  final bool isDark;
   MyApp({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<AppCubit>(
      create: (context)=>AppCubit()..createDatabase()..changeAppMood(fromShared: isDark),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , states){},
        builder:(context , states){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'diaries or notes ',
            home: AppLayOut(),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:AppCubit.get(context).isDark?ThemeMode.dark :ThemeMode.light,

          );
        } ,

      ),
    ) ;
  }
}
