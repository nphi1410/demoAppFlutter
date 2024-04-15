import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  var _username = '';
  var _password = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login_bg.png'),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text('Welcome\nBack',style: TextStyle(
                color: Colors.white,
                fontSize: 33
              ),),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.45,
                  right: 35,
                  left: 35),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value){
                        setState(() {
                          _username = value;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onChanged: (value){
                        setState(() {
                          _password = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _submit();
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the background color
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // To make the row take as little space as possible
                            children: [
                              Text(
                                'Sign in ',
                                style: TextStyle(
                                  color: Color(0xff4c505b),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Color(0xff4c505b), // You can adjust the color of the icon as needed
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 20,
                                color: Color(0xff4c505b)
                              ),
                            )),
                        TextButton(
                            onPressed: (){},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 20,
                                  color: Color(0xff4c505b)
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submit() {
    print('username: $_username\npassword: $_password');
    if (_username == 'admin' && _password == '123456') {
      Navigator.pushNamed(context, 'home');
    } else {
      // Show an error message or handle invalid credentials
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid username or password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

