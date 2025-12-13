import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';

/// 직원 정보 수정 화면을 제공하는 StatefulWidget
class UpdateEmp extends StatefulWidget {
  final Function(Employee) onUpdateEmp; // 직원 수정 완료시 상위에 수정된 Employee 전달용 콜백
  final Employee employee; // 수정 대상으로 전달받은 직원 정보

  const UpdateEmp({
    required this.onUpdateEmp,
    required this.employee,
    super.key,
  });

  @override
  State<UpdateEmp> createState() => _UpdateEmpEmpState();
}

/// 실제 상태 및 폼 입력/검증 로직을 담당하는 State 클래스
class _UpdateEmpEmpState extends State<UpdateEmp> {
  // 폼 유효성 검사에 사용할 글로벌 키
  final _formKey = GlobalKey<FormState>();

  // 각 입력 필드 별 입력값 제어 및 초기값 설정을 위한 컨트롤러
  final TextEditingController _txtName = TextEditingController(); // 이름
  final TextEditingController _txtPhone = TextEditingController(); // 전화번호
  final TextEditingController _txtDept = TextEditingController(); // 부서
  final TextEditingController _txtEmpNo = TextEditingController(); // 사원번호
  final TextEditingController _txtSalary = TextEditingController(); // 월급
  final TextEditingController _txtAccount = TextEditingController(); // 계좌번호

  String _selectPosition = "사원"; // 선택된 직급 값 (기본값: 사원)
  final List<String> _positions = ["사원", "대리", "과장", "부장"]; // 선택 가능한 직급 목록

  @override
  void initState() {
    super.initState();
    // 전달받은 employee 객체의 정보를 각 입력 필드 초기값으로 설정
    _txtName.text = widget.employee.name;
    _txtPhone.text = widget.employee.phone;
    _txtDept.text = widget.employee.dept;
    _txtEmpNo.text = widget.employee.empNo.toString();
    _txtSalary.text = widget.employee.salary.toString();
    _txtAccount.text = widget.employee.account;
    _selectPosition = widget.employee.position;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바, 화면 이름 명시
      appBar: AppBar(title: Text("Employee Update")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        // Form 위젯: 데이터 유효성 검사 및 제출 처리 담당
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ----- 이름 입력 필드 -----
              TextFormField(
                controller: _txtName,
                decoration: InputDecoration(labelText: '이름'),
                // 유효성 검사: 미입력시 에러 반환
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name is empty";
                  }
                  return null;
                },
              ),
              // ----- 전화번호 입력 필드 -----
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
              // ----- 부서 입력 필드 -----
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
              // ----- 사원번호 입력 필드 (정수) -----
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
              // ----- 월급 입력 필드 (숫자만 허용) -----
              TextFormField(
                controller: _txtSalary,
                decoration: InputDecoration(labelText: "월급"),
                keyboardType: TextInputType.number, // 숫자 키패드 적용
                validator: (value) {
                  if (value == null || value.isEmpty) return "월급을 입력하세요.";
                  if (int.tryParse(value) == null) return "숫자만 입력하세요.";
                  return null;
                },
              ),
              // ----- 계좌번호 입력 필드 (필수 아님) -----
              TextFormField(
                controller: _txtAccount,
                decoration: InputDecoration(labelText: "계좌번호"),
              ),
              // ----- 직급 선택 필드 (드롭다운) -----
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "직급"),
                initialValue: _selectPosition,
                items: _positions.map((pos) {
                  // 직급 목록에서 각 항목을 드롭다운 메뉴 아이템으로 생성
                  return DropdownMenuItem(value: pos, child: Text(pos));
                }).toList(),
                // 선택 변경시 상태 반영
                onChanged: (value) {
                  _selectPosition = value ?? "사원";
                },
              ),
              SizedBox(height: 20), // 입력란과 버튼 간격
              // ----- 저장(수정확정) 버튼 -----
              ElevatedButton(
                onPressed: _updateEmpData, // 수정 완료 함수 호출
                child: Text("Update Employee Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 직원 정보 수정 처리 함수
  /// 1. 폼 입력 유효성 검사
  /// 2. 수정 전 확인 팝업(AlertDialog) 표시
  /// 3. 사용자가 'Yes'를 선택하면 Employee 객체를 생성해 콜백으로 전달
  Future<void> _updateEmpData() async {
    // 폼 입력값 유효성 검사 수행(실패시 종료)
    if (!_formKey.currentState!.validate()) return;

    // 수정 의사를 확인하는 AlertDialog 표시
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('수정 확인'), // 다이얼로그 타이틀
        content: Text('수정하시겠습니까?'), // 안내 메시지
        actions: [
          // No 버튼: 취소
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No'),
          ),
          // Yes 버튼: 확인
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    // 사용자가 'Yes'를 누른 경우에만 실제 정보 수정 (아니면 함수 종료)
    if (confirm != true) return;

    // 입력값을 바탕으로 Employee 모델 객체 생성
    Employee updateEmp = Employee(
      name: _txtName.text,
      phone: _txtPhone.text,
      dept: _txtDept.text,
      empNo: int.parse(_txtEmpNo.text),
      salary: int.parse(_txtSalary.text),
      account: _txtAccount.text,
      position: _selectPosition,
    );

    // 상위(DetailEmp 등)로 수정된 정보를 콜백으로 전달
    // 실제 데이터 갱신 및 pop(화면 닫기)는 위에서 처리
    widget.onUpdateEmp(updateEmp);
  }
}
