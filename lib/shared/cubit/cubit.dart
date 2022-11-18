import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:diaries_or_notes/module/archived_tasks/archived_tasks.dart';
import 'package:diaries_or_notes/module/done_tasks/done_tasks_screen.dart';
import 'package:diaries_or_notes/module/new_tasks/new_tasks_screen.dart';
import 'package:diaries_or_notes/shared/cubit/states.dart';
import 'package:diaries_or_notes/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../style/colors.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  //=================================================================

  List<Widget> screens = const [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  List<String> titles = [
    "new tasks",
    "done tasks",
    "archived tasks",
  ];
  int currentIndex = 0;
  void changeBottomNavBarState(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  //==================================================================
  IconData fabIcon = Icons.add;
  bool isBottomSheetShown = false;
  void changeBottomSheetState({required IconData icon , required bool isShow }){
    fabIcon = icon;
    isBottomSheetShown = isShow;
    emit(AppBottomSheetState());
  }
  //==================================================================
  bool isDark = false;

  void changeAppMood({bool? fromShared}){
    if(fromShared!= null){
      isDark = fromShared;
      emit(AppChangeMoodState());
    }else{
      isDark = ! isDark;
      CacheHelper.setData(key: "isDark", value: isDark).then((value) {
        emit(AppChangeMoodState());
      });

    }

  }
  //====================================================================

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];


  void createDatabase()  {
     openDatabase('local.db', version: 1,
        onCreate: (database, version) async {

      await database
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY , title TEXT ,task TEXT ,location TEXT , time TEXT ,  status TEXT)')
          .then((value) {
        print("database created");

      }).catchError((error) {
        print(error.toString());
      });
    }, onOpen: (database)  {
       getDataFromDatabase(database);
       emit(AppGetDatabaseState());
      print("database opened");
    }).then((value){
      database = value;
      emit(AppCreateDatabase());
     });
  }

   insertIntoDatabase({
    required String title,
    required String time,
    required String location,
    required String task,
  }) async {
     await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Tasks(title,task,  location, time , status) VALUES("$title", "$task", "$location","$time","new")')
          .then((value) {
        getDataFromDatabase(database);
        emit(AppGetDatabaseState());
        print('data inserted');
        print(value.toString());
        emit(AppInsertIntoDatabase());

      }).catchError((error) {
        print(error.toString());
      });
    });
  }

  getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('SELECT * FROM Tasks').then((value) {

      value.forEach((element) {
        if (element['status'] == "new")
          newTasks.add(element);
        else if (element['status'] == "done")
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  updateData({required String status, required int id}) {
    database.rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?', [
      '$status',
      id,
    ]).then((value) {
     getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  deleteData({required int id}) {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
