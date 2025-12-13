import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';

// 직원 추가 화면을 위한 StatefulWidget 정의
class AddEmp extends StatefulWidget {
  // 신규 직원 추가 시 부모 위젯에 결과를 전달할 콜백 함수
  final Function(Employee) onAddEmp;

  // 생성자, 콜백 함수는 필수(required)
  const AddEmp({required this.onAddEmp, super.key});

  @override
  State<AddEmp> createState() => _AddEmpState();
}

// 화면 상태 관리를 위한 State 클래스
class _AddEmpState extends State<AddEmp> {
  // 폼 검증을 위한 글로벌 키
  final _formKey = GlobalKey<FormState>();

  // 각 입력 필드를 위한 TextEditingController 선언
  final TextEditingController _txtName = TextEditingController(); // 이름
  final TextEditingController _txtPhone = TextEditingController(); // 전화번호
  final TextEditingController _txtDept = TextEditingController(); // 부서
  final TextEditingController _txtEmpNo = TextEditingController(); // 사원번호
  final TextEditingController _txtSalary = TextEditingController(); // 월급
  final TextEditingController _txtAccount = TextEditingController(); // 계좌번호

  @override
  void dispose() {
    _txtName.dispose();
    _txtPhone.dispose();
    _txtDept.dispose();
    _txtEmpNo.dispose();
    _txtSalary.dispose();
    _txtAccount.dispose();
    super.dispose();
  }

  // 직급 선택 값의 초기값 (기본값: 사원)
  String _selectPosition = "사원";
  // 선택 가능한 직급 목록
  final List<String> _positions = ["사원", "대리", "과장", "부장"];

  @override
  Widget build(BuildContext context) {
    // Scaffold : 기본적인 화면 구조 제공
    return Scaffold(
      // 상단 앱바
      appBar: AppBar(title: Text("Employee Add")),
      // 화면 전체에 패딩 적용
      body: Padding(
        padding: const EdgeInsets.all(20),
        // 입력폼(Form) 위젯: 유효성 검사를 위해 사용
        child: Form(
          key: _formKey, // 폼 검증에 사용
          child: ListView(
            children: [
              // -----------------------
              // 이름 입력 필드
              TextFormField(
                controller: _txtName,
                decoration: InputDecoration(labelText: '이름'),
                // 유효성 검사: null이거나 비어있으면 에러 메시지 반환
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name is empty";
                  }
                  return null;
                },
              ),
              // -----------------------
              // 전화번호 입력 필드
              TextFormField(
                controller: _txtPhone,
                decoration: InputDecoration(labelText: '전화번호'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "전화번호 is empty";
                  }
                  return null;
                },
              ),
              // -----------------------
              // 부서 입력 필드
              TextFormField(
                controller: _txtDept,
                decoration: InputDecoration(labelText: '부서'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "부서 is empty";
                  }
                  return null;
                },
              ),
              // -----------------------
              // 사원번호 입력 필드 (문자열로 입력 후 정수로 변환)
              TextFormField(
                controller: _txtEmpNo,
                decoration: InputDecoration(labelText: '사원번호'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "사원번호 is empty";
                  }
                  return null;
                },
              ),
              // -----------------------
              // 월급 입력 필드 (숫자만 허용)
              TextFormField(
                controller: _txtSalary,
                decoration: InputDecoration(labelText: "월급"),
                keyboardType: TextInputType.number, // 숫자 키패드 타입
                validator: (value) {
                  if (value == null || value.isEmpty) return "월급을 입력하세요.";
                  // 숫자가 아닌 경우 에러 반환
                  if (int.tryParse(value) == null) return "숫자만 입력하세요.";
                  return null;
                },
              ),
              // -----------------------
              // 계좌번호 입력 필드 (필수 아님)
              TextFormField(
                controller: _txtAccount,
                decoration: InputDecoration(labelText: "계좌번호"),
              ),
              // -----------------------
              // 직급 선택 필드(드롭다운), 기본값은 '사원'
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "직급"),
                // _positions 리스트의 각 값에 대해 DropdownMenuItem 생성
                items: _positions.map((pos) {
                  return DropdownMenuItem(value: pos, child: Text(pos));
                }).toList(),
                // 선택값 변경 시 상태 최신화
                onChanged: (value) {
                  _selectPosition = value ?? "사원";
                },
              ),
              SizedBox(height: 20), // 버튼과 입력폼간의 간격
              // -----------------------
              // 저장 버튼
              ElevatedButton(
                onPressed: _addEmpData, // 저장 함수 호출
                child: Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 직원 추가 함수: 폼 검증 후 직원 객체를 생성해 콜백 전달 및 화면 종료
  void _addEmpData() {
    // 폼이 유효하면
    if (_formKey.currentState!.validate()) {
      // Employee 모델 객체를 입력된 값으로 생성
      Employee newEmp = Employee(
        name: _txtName.text,
        phone: _txtPhone.text,
        dept: _txtDept.text,
        empNo: int.parse(_txtEmpNo.text), // 사원번호: 정수형 변환
        salary: int.parse(_txtSalary.text), // 월급: 정수형 변환
        account: _txtAccount.text,
        position: _selectPosition,
      );

      // 콜백을 통해 부모 위젯에 직원 데이터 전달
      widget.onAddEmp(newEmp);

      // 현재 화면 닫기(이전 화면으로 이동)
      Navigator.pop(context);
    }
  }
}
