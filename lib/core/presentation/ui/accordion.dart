import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final openedPannel = StateProvider<String>((ref) => '');

class TrAccordion extends ConsumerStatefulWidget {
  final List<TrAccordionItem> items;
  const TrAccordion({super.key, required this.items});

  @override
  ConsumerState<TrAccordion> createState() => _TrAccordionState();
}

class _TrAccordionState extends ConsumerState<TrAccordion> {
  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }

  Widget _buildPanel() {
    final openedIndex = ref.watch(openedPannel);
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        final item = widget.items[index];
        if (item.id == ref.read(openedPannel)) {
          ref.read(openedPannel.notifier).state = '';
          return;
        }
        ref.read(openedPannel.notifier).state = item.id;
      },
      children: widget.items.map<ExpansionPanel>((item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    item.leading,
                    item.trailing,
                  ]),
            );
          },
          body: SizedBox(
            height: 300,
            child: ListView.builder(
                itemCount: item.subItems.length,
                itemBuilder: (context, i) {
                  return item.subItems[i];
                }),
          ),
          isExpanded: item.id == openedIndex,
        );
      }).toList(),
    );
  }
}

class TrAccordionItem {
  late String id;
  Widget trailing;
  Widget leading;
  List<Widget> subItems;

  TrAccordionItem(
      {required this.trailing,
      required this.leading,
      required this.subItems,
      this.id = ''}) {
    id = id.isEmpty ? const Uuid().v4() : id;
  }
}
