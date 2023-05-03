import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

import 'buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Calculator App",
                      style: TextStyle(
                        fontSize: 30,
                        // color: Colors.black,
                        fontWeight: FontWeight.w500,
                        // letterSpacing: 1
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        !Get.isDarkMode
                            ? Get.changeTheme(ThemeData.dark())
                            : Get.changeTheme(ThemeData.light());
                      },
                      iconSize: 35,
                      icon: const Icon(Icons.dark_mode)
                      // Icon(Icons.more_vert_rounded)
                      )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userInput,
                          style: TextStyle(
                              fontSize: 30,
                              color: !Get.isDarkMode
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        child: Text(
                          answer,
                          style: TextStyle(
                              fontSize: 40,
                              color:
                                  !Get.isDarkMode ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3,
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      // Clear Button
                      if (index == 0) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput = '';
                              answer = '0';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.blue[100],
                          textColor: Colors.black,
                        );
                      }

                      // +/- button
                      else if (index == 1) {
                        return MyButton(
                          buttonText: buttons[index],
                          color: Colors.blue[100],
                          textColor: Colors.black,
                        );
                      }
                      // % Button
                      else if (index == 2) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.blue[100],
                          textColor: Colors.black,
                        );
                      }
                      // Delete Button
                      else if (index == 3) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.blue[100],
                          textColor: Colors.black,
                        );
                      }
                      // Equal_to Button
                      else if (index == 18) {
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.orange[700],
                          textColor: Colors.white,
                        );
                      }

                      // other buttons
                      else {
                        return MyButton(
                            buttontapped: () {
                              setState(() {
                                userInput += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index])
                                ? Colors.blueAccent
                                : Colors.blueGrey,
                            textColor: Colors.white
                            // isOperator(buttons[index])
                            //     ? Colors.white
                            //     : Colors.black,
                            );
                      }
                    }), // GridView.builder
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
