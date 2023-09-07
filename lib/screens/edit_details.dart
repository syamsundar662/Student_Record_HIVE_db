import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/db/functions/db_functions.dart';
import 'package:student_list/screens/student_list.dart';
import '../db/model/data_model.dart';

class EditDetailsPage extends StatefulWidget {
  const EditDetailsPage({Key? key}) : super(key: key);

  @override
  State<EditDetailsPage> createState() => _EditDetailsPageState();
}

class _EditDetailsPageState extends State<EditDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  late String _name;

  late String _age;

  late String _phone;

  @override
  Widget build(BuildContext context) {
    XFile? imge;
    final TextEditingController nameController =
        TextEditingController(text: dbObject.name);
    final TextEditingController ageController =
        TextEditingController(text: dbObject.age);
    final TextEditingController contactController =
        TextEditingController(text: dbObject.phone);

    // ignore: unused_element
    Future<void> submitClick() async {
      final image = imge!.path;
      final name = _name;
      final age = _age;
      final phone = _phone;

      if (name.isEmpty ||
          age.isEmpty ||
          phone.isEmpty ||
          age.isEmpty ||
          image.isEmpty) {
        return;
      }

      final student = StudentModel(name, age, phone, image);

      addStudent(student);
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: const Color.fromARGB(255, 14, 14, 14),
        toolbarHeight: 70,
        title: const Text(
          'Edit Student Details.',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: Container(
                        color: Colors.black,
                        child: InteractiveViewer(
                          child: Hero(
                            tag: 'zoomed_image',
                            child: Image.file(
                              File(dbObject.image),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(
                  File(dbObject.image),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),

                        //name field
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 10)))),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.contains(
                                    RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]'))) {
                              return 'Enter a valid name';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                        //name field end

                        const SizedBox(
                          height: 10,
                        ),

                        //age field
                        TextFormField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'age',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 10)))),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.contains(
                                    RegExp(r'[a-zA-Z!@#$%^&*(),.?":{}|<>]'))) {
                              return 'Enter a valid Age';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _age = value!;
                          },
                        ),
                        //age field end

                        const SizedBox(
                          height: 10,
                        ),

                        // contact field
                        TextFormField(
                          controller: contactController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'contact Num.',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 10)))),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 10 ||
                                value.contains(
                                    RegExp(r'[a-zA-Z!@#$%^&*(),.?":{}|<>]'))) {
                              return 'Enter a valid Mobile no.';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _phone = value!;
                          },
                        ),
                        //contact field end

                        const SizedBox(
                          height: 10,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //submit button
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor:
                                    const Color.fromARGB(255, 185, 201, 255)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                final String name = nameController.text;

                                final String age = ageController.text;
                                final String contact = contactController.text;
                                await editStudent(
                                    updatedStudent: dbObject,
                                    name: name,
                                    age: age,
                                    phone: contact);

                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(Icons.edit_document),
                            label: const Text(
                              'Save Changes',
                              style: TextStyle(fontSize: 15),
                            )),
                        //submit button end
                      ],
                    )))
          ],
        ),
      )),
    );
  }
}
