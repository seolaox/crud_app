import 'dart:convert';

import 'package:crud_app/insert_student.dart';
import 'package:crud_app/update_student.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'delete_student.dart';

class QueryStudent extends StatefulWidget {
  const QueryStudent({super.key});

  @override
  State<QueryStudent> createState() => _QueryStudentState();
}

class _QueryStudentState extends State<QueryStudent> {
  late List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [];
    getJSONData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD for Students'),
        actions: [
          IconButton(
            onPressed:() {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return InsertStudent(); //버튼 눌렀을때 만든 context InsertStudent로 넘겨줌
                  },
                  ),
                ).then((value) => getJSONData()); //버튼 눌러서 insert시키고 버튼 위치로 다시 돌아오면 새로 구성된 getJSONData()를 보여주겠다
            }, 
            icon: Icon(Icons.add_outlined),
            ),
        ],
      ),

      body: Center(
        child: data.isEmpty //data가 비었으면
        ? const Text('데이터가 없습니다.',style: TextStyle(fontSize: 20),)
        : ListView.builder(
          itemCount: data.length, //개수만큼 card로 쓸거니까 개수 정해주기 위해서 쓰는거
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return UpdateStudent(
                        rcode: data[index]['code'],
                        rname: data[index]['name'],
                        rdept: data[index]['dept'],
                        rphone: data[index]['phone'],
                      );
                    },
                    ),
                  ).then((value) => getJSONData()); //다시 돌아오면 새로운 데이터 보여줌
              },
              onLongPress: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return DeleteStudent(
                        rcode: data[index]['code'],
                        rname: data[index]['name'],
                        rdept: data[index]['dept'],
                        rphone: data[index]['phone'],
                      );
                    },
                    ),
                  ).then((value) => getJSONData()); //다시 돌아오면 새로운 데이터 보여줌
              },
              child: Container(
                height: 120,
                child: Card( //return은 ';'으로 끝난당 -card모양을 listview한테 넘겨줘서 return 사용
                color: index % 3 ==0 ? Color.fromARGB(255, 172, 152, 239) : index%3==1? Color.fromARGB(255, 124, 171, 252) : Color.fromARGB(255, 146, 94, 244),
                
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(   'Code :  ${data[index]["code"]}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      Text(   'Name :  ${data[index]["name"]}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      Text( 'Dept :  ${data[index]["dept"]}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      Text( 'Phone :  ${data[index]["phone"]}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    ],
                  ),
                ),
              ),
            );
          },
          ),
      ),
    );

  }
//Functions-------

getJSONData() async {  // dart외에 다른곳에서 정보를 가져올때 async사용
  var url = Uri.parse('http://localhost:8080/Flutter/student_query_flutter.jsp'); //보내고 받는걸 대체 하는게 uri(내 정보도 같이 날아감)
  var response = await http.get(url); //uri에서 데이터정보를 가져온다 /데이터 불러올때까지 기다려라
  print(response.body);    //key값이 result 나머지 []는 value
  data.clear();
  var dataConvertedJason = json.decode(utf8.decode(response.bodyBytes));//json을 띄워야 겠다.
  List result = dataConvertedJason['results'];
  data.addAll(result);
  setState(() {
    
  });
}

}//END