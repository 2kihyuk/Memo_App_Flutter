import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/Screen/Check_Todo_List.dart';

import '../database/drift.dart';
import 'add_list_page.dart';

class AddTodolistScreen extends StatefulWidget {
  const AddTodolistScreen({super.key});

  @override
  State<AddTodolistScreen> createState() => _AddTodolistScreenState();
}

class _AddTodolistScreenState extends State<AddTodolistScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리스트 추가'),
        actions: [
          IconButton(
            onPressed: () async{
             final resp = await
             Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddListPage()));
             if(resp!=null){
               setState(() {
               });
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
              decoration: InputDecoration(
                hintText: '검색',
                icon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<MemoTableData>>(
                future: GetIt.I<AppDatabase>().getMemos(), //데이터 불러오는 함수
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

                      return GestureDetector(
                        onTap: () {
                          print('$index');
                          final resp = Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => CheckTodoList(index: index,))
                          );
                          if(resp!=null){
                            setState(() {

                            });
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
                            mainAxisSize: MainAxisSize.min,  // 최소 크기로 설정
                            children: List.generate(5, (index) {
                              // item.importance가 1~5 사이 값이라고 가정
                              return Icon(
                                Icons.star,
                                color: item.importance! > index ? Colors.amber : Colors.grey, // importance 값에 따라 색 변경
                                size: 10, // 별의 크기 설정
                              );
                            }),
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


}
