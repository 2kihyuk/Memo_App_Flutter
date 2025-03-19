// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $MemoTableTable extends MemoTable
    with TableInfo<$MemoTableTable, MemoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _importanceMeta = const VerificationMeta(
    'importance',
  );
  @override
  late final GeneratedColumn<int> importance = GeneratedColumn<int>(
    'importance',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    content,
    createdAt,
    importance,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memo_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemoTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('importance')) {
      context.handle(
        _importanceMeta,
        importance.isAcceptableOrUnknown(data['importance']!, _importanceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      importance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}importance'],
      ),
    );
  }

  @override
  $MemoTableTable createAlias(String alias) {
    return $MemoTableTable(attachedDatabase, alias);
  }
}

class MemoTableData extends DataClass implements Insertable<MemoTableData> {
  final int id;
  final String? title;
  final String? content;
  final DateTime createdAt;
  final int? importance;
  const MemoTableData({
    required this.id,
    this.title,
    this.content,
    required this.createdAt,
    this.importance,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || importance != null) {
      map['importance'] = Variable<int>(importance);
    }
    return map;
  }

  MemoTableCompanion toCompanion(bool nullToAbsent) {
    return MemoTableCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content:
          content == null && nullToAbsent
              ? const Value.absent()
              : Value(content),
      createdAt: Value(createdAt),
      importance:
          importance == null && nullToAbsent
              ? const Value.absent()
              : Value(importance),
    );
  }

  factory MemoTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      importance: serializer.fromJson<int?>(json['importance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'content': serializer.toJson<String?>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'importance': serializer.toJson<int?>(importance),
    };
  }

  MemoTableData copyWith({
    int? id,
    Value<String?> title = const Value.absent(),
    Value<String?> content = const Value.absent(),
    DateTime? createdAt,
    Value<int?> importance = const Value.absent(),
  }) => MemoTableData(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    content: content.present ? content.value : this.content,
    createdAt: createdAt ?? this.createdAt,
    importance: importance.present ? importance.value : this.importance,
  );
  MemoTableData copyWithCompanion(MemoTableCompanion data) {
    return MemoTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      importance:
          data.importance.present ? data.importance.value : this.importance,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemoTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('importance: $importance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, createdAt, importance);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.importance == this.importance);
}

class MemoTableCompanion extends UpdateCompanion<MemoTableData> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> content;
  final Value<DateTime> createdAt;
  final Value<int?> importance;
  const MemoTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.importance = const Value.absent(),
  });
  MemoTableCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.importance = const Value.absent(),
  });
  static Insertable<MemoTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<int>? importance,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (importance != null) 'importance': importance,
    });
  }

  MemoTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? title,
    Value<String?>? content,
    Value<DateTime>? createdAt,
    Value<int?>? importance,
  }) {
    return MemoTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      importance: importance ?? this.importance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (importance.present) {
      map['importance'] = Variable<int>(importance.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('importance: $importance')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MemoTableTable memoTable = $MemoTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [memoTable];
}

typedef $$MemoTableTableCreateCompanionBuilder =
    MemoTableCompanion Function({
      Value<int> id,
      Value<String?> title,
      Value<String?> content,
      Value<DateTime> createdAt,
      Value<int?> importance,
    });
typedef $$MemoTableTableUpdateCompanionBuilder =
    MemoTableCompanion Function({
      Value<int> id,
      Value<String?> title,
      Value<String?> content,
      Value<DateTime> createdAt,
      Value<int?> importance,
    });

class $$MemoTableTableFilterComposer
    extends Composer<_$AppDatabase, $MemoTableTable> {
  $$MemoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MemoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MemoTableTable> {
  $$MemoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MemoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemoTableTable> {
  $$MemoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => column,
  );
}

class $$MemoTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemoTableTable,
          MemoTableData,
          $$MemoTableTableFilterComposer,
          $$MemoTableTableOrderingComposer,
          $$MemoTableTableAnnotationComposer,
          $$MemoTableTableCreateCompanionBuilder,
          $$MemoTableTableUpdateCompanionBuilder,
          (
            MemoTableData,
            BaseReferences<_$AppDatabase, $MemoTableTable, MemoTableData>,
          ),
          MemoTableData,
          PrefetchHooks Function()
        > {
  $$MemoTableTableTableManager(_$AppDatabase db, $MemoTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MemoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MemoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MemoTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int?> importance = const Value.absent(),
              }) => MemoTableCompanion(
                id: id,
                title: title,
                content: content,
                createdAt: createdAt,
                importance: importance,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int?> importance = const Value.absent(),
              }) => MemoTableCompanion.insert(
                id: id,
                title: title,
                content: content,
                createdAt: createdAt,
                importance: importance,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MemoTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemoTableTable,
      MemoTableData,
      $$MemoTableTableFilterComposer,
      $$MemoTableTableOrderingComposer,
      $$MemoTableTableAnnotationComposer,
      $$MemoTableTableCreateCompanionBuilder,
      $$MemoTableTableUpdateCompanionBuilder,
      (
        MemoTableData,
        BaseReferences<_$AppDatabase, $MemoTableTable, MemoTableData>,
      ),
      MemoTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MemoTableTableTableManager get memoTable =>
      $$MemoTableTableTableManager(_db, _db.memoTable);
}
