import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_cubit.dart';
import 'package:news_app/layout/news_states.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sport_screen.dart';


class NewsLayout extends StatelessWidget {
  List <Widget> screen =[const BusinessScreen(),const ScienceScreen(),const SportScreen()];

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit =NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('News'),
              actions: [
                IconButton(
                  onPressed: (){
                    cubit.changeMode();
              }, icon: const Icon(Icons.brightness_4_outlined)),
                IconButton(onPressed: (){

                }, icon: Icon(CupertinoIcons.globe))

              ],),
            body: screen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon:  Icon(Icons.monetization_on_rounded),label: 'Business'),
                BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),
                BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sport'),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
            ),

          );
        },
    );

  }
}
