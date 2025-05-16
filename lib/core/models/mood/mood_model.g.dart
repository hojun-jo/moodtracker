// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMoodModelCollection on Isar {
  IsarCollection<MoodModel> get moodModels => this.collection();
}

const MoodModelSchema = CollectionSchema(
  name: r'MoodModel',
  id: -8742229374696050966,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'moodCategory': PropertySchema(
      id: 2,
      name: r'moodCategory',
      type: IsarType.byte,
      enumMap: _MoodModelmoodCategoryEnumValueMap,
    )
  },
  estimateSize: _moodModelEstimateSize,
  serialize: _moodModelSerialize,
  deserialize: _moodModelDeserialize,
  deserializeProp: _moodModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _moodModelGetId,
  getLinks: _moodModelGetLinks,
  attach: _moodModelAttach,
  version: '3.1.0+1',
);

int _moodModelEstimateSize(
  MoodModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  return bytesCount;
}

void _moodModelSerialize(
  MoodModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.description);
  writer.writeByte(offsets[2], object.moodCategory.index);
}

MoodModel _moodModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MoodModel(
    createdAt: reader.readDateTime(offsets[0]),
    description: reader.readString(offsets[1]),
    id: id,
    moodCategory:
        _MoodModelmoodCategoryValueEnumMap[reader.readByteOrNull(offsets[2])] ??
            MoodCategory.excitement,
  );
  return object;
}

P _moodModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (_MoodModelmoodCategoryValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MoodCategory.excitement) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

<<<<<<< HEAD
const _MoodModelmoodCategoryEnumValueMap = {
  'excitement': 0,
  'joy': 1,
  'happy': 2,
  'calm': 3,
  'neutral': 4,
  'anxiety': 5,
  'sad': 6,
  'angry': 7,
};
const _MoodModelmoodCategoryValueEnumMap = {
  0: MoodCategory.excitement,
  1: MoodCategory.joy,
  2: MoodCategory.happy,
  3: MoodCategory.calm,
  4: MoodCategory.neutral,
  5: MoodCategory.anxiety,
  6: MoodCategory.sad,
  7: MoodCategory.angry,
=======
const _MoodModelmoodTypeEnumValueMap = {
  'angry': 0,
  'anxiety': 1,
  'calm': 2,
  'excitement': 3,
  'happy': 4,
  'joy': 5,
  'neutral': 6,
  'sad': 7,
};
const _MoodModelmoodTypeValueEnumMap = {
  0: MoodType.angry,
  1: MoodType.anxiety,
  2: MoodType.calm,
  3: MoodType.excitement,
  4: MoodType.happy,
  5: MoodType.joy,
  6: MoodType.neutral,
  7: MoodType.sad,
>>>>>>> origin/main
};

Id _moodModelGetId(MoodModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _moodModelGetLinks(MoodModel object) {
  return [];
}

void _moodModelAttach(IsarCollection<dynamic> col, Id id, MoodModel object) {}

extension MoodModelQueryWhereSort
    on QueryBuilder<MoodModel, MoodModel, QWhere> {
  QueryBuilder<MoodModel, MoodModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MoodModelQueryWhere
    on QueryBuilder<MoodModel, MoodModel, QWhereClause> {
  QueryBuilder<MoodModel, MoodModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<MoodModel, MoodModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterWhereClause> idBetween(
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

extension MoodModelQueryFilter
    on QueryBuilder<MoodModel, MoodModel, QFilterCondition> {
  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition>
      createdAtGreaterThan(
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

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> moodCategoryEqualTo(
      MoodCategory value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moodCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition>
      moodCategoryGreaterThan(
    MoodCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moodCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition>
      moodCategoryLessThan(
    MoodCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moodCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterFilterCondition> moodCategoryBetween(
    MoodCategory lower,
    MoodCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moodCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MoodModelQueryObject
    on QueryBuilder<MoodModel, MoodModel, QFilterCondition> {}

extension MoodModelQueryLinks
    on QueryBuilder<MoodModel, MoodModel, QFilterCondition> {}

extension MoodModelQuerySortBy on QueryBuilder<MoodModel, MoodModel, QSortBy> {
  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> sortByMoodCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodCategory', Sort.asc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> sortByMoodCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodCategory', Sort.desc);
    });
  }
}

extension MoodModelQuerySortThenBy
    on QueryBuilder<MoodModel, MoodModel, QSortThenBy> {
  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> thenByMoodCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodCategory', Sort.asc);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QAfterSortBy> thenByMoodCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodCategory', Sort.desc);
    });
  }
}

extension MoodModelQueryWhereDistinct
    on QueryBuilder<MoodModel, MoodModel, QDistinct> {
  QueryBuilder<MoodModel, MoodModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<MoodModel, MoodModel, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MoodModel, MoodModel, QDistinct> distinctByMoodCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moodCategory');
    });
  }
}

extension MoodModelQueryProperty
    on QueryBuilder<MoodModel, MoodModel, QQueryProperty> {
  QueryBuilder<MoodModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MoodModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MoodModel, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<MoodModel, MoodCategory, QQueryOperations>
      moodCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moodCategory');
    });
  }
}
