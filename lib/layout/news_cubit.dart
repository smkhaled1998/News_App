import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_states.dart';
import 'package:news_app/shared/network/cashe_helper.dart';
import 'package:news_app/shared/network/dio-helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex =0;
  void changeBottomNavBar (int index){
    currentIndex=index;
    print("current index is $currentIndex");
    if(currentIndex==0){getBusiness('eg');}
    if(currentIndex==1){getScience('eg');}
    if(currentIndex==2){getSport('eg');}
    emit(NewsChangeBottomBarState());
  }

   List <dynamic> business=[];
  void getBusiness(country){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apikey':'81d40cce422e4cb5b487aabd87c7ba41',
        }).then((value){
          business=value.data['articles'];
          emit(NewsGetBusinessSuccessState());

    }).catchError((error){
      print('Error is ${error.toString()}');
      emit(NewsGetBusinessErrorState());
    });

  }

  List <dynamic> sport=[];
  void getSport(country){
    emit(NewsGetSportLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sport',
          'apikey':'81d40cce422e4cb5b487aabd87c7ba41',
        }).then((value){
      sport=value.data['articles'];
      emit(NewsGetSportSuccessState());
    }).catchError((error){
      print('Error is ${error.toString()}');
      emit(NewsGetSportErrorState());
    });

  }

  List <dynamic> science=[];
  void getScience(country){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apikey':'81d40cce422e4cb5b487aabd87c7ba41',
        }).then((value){
      science=value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print('Error is ${error.toString()}');
      emit(NewsGetScienceErrorState());
    });

  }

  bool isDark=false;
  void changeMode({
   bool? fromShared
}){
    if (fromShared != null){
      isDark=fromShared;
    }
    else {isDark=! isDark;
    CacheHelper.putMode(key: 'isDark', value: isDark).then((value) { emit(NewsChangeAppMode());});}
  }

  }




//https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=81d40cce422e4cb5b487aabd87c7ba41