import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List randomNumbers = [];
  List randomColors = [];
  Random randomizer = Random();

  @override
  void initState() {
    super.initState();

    generateRandomNumbersAndColors();
  }

  void generateRandomNumbersAndColors() {
    randomNumbers.clear();
    randomColors.clear();

    while (randomNumbers.length < 24) {
      int randomNumber = randomizer.nextInt(50);
      if (!randomNumbers.contains(randomNumber)) {
        randomNumbers.add(randomNumber);
        randomColors.add(
            Color((randomizer.nextDouble() * 0xFFFFFF)
                .toInt())
                .withOpacity(0.6)
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double desiredButtonWidth = 90.0;
    double desiredButtonHeight = 90.0;
    int crossAxisCount = (screenWidth / desiredButtonWidth).floor();
    double fontSize = (desiredButtonHeight / 3.5);

    return Scaffold(
        appBar: AppBar(
          title: Text('GridApp', style: TextStyle(
              color: Colors.white
          )),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: ListView(
            children: <Widget>[
              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount, // количество столбцов
                  ),
                  itemCount: randomNumbers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0), // отступ
                      child: TextButton(
                        key: Key(randomNumbers[index].toString()),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                int _selectedNumber = randomNumbers[index];

                                return AlertDialog(
                                  title: Text('Число'),
                                  content: Text(
                                    "Выбранное значение: $_selectedNumber",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Ок',

                                        style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontSize: 20,
                                        ),
                                      )
                                    )
                                  ]
                                );
                          });
                        },
                        child: Text(
                            randomNumbers[index].toString(),
                            style: TextStyle(
                              fontSize: fontSize,
                              color: HSLColor.fromColor(randomColors[index])
                                  .withLightness(HSLColor
                                    .fromColor(randomColors[index])
                                  .lightness * 0.1)
                                  .toColor(),
                            )
                        ),
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Colors.black, width: 1),
                          backgroundColor: randomColors[index], // цвет фона
                        ),
                      ),
                    );
                  }
              )
            ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              generateRandomNumbersAndColors();
            });
          },
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ),
    );
  }

}
