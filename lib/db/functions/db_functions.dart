import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_list/db/model/data_model.dart';


ValueNotifier<List<StudentModel>> stdntListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  //stdntListNotifier.value.add(value);
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  final id = await studentDb.add(value);
  value.id = id;
  //await studentDb.add(value);
  stdntListNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  stdntListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  stdntListNotifier.value.clear();
  stdntListNotifier.value.addAll(studentDb.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  stdntListNotifier.notifyListeners();
}

void deleteStudent(StudentModel studentModel) async {
  // final sutdentDb = await Hive.openBox<StudentModel>('student_db');
  studentModel.delete();
  getAllStudents();
}

Future<void> deleteAllStudents() async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  await studentDb.clear();
  await getAllStudents();
}

Future<List<StudentModel>> searchStudents(String query) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  final allStudents = studentDb.values.toList();

  if (query.isEmpty) {
    return allStudents;
  }

  final filteredStudents = allStudents.where((student) {
    final name = student.name.toLowerCase();
    final lowerQuery = query.toLowerCase();
    return name.contains(lowerQuery);
  }).toList();

  return filteredStudents;
}

Future<void> searchAndUpdateStudents(String query) async {
  final filteredStudents = await searchStudents(query);
  stdntListNotifier.value = List.from(filteredStudents);
}

Future<void> editStudent(
    {required StudentModel updatedStudent,
    required String name,
    required String age,
    required String phone}) async {
  // final studentDb = await Hive.openBox<StudentModel>('student_db');
  
  updatedStudent.name = name;
  updatedStudent.age = age;
  updatedStudent.phone = phone;
  updatedStudent.save();
  getAllStudents();
}
