import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:diaries_or_notes/shared/cubit/cubit.dart';
import 'package:diaries_or_notes/shared/cubit/states.dart';
import 'package:diaries_or_notes/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType? type,
  Function? onFieldSubmitted,
  required ValueChanged<String> onChanged,
  bool isPassword = false,
  Function(String)? onSubmit,
  required FormFieldValidator<String> validator,
  IconData? prefixIcon,
  IconData? suffixIxIcon,
  String? label,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
}) =>
    SizedBox(
      height: 40,

      child: TextFormField(

        onTap: onTap,
        obscureText: isPassword,
        keyboardType: type,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onSubmit,
        decoration: InputDecoration(
          focusColor: defaultLightColor,

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: defaultLightColor, width: 2.0),
            borderRadius: BorderRadius.circular(25),
          ),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(25),
          // ),
          prefixIcon: Icon(prefixIcon),
          labelText: label,
          suffixIcon: suffixIxIcon != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: const Icon(Icons.visibility_off_sharp))
              : null,
        ),
      ),
    );
Widget buildTaskItem(context, Map model) => Dismissible(
      key: Key(model['id'].toString()),
      child: Card(
        color: AppCubit.get(context).isDark ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        margin: const EdgeInsets.all(10),
        elevation: 10,
        child: Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppCubit.get(context).isDark ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("${model['title']}",
                        style: Theme.of(context).textTheme.bodyText1),
                    const Spacer(),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: defaultLightColor,
                      child: Center(
                        child: Text("${model['id']}"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text("${model['task']}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: defaultLightColor,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text("${model['location']}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: defaultLightColor
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_alarms_outlined,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("${model['time']}",
                        style: Theme.of(context).textTheme.caption),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context)
                            .updateData(status: "done", id: model['id']);
                      },
                      icon: const Icon(
                        Icons.done,
                        color: defaultLightColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context)
                            .updateData(status: "archive", id: model['id']);
                      },
                      icon: const Icon(
                        Icons.archive,
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );
Widget buildConditionalList({required List<Map> tasks}) => BlocConsumer<AppCubit , AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: tasks.length > 0,
            builder: (context) => ListView.builder(
              physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildTaskItem(context, tasks[index]);
                  },
                  itemCount: tasks.length,
                ),
            fallback: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.list,
                        size: 80,
                        color: defaultLightColor,
                      ),
                      Text(
                        "enter your tasks",
                        style: Theme.of(context).textTheme.bodyText1
                      ),
                    ],
                  ),
                ));
      },
    );
