import 'package:flutter/material.dart';
import 'package:todo_app0/cubit/cubit.dart';
import 'package:todo_app0/shared/colors.dart';
import 'package:todo_app0/shared/styles.dart';


 class Utility{
 static Widget taskItem({
  required Map<String,dynamic> task,
  required BuildContext context,
 })=> Dismissible(
  key: Key(task["id"].toString()),
  onDismissed: (direction)
  {
    TodoAppCubit.get(context).deleteFromDatabase(task["id"]);
  },
  background: Container(
    color:Colors.red,
  ),

  child:   Padding(
      padding: const EdgeInsets.all(15),
      child:   Row(
      children: [
       CircleAvatar(
        backgroundColor: MyColors.mainColor,

        child: Text(
          task["id"].toString(),
           style: MyStyles.headerStyle,),
        radius: 35,
      ),

        const SizedBox(width: 15,),

        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task["title"],
                style: MyStyles.headerStyle,),
              const SizedBox(height: 8,),
              Row(
                children: [
                  Text(
                    task["date"]
                    ,style: MyStyles.subtitleStyle,),
                  const SizedBox(width: 50,),
                  Text(
                    task["time"]
                    ,style: MyStyles.subtitleStyle,),
                ],
              ),
            ],
          ),
        ),

         Expanded(
           flex: 1,
           child: IconButton(
               onPressed: (){

                 print(task ["id"]);
                 TodoAppCubit.get(context).updateDatabase(
                     status: "Archive",
                     id:task ["id"],
                 );
               },
             icon: const Icon(Icons.archive_outlined,size: 20,)),
         ),

        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: (){
                print(task ["id"]);
                TodoAppCubit.get(context).updateDatabase(
                  status: "Done",
                  id:task ["id"],
                );
              },
              icon: const Icon(Icons.verified_outlined,size: 20,)),

        ),
      ],
    ),
  ),
);


 static Widget myTextFormField({
  required TextEditingController controller,
  TextInputType? textInputType,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  void Function()?onTap,
  void Function()? suffixIconPressed,
  void Function(String)? onChange,
  void Function(String)? onSubmit,
  String? Function(String?)? validator,
  bool obscureText=false,
  bool readOnly=false

})=>

    TextFormField(
    readOnly: readOnly,
    controller:controller,
    obscureText:obscureText ,
    keyboardType: textInputType,
      decoration:   InputDecoration(
      label:  Text(label),
      prefixIcon:  Icon(prefixIcon),
      suffixIcon: IconButton(

        onPressed:suffixIconPressed,

        icon: Icon(suffixIcon),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),

      ),
    ) ,
    onTap:onTap,

    validator:validator,

    onChanged:onChange,

    onFieldSubmitted:onSubmit,

  );


 static Widget myButton({
   required Color color,
   required double radius,
   required double width,
   required double height,
   required void Function()? onTap,
   Icon? icon,
   Text? text,
 })=>GestureDetector(
   onTap:onTap ,
   child: Container(
     decoration: BoxDecoration(
       color: color,
       borderRadius: BorderRadius.circular(30),
     ),
     width:width,
     height: height,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children:  [
         icon ?? const SizedBox(),
         text ?? const SizedBox(),
       ],
     ),
   ),
 );



 }