// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCsvImportSettingsCollection on Isar {
  IsarCollection<CsvImportSettings> get csvImportSettings => this.collection();
}

const CsvImportSettingsSchema = CollectionSchema(
  name: r'CsvImportSettings',
  id: -1228427446524310901,
  properties: {
    r'currencyId': PropertySchema(
      id: 0,
      name: r'currencyId',
      type: IsarType.string,
    ),
    r'dateFormat': PropertySchema(
      id: 1,
      name: r'dateFormat',
      type: IsarType.byte,
      enumMap: _CsvImportSettingsdateFormatEnumValueMap,
    ),
    r'dateSeparator': PropertySchema(
      id: 2,
      name: r'dateSeparator',
      type: IsarType.string,
    ),
    r'endOfLine': PropertySchema(
      id: 3,
      name: r'endOfLine',
      type: IsarType.string,
    ),
    r'excludeIncome': PropertySchema(
      id: 4,
      name: r'excludeIncome',
      type: IsarType.bool,
    ),
    r'expenseSign': PropertySchema(
      id: 5,
      name: r'expenseSign',
      type: IsarType.byte,
      enumMap: _CsvImportSettingsexpenseSignEnumValueMap,
    ),
    r'fieldDelimiter': PropertySchema(
      id: 6,
      name: r'fieldDelimiter',
      type: IsarType.string,
    ),
    r'fieldIndexes': PropertySchema(
      id: 7,
      name: r'fieldIndexes',
      type: IsarType.object,
      target: r'FieldIndexes',
    ),
    r'headerAndFirstRowData': PropertySchema(
      id: 8,
      name: r'headerAndFirstRowData',
      type: IsarType.object,
      target: r'HeaderFirstRowData',
    ),
    r'numberStyle': PropertySchema(
      id: 9,
      name: r'numberStyle',
      type: IsarType.byte,
      enumMap: _CsvImportSettingsnumberStyleEnumValueMap,
    )
  },
  estimateSize: _csvImportSettingsEstimateSize,
  serialize: _csvImportSettingsSerialize,
  deserialize: _csvImportSettingsDeserialize,
  deserializeProp: _csvImportSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'FieldIndexes': FieldIndexesSchema,
    r'HeaderFirstRowData': HeaderFirstRowDataSchema
  },
  getId: _csvImportSettingsGetId,
  getLinks: _csvImportSettingsGetLinks,
  attach: _csvImportSettingsAttach,
  version: '3.1.0+1',
);

int _csvImportSettingsEstimateSize(
  CsvImportSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.currencyId.length * 3;
  bytesCount += 3 + object.dateSeparator.length * 3;
  bytesCount += 3 + object.endOfLine.length * 3;
  bytesCount += 3 + object.fieldDelimiter.length * 3;
  bytesCount += 3 +
      FieldIndexesSchema.estimateSize(
          object.fieldIndexes, allOffsets[FieldIndexes]!, allOffsets);
  bytesCount += 3 +
      HeaderFirstRowDataSchema.estimateSize(object.headerAndFirstRowData,
          allOffsets[HeaderFirstRowData]!, allOffsets);
  return bytesCount;
}

void _csvImportSettingsSerialize(
  CsvImportSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.currencyId);
  writer.writeByte(offsets[1], object.dateFormat.index);
  writer.writeString(offsets[2], object.dateSeparator);
  writer.writeString(offsets[3], object.endOfLine);
  writer.writeBool(offsets[4], object.excludeIncome);
  writer.writeByte(offsets[5], object.expenseSign.index);
  writer.writeString(offsets[6], object.fieldDelimiter);
  writer.writeObject<FieldIndexes>(
    offsets[7],
    allOffsets,
    FieldIndexesSchema.serialize,
    object.fieldIndexes,
  );
  writer.writeObject<HeaderFirstRowData>(
    offsets[8],
    allOffsets,
    HeaderFirstRowDataSchema.serialize,
    object.headerAndFirstRowData,
  );
  writer.writeByte(offsets[9], object.numberStyle.index);
}

CsvImportSettings _csvImportSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CsvImportSettings();
  object.currencyId = reader.readString(offsets[0]);
  object.dateFormat = _CsvImportSettingsdateFormatValueEnumMap[
          reader.readByteOrNull(offsets[1])] ??
      DateFormatEnum.ddmmyyyy;
  object.dateSeparator = reader.readString(offsets[2]);
  object.endOfLine = reader.readString(offsets[3]);
  object.excludeIncome = reader.readBool(offsets[4]);
  object.expenseSign = _CsvImportSettingsexpenseSignValueEnumMap[
          reader.readByteOrNull(offsets[5])] ??
      ExpenseSignEnum.negative;
  object.fieldDelimiter = reader.readString(offsets[6]);
  object.fieldIndexes = reader.readObjectOrNull<FieldIndexes>(
        offsets[7],
        FieldIndexesSchema.deserialize,
        allOffsets,
      ) ??
      FieldIndexes();
  object.headerAndFirstRowData = reader.readObjectOrNull<HeaderFirstRowData>(
        offsets[8],
        HeaderFirstRowDataSchema.deserialize,
        allOffsets,
      ) ??
      HeaderFirstRowData();
  object.id = id;
  object.numberStyle = _CsvImportSettingsnumberStyleValueEnumMap[
          reader.readByteOrNull(offsets[9])] ??
      NumberingStyle.eu;
  return object;
}

P _csvImportSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (_CsvImportSettingsdateFormatValueEnumMap[
              reader.readByteOrNull(offset)] ??
          DateFormatEnum.ddmmyyyy) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (_CsvImportSettingsexpenseSignValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ExpenseSignEnum.negative) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readObjectOrNull<FieldIndexes>(
            offset,
            FieldIndexesSchema.deserialize,
            allOffsets,
          ) ??
          FieldIndexes()) as P;
    case 8:
      return (reader.readObjectOrNull<HeaderFirstRowData>(
            offset,
            HeaderFirstRowDataSchema.deserialize,
            allOffsets,
          ) ??
          HeaderFirstRowData()) as P;
    case 9:
      return (_CsvImportSettingsnumberStyleValueEnumMap[
              reader.readByteOrNull(offset)] ??
          NumberingStyle.eu) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CsvImportSettingsdateFormatEnumValueMap = {
  'ddmmyyyy': 0,
  'mmddyyyy': 1,
  'yyyymmdd': 2,
};
const _CsvImportSettingsdateFormatValueEnumMap = {
  0: DateFormatEnum.ddmmyyyy,
  1: DateFormatEnum.mmddyyyy,
  2: DateFormatEnum.yyyymmdd,
};
const _CsvImportSettingsexpenseSignEnumValueMap = {
  'negative': 0,
  'positive': 1,
};
const _CsvImportSettingsexpenseSignValueEnumMap = {
  0: ExpenseSignEnum.negative,
  1: ExpenseSignEnum.positive,
};
const _CsvImportSettingsnumberStyleEnumValueMap = {
  'eu': 0,
  'us': 1,
};
const _CsvImportSettingsnumberStyleValueEnumMap = {
  0: NumberingStyle.eu,
  1: NumberingStyle.us,
};

Id _csvImportSettingsGetId(CsvImportSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _csvImportSettingsGetLinks(
    CsvImportSettings object) {
  return [];
}

void _csvImportSettingsAttach(
    IsarCollection<dynamic> col, Id id, CsvImportSettings object) {
  object.id = id;
}

extension CsvImportSettingsQueryWhereSort
    on QueryBuilder<CsvImportSettings, CsvImportSettings, QWhere> {
  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CsvImportSettingsQueryWhere
    on QueryBuilder<CsvImportSettings, CsvImportSettings, QWhereClause> {
  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterWhereClause>
      idBetween(
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

extension CsvImportSettingsQueryFilter
    on QueryBuilder<CsvImportSettings, CsvImportSettings, QFilterCondition> {
  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      currencyIdEqualTo(
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

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      currencyIdGreaterThan(
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

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      currencyIdLessThan(
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

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      currencyIdBetween(
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

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      currencyIdStartsWith(
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

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      currencyIdEndsWith(
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

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      currencyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currencyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      currencyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currencyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      currencyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currencyId',
        value: '',
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      currencyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currencyId',
        value: '',
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateFormatEqualTo(DateFormatEnum value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateFormat',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateFormatGreaterThan(
    DateFormatEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateFormat',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateFormatLessThan(
    DateFormatEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateFormat',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateFormatBetween(
    DateFormatEnum lower,
    DateFormatEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateFormat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateSeparatorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateSeparator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateSeparatorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateSeparator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateSeparatorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateSeparator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateSeparatorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateSeparator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateSeparatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateSeparator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateSeparatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateSeparator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateSeparatorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateSeparator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateSeparatorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateSeparator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateSeparatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateSeparator',
        value: '',
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      dateSeparatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateSeparator',
        value: '',
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      endOfLineEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endOfLine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      endOfLineGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endOfLine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      endOfLineLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endOfLine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      endOfLineBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endOfLine',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      endOfLineStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'endOfLine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      endOfLineEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'endOfLine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      endOfLineContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'endOfLine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      endOfLineMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'endOfLine',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      endOfLineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endOfLine',
        value: '',
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      endOfLineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'endOfLine',
        value: '',
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      excludeIncomeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'excludeIncome',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      expenseSignEqualTo(ExpenseSignEnum value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expenseSign',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      expenseSignGreaterThan(
    ExpenseSignEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expenseSign',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      expenseSignLessThan(
    ExpenseSignEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expenseSign',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      expenseSignBetween(
    ExpenseSignEnum lower,
    ExpenseSignEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expenseSign',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldDelimiterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fieldDelimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldDelimiterGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fieldDelimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldDelimiterLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fieldDelimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldDelimiterBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fieldDelimiter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldDelimiterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fieldDelimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldDelimiterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fieldDelimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldDelimiterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fieldDelimiter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldDelimiterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fieldDelimiter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldDelimiterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fieldDelimiter',
        value: '',
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldDelimiterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fieldDelimiter',
        value: '',
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      numberStyleEqualTo(NumberingStyle value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numberStyle',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      numberStyleGreaterThan(
    NumberingStyle value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numberStyle',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      numberStyleLessThan(
    NumberingStyle value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numberStyle',
        value: value,
      ));
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      numberStyleBetween(
    NumberingStyle lower,
    NumberingStyle upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numberStyle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CsvImportSettingsQueryObject
    on QueryBuilder<CsvImportSettings, CsvImportSettings, QFilterCondition> {
  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      fieldIndexes(FilterQuery<FieldIndexes> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fieldIndexes');
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterFilterCondition>
      headerAndFirstRowData(FilterQuery<HeaderFirstRowData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'headerAndFirstRowData');
    });
  }
}

extension CsvImportSettingsQueryLinks
    on QueryBuilder<CsvImportSettings, CsvImportSettings, QFilterCondition> {}

extension CsvImportSettingsQuerySortBy
    on QueryBuilder<CsvImportSettings, CsvImportSettings, QSortBy> {
  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByCurrencyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyId', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByCurrencyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyId', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByDateFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByDateFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByDateSeparator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSeparator', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByDateSeparatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSeparator', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByEndOfLine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endOfLine', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByEndOfLineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endOfLine', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByExcludeIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'excludeIncome', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByExcludeIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'excludeIncome', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByExpenseSign() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseSign', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByExpenseSignDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseSign', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByFieldDelimiter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fieldDelimiter', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByFieldDelimiterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fieldDelimiter', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByNumberStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberStyle', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      sortByNumberStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberStyle', Sort.desc);
    });
  }
}

extension CsvImportSettingsQuerySortThenBy
    on QueryBuilder<CsvImportSettings, CsvImportSettings, QSortThenBy> {
  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByCurrencyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyId', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByCurrencyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyId', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByDateFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByDateFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByDateSeparator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSeparator', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByDateSeparatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSeparator', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByEndOfLine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endOfLine', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByEndOfLineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endOfLine', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByExcludeIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'excludeIncome', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByExcludeIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'excludeIncome', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByExpenseSign() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseSign', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByExpenseSignDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseSign', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByFieldDelimiter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fieldDelimiter', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByFieldDelimiterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fieldDelimiter', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByNumberStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberStyle', Sort.asc);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QAfterSortBy>
      thenByNumberStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberStyle', Sort.desc);
    });
  }
}

extension CsvImportSettingsQueryWhereDistinct
    on QueryBuilder<CsvImportSettings, CsvImportSettings, QDistinct> {
  QueryBuilder<CsvImportSettings, CsvImportSettings, QDistinct>
      distinctByCurrencyId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currencyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QDistinct>
      distinctByDateFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateFormat');
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QDistinct>
      distinctByDateSeparator({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateSeparator',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QDistinct>
      distinctByEndOfLine({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endOfLine', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QDistinct>
      distinctByExcludeIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'excludeIncome');
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QDistinct>
      distinctByExpenseSign() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expenseSign');
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QDistinct>
      distinctByFieldDelimiter({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fieldDelimiter',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CsvImportSettings, CsvImportSettings, QDistinct>
      distinctByNumberStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numberStyle');
    });
  }
}

extension CsvImportSettingsQueryProperty
    on QueryBuilder<CsvImportSettings, CsvImportSettings, QQueryProperty> {
  QueryBuilder<CsvImportSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CsvImportSettings, String, QQueryOperations>
      currencyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currencyId');
    });
  }

  QueryBuilder<CsvImportSettings, DateFormatEnum, QQueryOperations>
      dateFormatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateFormat');
    });
  }

  QueryBuilder<CsvImportSettings, String, QQueryOperations>
      dateSeparatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateSeparator');
    });
  }

  QueryBuilder<CsvImportSettings, String, QQueryOperations>
      endOfLineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endOfLine');
    });
  }

  QueryBuilder<CsvImportSettings, bool, QQueryOperations>
      excludeIncomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'excludeIncome');
    });
  }

  QueryBuilder<CsvImportSettings, ExpenseSignEnum, QQueryOperations>
      expenseSignProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expenseSign');
    });
  }

  QueryBuilder<CsvImportSettings, String, QQueryOperations>
      fieldDelimiterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fieldDelimiter');
    });
  }

  QueryBuilder<CsvImportSettings, FieldIndexes, QQueryOperations>
      fieldIndexesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fieldIndexes');
    });
  }

  QueryBuilder<CsvImportSettings, HeaderFirstRowData, QQueryOperations>
      headerAndFirstRowDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'headerAndFirstRowData');
    });
  }

  QueryBuilder<CsvImportSettings, NumberingStyle, QQueryOperations>
      numberStyleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numberStyle');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FieldIndexesSchema = Schema(
  name: r'FieldIndexes',
  id: 3416112390240900299,
  properties: {
    r'amountField': PropertySchema(
      id: 0,
      name: r'amountField',
      type: IsarType.long,
    ),
    r'dateField': PropertySchema(
      id: 1,
      name: r'dateField',
      type: IsarType.long,
    ),
    r'descriptionField': PropertySchema(
      id: 2,
      name: r'descriptionField',
      type: IsarType.long,
    )
  },
  estimateSize: _fieldIndexesEstimateSize,
  serialize: _fieldIndexesSerialize,
  deserialize: _fieldIndexesDeserialize,
  deserializeProp: _fieldIndexesDeserializeProp,
);

int _fieldIndexesEstimateSize(
  FieldIndexes object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _fieldIndexesSerialize(
  FieldIndexes object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amountField);
  writer.writeLong(offsets[1], object.dateField);
  writer.writeLong(offsets[2], object.descriptionField);
}

FieldIndexes _fieldIndexesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FieldIndexes(
    amountField: reader.readLongOrNull(offsets[0]) ?? 1,
    dateField: reader.readLongOrNull(offsets[1]) ?? 0,
    descriptionField: reader.readLongOrNull(offsets[2]) ?? 2,
  );
  return object;
}

P _fieldIndexesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 2) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FieldIndexesQueryFilter
    on QueryBuilder<FieldIndexes, FieldIndexes, QFilterCondition> {
  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      amountFieldEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountField',
        value: value,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      amountFieldGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountField',
        value: value,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      amountFieldLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountField',
        value: value,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      amountFieldBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountField',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      dateFieldEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateField',
        value: value,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      dateFieldGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateField',
        value: value,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      dateFieldLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateField',
        value: value,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      dateFieldBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateField',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      descriptionFieldEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionField',
        value: value,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      descriptionFieldGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descriptionField',
        value: value,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      descriptionFieldLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descriptionField',
        value: value,
      ));
    });
  }

  QueryBuilder<FieldIndexes, FieldIndexes, QAfterFilterCondition>
      descriptionFieldBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descriptionField',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FieldIndexesQueryObject
    on QueryBuilder<FieldIndexes, FieldIndexes, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const HeaderFirstRowDataSchema = Schema(
  name: r'HeaderFirstRowData',
  id: 9000377330969592656,
  properties: {
    r'firstRow': PropertySchema(
      id: 0,
      name: r'firstRow',
      type: IsarType.stringList,
    ),
    r'headerRow': PropertySchema(
      id: 1,
      name: r'headerRow',
      type: IsarType.stringList,
    )
  },
  estimateSize: _headerFirstRowDataEstimateSize,
  serialize: _headerFirstRowDataSerialize,
  deserialize: _headerFirstRowDataDeserialize,
  deserializeProp: _headerFirstRowDataDeserializeProp,
);

int _headerFirstRowDataEstimateSize(
  HeaderFirstRowData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.firstRow.length * 3;
  {
    for (var i = 0; i < object.firstRow.length; i++) {
      final value = object.firstRow[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.headerRow.length * 3;
  {
    for (var i = 0; i < object.headerRow.length; i++) {
      final value = object.headerRow[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _headerFirstRowDataSerialize(
  HeaderFirstRowData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.firstRow);
  writer.writeStringList(offsets[1], object.headerRow);
}

HeaderFirstRowData _headerFirstRowDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HeaderFirstRowData(
    reader.readStringList(offsets[1]) ?? const [],
    reader.readStringList(offsets[0]) ?? const [],
  );
  return object;
}

P _headerFirstRowDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? const []) as P;
    case 1:
      return (reader.readStringList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension HeaderFirstRowDataQueryFilter
    on QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QFilterCondition> {
  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstRow',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firstRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firstRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firstRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firstRow',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstRow',
        value: '',
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firstRow',
        value: '',
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'firstRow',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'firstRow',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'firstRow',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'firstRow',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'firstRow',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      firstRowLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'firstRow',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headerRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'headerRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'headerRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'headerRow',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'headerRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'headerRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'headerRow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'headerRow',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headerRow',
        value: '',
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'headerRow',
        value: '',
      ));
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerRow',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerRow',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerRow',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerRow',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerRow',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QAfterFilterCondition>
      headerRowLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerRow',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension HeaderFirstRowDataQueryObject
    on QueryBuilder<HeaderFirstRowData, HeaderFirstRowData, QFilterCondition> {}
