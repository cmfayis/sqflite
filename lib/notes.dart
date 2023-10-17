import 'package:databasesqflite/model.dart';
import 'package:databasesqflite/sql.dart';
import 'package:flutter/material.dart';

class pageone extends StatefulWidget {
  const pageone({super.key});

  @override
  State<pageone> createState() => _pageoneState();
}

class _pageoneState extends State<pageone> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'TODO APP',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 10, 33, 55),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Name',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Age',
                        labelText: 'Age',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Buttonpress();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ValueListenableBuilder(
                    valueListenable: studentlist,
                    builder: (BuildContext ctx, List<Studentmodel> studentlist1,
                        Widget? child) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final data = studentlist1[index];
                          return Card(
                            color: Color.fromARGB(255, 87, 249, 217),
                            child: ListTile(
                              title: Text("Name :${data.name}"),
                              subtitle: Text("Age  :${data.age}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      editStudentDialog(data);
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteStudent(data.id!);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: studentlist1.length,
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Buttonpress() {
    final name = nameController.text;
    final age = ageController.text;
    if (age.isNotEmpty && name.isNotEmpty) {
      final student = Studentmodel(
        name: name,
        age: age,
      );
      addStudent(student);
      nameController.clear();
      ageController.clear();
    }
  }

  Future<void> editStudentDialog(Studentmodel student) async {
    final nameController = TextEditingController(text: student.name);
    final ageController = TextEditingController(text: student.age);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                final newName = nameController.text;
                final newAge = ageController.text;

                if (newName.isNotEmpty && newAge.isNotEmpty) {
                  student.name = newName;
                  student.age = newAge;
                  updateStudent(student);

                  studentlist.notifyListeners();

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
  
  
  
}
