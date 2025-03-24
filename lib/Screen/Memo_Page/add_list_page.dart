import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_list_app/database/riverPod/MemoNotifier.dart';

import '../../database/drift.dart';

class AddListPage extends ConsumerStatefulWidget {
  const AddListPage({super.key});

  @override
  ConsumerState<AddListPage> createState() => _AddListPageState();
}

class _AddListPageState extends ConsumerState<AddListPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  double _sliderValue = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('메모 작성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                 hintText: '제목을 입력하세요.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              maxLines: 16,
              controller: contentController,
              decoration: InputDecoration(
                hintText: '내용을 입력하세요.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '1부터 5 까지 중요도를 선택하세요.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 5,
              divisions: 5,
              label: _sliderValue.toInt().toString(),
              onChanged: (double newValue) {
                setState(() {
                  _sliderValue = newValue;
                });
              },
            ),
            Text(
              '중요도 : ${_sliderValue.toInt()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Spacer(),
            OutlinedButton(
              onPressed: () {

                saveMemoData();
              },
              child: Text('저장하기'),
            ),

            ///중요도체크? 1~5 or 색깔로? or 고정 여부?
          ],
        ),
      ),
    );
  }

  void saveMemoData() async{
    final database = GetIt.I<AppDatabase>();

    await database.createMemo(
      MemoTableCompanion(
        title: Value(titleController.text),
        content: Value(contentController.text),
        importance: Value(_sliderValue.toInt()),
      )
    );
    Navigator.pop(context,true);
  }

}
