import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_using_provider/todo_provider/todo_provider.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Todo App",style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.indigo.shade800,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: title,
                decoration: const InputDecoration(
                  labelText: 'title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: subTitle,
                decoration: const InputDecoration(
                  labelText: 'subtitle',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              todoProvider.addTodo(title.text, subTitle.text);
              title.clear();
              subTitle.clear();
            }, child: const Text("ADD")),
            Expanded(
              child: ListView.builder(
                itemCount: todoProvider.todos.length,
                itemBuilder: (context, index) {
                  final todo = todoProvider.todos[index];
                  return ListTile(
                    title: Text(
                      todo.title.toString(),
                    ),


                    subtitle: Text(todo.subTitle.toString()),
                    trailing: Wrap(
                      children:[
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          todoProvider.removeTodo(index);
                        },
                       ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Show dialog to edit the Todo
                            showDialog(
                              context: context,
                              builder: (context) {
                                String? newTitle = todo.title;
                                String? newSubTitle = todo.subTitle;

                                return AlertDialog(
                                  title: const Text('Edit Todo'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        decoration: const InputDecoration(
                                          labelText: 'Title',
                                        ),
                                        onChanged: (value) {
                                          newTitle = value;
                                        },
                                        controller: TextEditingController(text: todo.title),
                                      ),
                                      TextField(
                                        decoration: const InputDecoration(
                                          labelText: 'Subtitle',
                                        ),
                                        onChanged: (value) {
                                          newSubTitle = value;
                                        },
                                        controller: TextEditingController(text: todo.subTitle),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Call the editTodo method to update the Todo item
                                        todoProvider.updateTodo(index, newTitle!, newSubTitle!);
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),

                      ]
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
