import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:student_list/db/functions/db_functions.dart';
import 'package:student_list/screens/full_details.dart';
import 'package:student_list/screens/add_details.dart';
import '../db/model/data_model.dart';
import 'edit_details.dart';

late StudentModel dbObject;
TextEditingController _searchController = TextEditingController();
bool isListEmpty = true;

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: TextField(
          style: const TextStyle(color: Colors.white),
          controller: _searchController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: .5, color: Color.fromARGB(147, 158, 158, 158)),
                borderRadius: BorderRadius.circular(15)),
            focusColor: Colors.green,
            hintText: 'Search...',
            border: const OutlineInputBorder(

                // borderSide: BorderSide( width: 1,color: Colors.white),

                borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
            hintStyle:
                const TextStyle(color: Color.fromARGB(255, 121, 121, 121)),
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                searchAndUpdateStudents(_searchController.text);
                // Perform search or any other action here
              },
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: stdntListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          isListEmpty = studentList.isEmpty;
          return isListEmpty
              ? Center(
                  child: TextButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const AddNew();
                          },
                        ));
                      },
                      icon: const Icon(Icons.error),
                      label: const Text(
                        'List is empty,Click here to add student!',
                        style: TextStyle(
                            fontSize: 18, decoration: TextDecoration.underline),
                      )),
                  // Text('List is empty'),
                )
              : ListView.separated(
                  itemCount: studentList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    thickness: 1.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final data = studentList[index];
                    return ListTile(
                      onTap: () {
                        dbObject = StudentModel(data.name, data.age, data.phone,
                            data.image, data.id);
                        Get.to(const FullDetails());
                      },
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.image)),
                      ),
                      title: Text(data.name),
                      // subtitle: Text('Age : ${data.age}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              dbObject = data;
                              Get.to(const EditDetailsPage());
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                deleteStudent(data);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(188, 219, 1, 1),
                              )),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.black,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.home)),
              label: 'Home',
              //
              //
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: const Text(
                          'Clear all data!',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: const Text(
                            'This will clear all student data, Do you want to continue?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteAllStudents();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.clear),
              ),
              label: 'Clear All',
            ),
          ]),
    );
  }
}
