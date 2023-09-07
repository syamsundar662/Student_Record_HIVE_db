import 'package:flutter/material.dart';
// import 'package:get/get_navigation/get_navigation.dart';
import 'package:student_list/db/functions/db_functions.dart';
import 'package:student_list/db/model/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/screens/student_list.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final _formKey = GlobalKey<FormState>();

  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  late String _name;
  late String _age;
  late String _phone;

  @override
  Widget build(BuildContext context) {
    XFile? img;
    Future<void> submitClick() async {
      final image = img!.path;
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
      body: SafeArea(
          child: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter student details.',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          controller: namecontroller,
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
                              return 'Enter name';
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
                          controller: agecontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Age',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 10)))),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.contains(
                                    RegExp(r'[a-zA-Z!@#$%^&*(),.?":{}|<>]'))) {
                              return 'Enter age';
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
                          controller: phonecontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Phone number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 10)))),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 10 ||
                                value.contains(
                                    RegExp(r'[a-zA-Z!@#$%^&*(),.?":{}|<>]'))) {
                              return 'Enter a valid mobile number';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _phone = value!;
                          },
                        ),

                        //upload photo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton.icon(
                              onPressed: () async {
                                img = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                              },
                              label: const Text(
                                'Upload photo',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blueAccent),
                              ),
                              icon: const Icon(
                                Icons.image,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                        //upload photo end

                        const SizedBox(
                          height: 20,
                        ),

                        //submit button
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 0, 0)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                submitClick();
                                namecontroller.clear();
                                agecontroller.clear();
                                phonecontroller.clear();

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialog(
                                        title: Text('Successfully added'),
                                      );
                                    });
                              }
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Submit',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const EmptyList()));
                            },
                            child: const Text(
                              'tap here to student list',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    )))
          ],
        ),
      )),
    );
  }
}
