import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_list/screens/student_list.dart';

class FullDetails extends StatelessWidget {
  const FullDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        title: const Text('Profile',style: TextStyle(
          color: Colors.grey
        ),),
      ),

      //
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.black,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.home_filled)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.list_alt),

              ),
              label: 'List',
            ),
          ]),

      
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
              //
              
              const SizedBox(height: 10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dbObject.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              //Name field
              
              Container(
                width: 400,
                height: 70,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                  shape: BoxShape.rectangle,
                 color: const Color.fromARGB(200, 0, 0, 0),
              
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Name : ${dbObject.name}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.white),
                  ),
                ),
              ),
              

              const SizedBox(height: 5),

              
              Container(
                width: 400,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  shape: BoxShape.rectangle,
                  color: const Color.fromARGB(200, 0, 0, 0),
              
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                    child: Text(
                      'Age : ${dbObject.age}               ',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.white),
                    ),
                  ),
                ),
              ),
              

              const SizedBox(height: 5),

              
              Container(
                width: 400,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  shape: BoxShape.rectangle,
                  
                  color: const Color.fromARGB(200, 0, 0, 0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Mobile: ${dbObject.phone}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.white),
                  ),
                ),
              ),
              

            ],
          ),
        ),
      ),
    );
  }
}

