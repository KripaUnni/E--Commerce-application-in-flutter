import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_application/ui/loginPage.dart';
import 'package:e_commerce_application/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget{
  const RegistrationPage({super.key});

   @override
  State<RegistrationPage> createState()=> _FormValidationState();
}

class _FormValidationState extends State<RegistrationPage>{
  final _formKey = GlobalKey<FormState>();
  String? name, phone, address, username, password;
  @override
  void initState(){
    super.initState();
  }

  registration(String name, phone, address, username,password) async{
    try{
      print(username);
      print(password);
      var result;
      final Map<String, dynamic> Data = {
        "name" : name,
        "phone" : phone,
        "address" : address,
        "username" : username,
        "password" : password,
      };
      final response = await http.post(
        Uri.parse(Webservice.mainurl +"registration.php"),
        body: Data
      );
          print(response.statusCode);
      if(response.statusCode == 200){
        if(response.body.contains("success")){
          log("registration successfully completed");
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            content: Text("Registration successfully completed !",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),)));
          Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return LoginPage();
            }));
        } else{
          log("Registration failed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            content: Text("REGISTRATION FAILED !!!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),)));
        }
      } else {
        result = {log(json.decode(response.body)['error'].toString())};
      }
      return result;
    }catch (e) {
      log(e.toString());
    }
  }

   @override
  Widget build(BuildContext context){
     return Scaffold(
      appBar: AppBar(
        title: Text("Registration"), titleTextStyle: TextStyle(color: Colors.white,fontSize: 30),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text(
                  "Register Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Complete your details \n",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 28,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 241, 233, 233),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: "Name"),
                            onChanged: (text) {
                              setState(() {
                                name = text;
                              });
                            },
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter your name";
                              }
                              return null;
                            },
                        ),
                      ),),
                  ),),Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 241, 233, 233),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: "Phone"),
                            onChanged: (text) {
                              setState(() {
                                phone = text;
                              });
                            },
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter your phone number";
                              }
                              return null;
                            },
                        ),
                      ),),
                  ),),Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 241, 233, 233),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 15,
                            
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: "Address"),
                            onChanged: (text) {
                              setState(() {
                                address = text;
                              });
                            },
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter your address";
                              }
                              return null;
                            },
                        ),
                      ),),
                  ),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 241, 233, 233),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: "Username"),
                            onChanged: (text) {
                              setState(() {
                                username = text;
                              });
                            },
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter your username text";
                              }
                              return null;
                            },
                        ),
                      ),),
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 241, 233, 233),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 15
                            ),
                            decoration: InputDecoration.collapsed(hintText: "Password"),
                            onChanged: (text) {
                              setState(() {
                                password = text;
                              });
                            },
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter your password text";
                              }
                              return null;
                            },
                          ),
                        ),),
                    ),),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width /2,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            primary: Colors.white,
                            backgroundColor: Colors.black
                          ),
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              print("Name: "+ name.toString());
                              print("Phone: "+ phone.toString());
                              print("Address: "+ address.toString());
                              print("Username: "+ username.toString());
                              print("Password: "+ password.toString());
                              registration(name.toString(),phone.toString(), address.toString(), username.toString(),password.toString());
                            }
                          }, child: Text(
                            "Register",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )),
                      ),
                      ),const SizedBox(
              height: 20,
            ),
            TextButton(child: Text(
              "Do you have an account? Login",
              style: TextStyle(color: Colors.black),),
             onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> RegistrationPage()));
             },
             )
              ],
            ),
          )),
      )
    );
  }
}