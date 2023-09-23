// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReportCollection on Isar {
  IsarCollection<Report> get reports => this.collection();
}

const ReportSchema = CollectionSchema(
  name: r'Report',
  id: 4107730612455750309,
  properties: {
    r'categories': PropertySchema(
      id: 0,
      name: r'categories',
      type: IsarType.objectList,
      target: r'ReportCategorySnapshot',
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currencyId': PropertySchema(
      id: 2,
      name: r'currencyId',
      type: IsarType.string,
    ),
    r'dateRangeFrom': PropertySchema(
      id: 3,
      name: r'dateRangeFrom',
      type: IsarType.dateTime,
    ),
    r'dateRangeTo': PropertySchema(
      id: 4,
      name: r'dateRangeTo',
      type: IsarType.dateTime,
    ),
    r'expenseTransactions': PropertySchema(
      id: 5,
      name: r'expenseTransactions',
      type: IsarType.objectList,
      target: r'Transaction',
    ),
    r'expenses': PropertySchema(
      id: 6,
      name: r'expenses',
      type: IsarType.double,
    ),
    r'income': PropertySchema(
      id: 7,
      name: r'income',
      type: IsarType.double,
    ),
    r'incomeTransactions': PropertySchema(
      id: 8,
      name: r'incomeTransactions',
      type: IsarType.objectList,
      target: r'Transaction',
    )
  },
  estimateSize: _reportEstimateSize,
  serialize: _reportSerialize,
  deserialize: _reportDeserialize,
  deserializeProp: _reportDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'ReportCategorySnapshot': ReportCategorySnapshotSchema,
    r'Transaction': TransactionSchema,
    r'ColorValues': ColorValuesSchema
  },
  getId: _reportGetId,
  getLinks: _reportGetLinks,
  attach: _reportAttach,
  version: '3.1.0+1',
);

int _reportEstimateSize(
  Report object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.categories.length * 3;
  {
    final offsets = allOffsets[ReportCategorySnapshot]!;
    for (var i = 0; i < object.categories.length; i++) {
      final value = object.categories[i];
      bytesCount +=
          ReportCategorySnapshotSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.currencyId.length * 3;
  bytesCount += 3 + object.expenseTransactions.length * 3;
  {
    final offsets = allOffsets[Transaction]!;
    for (var i = 0; i < object.expenseTransactions.length; i++) {
      final value = object.expenseTransactions[i];
      bytesCount += TransactionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.incomeTransactions.length * 3;
  {
    final offsets = allOffsets[Transaction]!;
    for (var i = 0; i < object.incomeTransactions.length; i++) {
      final value = object.incomeTransactions[i];
      bytesCount += TransactionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _reportSerialize(
  Report object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<ReportCategorySnapshot>(
    offsets[0],
    allOffsets,
    ReportCategorySnapshotSchema.serialize,
    object.categories,
  );
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.currencyId);
  writer.writeDateTime(offsets[3], object.dateRangeFrom);
  writer.writeDateTime(offsets[4], object.dateRangeTo);
  writer.writeObjectList<Transaction>(
    offsets[5],
    allOffsets,
    TransactionSchema.serialize,
    object.expenseTransactions,
  );
  writer.writeDouble(offsets[6], object.expenses);
  writer.writeDouble(offsets[7], object.income);
  writer.writeObjectList<Transaction>(
    offsets[8],
    allOffsets,
    TransactionSchema.serialize,
    object.incomeTransactions,
  );
}

Report _reportDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Report(
    reader.readDouble(offsets[7]),
    reader.readDouble(offsets[6]),
    reader.readObjectList<ReportCategorySnapshot>(
          offsets[0],
          ReportCategorySnapshotSchema.deserialize,
          allOffsets,
          ReportCategorySnapshot(),
        ) ??
        [],
  );
  object.createdAt = reader.readDateTime(offsets[1]);
  object.currencyId = reader.readString(offsets[2]);
  object.dateRangeFrom = reader.readDateTimeOrNull(offsets[3]);
  object.dateRangeTo = reader.readDateTimeOrNull(offsets[4]);
  object.id = id;
  return object;
}

P _reportDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<ReportCategorySnapshot>(
            offset,
            ReportCategorySnapshotSchema.deserialize,
            allOffsets,
            ReportCategorySnapshot(),
          ) ??
          []) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readObjectList<Transaction>(
            offset,
            TransactionSchema.deserialize,
            allOffsets,
            Transaction(),
          ) ??
          []) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readObjectList<Transaction>(
            offset,
            TransactionSchema.deserialize,
            allOffsets,
            Transaction(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _reportGetId(Report object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _reportGetLinks(Report object) {
  return [];
}

void _reportAttach(IsarCollection<dynamic> col, Id id, Report object) {
  object.id = id;
}

extension ReportQueryWhereSort on QueryBuilder<Report, Report, QWhere> {
  QueryBuilder<Report, Report, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReportQueryWhere on QueryBuilder<Report, Report, QWhereClause> {
  QueryBuilder<Report, Report, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Report, Report, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Report, Report, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Report, Report, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReportQueryFilter on QueryBuilder<Report, Report, QFilterCondition> {
  QueryBuilder<Report, Report, QAfterFilterCondition> categoriesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> categoriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> categoriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> categoriesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      categoriesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> categoriesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categories',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> currencyIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currencyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> currencyIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currencyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> currencyIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currencyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> currencyIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currencyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> currencyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currencyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> currencyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currencyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> currencyIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currencyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> currencyIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currencyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> currencyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currencyId',
        value: '',
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> currencyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currencyId',
        value: '',
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeFromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateRangeFrom',
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeFromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateRangeFrom',
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeFromEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateRangeFrom',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeFromGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateRangeFrom',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeFromLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateRangeFrom',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeFromBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateRangeFrom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeToIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateRangeTo',
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeToIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateRangeTo',
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeToEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateRangeTo',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeToGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateRangeTo',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeToLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateRangeTo',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> dateRangeToBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateRangeTo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      expenseTransactionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expenseTransactions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      expenseTransactionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expenseTransactions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      expenseTransactionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expenseTransactions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      expenseTransactionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expenseTransactions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      expenseTransactionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expenseTransactions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      expenseTransactionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'expenseTransactions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> expensesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expenses',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> expensesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expenses',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> expensesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expenses',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> expensesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expenses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> incomeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> incomeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> incomeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> incomeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'income',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      incomeTransactionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'incomeTransactions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      incomeTransactionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'incomeTransactions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      incomeTransactionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'incomeTransactions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      incomeTransactionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'incomeTransactions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      incomeTransactionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'incomeTransactions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      incomeTransactionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'incomeTransactions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ReportQueryObject on QueryBuilder<Report, Report, QFilterCondition> {
  QueryBuilder<Report, Report, QAfterFilterCondition> categoriesElement(
      FilterQuery<ReportCategorySnapshot> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'categories');
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition>
      expenseTransactionsElement(FilterQuery<Transaction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'expenseTransactions');
    });
  }

  QueryBuilder<Report, Report, QAfterFilterCondition> incomeTransactionsElement(
      FilterQuery<Transaction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'incomeTransactions');
    });
  }
}

extension ReportQueryLinks on QueryBuilder<Report, Report, QFilterCondition> {}

extension ReportQuerySortBy on QueryBuilder<Report, Report, QSortBy> {
  QueryBuilder<Report, Report, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByCurrencyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyId', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByCurrencyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyId', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByDateRangeFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangeFrom', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByDateRangeFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangeFrom', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByDateRangeTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangeTo', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByDateRangeToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangeTo', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByExpenses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenses', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByExpensesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenses', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'income', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> sortByIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'income', Sort.desc);
    });
  }
}

extension ReportQuerySortThenBy on QueryBuilder<Report, Report, QSortThenBy> {
  QueryBuilder<Report, Report, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByCurrencyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyId', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByCurrencyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyId', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByDateRangeFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangeFrom', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByDateRangeFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangeFrom', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByDateRangeTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangeTo', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByDateRangeToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangeTo', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByExpenses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenses', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByExpensesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenses', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'income', Sort.asc);
    });
  }

  QueryBuilder<Report, Report, QAfterSortBy> thenByIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'income', Sort.desc);
    });
  }
}

extension ReportQueryWhereDistinct on QueryBuilder<Report, Report, QDistinct> {
  QueryBuilder<Report, Report, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Report, Report, QDistinct> distinctByCurrencyId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currencyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Report, Report, QDistinct> distinctByDateRangeFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateRangeFrom');
    });
  }

  QueryBuilder<Report, Report, QDistinct> distinctByDateRangeTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateRangeTo');
    });
  }

  QueryBuilder<Report, Report, QDistinct> distinctByExpenses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expenses');
    });
  }

  QueryBuilder<Report, Report, QDistinct> distinctByIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'income');
    });
  }
}

extension ReportQueryProperty on QueryBuilder<Report, Report, QQueryProperty> {
  QueryBuilder<Report, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Report, List<ReportCategorySnapshot>, QQueryOperations>
      categoriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categories');
    });
  }

  QueryBuilder<Report, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Report, String, QQueryOperations> currencyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currencyId');
    });
  }

  QueryBuilder<Report, DateTime?, QQueryOperations> dateRangeFromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateRangeFrom');
    });
  }

  QueryBuilder<Report, DateTime?, QQueryOperations> dateRangeToProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateRangeTo');
    });
  }

  QueryBuilder<Report, List<Transaction>, QQueryOperations>
      expenseTransactionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expenseTransactions');
    });
  }

  QueryBuilder<Report, double, QQueryOperations> expensesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expenses');
    });
  }

  QueryBuilder<Report, double, QQueryOperations> incomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'income');
    });
  }

  QueryBuilder<Report, List<Transaction>, QQueryOperations>
      incomeTransactionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'incomeTransactions');
    });
  }
}
