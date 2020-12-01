import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './widgets.dart';
import './timer.dart';
import './timermodel.dart';
import './settings.dart';
import './about.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, 
      ),
      home: TimerHomePage(),
    );
  }
}




class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();
  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();
    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));
    menuItems.add(PopupMenuItem(
      value: 'About',
      child: Text('About'),
    ));

  

    timer.startWork();
    return Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
          actions: [    // navigation to settings screen 
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context){
                return menuItems.toList();
              },
              onSelected: (s){
                if (s=='Settings'){
                  goToSettings(context);
                }
                else{
                  goToAbout(context);
                }
              },
              
              )
          ],
        ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
          final double availableWidth = constraints.maxWidth;
          return Column(children: [
          // We will row widget and include it as the first element of the column
          Row(
            children: [
              // Expanded widget that takes all the available space of a colun or a row after placing in the fixed elements.
              Padding(padding: EdgeInsets.all(defaultPadding),),
              Expanded(child: ProductivityButton(color:Color(0xff009688), text: "Work", onPressed: () => timer.startWork())),
              Padding(padding: EdgeInsets.all(defaultPadding),),
              Expanded(child: ProductivityButton(color: Color(0xff607D8B), text: "Short Break", onPressed: () => timer.startBreak(true))),
              Padding(padding: EdgeInsets.all(defaultPadding),),
              Expanded(child: ProductivityButton(color: Color(0xff455A64), text: "Long Break", onPressed: () => timer.startBreak(false))),
              Padding(padding: EdgeInsets.all(defaultPadding),),
              
            ],
          ),
          // this is for the main clock
          Expanded(
                  child: StreamBuilder(
                      initialData: TimerModel('00:00', 1),
                      stream: timer.stream(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        TimerModel timer = snapshot.data;
                        return Container(
                            child: CircularPercentIndicator(
                          radius: availableWidth / 2,
                          lineWidth: 10.0,
                          percent: (timer.percent == null) ? 1 : timer.percent,
                          center: Text( (timer.time == null) ? '00:00' : timer.time ,
                              style: Theme.of(context).textTheme.headline4),
                          progressColor: Color(0xff009688),
                        ));
                      })),
          Row(
            children: [
              Padding(padding: EdgeInsets.all(defaultPadding),),
              Expanded(child: ProductivityButton(color: Color(0xff212121), text: "Stop", onPressed: () => timer.stopTimer())),
              Padding(padding: EdgeInsets.all(defaultPadding),),
              Expanded(child: ProductivityButton(color: Color(0xff009688), text: "Restart", onPressed: () => timer.startTimer())),
              Padding(padding: EdgeInsets.all(defaultPadding),),
            ],
          )
        ],
        );
        },
        ),
      );
  }
  // this is for button
  void emptyMethod() {}

  void goToSettings(BuildContext context) {
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }
  
  void goToAbout(BuildContext context){
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => About()));
  }

}