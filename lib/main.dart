import 'package:flutter/material.dart';

void main() {
  runApp(const Pomotimer());
}

class Pomotimer extends StatelessWidget {
  const Pomotimer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepOrange,
        primaryColor: Colors.white,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const twentyFiveMinutes = 1500;
  static const twentyMinutes = 2000;

  List<Widget> timeSetter() {
    List<Widget> times = [];
    for (var time in ['15', '20', '25', '30', '35']) {
      times.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.white)),
          width: 70,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            time,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ));
    }
    return times;
  }

  Widget timeDisplay(String number) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(3)),
                color: Colors.white.withOpacity(0.5),
              ),
              width: 115,
              height: 180,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(3)),
                color: Colors.white.withOpacity(0.7),
              ),
              width: 132,
              height: 176,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              width: 150,
              height: 170,
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void onResetPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Row(
              children: [
                Text(
                  'POMOTIMER',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              timeDisplay('12'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Text(
                      ':',
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              timeDisplay('00'),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: timeSetter(),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onResetPressed,
                iconSize: 90,
                icon: const Icon(
                  Icons.pause_circle_filled,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Center(child: Text('ROUND')),
                ],
              ),
              Column(
                children: [
                  Text('GOAL'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
