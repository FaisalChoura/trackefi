import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:Trackefi/core/presentation/ui/button.dart';
import 'package:Trackefi/core/presentation/ui/dialog.dart';
import 'package:Trackefi/core/presentation/ui/editable_text.dart';
import 'package:Trackefi/core/presentation/ui/text_field.dart';
import 'package:Trackefi/features/categories/presentaion/ui/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/category.dart';
import '../category_keyword_field.dart';
import '../viewmodel/categories_viewmodel.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

final selectedCategoryId = StateProvider<int>((ref) => 0);

class CategoriesScreen extends ConsumerWidget {
  final TextEditingController categoryNameController = TextEditingController();
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Row(
        children: [
          const CategoriesList(),
          Container(width: 0.5, color: Colors.grey),
          const Expanded(child: CategoryDetails()),
        ],
      ),
      floatingActionButton: TrButton(
          onPressed: () => _openNewCategoryDialog(context, ref),
          child: const Wrap(
            alignment: WrapAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 8,
              ),
              Text('Add'),
            ],
          )),
    );
  }

  _openNewCategoryDialog(BuildContext context, WidgetRef ref) {
    showTrDialog(context, _newCategoryBuilder(context, ref));
  }

  _newCategoryBuilder(BuildContext context, WidgetRef ref) {
    return NewCategoryDialog(categoryNameController: categoryNameController);
  }
}

class NewCategoryDialog extends ConsumerWidget {
  const NewCategoryDialog({
    super.key,
    required this.categoryNameController,
  });

  final TextEditingController categoryNameController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.enter): () =>
            _addCategory(context, ref)
      },
      child: Container(
        height: 185,
        width: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Category',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            TrTextField(
              controller: categoryNameController,
              autofocus: true,
            ),
            const SizedBox(
              height: 16,
            ),
            TrButton(
              onPressed: () => _addCategory(context, ref),
              child: const Text('Add Category'),
            )
          ],
        ),
      ),
    );
  }

  void _addCategory(BuildContext context, WidgetRef ref) {
    final category = Category(categoryNameController.text, []);
    ref
        .read(categoriesViewModelStateNotifierProvider.notifier)
        .addCategory(category);
    categoryNameController.clear();
    Navigator.of(context).pop();
  }
}

class CategoriesList extends ConsumerWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedCategoryId);
    return ref.watch(categoriesViewModelStateNotifierProvider).maybeWhen(
        data: (content) => _buildCategoriesView(ref, content, selectedId),
        orElse: () =>
            const Expanded(child: Center(child: CircularProgressIndicator())));
  }

  Container _buildCategoriesView(
      WidgetRef ref, List<Category> categories, int selectedId) {
    return Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 36, bottom: 16, left: 8, right: 8),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(
                        "${categories[index].name} ${categories[index].keywords.length}"),
                    onTap: () => ref.read(selectedCategoryId.notifier).state =
                        categories[index].id,
                    selected: selectedId == categories[index].id,
                  );
                }),
              ),
            ),
          ],
        ));
  }
}

class CategoryDetails extends ConsumerStatefulWidget {
  const CategoryDetails({super.key});

  @override
  ConsumerState<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends ConsumerState<CategoryDetails> {
  Color currentColor = Colors.red;
  final categoryKeywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final id = ref.watch(selectedCategoryId);
    ref.watch(categoriesViewModelStateNotifierProvider);
    return FutureBuilder(
        future: ref
            .watch(categoriesViewModelStateNotifierProvider.notifier)
            .getCategory(id),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            final category = snapshot.data!;
            currentColor = category.colorValues != null
                ? category.colorValues!.toColor()
                : currentColor;
            return Padding(
              padding: const EdgeInsets.only(
                  top: 36, left: 24, right: 24, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        children: [
                          TrEditableText(
                              text: category.name,
                              onChanged: (updatedText) {
                                category.name = updatedText;
                                ref
                                    .read(
                                        categoriesViewModelStateNotifierProvider
                                            .notifier)
                                    .updateCategory(category);
                              }),
                          const SizedBox(
                            width: 16,
                          ),
                          ColorDisplay(
                            pickerColor: category.colorValues != null
                                ? category.colorValues!.toColor()
                                : currentColor,
                            onTap: () =>
                                _setNewCategoryColor(currentColor, category),
                          ),
                        ],
                      ),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => ref
                              .read(categoriesViewModelStateNotifierProvider
                                  .notifier)
                              .deleteCategory(category.id)),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    children: [
                      CategoryKeywordField(
                        category: category,
                        controller: categoryKeywordController,
                        onChange: (String addedKeyword) {
                          category.keywords = [
                            ...category.keywords,
                            addedKeyword
                          ];
                          ref
                              .read(categoriesViewModelStateNotifierProvider
                                  .notifier)
                              .updateCategory(category);
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TrButton(
                        onPressed: () {
                          final addedKeyword = categoryKeywordController.text;
                          category.keywords = [
                            ...category.keywords,
                            addedKeyword
                          ];
                          ref
                              .read(categoriesViewModelStateNotifierProvider
                                  .notifier)
                              .updateCategory(category);
                          categoryKeywordController.clear();
                        },
                        child: const Text('Add Keyword'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Use a comma "," or press the "Add Keyword" button to insert a new keyword into this category',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Wrap(
                    children: [
                      for (var keyword in category.keywords)
                        Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 8),
                          child: Tag(
                              title: keyword,
                              color: TColors.labelColor,
                              onClose: () {
                                category.removeKeyword(keyword);
                                ref
                                    .read(
                                        categoriesViewModelStateNotifierProvider
                                            .notifier)
                                    .updateCategory(category);
                              }),
                        )
                    ],
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }

  Future<Color> _selectColor(Color currentColor) async {
    Color newSelectedColor = currentColor;
    return await showTrDialog<Color>(
          context,
          SizedBox(
            height: 420,
            width: 650,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Color',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ColorPicker(
                  pickerColor: newSelectedColor,
                  onColorChanged: (color) {
                    newSelectedColor = color;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TrButton(
                          child: const Text('Select'),
                          onPressed: () =>
                              Navigator.of(context).pop(newSelectedColor)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ) ??
        currentColor;
  }

  void _setNewCategoryColor(Color color, Category category) async {
    final color = await _selectColor(currentColor);
    category.colorValues = ColorValues.fromColor(color);
    ref
        .read(categoriesViewModelStateNotifierProvider.notifier)
        .updateCategory(category);
  }
}

class ColorDisplay extends StatelessWidget {
  const ColorDisplay({
    super.key,
    required this.pickerColor,
    required this.onTap,
  });

  final Color pickerColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: pickerColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
