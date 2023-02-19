import 'package:flutter/material.dart';
import 'PomodoroTimer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro Timer',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _mode = "Focus";
  int _count = 0;
  void _changeMode(String s) {
    setState(() {
      _mode = s;
    });
  }

  void _updatecount() {
    setState(() {
      _count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pomodoro Timer',
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: (_mode == "Focus")
                  ? PomodoroTimer(
                      title: "Focus",
                      modetime: 1 * 60,
                      updateCount: _updatecount,
                      changeMode: _changeMode,
                      count: _count,
                    )
                  : (_mode == "Short")
                      ? PomodoroTimer(
                          title: "Short",
                          modetime: 1 * 60,
                          updateCount: _updatecount,
                          changeMode: _changeMode,
                          count: _count)
                      : PomodoroTimer(
                          title: "Long",
                          modetime: 1 * 60,
                          updateCount: _updatecount,
                          changeMode: _changeMode,
                          count: _count),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text("Focus"),
                    onPressed: () {
                      _changeMode("Focus");
                    },
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(100, 40)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.lightBlue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                  ),
                  ElevatedButton(
                    child: Text("Short"),
                    onPressed: () {
                      _changeMode("Short");
                    },
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(100, 40)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.lightBlue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                  ),
                  ElevatedButton(
                    child: Text("Long"),
                    onPressed: () {
                      _changeMode("Long");
                    },
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(100, 40)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.lightBlue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
