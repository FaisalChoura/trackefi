import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> categories = ['Restaurants', 'Grocceries'];
  bool showNewCategoryField = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          actions: [
            IconButton(
                onPressed: () => _openNewCategoryInput(),
                icon: const Icon(Icons.add))
          ],
        ),
        body: Row(
          children: [
            SizedBox(
              width: 180,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: ((context, index) {
                  if (index == 0 && showNewCategoryField) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              const Flexible(
                                flex: 3,
                                child: TextField(),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () => _closeNewCategoryInput(),
                                      icon: const Icon(Icons.close)))
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(categories[index]),
                        )
                      ],
                    );
                  }
                  return ListTile(
                    title: Text(categories[index]),
                  );
                }),
              ),
            ),
            Container(width: 0.5, color: Colors.grey),
          ],
        ));
  }

  _openNewCategoryInput() {
    setState(() {
      showNewCategoryField = true;
    });
  }

  _closeNewCategoryInput() {
    setState(() {
      showNewCategoryField = false;
    });
  }
}
