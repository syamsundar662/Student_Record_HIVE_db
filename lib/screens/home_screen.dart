import 'package:flutter/material.dart';

import 'package:student_list/screens/student_list.dart';
import 'package:student_list/screens/add_details.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Student registration',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      // minimumSize: const Size(30, 80),
                      shape: const StadiumBorder(),
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 40.0, vertical: 20.0),
                      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
                      shadowColor: const Color.fromARGB(0, 255, 255, 255)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddNew()));
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Click here',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
            //        Add student button End

            const SizedBox(
              height: 30,
            ),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'View added student list',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),

            //          view  List button
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      // minimumSize: const Size(30, 80),
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 40.0, vertical: 20.0),
                      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
                      shadowColor: const Color.fromARGB(0, 255, 255, 255)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EmptyList()));
                  },
                  icon: const Icon(
                    Icons.list,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Click here',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
            //          view List button End
          ]),
        ),
      )),
    );
  }
}
