import 'package:drift/drift.dart';

class MemoTable extends Table{
  //ID 값
  IntColumn get id => integer().autoIncrement()();
  //제목
  TextColumn get title => text().nullable()();
  //내용
  TextColumn get content => text().nullable()();
  //메모 생성 시간
  DateTimeColumn get createdAt => dateTime().clientDefault(()=>DateTime.now().toUtc())();
  //중요도
  IntColumn get importance => integer().nullable()();

}
