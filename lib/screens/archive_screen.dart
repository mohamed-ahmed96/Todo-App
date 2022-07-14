import 'package:flutter/material.dart';
import 'package:todo_app0/shared/styles.dart';
import 'package:todo_app0/shared/utility.dart';

class ArchiveTasksScreen extends StatelessWidget {

  List<Map<String,dynamic>> tasks;
  ArchiveTasksScreen({
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => Utility.taskItem(
                  task: tasks[index],
                  context: context,
                ),
                separatorBuilder: (context, index) =>const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: Colors.blueAccent,
                    height: 2,
                  ),
                ),

                itemCount:tasks.length
            ),
          ),




        ],
      ),
    );

  }
}
