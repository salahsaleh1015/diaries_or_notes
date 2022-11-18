import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:diaries_or_notes/shared/component/component.dart';
import 'package:diaries_or_notes/shared/cubit/cubit.dart';
import 'package:diaries_or_notes/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../shared/style/colors.dart';

class AppLayOut extends StatefulWidget {
   AppLayOut({Key? key}) : super(key: key);

  @override
  State<AppLayOut> createState() => _AppLayOutState();
}

class _AppLayOutState extends State<AppLayOut> {
var scaffoldKey = GlobalKey<ScaffoldState>();

   var formKey = GlobalKey<FormState>();

   var titleController = TextEditingController();

   var locationController = TextEditingController();

   var timeController = TextEditingController();

   var taskController = TextEditingController();

   late PageController pageController;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (BuildContext context , AppStates state){
        if(state is AppInsertIntoDatabase){
          Navigator.pop(context);
        }
      },
      builder:(BuildContext context , AppStates state){
        var cubit = AppCubit.get(context);
        return Scaffold(
          // backgroundColor: Colors.grey[100],
          key: scaffoldKey,
          appBar: AppBar(
           // backgroundColor: Colors.grey[100],
            title: Text(cubit.titles[cubit.currentIndex]),
            // elevation: 5.0,
            actions: [
              IconButton(onPressed: (){
                showSimpleDialog(context);
              },
                  icon: Icon(cubit.fabIcon)),
              IconButton(onPressed: (){
                AppCubit.get(context).changeAppMood();
              }, icon: const Icon(Icons.brightness_4_outlined)),



            ],

          ),
          bottomNavigationBar: BottomNavyBar(
           backgroundColor:cubit.isDark? HexColor("333739"):Colors.white ,

            containerHeight: 60,
            selectedIndex: cubit.currentIndex,
            showElevation: false, // use this to remove appBar's elevation
         onItemSelected: (int index){
              cubit.changeBottomNavBarState(index);
              pageController.animateToPage(index, duration: Duration(milliseconds: 700), curve: Curves.ease);
         },
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.task),
                title: Text('new tasks',style: Theme.of(context).textTheme.caption),
                activeColor: defaultLightColor,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.done),
                title: Text('done tasks',style: Theme.of(context).textTheme.caption),
                activeColor: defaultLightColor,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey,


              ),
              BottomNavyBarItem(
                icon: Icon(Icons.archive),
                title: Text('archived',style: Theme.of(context).textTheme.caption),
                activeColor: defaultLightColor,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey,


              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],


        );
      } ,


    );
  }

  void showSimpleDialog(context)=>showDialog(context: context, builder: (context){
    return Container(
      height: 350,
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(25.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Text("enter your tasks"),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(

                  label: "title",
                    controller: titleController,
                    type: TextInputType.text,
                    onChanged: (value){},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'input must not be empty';
                      }
                    }
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    label: "tasks",
                    controller: taskController,
                    type: TextInputType.text,
                    onChanged: (value){},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'input must not be empty';
                      }
                    }
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    label: "location",
                    controller: locationController,
                    type: TextInputType.text,
                    onChanged: (value){},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'input must not be empty';
                      }
                    }
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    label: "time",
                    controller: timeController,
                    type: TextInputType.text,
                    onTap: (){
                      showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now())
                          .then((value) {
                        timeController.text =
                            value!.format(context).toString();
                      });
                    },
                    onChanged: (value){},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'input must not be empty';
                      }
                    }
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                 if (formKey.currentState!.validate()) {
                   AppCubit.get(context).insertIntoDatabase(
                      location: locationController.text,
                       task: taskController.text,
                       title: titleController.text,
                       time: timeController.text,);
                 }
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: defaultLightColor,

                    ),
                    child: const Center(child: Text("done",style: TextStyle(color: Colors.white,fontSize: 15),)),
                  ),
                )
              ],
              ),
            ),
          ),
        ),
      ),
    );
  });
}
