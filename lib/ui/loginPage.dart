import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_application/ui/home.dart';
import 'package:e_commerce_application/ui/registrationPage.dart';
import 'package:e_commerce_application/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username,password;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
  }

void _loadcounter() async{
  final prefs= await SharedPreferences.getInstance();
  bool isLoggedIn= prefs.getBool('isLoggedIn')??false;
  log("isLoggedin="+isLoggedIn.toString());
  if(isLoggedIn){
    Navigator.push(context,MaterialPageRoute(builder:(_) =>HomePage()));
  }
}

login(String username,String password) async{
  try{
   print(Webservice.mainurl+"login.php");
    print(username);
    print(password);
    var result;
    final Map<String,dynamic> loginData={
      'username':username,
      'password':password,
    };

    final response =await http.post(
      Uri.parse(Webservice.mainurl+"login.php"),
      body:loginData,
    );

    print(response.statusCode);
    if(response.statusCode==200){
      print(response.body);
      if(response.body.contains("success")){
        log("login successfully completed");
        final prefs =await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn",true);
        prefs.setString("username",username);
        Navigator.push(context,MaterialPageRoute(
          builder:(context){
            return HomePage();
          }
          ));
      }else{
       log("login failed");
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration:Duration(seconds:3),
        behavior: SnackBarBehavior.floating,
        padding:EdgeInsets.all(15.0),
        shape:RoundedRectangleBorder(
          borderRadius:BorderRadius.all(Radius.circular(10))),
         content:Text("LOGIN FAILED!!!",
         textAlign: TextAlign.center,
         style:TextStyle(
          fontSize:18,
          color: Colors.white,
          )),
       ));
      }
    }else{
      result={log(json.decode(response.body)['error'].toString())};
    }
    return result;
  }catch(e){
    log(e.toString());
  }
}

@override
Widget build(BuildContext context){
  return Scaffold(
    body:SingleChildScrollView(
      child: Form(
        key:_formkey,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Text(
                "Welcome Back",
                style:TextStyle(
                  color:Colors.black,
                  fontSize:28,
                fontWeight  :FontWeight.bold,
                )
              ),

               const Text(
                "Login with your username and password \n",
                textAlign:TextAlign.center,
              ),
             SizedBox(height:50),
             Padding(
              padding:EdgeInsets.all(8.0),
             child: Container(
              height: 50,
              width:MediaQuery.of(context).size.width,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius:BorderRadius.all(Radius.circular(10)),
              ),
              child:Padding(
              padding:EdgeInsets.symmetric(horizontal:15),
              child:Center(
                child:TextFormField(
                  style:TextStyle(
                    fontSize: 15,
                  ),
                  decoration:InputDecoration.collapsed(
                    hintText:'Username',
                    ),
                    onChanged: (text){
                      setState(() {
                        username=text;
                      });
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your username text';
                      }
                      return null;
                    },
                ),
              ),
              ),
             ),
             ),
             Padding(
              padding:EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width:MediaQuery.of(context).size.width,
                decoration:const BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),                 
                ),
                child:Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 15),
                  child:Center(
                    child:TextFormField(
                      obscureText:true,
                      style:const TextStyle( 
                        fontSize:15,
                      ),
                      decoration:const InputDecoration.collapsed(
                        hintText:'Password',
                      ),
                      onChanged:(text){
                        setState((){
                          password=text;
                        });
                      },
                      validator:(value){
                        if(value!.isEmpty){
                          return'Enter your password text';
                        }
                        return null;
                      },
                    ))
                  ),
              ),
              ),
              SizedBox(height: 30),
              Padding(
                padding:EdgeInsets.all(8.0),
                child: Container(
                  width:MediaQuery.of(context).size.width/2,
                  height: 50,
                  child:TextButton(
                    style:TextButton.styleFrom(
                      shape:RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(20)),
                        primary:Colors.white,
                       backgroundColor:Colors.grey),
                      onPressed:() {
                        if(_formkey.currentState!.validate()){
                          log("username="+username.toString());
                          log("password="+password.toString());  
                          login(username.toString(),password.toString());                    
                       }
                      } ,
                      child:const Text(
                       "Login",
                       style:TextStyle(
                        fontSize:18,
                        color:Colors.white,
                       ),
                      ),                   
                  ),
                ),                 
                ),
                  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  RegistrationPage (
                               
                                )),
                      );
                    },
                    child: const Text(
                      'Go to Register',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          )
        )      )
    )
  );
}}
    
 