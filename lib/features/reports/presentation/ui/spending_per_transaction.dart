import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:Trackefi/core/presentation/ui/dialog.dart';
import 'package:Trackefi/features/csv_files/presentation/ui/extra_info_card.dart';
import 'package:Trackefi/features/reports/domain/model/report_category_snapshot.dart';
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
    return showTrDialog(
      context,
      SizedBox(
        height: 340,
        width: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Expenses by transaction',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ))
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                      itemCount: groupedTransactionsMap.length,
                      itemBuilder: (context, i) {
                        final name = groupedTransactionsMap[i].key;
                        final amount = groupedTransactionsMap[i].value;
                        return Container(
                          decoration: BoxDecoration(
                              color: i % 2 == 0
                                  ? Colors.transparent
                                  : TColors.lightGrey),
                          padding: const EdgeInsets.all(8),
                          child: TrShortenedListItem(
                              stringLength: name.length + 1,
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

    for (var i = 0; i < charCount; i++) {
      stringArray.add(splitString[i]);
    }

    if (charCount != splitString.length) {
      stringArray.add('...');
    }

    return stringArray.join();
  }
}
