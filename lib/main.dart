import 'dart:async';
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
  static const MAXIMUM_ROUND = 4;
  static const MAXIMUM_GOAL = 12;
  static int TOTAL_MINUTES = 25;
  static int TOTAL_SECONDS = 00;
  static const List<String> TIMERS = ['15', '20', '25', '30', '35'];
  static List<bool> selected = [false, false, true, false, false];

  int minutes = TOTAL_MINUTES;
  int seconds = TOTAL_SECONDS;
  int round = 0;
  int goal = 0;
  bool isRunning = false;
  late Timer timer;

  void onTick(Timer timer) {
    if (isEnd(minutes, seconds)) {
      setState(() {
        isRunning = false;
      });
      timer.cancel();
      return;
    }
    tickToc();
  }

  void tickToc() {
    if (seconds == 0) {
      setState(() {
        minutes--;
        seconds = 59;
      });
    } else {
      setState(() {
        seconds--;
      });
    }
  }

  void resetTimer() {
    minutes = TOTAL_MINUTES;
    seconds = TOTAL_SECONDS;
  }

  bool isEnd(int minutes, int seconds) {
    if (minutes == 0 && seconds == 0) {
      resetTimer();
      incrementRoundAndGoal();
      return true;
    }
    return false;
  }

  void incrementRoundAndGoal() {
    if (round < MAXIMUM_ROUND) {
      round++;
      return;
    }
    if (round >= MAXIMUM_ROUND) {
      round = 0;
      goal++;
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    setState(() {
      isRunning = false;
    });
    timer.cancel();
    resetTimer();
  }

  Widget timeDisplay(int number) {
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
                number == 0 ? '00' : number.toString(),
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

  void setTimer(int index) {
    if (index == 0) {
      minutes = 15;
      seconds = 0;
      TOTAL_MINUTES = 15;
      TOTAL_SECONDS = 0;
    } else if (index == 1) {
      minutes = 20;
      seconds = 0;
      TOTAL_MINUTES = 20;
      TOTAL_SECONDS = 0;
    } else if (index == 2) {
      minutes = 25;
      seconds = 0;
      TOTAL_MINUTES = 25;
      TOTAL_SECONDS = 0;
    } else if (index == 3) {
      minutes = 30;
      seconds = 0;
      TOTAL_MINUTES = 30;
      TOTAL_SECONDS = 0;
    } else if (index == 4) {
      minutes = 35;
      seconds = 0;
      TOTAL_MINUTES = 35;
      TOTAL_SECONDS = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
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
              timeDisplay(minutes),
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
              timeDisplay(seconds),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ToggleButtons(
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: selected,
                  color: Colors.white38,
                  borderWidth: 4,
                  borderColor: Colors.white38,
                  selectedColor: Colors.deepOrange,
                  selectedBorderColor: Colors.white,
                  fillColor: Colors.white,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < selected.length; i++) {
                        if (selected[i]) {
                          selected[i] = false;
                          break;
                        }
                      }
                      selected[index] = true;
                    });
                    setTimer(index);
                  },
                  children: const [
                    Text(
                      '15',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '20',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '25',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '30',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '35',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                color: Colors.black87.withOpacity(0.5),
                iconSize: 110,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(
                  isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_fill_outlined,
                ),
              ),
              IconButton(
                color: Colors.black87.withOpacity(0.5),
                iconSize: 110,
                onPressed: onResetPressed,
                icon: const Icon(
                  Icons.restore,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    '$round/$MAXIMUM_ROUND',
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'ROUND',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '$goal/$MAXIMUM_GOAL',
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'GOAL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
