import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';
import 'package:to_do_list_app/Model/memo_model.dart';
import 'package:to_do_list_app/database/drift.dart';



class MemoNotifier extends StateNotifier<List<MemoTableData>> {

  final AppDatabase _appDatabase;

  MemoNotifier(this._appDatabase) : super([]);

  //메모 리스트 반환
  Stream<List<MemoTableData>> watchMemos() {
    return _appDatabase.getMemos().map((memos){
      state = memos;
      return memos;
    });
  }
  //메모 정렬 중요도 순
  Stream<List<MemoTableData>> watchSortMemos() {
    return _appDatabase.getSortMemos().map((memos){
      state = memos;
      return memos;
    });
  }

  void setSortOption(String option)async {
    if (option == '날짜순') {
      state = await _appDatabase.getMemos().first;  // 날짜순으로 정렬된 메모
    } else if (option == '중요도순') {
      state = await _appDatabase.getSortMemos().first;  // 중요도순으로 정렬된 메모
    }
  }

  Future<List<MemoTableData>> searchMemos(String query) async{
    final filteredMemos = await _appDatabase.getSearchMemos(query);
    state = filteredMemos;
    return filteredMemos;
  }

  Future<int> addMemo(MemoTableCompanion data) async{
    final newMemoId =  await _appDatabase.createMemo(data);
    await refreshMemos();
    return newMemoId;
  }

  Future<MemoTableData?> getMemoUsingId(int id) async{
    return _appDatabase.getMemoById(id);
  }

  Future<int> updateMemo(MemoTableCompanion data) async{
    final updatedId = await _appDatabase.updateMemo(data);
    await refreshMemos();
    return updatedId;
  }

  Future<int> deleteMemo(int id) async{
    final deletedId = await _appDatabase.deleteMemo(id);
    await refreshMemos(); // 삭제 후 전체 메모를 다시 불러옴
    return deletedId;
  }

  Future<void> refreshMemos() async {
    // final memos = await watchMemos();
    // state = memos as List<MemoTableData>; // 새로 불러온 전체 메모 리스트로 상태 업데이트
    final memos = await _appDatabase.getMemos().first; // 첫 번째 값을 가져옴
    state = memos; // 새로 불러온 전체 메모 리스트로 상태 업데이트
  }
}





final memoNotifierProvider = StateNotifierProvider<MemoNotifier, List<MemoTableData>>((ref) {
  final database = GetIt.I<AppDatabase>();
  return MemoNotifier(database);
});