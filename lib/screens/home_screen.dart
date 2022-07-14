import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app0/cubit/cubit.dart';
import 'package:todo_app0/cubit/states.dart';
import 'package:todo_app0/screens/archive_screen.dart';
import 'package:todo_app0/screens/done_screen.dart';
import 'package:todo_app0/screens/new_tasks_screen.dart';
import 'package:todo_app0/shared/colors.dart';
import 'package:todo_app0/shared/styles.dart';
import 'package:todo_app0/shared/utility.dart';


class HomeScreen extends StatelessWidget {

   var scaffoldKey=GlobalKey<ScaffoldState>();
   var formKey=GlobalKey<FormState>();
   var titleController=TextEditingController();
   var timeController=TextEditingController();
   var dateController=TextEditingController();



  List<String> titles=[
    "New Tasks",
    "Done Tasks",
    "Archive Tasks",
  ];
   //IconData icon=Icons.add_task_outlined;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoAppCubit,TodoAppStates>(
      listener: (context, state) {

      },
      builder:(context, state){
        List<Widget> screens=[
          NewTasksScreen(
              tasks:TodoAppCubit.get(context).newTasks,
          ),
          DoneTasksScreen(tasks: TodoAppCubit.get(context).doneTasks,),
          ArchiveTasksScreen(tasks: TodoAppCubit.get(context).archiveTasks,),
        ];

        return Scaffold(
        key: scaffoldKey,
        floatingActionButton:FloatingActionButton(
          onPressed: (){


            if(TodoAppCubit.get(context).isShown==false){
              scaffoldKey.currentState!.showBottomSheet((context) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,

                  child: SingleChildScrollView(
                    child: Form(
                      key:formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Utility.myTextFormField(
                              controller: titleController,
                              label: "Title",
                              validator: (value){
                                if(value!.isEmpty) {
                                  return "Title is required";
                                }
                              },
                              prefixIcon: Icons.title,
                              textInputType:TextInputType.text ),
                          const SizedBox(height: 20,),
                          Utility.myTextFormField(
                              controller: timeController,
                              label: "Time",
                              validator: (value){
                                if(value!.isEmpty) {
                                  return "Time is required";
                                }
                              },
                              onTap: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value){
                                  timeController.text=value.toString();
                                });
                              },
                              prefixIcon: Icons.watch_later,
                              textInputType:TextInputType.number,
                              readOnly: true),
                          const SizedBox(height: 20,),
                          Utility.myTextFormField(
                              controller: dateController,
                              label: "Date",
                              validator: (value){
                                if(value!.isEmpty) {
                                  return "Date is required";
                                }
                              },
                              prefixIcon: Icons.date_range,
                              textInputType:TextInputType.number,
                              readOnly: true,
                              onTap: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse("2025-05-05"),).then((value) {
                                  dateController.text=DateFormat.yMMMd().format(value!);
                                } );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });

              TodoAppCubit.get(context).changeBottomSheetStatus();

            }else{
              if(formKey.currentState!.validate())
              {
                TodoAppCubit.get(context).insertToDatabase(
                  titleController.text,dateController.text,timeController.text
                ).then((value) {

                  Navigator.pop(context);
                  TodoAppCubit.get(context).changeBottomSheetStatus();
                });
              }
            }
          },
          backgroundColor: MyColors.mainColor,
          child: Icon(
              TodoAppCubit.get(context).isShown? Icons.add_task_outlined:Icons.text_rotation_angleup_outlined
          ),
        ),

          appBar: AppBar(
          backgroundColor: MyColors.mainColor,
          title: Text(titles[TodoAppCubit.get(context).index],
            style:MyStyles.headerStyle ,),
          centerTitle:true  ,
        ),
         body: screens[TodoAppCubit.get(context).index],
          bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon:Icon(Icons.task),label: "New " ),
            BottomNavigationBarItem(icon:Icon(Icons.done_outlined),label:"Done"  ),
            BottomNavigationBarItem(icon:Icon(Icons.archive_outlined),label: "Archive" ),
          ],
          currentIndex: TodoAppCubit.get(context).index,
          selectedItemColor: MyColors.selectedBottomNavigationItem,
          onTap: (value){

            TodoAppCubit.get(context).changScreens(value);
          },
          backgroundColor: MyColors.mainColor,
        ),
      );},
    );
  }
}
