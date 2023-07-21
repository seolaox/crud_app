// import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteStudent extends StatefulWidget {
  final String rcode;
  final String rname;
  final String rdept;
  final String rphone;

  const DeleteStudent({
    super.key, //똑같은 위젯에 있으면 번호를 주는게 key
    required this.rcode,
    required this.rname,
    required this.rdept,
    required this.rphone
    });

  @override
  State<DeleteStudent> createState() => _DeleteStudentState();
}

class _DeleteStudentState extends State<DeleteStudent> {
//property
  late TextEditingController codeController; 
  late TextEditingController nameController;
  late TextEditingController deptController;
  late TextEditingController phoneController;


@override
  void initState() {
    super.initState();
    codeController= TextEditingController(); //넘겨준거를 화면에 띄우기 위해 넣어줌
    nameController= TextEditingController();
    deptController= TextEditingController();
    phoneController= TextEditingController();
    codeController.text = widget.rcode;
    nameController.text = widget.rname;
    deptController.text = widget.rdept;
    phoneController.text = widget.rphone;





  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete for CRUD'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: codeController,
                decoration: InputDecoration(
                  // labelText: '학번 입니다.',
                ),
                readOnly: true,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  // labelText: '이름 입니다.',
                ),
                readOnly: true,
              ),
              TextField(
                controller: deptController,
                decoration: InputDecoration(
                  // labelText: '전공 입니다.',
                ),
                readOnly: true,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  // labelText: '전화번호 입니다.',
                ),
                readOnly: true,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () => deleteAction(),
                  child: Text('삭제'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Functions---------

  deleteAction() async{
    var url = Uri.parse("http://localhost:8080/Flutter/student_delete_flutter.jsp?code=${codeController.text.trim()}");
    //update 문에는 return 값이 있다. (json파일에) =>result ="OK" or result ="error"
    var response =await http.get(url);//화면에 떠있는 정보를 가져오게 된다.
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    var result = dataConvertedJSON['resultD'];//dataConvertedJSON의 key값을 가져온다.
    if(result=="OK"){
      _showDialog();
    }
    setState(() {
      
    });
  }



  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('삭제 결과'),
            content: Text('삭제 완료 되었습니다.'),
            actions: [TextButton(
              onPressed: () {
                Navigator.of(context).pop(); //alert화면 지우는거
                Navigator.pop(context); //입력화면 페이지 안보고 main페이지가려고 하는거 = 입력화면 창 나가기
              }, child: Text('OK'))],
          );
        });
  }




// errorSnackBar() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('사용자 정보 입력에 문제가 발생했습니다!'),
//         duration: Duration(seconds: 2),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }











} //END
