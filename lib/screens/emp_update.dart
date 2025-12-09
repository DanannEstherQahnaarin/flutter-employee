import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';

class UpdateEmp extends StatefulWidget {
  final Function(Employee) onUpdateEmp; // 직원 수정 콜백
  final Employee employee;
  const UpdateEmp({required this.onUpdateEmp, required this.employee, super.key});

  @override
  State<UpdateEmp> createState() => _UpdateEmpEmpState();
}

class _UpdateEmpEmpState extends State<UpdateEmp> {
  // 폼 검증 키
  final _formKey = GlobalKey<FormState>();

  // 입력 필드 컨트롤러
  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtPhone = TextEditingController();
  final TextEditingController _txtDept = TextEditingController();
  final TextEditingController _txtEmpNo = TextEditingController();
  final TextEditingController _txtSalary = TextEditingController();
  final TextEditingController _txtAccount = TextEditingController();

  String _selectPosition = "사원";
  final List<String> _positions = ["사원", "대리", "과장", "부장"];

  @override
  void initState() {
    super.initState();
    // 초기 값 설정: 전달된 employee 정보 세팅
    _txtName.text = widget.employee.name;
    _txtPhone.text = widget.employee.phone;
    _txtDept.text = widget.employee.dept;
    _txtEmpNo.text = widget.employee.empNo.toString();
    _txtSalary.text = widget.employee.salary.toString();
    _txtAccount.text = widget.employee.account;
    _selectPosition = widget.employee.position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee Add")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 이름
              TextFormField(
                controller: _txtName,
                decoration: InputDecoration(labelText: '이름'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name is empty";
                  }

                  return null;
                },
              ),
              // 전화번호
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
              // 부서
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
              // 사원번호
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
              // 월급
              TextFormField(
                controller: _txtSalary,
                decoration: InputDecoration(labelText: "월급"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return "월급을 입력하세요.";
                  if (int.tryParse(value) == null) return "숫자만 입력하세요.";
                  return null;
                },
              ),
              // 계좌번호
              TextFormField(
                controller: _txtAccount,
                decoration: InputDecoration(labelText: "계좌번호"),
              ),
              // 직급 선택
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "직급"),
                items: _positions.map((pos) {
                  return DropdownMenuItem(value: pos, child: Text(pos));
                }).toList(),
                onChanged: (value) {
                  _selectPosition = value ?? "사원";
                },
              ),
              SizedBox(height: 20),
              // 저장 버튼 (업데이트 확인 팝업)
              ElevatedButton(onPressed: _updateEmpData, child: Text("Update Employee Data")),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateEmpData() async {
    // 입력 검증
    if (!_formKey.currentState!.validate()) return;

    // 수정 확인 팝업
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('수정 확인'),
        content: Text('수정하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // 수정 데이터 생성
    Employee updateEmp = Employee(
      name: _txtName.text,
      phone: _txtPhone.text,
      dept: _txtDept.text,
      empNo: int.parse(_txtEmpNo.text),
      salary: int.parse(_txtSalary.text),
      account: _txtAccount.text,
      position: _selectPosition,
    );

    // 수정된 정보 콜백 전달 (상위 화면에서 pop 처리)
    widget.onUpdateEmp(updateEmp);
  }
}
