import 'package:flutter/material.dart';
import 'package:todo/log_in.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // White app bar
      ),
      backgroundColor: Colors.white, // White background
      body: SafeArea(
        child: Expanded(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 45.0), // Top space
                const Image(
                    image: AssetImage('images/todolist.png')), // App image
                Column(
                  children: [
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Simplify, Organize, and Conquer ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Your Day',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ])),
                    SizedBox(height: 10.0), // Space between texts
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26.0), // Horizontal padding
                      child: Column(
                        children: [
                          Text(
                            'Take control of your tasks and ',
                            style: TextStyle(fontSize: 16.5),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'achieve your goals.',
                            style: TextStyle(fontSize: 16.5),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40.0), // Space before button
                          Container(
                            width: double.infinity, // Full-width button
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const LogIn()));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0), // Rounded button
                                  ),
                                ),
                                child: Text(
                                  'Lets Start',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
