class ReportSettings {
  String currencyId = '';
  DateTime? fromDate;
  DateTime? toDate;
  ReportSettings({
    required this.currencyId,
    this.fromDate,
    this.toDate,
  });
}
