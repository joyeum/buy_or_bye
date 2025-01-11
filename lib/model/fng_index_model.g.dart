// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fng_index_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMetadataCollection on Isar {
  IsarCollection<Metadata> get metadatas => this.collection();
}

const MetadataSchema = CollectionSchema(
  name: r'Metadata',
  id: -437953486446359667,
  properties: {
    r'index': PropertySchema(
      id: 0,
      name: r'index',
      type: IsarType.double,
    ),
    r'index_previous_1_month': PropertySchema(
      id: 1,
      name: r'index_previous_1_month',
      type: IsarType.double,
    ),
    r'index_previous_1_week': PropertySchema(
      id: 2,
      name: r'index_previous_1_week',
      type: IsarType.double,
    ),
    r'index_previous_1_year': PropertySchema(
      id: 3,
      name: r'index_previous_1_year',
      type: IsarType.double,
    ),
    r'index_previous_close': PropertySchema(
      id: 4,
      name: r'index_previous_close',
      type: IsarType.double,
    ),
    r'lastUpdated': PropertySchema(
      id: 5,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'rating': PropertySchema(
      id: 6,
      name: r'rating',
      type: IsarType.byte,
      enumMap: _MetadataratingEnumValueMap,
    )
  },
  estimateSize: _metadataEstimateSize,
  serialize: _metadataSerialize,
  deserialize: _metadataDeserialize,
  deserializeProp: _metadataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _metadataGetId,
  getLinks: _metadataGetLinks,
  attach: _metadataAttach,
  version: '3.1.0+1',
);

int _metadataEstimateSize(
  Metadata object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _metadataSerialize(
  Metadata object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.index);
  writer.writeDouble(offsets[1], object.index_previous_1_month);
  writer.writeDouble(offsets[2], object.index_previous_1_week);
  writer.writeDouble(offsets[3], object.index_previous_1_year);
  writer.writeDouble(offsets[4], object.index_previous_close);
  writer.writeDateTime(offsets[5], object.lastUpdated);
  writer.writeByte(offsets[6], object.rating.index);
}

Metadata _metadataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Metadata();
  object.id = id;
  object.index = reader.readDouble(offsets[0]);
  object.index_previous_1_month = reader.readDouble(offsets[1]);
  object.index_previous_1_week = reader.readDouble(offsets[2]);
  object.index_previous_1_year = reader.readDouble(offsets[3]);
  object.index_previous_close = reader.readDouble(offsets[4]);
  object.lastUpdated = reader.readDateTime(offsets[5]);
  object.rating =
      _MetadataratingValueEnumMap[reader.readByteOrNull(offsets[6])] ??
          Rating.extremeGreed;
  return object;
}

P _metadataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (_MetadataratingValueEnumMap[reader.readByteOrNull(offset)] ??
          Rating.extremeGreed) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MetadataratingEnumValueMap = {
  'extremeGreed': 0,
  'greed': 1,
  'neutral': 2,
  'fear': 3,
  'extremeFear': 4,
};
const _MetadataratingValueEnumMap = {
  0: Rating.extremeGreed,
  1: Rating.greed,
  2: Rating.neutral,
  3: Rating.fear,
  4: Rating.extremeFear,
};

Id _metadataGetId(Metadata object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _metadataGetLinks(Metadata object) {
  return [];
}

void _metadataAttach(IsarCollection<dynamic> col, Id id, Metadata object) {
  object.id = id;
}

extension MetadataQueryWhereSort on QueryBuilder<Metadata, Metadata, QWhere> {
  QueryBuilder<Metadata, Metadata, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MetadataQueryWhere on QueryBuilder<Metadata, Metadata, QWhereClause> {
  QueryBuilder<Metadata, Metadata, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Metadata, Metadata, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterWhereClause> idBetween(
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

extension MetadataQueryFilter
    on QueryBuilder<Metadata, Metadata, QFilterCondition> {
  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> indexEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> indexGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> indexLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> indexBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_monthEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index_previous_1_month',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_monthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index_previous_1_month',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_monthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index_previous_1_month',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_monthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index_previous_1_month',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_weekEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index_previous_1_week',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_weekGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index_previous_1_week',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_weekLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index_previous_1_week',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_weekBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index_previous_1_week',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_yearEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index_previous_1_year',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_yearGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index_previous_1_year',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_yearLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index_previous_1_year',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_1_yearBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index_previous_1_year',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_closeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index_previous_close',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_closeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index_previous_close',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_closeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index_previous_close',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      index_previous_closeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index_previous_close',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> lastUpdatedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      lastUpdatedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> lastUpdatedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> lastUpdatedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> ratingEqualTo(
      Rating value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> ratingGreaterThan(
    Rating value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> ratingLessThan(
    Rating value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> ratingBetween(
    Rating lower,
    Rating upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MetadataQueryObject
    on QueryBuilder<Metadata, Metadata, QFilterCondition> {}

extension MetadataQueryLinks
    on QueryBuilder<Metadata, Metadata, QFilterCondition> {}

extension MetadataQuerySortBy on QueryBuilder<Metadata, Metadata, QSortBy> {
  QueryBuilder<Metadata, Metadata, QAfterSortBy> sortByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> sortByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy>
      sortByIndex_previous_1_month() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_month', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy>
      sortByIndex_previous_1_monthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_month', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> sortByIndex_previous_1_week() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_week', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy>
      sortByIndex_previous_1_weekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_week', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> sortByIndex_previous_1_year() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_year', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy>
      sortByIndex_previous_1_yearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_year', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> sortByIndex_previous_close() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_close', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy>
      sortByIndex_previous_closeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_close', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }
}

extension MetadataQuerySortThenBy
    on QueryBuilder<Metadata, Metadata, QSortThenBy> {
  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy>
      thenByIndex_previous_1_month() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_month', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy>
      thenByIndex_previous_1_monthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_month', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenByIndex_previous_1_week() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_week', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy>
      thenByIndex_previous_1_weekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_week', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenByIndex_previous_1_year() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_year', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy>
      thenByIndex_previous_1_yearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_1_year', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenByIndex_previous_close() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_close', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy>
      thenByIndex_previous_closeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index_previous_close', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterSortBy> thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }
}

extension MetadataQueryWhereDistinct
    on QueryBuilder<Metadata, Metadata, QDistinct> {
  QueryBuilder<Metadata, Metadata, QDistinct> distinctByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index');
    });
  }

  QueryBuilder<Metadata, Metadata, QDistinct>
      distinctByIndex_previous_1_month() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index_previous_1_month');
    });
  }

  QueryBuilder<Metadata, Metadata, QDistinct>
      distinctByIndex_previous_1_week() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index_previous_1_week');
    });
  }

  QueryBuilder<Metadata, Metadata, QDistinct>
      distinctByIndex_previous_1_year() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index_previous_1_year');
    });
  }

  QueryBuilder<Metadata, Metadata, QDistinct> distinctByIndex_previous_close() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index_previous_close');
    });
  }

  QueryBuilder<Metadata, Metadata, QDistinct> distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<Metadata, Metadata, QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }
}

extension MetadataQueryProperty
    on QueryBuilder<Metadata, Metadata, QQueryProperty> {
  QueryBuilder<Metadata, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Metadata, double, QQueryOperations> indexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index');
    });
  }

  QueryBuilder<Metadata, double, QQueryOperations>
      index_previous_1_monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index_previous_1_month');
    });
  }

  QueryBuilder<Metadata, double, QQueryOperations>
      index_previous_1_weekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index_previous_1_week');
    });
  }

  QueryBuilder<Metadata, double, QQueryOperations>
      index_previous_1_yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index_previous_1_year');
    });
  }

  QueryBuilder<Metadata, double, QQueryOperations>
      index_previous_closeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index_previous_close');
    });
  }

  QueryBuilder<Metadata, DateTime, QQueryOperations> lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<Metadata, Rating, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFngIndexModelCollection on Isar {
  IsarCollection<FngIndexModel> get fngIndexModels => this.collection();
}

const FngIndexModelSchema = CollectionSchema(
  name: r'FngIndexModel',
  id: 5601942049614600003,
  properties: {
    r'dateTime': PropertySchema(
      id: 0,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'index': PropertySchema(
      id: 1,
      name: r'index',
      type: IsarType.double,
    ),
    r'rating': PropertySchema(
      id: 2,
      name: r'rating',
      type: IsarType.byte,
      enumMap: _FngIndexModelratingEnumValueMap,
    )
  },
  estimateSize: _fngIndexModelEstimateSize,
  serialize: _fngIndexModelSerialize,
  deserialize: _fngIndexModelDeserialize,
  deserializeProp: _fngIndexModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'dateTime': IndexSchema(
      id: -138851979697481250,
      name: r'dateTime',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateTime',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _fngIndexModelGetId,
  getLinks: _fngIndexModelGetLinks,
  attach: _fngIndexModelAttach,
  version: '3.1.0+1',
);

int _fngIndexModelEstimateSize(
  FngIndexModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _fngIndexModelSerialize(
  FngIndexModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateTime);
  writer.writeDouble(offsets[1], object.index);
  writer.writeByte(offsets[2], object.rating.index);
}

FngIndexModel _fngIndexModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FngIndexModel();
  object.dateTime = reader.readDateTime(offsets[0]);
  object.id = id;
  object.index = reader.readDouble(offsets[1]);
  object.rating =
      _FngIndexModelratingValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          Rating.extremeGreed;
  return object;
}

P _fngIndexModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (_FngIndexModelratingValueEnumMap[reader.readByteOrNull(offset)] ??
          Rating.extremeGreed) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FngIndexModelratingEnumValueMap = {
  'extremeGreed': 0,
  'greed': 1,
  'neutral': 2,
  'fear': 3,
  'extremeFear': 4,
};
const _FngIndexModelratingValueEnumMap = {
  0: Rating.extremeGreed,
  1: Rating.greed,
  2: Rating.neutral,
  3: Rating.fear,
  4: Rating.extremeFear,
};

Id _fngIndexModelGetId(FngIndexModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fngIndexModelGetLinks(FngIndexModel object) {
  return [];
}

void _fngIndexModelAttach(
    IsarCollection<dynamic> col, Id id, FngIndexModel object) {
  object.id = id;
}

extension FngIndexModelByIndex on IsarCollection<FngIndexModel> {
  Future<FngIndexModel?> getByDateTime(DateTime dateTime) {
    return getByIndex(r'dateTime', [dateTime]);
  }

  FngIndexModel? getByDateTimeSync(DateTime dateTime) {
    return getByIndexSync(r'dateTime', [dateTime]);
  }

  Future<bool> deleteByDateTime(DateTime dateTime) {
    return deleteByIndex(r'dateTime', [dateTime]);
  }

  bool deleteByDateTimeSync(DateTime dateTime) {
    return deleteByIndexSync(r'dateTime', [dateTime]);
  }

  Future<List<FngIndexModel?>> getAllByDateTime(List<DateTime> dateTimeValues) {
    final values = dateTimeValues.map((e) => [e]).toList();
    return getAllByIndex(r'dateTime', values);
  }

  List<FngIndexModel?> getAllByDateTimeSync(List<DateTime> dateTimeValues) {
    final values = dateTimeValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'dateTime', values);
  }

  Future<int> deleteAllByDateTime(List<DateTime> dateTimeValues) {
    final values = dateTimeValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'dateTime', values);
  }

  int deleteAllByDateTimeSync(List<DateTime> dateTimeValues) {
    final values = dateTimeValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'dateTime', values);
  }

  Future<Id> putByDateTime(FngIndexModel object) {
    return putByIndex(r'dateTime', object);
  }

  Id putByDateTimeSync(FngIndexModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'dateTime', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDateTime(List<FngIndexModel> objects) {
    return putAllByIndex(r'dateTime', objects);
  }

  List<Id> putAllByDateTimeSync(List<FngIndexModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'dateTime', objects, saveLinks: saveLinks);
  }
}

extension FngIndexModelQueryWhereSort
    on QueryBuilder<FngIndexModel, FngIndexModel, QWhere> {
  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhere> anyDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateTime'),
      );
    });
  }
}

extension FngIndexModelQueryWhere
    on QueryBuilder<FngIndexModel, FngIndexModel, QWhereClause> {
  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhereClause> dateTimeEqualTo(
      DateTime dateTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateTime',
        value: [dateTime],
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhereClause>
      dateTimeNotEqualTo(DateTime dateTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [],
              upper: [dateTime],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [dateTime],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [dateTime],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [],
              upper: [dateTime],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhereClause>
      dateTimeGreaterThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [dateTime],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhereClause>
      dateTimeLessThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [],
        upper: [dateTime],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterWhereClause> dateTimeBetween(
    DateTime lowerDateTime,
    DateTime upperDateTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [lowerDateTime],
        includeLower: includeLower,
        upper: [upperDateTime],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FngIndexModelQueryFilter
    on QueryBuilder<FngIndexModel, FngIndexModel, QFilterCondition> {
  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
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

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      indexEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      indexGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      indexLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      indexBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      ratingEqualTo(Rating value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      ratingGreaterThan(
    Rating value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      ratingLessThan(
    Rating value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterFilterCondition>
      ratingBetween(
    Rating lower,
    Rating upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FngIndexModelQueryObject
    on QueryBuilder<FngIndexModel, FngIndexModel, QFilterCondition> {}

extension FngIndexModelQueryLinks
    on QueryBuilder<FngIndexModel, FngIndexModel, QFilterCondition> {}

extension FngIndexModelQuerySortBy
    on QueryBuilder<FngIndexModel, FngIndexModel, QSortBy> {
  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> sortByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> sortByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }
}

extension FngIndexModelQuerySortThenBy
    on QueryBuilder<FngIndexModel, FngIndexModel, QSortThenBy> {
  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> thenByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> thenByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QAfterSortBy> thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }
}

extension FngIndexModelQueryWhereDistinct
    on QueryBuilder<FngIndexModel, FngIndexModel, QDistinct> {
  QueryBuilder<FngIndexModel, FngIndexModel, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QDistinct> distinctByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index');
    });
  }

  QueryBuilder<FngIndexModel, FngIndexModel, QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }
}

extension FngIndexModelQueryProperty
    on QueryBuilder<FngIndexModel, FngIndexModel, QQueryProperty> {
  QueryBuilder<FngIndexModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FngIndexModel, DateTime, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<FngIndexModel, double, QQueryOperations> indexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index');
    });
  }

  QueryBuilder<FngIndexModel, Rating, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }
}
