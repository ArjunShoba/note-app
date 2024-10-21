import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box box;
  List<Map<String, String>> itemsList = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    box = Hive.box('myBox');
    final storedItems = box.get('itemsList');

    if (storedItems is List) {
      itemsList = List<Map<String, String>>.from(
        storedItems.map((e) => Map<String, String>.from(e)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          itemCount: itemsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ), // SliverGridDelegateWithFixedCrossAxisCount
          itemBuilder: (context, index) {
            final item = itemsList[index];
            return Container(
              height: 100,
              width: 150,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ), // BoxDecoration
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'] ?? 'No Title'),
                  Text(item['description'] ?? 'No Description'),
                  Text(item['category'] ?? 'No Category'),
                  Text(item['date'] ?? 'No Date'),
                ],
              ), // Column
            ); // Container
          },
        ), // GridView.builder
      ), // Padding
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 5,
                          ),
                        ),
                        hintText: "Title...",
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 5,
                          ),
                        ),
                        hintText: "Description...",
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 5,
                          ),
                        ),
                        hintText: "Category...",
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 5,
                          ),
                        ),
                        hintText: "Date...",
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              itemsList.add({
                                'title': titleController.text,
                                'description': descriptionController.text,
                                'category': categoryController.text,
                                'date': dateController.text,
                              });

                              box.put(
                                'itemsList',
                                itemsList
                                    .map((e) => Map<String, dynamic>.from(e))
                                    .toList(),
                              );
                            });

                            titleController.clear();
                            descriptionController.clear();
                            categoryController.clear();
                            dateController.clear();

                            Navigator.pop(context);
                          },
                          child: const Text("Add"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ), // FloatingActionButton
    ); 
}
}