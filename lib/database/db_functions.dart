import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_db_provider/model/student_modal/students_modal.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  final id = await studentDB.add(value);

  value.id = id;

  await studentDB.put(id, value);
}

Future<List<StudentModel>> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  log(studentDB.values.toList().toString());
  return studentDB.values.toList();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.delete(id);
}

Future<void> editStudent(StudentModel value) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  await studentDb.put(value.id!, value);
}

Future<List<StudentModel>> searchStudents(String searchQuery) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  return studentDb.values
      .toList()
      .where((student) =>
          student.name.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();
 }
