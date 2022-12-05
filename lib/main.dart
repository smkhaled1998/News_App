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
import 'package:news_app/shared/styles.dart';

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
            theme: lightMode,
            darkTheme: darkMode,
            themeMode:cubit.isDark? ThemeMode.dark:ThemeMode.light,
            home:
            Directionality(textDirection: TextDirection.rtl, child: NewsLayout()),
          );
        },
      ),
    );
  }
}
