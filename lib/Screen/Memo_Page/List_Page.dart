import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/Screen/Memo_Page/Check_Todo_List.dart';
import 'package:to_do_list_app/database/riverPod/MemoNotifier.dart';

import '../../database/drift.dart';
import 'add_list_page.dart';

class AddTodolistScreen extends ConsumerStatefulWidget {
  const AddTodolistScreen({super.key});

  @override
  ConsumerState<AddTodolistScreen> createState() => _AddTodolistScreenState();
}

class _AddTodolistScreenState extends ConsumerState<AddTodolistScreen> {

  List<MemoTableData> searchedMemos = [];
  String selectedSortOption = '날짜순';
  List<String> sortOption = ['날짜순','중요도순'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('메모'),
        actions: [
          IconButton(
            onPressed: () async {
              final resp = await Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => AddListPage()));
              if (resp != null) {
                setState(() {});
              }
            },
            icon: Icon(Icons.add_box_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '메모',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),
            TextField(
              onChanged: (String query) async {

                final filteredMemos = await ref.read(memoNotifierProvider.notifier).searchMemos(query);

                // final filteredMemos = await GetIt.I<AppDatabase>()
                //     .getSearchMemos(query);

                setState(() {
                  searchedMemos = filteredMemos;
                });
              },
              decoration: InputDecoration(
                hintText: '제목을 검색하세요.',
                icon: Icon(Icons.search),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<String>(
                value: selectedSortOption,
                items: sortOption.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged:(String? newValue){
                    setState(() {
                      selectedSortOption = newValue!;
                      ref
                          .read(memoNotifierProvider.notifier)
                          .setSortOption(selectedSortOption);
                    });
                }
                ),
            ),
            Expanded(
              child: StreamBuilder<List<MemoTableData>>(
                stream:

                    searchedMemos.isEmpty
                    ? selectedSortOption == '날짜순'
                    ? ref.read(memoNotifierProvider.notifier).watchMemos() // 기본 데이터 호출
                    : ref.read(memoNotifierProvider.notifier).watchSortMemos() // 중요도순 정렬 호출
                    : Stream.value(searchedMemos),

                  // GetIt.I<AppDatabase>().getMemos() 기본 데이터 호출
                  // GetIt.I<AppDatabase>().getSortMemos() 중요도 순 정렬


                //데이터 불러오는 함수 GetIt.I<AppDatabase>().getMemos()
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (!snapshot.hasError &&
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final memos = snapshot.data!;
                  final length = snapshot.data?.length;

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final item = memos[index];

                      return Dismissible(
                        key: ObjectKey(item.id),
                        //키 값은 메모데이터의 id값. 어떤걸 삭제해주는지 인지시켜주기위함.
                        direction: DismissDirection.endToStart,

                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),

                        confirmDismiss: (DismissDirection direction) async {
                          bool? shouldDelete = await showDeleteDialog(context);
                          if (shouldDelete == true) {

                            await ref.read(memoNotifierProvider.notifier).deleteMemo(item.id);
                            //
                            // await GetIt.I<AppDatabase>().deleteMemo(item.id);
                            // setState(() {});
                          }
                          return shouldDelete ?? false;
                        },
                        child: GestureDetector(
                          onTap: () {
                            print('$index');
                            final resp = Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (_) => CheckTodoList(index: item.id - 1),
                              ),
                            );
                            if (resp != null) {
                              setState(() {});
                            }
                          },
                          child: ListTile(
                            title: Text(
                              '${item.title}',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(
                              '${item.content}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: Text(
                                '${DateFormat('yyyy-MM-dd HH:mm').format(item.createdAt)}',
                              ),
                            ),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min, // 최소 크기로 설정
                              children: List.generate(5, (index) {
                                // item.importance가 1~5 사이 값이라고 가정
                                return Icon(
                                  Icons.star,
                                  color:
                                      item.importance! > index
                                          ? Colors.amber
                                          : Colors
                                              .grey, // importance 값에 따라 색 변경
                                  size: 10, // 별의 크기 설정
                                );
                              }),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: length!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 확인'),
          content: Text('정말로 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('삭제'),
            ),
          ],
        );
      },
    );
  }
}
