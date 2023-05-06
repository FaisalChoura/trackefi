import 'package:expense_categoriser/services/categories_provider.dart';
import 'package:expense_categoriser/utils/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool showNewCategoryField = false;
  TextEditingController categoryNameController = TextEditingController();
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
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  List<Category> categories = ref.watch(categoriesProvider);
                  return Column(
                    children: [
                      showNewCategoryField
                          ? Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: categoryNameController,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          ref
                                              .watch(
                                                  categoriesProvider.notifier)
                                              .addCategory(Category(
                                                  categoryNameController.text,
                                                  []));
                                          _closeNewCategoryInput();
                                        },
                                        icon: const Icon(Icons.check),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            _closeNewCategoryInput(),
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              title: Text(categories[index].name),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                },
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
