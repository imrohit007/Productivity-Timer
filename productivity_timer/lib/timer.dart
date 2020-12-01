import 'dart:async';
import './timermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';


//this class is craeted to countdown timers

class CountDownTimer {
  double _radius = 1;     //we will use this to express the percentage of completed time
  bool _isActive = true;    //will tell us if the counter is active or not. when the user presses the stop button, it will become inactive
  Timer timer;      // this is for timer
  Duration _time;     // we will use to express the remaining time,
  Duration _fullTime;     //it is the begning time for short break, long break
  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  String returnTime(Duration t) {
    //We make sure that, if minutes or seconds have only one digit, we add a "0" before the number, and then concatenate the two values with a ":" sign.
    String minutes = (t.inMinutes<10) ? '0' + t.inMinutes.toString():
    t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes*60);
    String seconds = (numSeconds<10) ? '0' + numSeconds.toString():
    numSeconds.toString();
    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }

  //let's create the stream() method. The asterisk (*) after async is used to say that a Stream is being returned,

  Stream<TimerModel> stream() async* {
    //Stream.periodic() is a constructor creating a Stream that emits events at the intervals specified in the first parameter. 
    //In our code, this will emit a value every 1 second.
    yield* Stream.periodic(Duration(seconds: 1), (int a){
      String time;
      if (this._isActive){
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;
        if (_time.inSeconds <= 0){
          _isActive = false;
        }
      }
      time = returnTime(_time);   //he returnTime method to transform the remaining Duration into a String, like this.
      return TimerModel(time, _radius);   // this function returns a Stream of TimerModel , decrementing the Duration every second.
    });
  }

  void startWork() async{
    await readSettings(); 
    _radius = 1;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
  }

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = prefs.getInt('workTime') == null ? 30 : prefs.getInt('workTime');
    shortBreak = prefs.getInt('shortBreak') == null ? 30 : prefs.getInt('shortBreak');
    longBreak = prefs.getInt('longBreak') == null ? 30 : prefs.getInt('longBreak');
  }

  void stopTimer(){
    this._isActive = false;
  }

  void startTimer(){    //hat will check whether the remaining time is bigger than 0 seconds, and will set the _isActive Boolean to true
    if (_time.inSeconds > 0){
      this._isActive = true;
    }
  }

  void startBreak(bool isShort) {
    _radius = 1;
    _time = Duration(
      minutes: (isShort) ? shortBreak: longBreak,
      seconds: 0);
    _fullTime = _time;
  }
}