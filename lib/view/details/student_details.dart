import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_db_provider/constants/constants.dart';
import 'package:student_db_provider/model/student_modal/students_modal.dart';
import 'package:student_db_provider/view/common_widgets/appbar_widget/appbar_widget.dart';

class StudentDetailsPage extends StatelessWidget {
   const StudentDetailsPage({super.key,required this.student});
  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBArWidget(
            title: 'Details',
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          kHeight50,
           CircleAvatar(
            backgroundImage:FileImage(File(student.image)),
            radius: 95,
            backgroundColor: baseColor,
          ),
          Container(
            height: 350,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                    topRight: Radius.circular(200)),
                color: baseColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('NAME : ${student.name}',style: costomTextStyle()),
                    kHeight20,
                    Text('AGE :${student.age}',style: costomTextStyle()),
                    kHeight20,
                    Text('BATCH:${student.batch}',style: costomTextStyle()),
                    kHeight20,
                    Text('PHONE NUMBER :${student.phoneNumber}',style: costomTextStyle()),
                  ],
                ),
          )
        ],
      ),
    );
  }
}
