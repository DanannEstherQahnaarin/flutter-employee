import 'package:flutter/material.dart';
import 'package:flutter_employee/providers/emp_provider.dart';
import 'package:flutter_employee/screens/emp_list.dart';
import 'package:provider/provider.dart';

// 프로그램의 진입점인 main 함수 정의
void main() {
  // runApp 함수로 전체 플러터 앱 실행
  runApp(
    // MultiProvider는 여러 Provider를 한 번에 하위 위젯 트리에 주입할 수 있도록 함
    MultiProvider(
      // ChangeNotifierProvider: EmployeeProvider 인스턴스를 제공함 (사원 관리 상태 관리)
      providers: [
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
      ],
      // 실제 앱 트리 구조의 루트 위젯으로 MyWidget 사용
      child: const MyWidget(),
    ),
  );
}

// 앱의 루트 위젯: StatelessWidget 상속
class MyWidget extends StatelessWidget {
  const MyWidget({super.key}); // 생성자 (불변 위젯)

  @override
  Widget build(BuildContext context) {
    // 전체 앱 구조는 MaterialApp으로 래핑됨
    return MaterialApp(
      // 디버그 배너 비활성화
      debugShowCheckedModeBanner: false,
      // 앱 타이틀 설정
      title: 'Employee Manager',
      // 앱의 테마 설정
      theme: ThemeData(
        brightness: Brightness.light, // 밝은 테마 적용
        primaryColor: Colors.greenAccent, // 주요 색상 지정
        fontFamily: 'IBM-Sans', // 폰트 패밀리 지정
      ),
      // 첫 번째로 띄울 화면: EmployeeList 위젯
      home: EmployeeList(),
    );
  }
}
