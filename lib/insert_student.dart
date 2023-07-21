import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertStudent extends StatefulWidget {
  const InsertStudent({super.key});

  @override
  State<InsertStudent> createState() => _InsertStudentState();
}

class _InsertStudentState extends State<InsertStudent> {
//property
  late TextEditingController codeController; //사용자가 입력하면 codeController여기에 데이터가 들어가는 전역변수
  late TextEditingController nameController;
  late TextEditingController deptController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    nameController = TextEditingController();
    deptController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert for CRUD'),
      ),
       body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: codeController,
                decoration: InputDecoration(
                  labelText: '학번을 입력 하세요',
                ),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: '이름을 입력 하세요',
                ),
              ),
              TextField(
                controller: deptController,
                decoration: InputDecoration(
                  labelText: '전공을 입력 하세요',
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: '전화번호을 입력 하세요',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () => insertAction(),
                  child: Text('입력'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Functions---------
  insertAction() async {
    //데이터를 통해 넣어주겠다
    var url = Uri.parse(
        
        'http://localhost:8080/Flutter/student_insert_flutter.jsp?code=${codeController.text}&name=${nameController.text}&dept=${deptController.text}&phone=${phoneController.text}');
    // var response =
    await http.get(url);
  if (codeController.text.trim().isEmpty || nameController.text.trim().isEmpty || deptController.text.trim().isEmpty|| phoneController.text.trim().isEmpty) { 
      showSnackbar(); 
    } else{
      _showDialog();
    }
  

  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('입력결과'),
            content: Text('${nameController.text}의 입력이 완료 되었습니다.'),
            actions: [TextButton(
              onPressed: () {
                Navigator.of(context).pop(); //alert화면 지우는거
                Navigator.pop(context); //입력화면 페이지 안보고 main페이지가려고 하는거 = 입력화면 창 나가기
              }, child: Text('OK'))],
          );
        });
  }




  showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('입력하세요!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  // removeAction() { 
  //   codeController.text = '';
  //   nameController.text = '';
  //   deptController.text = '';
  //   phoneController.text = '';
  // }











} //END
