import 'package:expense_categoriser/features/csv_files/presentation/ui/extra_info_card.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:flutter/material.dart';

class SpendingPerTransactionList extends StatelessWidget {
  const SpendingPerTransactionList({super.key, required this.transactions});
  final List<Transaction> transactions;

  List<MapEntry<String, double>> groupedTransactionByName() {
    final groupedTransactions = <String, double>{};
    for (var transaction in transactions) {
      if (groupedTransactions[transaction.name] != null) {
        groupedTransactions[transaction.name] = double.parse(
            (groupedTransactions[transaction.name]! + transaction.amount)
                .toStringAsFixed(2));
      } else {
        groupedTransactions[transaction.name] = transaction.amount;
      }
    }

    final mapEntryList = groupedTransactions.entries.toList();

    mapEntryList.sort((a, b) => b.value.compareTo(a.value));

    return mapEntryList;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactionsMap = groupedTransactionByName();
    return TrExtraInfoCard(
        title: 'Expenses by transaction',
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, i) {
                    final name = groupedTransactionsMap[i].key;
                    final amount = groupedTransactionsMap[i].value;
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TrShortenedListItem(
                          title: name, trailing: Text(amount.toString())),
                    );
                  }),
            )
          ],
        ),
        onButtonClick: () => _showMore(context, groupedTransactionsMap));
  }

  Future<dynamic> _showMore(BuildContext context,
      List<MapEntry<String, double>> groupedTransactionsMap) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(32),
            height: 420,
            width: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                          size: 20,
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      'Expenses by transaction',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          itemCount: groupedTransactionsMap.length,
                          itemBuilder: (context, i) {
                            final name = groupedTransactionsMap[i].key;
                            final amount = groupedTransactionsMap[i].value;
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TrShortenedListItem(
                                  stringLength: name.length,
                                  title: name,
                                  trailing: Text(amount.toString())),
                            );
                          }),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TrShortenedListItem extends StatelessWidget {
  const TrShortenedListItem(
      {super.key, required this.title, this.trailing, this.stringLength = 20});
  final String title;
  final int stringLength;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_shortenStringTo(title, stringLength)),
        trailing ?? Container(),
      ],
    );
  }

  String _shortenStringTo(String text, num charCount) {
    final stringArray = <String>[];
    final splitString = text.split('');

    charCount = charCount > splitString.length ? splitString.length : charCount;

    for (var i = 0; i < charCount - 1; i++) {
      stringArray.add(splitString[i]);
    }

    if (charCount != splitString.length) {
      stringArray.add('...');
    }

    return stringArray.join();
  }
}
