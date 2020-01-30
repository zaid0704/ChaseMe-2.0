import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Auth.dart';
class SignUP extends StatefulWidget {
  SignUP({Key key}) : super(key: key);

  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {

  final GlobalKey<FormState> key = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController admissionController = TextEditingController();
  TextEditingController gangstarController = TextEditingController();
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    return  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child:
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Loot',style: TextStyle(color: Colors.yellow,fontSize: 30),)

            ],
          ),
           Form(
                key: key,

                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: nameController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,color: Colors.yellow),
                        
                        validator: (val){
                          if (val.isEmpty ||!val.contains('@gmail.com'))
                           {
                             return 'Invalid Name';
                           
                           }
                        },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   borderSide: BorderSide(color: Colors.yellow),
                   ), 
               
                hintStyle: TextStyle(color: Colors.yellow,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
               borderSide: BorderSide(color: Colors.yellow),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Colors.yellow),
                        labelText: 'Name',
                        // helperText: 'abc0000@gmail.com',
                        helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,color: Colors.yellow),
                        
                        validator: (val){
                          if (val.isEmpty ||!val.contains('@gmail.com'))
                           {
                             return 'Invalid Email';
                           
                           }
                        },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   borderSide: BorderSide(color: Colors.yellow),
                   ), 
               
                hintStyle: TextStyle(color: Colors.yellow,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
               borderSide: BorderSide(color: Colors.yellow),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Colors.yellow),
                        labelText: 'Email Id',
                        // helperText: 'abc0000@gmail.com',
                        helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: admissionController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,color: Colors.yellow),
                        
                        validator: (val){
                          if (val.isEmpty ||!val.contains('@gmail.com'))
                           {
                             return 'Invalid Admission';
                           
                           }
                        },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   borderSide: BorderSide(color: Colors.yellow),
                   ), 
               
                hintStyle: TextStyle(color: Colors.yellow,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
               borderSide: BorderSide(color: Colors.yellow),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Colors.yellow),
                        labelText: 'Admission no.',
                        // helperText: 'abc0000@gmail.com',
                        helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: contactController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,color: Colors.yellow),
                        
                        validator: (val){
                          if (val.isEmpty ||!val.contains('@gmail.com'))
                           {
                             return 'Invalid Contact';
                           
                           }
                        },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   borderSide: BorderSide(color: Colors.yellow),
                   ), 
               
                hintStyle: TextStyle(color: Colors.yellow,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
               borderSide: BorderSide(color: Colors.yellow),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Colors.yellow),
                        labelText: 'Contact no.',
                        // helperText: 'abc0000@gmail.com',
                        helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                   Padding(
                      padding: const EdgeInsets.all(10),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: passwordController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,color: Colors.yellow),
                        
                        validator: (val){
                          if (val.isEmpty )
                           {
                             return 'Invalid Password';
                           
                           }
                        },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   borderSide: BorderSide(color: Colors.yellow),
                   ), 
               
                hintStyle: TextStyle(color: Colors.yellow,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
               borderSide: BorderSide(color: Colors.yellow),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Colors.yellow),
                        labelText: 'password',
                        hintText: 'abc@123',
                        helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: gangstarController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 18,color: Colors.yellow),
                        
                        validator: (val){
                          if (val.isEmpty ||!val.contains('@gmail.com'))
                           {
                             return 'Invalid Gangstar';
                           
                           }
                        },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   borderSide: BorderSide(color: Colors.yellow),
                   ), 
               
                hintStyle: TextStyle(color: Colors.yellow,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
               borderSide: BorderSide(color: Colors.yellow),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Colors.yellow),
                        labelText: 'Gangstar',
                        // helperText: 'abc0000@gmail.com',
                        helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.only(left:30,right: 30),
                      child:Text('SignUp',style: TextStyle(fontFamily:'Quicksand',color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),) ,
                      onPressed: (){
                        _submit(auth,nameController.text,emailController.text,admissionController.text,contactController.text,passwordController.text,gangstarController.text);
                        },
                      color: Colors.yellow,
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15)
                      ),
                    ),
                    SizedBox(height: 5,),
                   
                  
                    
                  ],
                ),
              ),
           ],
      ),
    ));
  }
  Future _submit(Auth auth,String name,String email,String admission,String contact,String password,String gangstar)
  {
    print("Submit ...");
    auth.SignUp(name, email, admission, contact, password, gangstar);
    Navigator.of(context).popAndPushNamed('/login'); 
  }
}