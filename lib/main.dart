import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_cubit.dart';

import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/layout/news_states.dart';
import 'package:news_app/shared/network/local/cashe_helper.dart';
import 'package:news_app/shared/network/remote/dio-helper.dart';

import 'shared/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark =CacheHelper.getMode(key: 'isDark');

  Bloc.observer = MyBlocObserver();
  runApp(Myapp(isDark));
}

class Myapp extends StatelessWidget {
// comment for github
  final bool? isDark;
   Myapp(this.isDark);
  @override
  Widget build(BuildContext context) // function return widget
  {
    return BlocProvider(
      create: (context)=>NewsCubit()..getBusiness()..getScience()..getSport()..changeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NewsCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black)),
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white),
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
                actionsIconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed, elevation: 0),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: HexColor('333739'),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light),
              ),
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('333739'),
                elevation: 0,
                unselectedItemColor: Colors.grey,
              ),
            ),
            themeMode:cubit.isDark? ThemeMode.dark:ThemeMode.light,
            home:
            Directionality(textDirection: TextDirection.ltr, child: NewsLayout()),
          );
        },
      ),
    );
  }
}
