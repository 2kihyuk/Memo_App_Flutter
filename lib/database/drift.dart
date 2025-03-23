import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import '../Model/memo_model.dart';
import 'package:sqlite3/sqlite3.dart';

part 'drift.g.dart';

@DriftDatabase(tables: [MemoTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  //여러개의 메모를 불러온다.
  Stream<List<MemoTableData>> getMemos() => select(memoTable).watch();

  // Future<List<MemoTableData>>getMemos() => select(memoTable).get();

  // //Companion은 업데이트하거나 생성할때 사용한다.
  Future<int> createMemo(MemoTableCompanion data) =>
      into(memoTable).insert(data);

  //중요도 순으로 내림차순 정렬하기.(중요도 중요한거부터 띄워주기)
  Stream<List<MemoTableData>> getSortMemos() {
    return (select(memoTable)..orderBy([
      (table) =>
          OrderingTerm(expression: table.importance, mode: OrderingMode.desc),
    ])).watch();
  }

  Future<MemoTableData?> getMemoById(int id) {
    return (select(memoTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  //업데이트할 행을 id로 찾아서 내용을 write하기.
  Future<int> updateMemo(MemoTableCompanion data) {
    return (update(memoTable)
      ..where((t) => t.id.equals(data.id.value))).write(data);
  }

  //검색어를 통해서 테이블에서 제목이 포함된 메모 반환하기.
  Future<List<MemoTableData>> getSearchMemos(String query) {
    return (select(memoTable)
      ..where((table) => table.title.contains(query))).get();
  }

  Future<int> deleteMemo(int id) =>
      (delete(memoTable)..where((table) => table.id.equals(id))).go();

  @override
  int get schemaVersion => 1; // 스키마 버전 업데이트
}

///_openConnection함수를 실행하면 file변수의 위치에다가 데이터베이스를 생성한다.

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder =
        await getApplicationDocumentsDirectory(); //앱을 설치하면 각각의 앱별로 배정이 되는 다큐멘트 폴더의 위치를 가져오는 함수이다. 각각 하나의 앱마다 제공해주는 폴더의 위치를 가져와주는 기능

    final file = File(
      p.join(dbFolder.path, 'db.sqlite'),
    ); //join함수로 인해 여러 운영체제마다 다른 경로를 하나의 형식으로 합쳐주기 가능.

    final cachebase = await getTemporaryDirectory(); //임시 폴더를 가져오는 함수

    sqlite3.tempDirectory = cachebase.path;

    return NativeDatabase.createInBackground(file);
  });
}
