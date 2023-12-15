import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:student_db_provider/constants/constants.dart';
import 'package:student_db_provider/controller/student_controller.dart';
import 'package:student_db_provider/model/student_modal/students_modal.dart';
import 'package:student_db_provider/view/add_student/add_student.dart';
import 'package:student_db_provider/view/common_widgets/appbar_widget/appbar_widget.dart';
import 'package:student_db_provider/view/details/student_details.dart';

ValueNotifier<bool> isSearching = ValueNotifier(false);

class StudentHome extends StatelessWidget {
  StudentHome({super.key});
  final studentcontroller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    studentcontroller.getStudents();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBArWidget(
            title: 'HOME SCREEN',
            iconData: InkWell(
                onTap: () {
                  isSearching.value = !isSearching.value;
                },
                child: const Icon(Icons.search)),
          )),
      body: RefreshIndicator(
        onRefresh: () async {
          studentcontroller.getStudents();
        },
        child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: isSearching,
                builder: (context, value, _) {
                  return AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: isSearching.value ? 70 : 0,
                      curve: Curves.easeInCirc,
                      child: ValueListenableBuilder(
                          valueListenable: isSearching,
                          builder: (context, value, _) {
                            return value
                                ? CupertinoSearchTextField(
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        studentcontroller.getStudents();
                                      } else {
                                        studentcontroller
                                            .searchStudentData(value);
                                      }
                                    },
                                  )
                                : const SizedBox();
                          }));
                }),
            Expanded(
              child: GetX<StudentController>(builder: (controller) {
                return controller.studentList.isEmpty
                    ? const Center(
                        child: Text(
                        'List is Empty',
                        style: TextStyle(
                            color: baseColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.studentList.length,
                        itemBuilder: (context, index) {
                          final student = controller.studentList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(StudentDetailsPage(student: student));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: baseColor,
                                ),
                                child: Row(
                                  children: [
                                    kWidth20,
                                    // CircleAvatar(radius: 45,),
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.amber,
                                          image: DecorationImage(
                                              image: FileImage(
                                                  File(student.image)),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          student.name,
                                          style: costomTextStyle(),
                                        ),
                                        Text(
                                          student.batch,
                                          style: costomTextStyle(),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.to(AddStudentPage(
                                                  student: student));
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              deleteStudentDialog(student);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
    
    );
  }

  void deleteStudentDialog(StudentModel student) {
    Get.dialog(
      Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets
                .symmetric(
                horizontal: 40),
            child: Container(
              decoration:
                  const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets
                        .all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(
                          height: 10),
                      const Text(
                        "DELETE",
                        style: TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                            fontSize:
                                22),
                        textAlign:
                            TextAlign
                                .center,
                      ),
                      const SizedBox(
                          height: 15),
                      const Text(
                        "Are You Want To Delete ? ",
                        textAlign:
                            TextAlign
                                .center,
                        style: TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold),
                      ),
                      const SizedBox(
                          height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child:
                                ElevatedButton(
                              child:
                                  const Text(
                                'NO',
                              ),
                              onPressed:
                                  () {
                                Get.back();
                              },
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10),
                          Expanded(
                            child:
                                ElevatedButton(
                              child:
                                  const Text(
                                'YES',
                              ),
                              onPressed:
                                  () {
                                Get.back();
                                studentcontroller
                                    .deleteAStudent(student.id!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
