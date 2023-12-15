
import 'package:get/state_manager.dart';
import 'package:student_db_provider/database/db_functions.dart';
import 'package:student_db_provider/model/student_modal/students_modal.dart';

class StudentController extends GetxController{
 RxString image = ''.obs;
 
 updateImage(String image){
  this.image.value=image;
 }
 RxList<StudentModel> studentList=<StudentModel>[].obs;

 registerStudent(StudentModel student){
  addStudent(student);
  getStudents();
 }
 getStudents()async{
  final students=await getAllStudents();
  studentList.assignAll(students);

 }
 updateStudent(StudentModel student)async{
 await editStudent(student);
  getStudents();
 }
 deleteAStudent(int id)async{
 await deleteStudent(id);
 getStudents();
 }

 searchStudentData(String searchQuery)async{
 final result = await searchStudents(searchQuery);
 studentList.assignAll(result);

 }




}