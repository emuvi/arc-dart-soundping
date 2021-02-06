import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundPing',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'SoundPing'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _times = TextEditingController(); 
  String _period = 'Second';

  String _elapsed = "0 second(s)";
  String _ringed = "0 time(s)";

  void _startCounter() {
    debugPrint(_times.text);
    debugPrint(_period);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.40,
              child: Row(
                children: [
                  Text(
                    "Ring Bell",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.40,
              child: TextField(
                decoration: new InputDecoration(labelText: "Time(s) per"),
                controller: _times,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.40,
              child: DropdownButton<String>(
                value: _period,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                style: TextStyle(color: Colors.deepOrange),
                underline: Container(
                  height: 2,
                  color: Colors.deepOrangeAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    _period = newValue;
                  });
                },
                items: <String>['Second', 'Minute', 'Hour']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.90,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Row(
                children: [
                  Text("Elapsed: " + _elapsed,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Row(
                children: [
                  Text("Ringed: " + _ringed,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startCounter,
        tooltip: 'Start',
        child: Icon(Icons.audiotrack_rounded),
      ),
    );
  }

  @override
  void dispose() {
    _times.dispose();
    super.dispose();
  }
}
