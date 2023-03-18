// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oturn = true; // first player is 'O'
  List<String> displayXO = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
  //var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int oScore = 0;
  int xScore = 0;
  int filledBox = 0;
  static var myNewFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
// Create A 3x3 matrix using Grid:
      body: Column(
        children: [
//Score Board
          Expanded(
              child: Container(
                  child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Player O', style: myNewFontWhite),
                  SizedBox(
                    height: 20,
                  ),
                  Text(xScore.toString(), style: myNewFontWhite),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Player X', style: myNewFontWhite),
                  SizedBox(
                    height: 20,
                  ),
                  Text(oScore.toString(), style: myNewFontWhite),
                ],
              ),
            ],
          ))),
// Grid VIEW BUILDER
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
// Creating  A button out of Container
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: SafeArea(
                      child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade800,
                                offset: Offset(10, 10),
                                blurRadius: 4,
                                spreadRadius: 1),
                            BoxShadow(
                                color: Colors.grey.shade900,
                                offset: Offset(-10, -10),
                                blurRadius: 4,
                                spreadRadius: 1),
                          ],
                          border: Border.all(
                            color: Color.fromARGB(255, 76, 74, 74),
                            width: 3,
                          ),
                        ),
                        child: Center(
                            //For Each index a String is to be defined X or O
                            child: Text(
                          displayXO[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        )),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
            child: Center(
              child: Column(
                children: [
                  Text(
                    "T I C  T A C  T O E",
                    style: myNewFontWhite,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

// IF TAPPED WHAT WILL HAPPEN -> X OR O
  void _tapped(int index) {
    setState(() {
      if (oturn && displayXO[index] == " ") {
        oturn = false;
        displayXO[index] = 'O';
        filledBox++;
      } else if (!oturn && displayXO[index] == " ") {
        oturn = true;
        displayXO[index] = 'X';
        filledBox++;
      }
      _checkWinner();
    });
  }

// if three of the grids are having same String then win using 8 logics
  void _checkWinner() {
//  1st row blocks
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != ' ') {
      _ShowWinDialog(displayXO[0]);
    }
// 2nd row blocks
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != ' ') {
      _ShowWinDialog(displayXO[3]);
    }
//3rd row blocks
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != ' ') {
      _ShowWinDialog(displayXO[6]);
    }
// 1st colmn down blocks
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != ' ') {
      _ShowWinDialog(displayXO[0]);
    }
// 2nd colmn down blocks
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != ' ') {
      _ShowWinDialog(displayXO[1]);
    }
// 3rd colmn down blocks
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != ' ') {
      _ShowWinDialog(displayXO[2]);
    }
// diagonal \  blocks
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != ' ') {
      _ShowWinDialog(displayXO[0]);
    }
// diagonal /  blocks
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != ' ') {
      _ShowWinDialog(displayXO[6]);
    } else if (filledBox == 9) {
      _showDrawDialog();
    }
  }

// to show alert dialog box::
  void _ShowWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          // O -> player 1
          // X -> player 2
          String player = " ";
          if (winner == "X") {
            player = "P L A Y E R 2";
            oScore++;
          } else {
            player = "P L A Y E R 1";
            xScore++;
          }

          // dialog box with clear button;
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            title: Text("W I N N E R : " + player),
            actions: [
              ElevatedButton(
                onPressed: _clearBoard,
                child: Icon(CupertinoIcons.refresh_thick),
              ),
            ],
          );
        });
  }

// to rest the game // without changing Score::
  void _clearBoard() {
    setState(() {
      displayXO = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
      Navigator.pop(context);
    });
    filledBox = 0;
  }

//Draw dialog box
  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("D R A W"),
            actions: [
              ElevatedButton(
                onPressed: _clearBoard,
                child: Icon(CupertinoIcons.refresh_thick),
              ),
            ],
          );
        });
  }
}
