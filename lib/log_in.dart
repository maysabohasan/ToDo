import 'package:flutter/material.dart';
import 'package:todo/To_do.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // Controllers for text input fields
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool is_hidden = true;
  // Variables to store error messages
  String emailError = '';
  String passwordError = '';

  // Regular expression pattern for validating email
  String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  // Function to validate form inputs
  bool _validateForm() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    setState(() {
      emailError = '';
      passwordError = '';
    });

    bool isValid = true;

    // Validate email using regex pattern
    if (!RegExp(emailPattern).hasMatch(email)) {
      setState(() {
        emailError = 'Invalid email';
      });
      isValid = false;
    }

    // Validate password length
    if (password.length < 8) {
      setState(() {
        passwordError = 'Password too short';
      });
      isValid = false;
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 29.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 29.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Email input field
                  Row(
                    children: [
                      Icon(
                        Icons.email_sharp,
                        size: 17.0,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        'Your email',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email Address ',
                      hintStyle:
                          TextStyle(fontSize: 13, color: Colors.grey[700]),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),

                  // Display email error message if any
                  if (emailError.isNotEmpty)
                    Text(
                      emailError,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),

                  SizedBox(height: 30),

                  // Password input field
                  Row(
                    children: [
                      Icon(
                        Icons.lock,
                        size: 17.0,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        'Password',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    controller: passwordController,
                    obscureText: is_hidden,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            is_hidden == true
                                ? is_hidden = false
                                : is_hidden = true;
                          });
                        },
                        child: is_hidden
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                      hintText: 'Password ',
                      hintStyle:
                          TextStyle(fontSize: 13, color: Colors.grey[700]),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),

                  // Display password error message if any
                  if (passwordError.isNotEmpty)
                    Text(
                      passwordError,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),

                  SizedBox(height: 10.0),

                  // Forgot Password button
                  TextButton(
                    onPressed: () {},
                    child: Center(
                      child: Text('Forgot Password?',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),

                  SizedBox(height: 30.0),

                  // Login button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to ToDo page if form is valid
                        if (_validateForm()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ToDo()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Dont have a account ? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold)),
                      ]),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Text(
                      'OR',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 1.5,
                      color: Colors.black12,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundImage: AssetImage('images/facebook.jpeg'),
                            radius: 27.0),
                        SizedBox(
                          width: 10.0,
                        ),
                        CircleAvatar(
                            backgroundImage:
                                AssetImage('images/instagram2.png'),
                            radius: 26.0),
                        SizedBox(
                          width: 10.0,
                        ),
                        CircleAvatar(
                            backgroundImage: AssetImage('images/TTT.jpeg'),
                            radius: 24.0),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
