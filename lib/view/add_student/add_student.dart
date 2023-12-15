// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:student_db_provider/constants/constants.dart';
import 'package:student_db_provider/controller/student_controller.dart';
import 'package:student_db_provider/model/student_modal/students_modal.dart';
import 'package:student_db_provider/utils/utils.dart';
import 'package:student_db_provider/view/common_widgets/appbar_widget/appbar_widget.dart';
import 'package:student_db_provider/view/common_widgets/bottom_nav/bottom_nav.dart';



class AddStudentPage extends StatelessWidget {
  AddStudentPage({super.key, this.student});
  final StudentModel? student;
  final studentController = Get.put<StudentController>(StudentController());
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final batchController = TextEditingController();
  final phoneNumberController = TextEditingController();
  //  final bool _validate = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    initializing(studentController);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBArWidget(
            title:student==null? 'ADD STUDENT':'EDIT STUDENT',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kHeight50,
                const SizedBox(
                  width: double.infinity,
                ),
                Obx(() {
                  return Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: baseColor,
                        image: studentController.image.isEmpty
                            ? null
                            : DecorationImage(
                                image: FileImage(File(
                                  studentController.image.value,
                                )),
                                fit: BoxFit.cover),
                        borderRadius:const  BorderRadius.all(Radius.circular(20))),
                    child: IconButton(
                        onPressed: () async {
                          final image = await pickImage();
                          if (image != null) {
                            studentController.updateImage(image);
                          }
                        },
                        icon: studentController.image.isEmpty
                            ? const Icon(
                                Icons.photo_camera_back_outlined,
                                size: 80,
                                color: Colors.white60,
                              )
                            : const SizedBox()),
                  );
                }),
                kHeight50,
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is Required';
                    } else {
                      return null;
                    }
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                      label: Text('Name')),
                ),
                kHeight20,
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is Required';
                    } else {
                      return null;
                    }
                  },
                  controller: ageController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Age',
                      label: Text('Age')),
                  keyboardType: TextInputType.number,
                ),
                kHeight20,
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is Required';
                    } else {
                      return null;
                    }
                  },
                  controller: batchController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Batch',
                      label: Text('Batch')),
                ),
                kHeight20,
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is Required';
                    } else {
                      return null;
                    }
                  },
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone Number',
                      label: Text('Phone Number')),
                ),
                kHeight50,
                ElevatedButton(
                  onPressed: () {
                    checkLogin();

                  },
                  child: Text(
                   student==null? 'Add Details':'Update Details',
                    style: costomTextStyle(),
                  ),
                  style: const ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(700, 50))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkLogin() {
    if (_formKey.currentState!.validate()) {
      final studentModel = StudentModel(
          id: student != null ? student!.id! : null,
          name: nameController.text.trim(),
          age: ageController.text.trim(),
          batch: batchController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
          image: studentController.image.value);
      if (student == null) {
        studentController.registerStudent(studentModel);
      } else {
        studentController.updateStudent(studentModel);
        Get.back();
      }
      indexChangeNotifier.value = 0;
    }
    nameController.clear();
    ageController.clear();
    batchController.clear();
    phoneNumberController.clear();
    studentController.updateImage('');
  }

  initializing(StudentController studentController) {
    if (student != null) {
      nameController.text = student!.name;
      ageController.text = student!.age;
      batchController.text = student!.batch;
      phoneNumberController.text = student!.phoneNumber;
      studentController.updateImage(student!.image);
    }
  }
}
