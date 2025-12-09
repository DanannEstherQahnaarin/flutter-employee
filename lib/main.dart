import 'package:flutter/material.dart';
import 'package:flutter_employee/providers/emp_provider.dart';
import 'package:flutter_employee/screens/emp_list.dart';
import 'package:provider/provider.dart';

void main() {
  // Provider 설정 및 앱 시작
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EmployeeProvider())],
      child: const MyWidget(),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 디버그 태그 표시
      debugShowCheckedModeBanner: false,
      // 앱의 한 줄 설명
      title: 'Employee Manager',
      // 앱의 테마 지정
      theme: ThemeData(
        // 상호작용 요소에 사용되는 색상
        brightness: Brightness.light,
        // 앱의 주요부분 배경 색 (앱바, 탭바 등)
        primaryColor: Colors.greenAccent,

        // 앱에 기본으로 사용될 폰트
        fontFamily: 'IBM-Sans',
      ),
      // MaterialApp의 기본 경로로 앱 실행 시 가장 먼저 볼 수 있는 화면
      home: EmployeeList(),
    );
  }
}
