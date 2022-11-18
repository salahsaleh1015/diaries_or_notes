import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:diaries_or_notes/shared/component/component.dart';
import 'package:diaries_or_notes/shared/cubit/cubit.dart';
import 'package:diaries_or_notes/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var tasks = AppCubit.get(context).archivedTasks;
        return buildConditionalList(tasks: tasks

        );
      },


    );
  }
}
