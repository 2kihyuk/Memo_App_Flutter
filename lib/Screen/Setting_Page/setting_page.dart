import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isBlackAndWhite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('흑백 모드'),
      ),
      body: Stack(
        children: [
          // 본문 내용
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello, Flutter!',
                  style: TextStyle(fontSize: 24),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isBlackAndWhite = !isBlackAndWhite; // 상태 변경
                    });
                  },
                  child: Text(isBlackAndWhite ? '컬러 모드로 전환' : '흑백 모드로 전환'),
                ),
              ],
            ),
          ),

          // 색 필터 적용 (흑백 모드)
          if (isBlackAndWhite)
            ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.saturation),
              child: Container(
                color: Colors.transparent, // 필터만 적용
              ),
            ),
        ],
      ),
    );
  }
}
