import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:post_api_demoo/model_class.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostApi extends StatefulWidget {
  const PostApi({Key? key}) : super(key: key);

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {
  var model = ModelClass();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // modelclass? model;
  // String? name;

  @override

  // void initState() {
  //   setData();
  //   // TODO: implement initState
  //   super.initState();
  // }
  //
  // setData()async{
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs. setString('name', "HELLO!");
  //   name = prefs.getString('name');
  //   setState(() {
  //
  //   });
  // }

  postApiCalling()async{
    var response=await http.post(Uri.parse("https://reqres.in/api/users"),body: {

        // "name": "ABC",
        // "job": "leader",

      "name": nameController.text,
      "email": emailController.text,

      // "name": name,
      // "email":email,

    });
    if(response.statusCode ==201){
      print(response.body);
      var jsonDecodeResponse = await jsonDecode(response.body);
      model=ModelClass.fromJson(jsonDecodeResponse);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("POST API"),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

              ),
            ),

            SizedBox(height: 10,),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
              ),
            ),

            SizedBox(height: 10,),

            GestureDetector(
              onTap: (){
                postApiCalling();
              },

              // async{
              //   postApiCalling();
              //   var prefs= await SharedPreferences.getInstance();
              //   await prefs.remove("name");
              //   postApiCalling(nameController.text,EmailController.text);
              // },

              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                // child: Center(child: Text("${name}")),
                child: Center(child: Text("SAVE")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
