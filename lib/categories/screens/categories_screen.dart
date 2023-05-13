import 'package:expense_categoriser/categories/utils/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/categories_provider.dart';
import '../ui/category_keyword_field.dart';

final showNewCategoryField = StateProvider<bool>((ref) => false);
final selectedCategoryId = StateProvider<int>((ref) => 0);

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          actions: [
            IconButton(
                onPressed: () => _openNewCategoryInput(ref),
                icon: const Icon(Icons.add))
          ],
        ),
        body: Row(
          children: [
            CategoriesList(),
            Container(width: 0.5, color: Colors.grey),
            const CategoryDetails(),
          ],
        ));
  }

  _openNewCategoryInput(WidgetRef ref) {
    ref.read(showNewCategoryField.notifier).state = true;
  }
}

class CategoriesList extends ConsumerWidget {
  final TextEditingController categoryNameController = TextEditingController();

  CategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Category> categories = ref.watch(categoriesProvider);
    bool showField = ref.watch(showNewCategoryField);
    return SizedBox(
        width: 180,
        child: Column(
          children: [
            showField
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
                                    .watch(categoriesProvider.notifier)
                                    .addCategory(Category(
                                        categoryNameController.text, []));
                                _closeNewCategoryInput(ref);
                              },
                              icon: const Icon(Icons.check),
                            ),
                            IconButton(
                              onPressed: () => _closeNewCategoryInput(ref),
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
                    title: Text(
                        "${categories[index].name} ${categories[index].keywords.length}"),
                    onTap: () => ref.read(selectedCategoryId.notifier).state =
                        categories[index].id,
                  );
                }),
              ),
            ),
          ],
        ));
  }

  _closeNewCategoryInput(WidgetRef ref) {
    ref.read(showNewCategoryField.notifier).state = false;
  }
}

class CategoryDetails extends ConsumerWidget {
  const CategoryDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(selectedCategoryId);
    ref.watch(categoriesProvider);
    return FutureBuilder(
        future: ref.watch(categoriesProvider.notifier).getCategory(id),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            final category = snapshot.data!;
            return Column(
              children: [
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => ref
                        .read(categoriesProvider.notifier)
                        .deleteCategory(category)),
                Text(category.name),
                CategoryKeywordField(
                  category: category,
                  onChange: (String addedCategory) {
                    category.keywords = [...category.keywords, addedCategory];
                    ref
                        .read(categoriesProvider.notifier)
                        .updateCategory(category);
                  },
                ),
                for (var keyword in category.keywords)
                  MaterialButton(
                      child: Text(keyword),
                      onPressed: () {
                        category.removeKeyword(keyword);
                        ref
                            .read(categoriesProvider.notifier)
                            .updateCategory(category);
                      }),
              ],
            );
          }
          return Container();
        });
  }
}
