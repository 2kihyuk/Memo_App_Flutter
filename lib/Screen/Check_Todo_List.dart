import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_list_app/database/drift.dart';

class CheckTodoList extends StatefulWidget {
  final int index;

  const CheckTodoList({required this.index, super.key});

  @override
  State<CheckTodoList> createState() => _CheckTodoListState();
}

class _CheckTodoListState extends State<CheckTodoList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
   double? _sliderValue;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('메모 확인')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: GetIt.I<AppDatabase>().getMemoById(widget.index + 1),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            final item = snapshot.data!;

            if (_sliderValue == null) {
              _sliderValue = item.importance?.toDouble();
              titleController.text = item.title ?? '';
              contentController.text = item.content ?? '';
            }

            return Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: '제목을 입력하세요.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
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
                SizedBox(height: 20),
                Text(
                  '1부터 5 까지 중요도를 선택하세요.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Slider(
                  value: _sliderValue!,
                  min: 0,
                  max: 5,
                  divisions: 5,
                  label: _sliderValue!.toInt().toString(),
                  onChanged: (double newValue) {
                    setState(() {
                      _sliderValue = newValue;
                    });
                  },
                ),
                Text(
                  '중요도 : ${_sliderValue!.toInt()}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                OutlinedButton(onPressed: () {
                    EditMemoData(snapshot.data!,titleController.text,contentController.text,_sliderValue!.toInt());
                    Navigator.pop(context,true);
                  },
                    child:
                    Text('수정하기')
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void EditMemoData(MemoTableData oldData, String newTitle , String newContent, int newImportance) async{
    final database = GetIt.I<AppDatabase>();

    await database.updateMemo(
      MemoTableCompanion(
        id: Value(oldData.id),
        title: oldData.title != newTitle ? Value(newTitle) : Value.absent(),
        content: oldData.content != newContent ? Value(newContent) : Value.absent(),
        importance: oldData.importance != newImportance ? Value(newImportance) : Value.absent()
      )
    );
  }
}
