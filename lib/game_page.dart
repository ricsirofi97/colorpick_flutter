import 'package:colorpick_flutter/colorpick_layout.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'Controller/GameController.dart';
import 'package:provider/provider.dart';
import 'package:colorpick_flutter/providers/counter_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user.dart';
import 'package:flutter_gen/gen_l10n/colorpick_localization.dart';

enum buttons {
  RED,
  GREEN,
  BLUE,
  YELLOW
}

bool blinkOn=false;
bool stop=false;
bool playerTurn=false;
bool ready = false;

class GamePage extends StatefulWidget {
  Color redButton = const Color.fromARGB(255, 255, 102, 102);

  Color greenButton = const Color.fromARGB(255, 0, 180, 102);

  Color blueButton = const Color.fromARGB(255, 0, 102, 204);

  Color yellowButton = const Color.fromARGB(255, 255, 255, 102);

  List<buttons> buttonOrder = [];

  int index=0;
  int orderIndex=0;
  int points=0;
  int correct=0;
  bool end = false;
  bool gameOver = false;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {

  late Box box;
  late User user;
  late GameController gameController;
  bool darkMode=true;

  void buttonBlinkOn(buttons buttonColor){
    if(widget.index < 4 && !widget.end) {
        setState(() {

          int indexprint = widget.index;
          debugPrint('index: $indexprint');
          switch (buttonColor){
            case buttons.RED:
              gameController.playSound(buttons.RED);

              AnimationController redAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
              Animation animationRed = ColorTween(begin: const Color.fromARGB(255, 255, 102, 102), end: Colors.white).animate(redAnimationController);
              animationRed.addListener((){
                setState((){
                  widget.redButton = animationRed.value;
                });
              });
              animationRed.addStatusListener((status){
                if(status == AnimationStatus.completed) {
                  redAnimationController.reverse();
                  if(status == AnimationStatus.completed && (widget.buttonOrder != null && widget.buttonOrder.length > widget.index)) {
                    blink(widget.buttonOrder[widget.index]);
                  }
                }
              });
              redAnimationController.forward();
              break;
            case buttons.BLUE:
              gameController.playSound(buttons.BLUE);

              AnimationController blueAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
              Animation animationBlue = ColorTween(begin: const Color.fromARGB(255, 0, 102, 204), end: Colors.white).animate(blueAnimationController);
              animationBlue.addListener((){
                setState((){
                  widget.blueButton = animationBlue.value;
                });
              });
              animationBlue.addStatusListener((status){
                if(status == AnimationStatus.completed) {
                  blueAnimationController.reverse();
                  if(status == AnimationStatus.completed && (widget.buttonOrder != null && widget.buttonOrder.length > widget.index)) {
                    blink(widget.buttonOrder[widget.index]);
                  }
                }
              });
              blueAnimationController.forward();
              break;
            case buttons.GREEN:
              gameController.playSound(buttons.GREEN);

              AnimationController greenAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
              Animation animationGreen = ColorTween(begin: const Color.fromARGB(255, 0, 180, 102), end: Colors.white).animate(greenAnimationController);
              animationGreen.addListener((){
                setState((){
                  widget.greenButton = animationGreen.value;
                });
              });
              animationGreen.addStatusListener((status){
                if(status == AnimationStatus.completed) {
                  greenAnimationController.reverse();
                  if(status == AnimationStatus.completed && (widget.buttonOrder != null && widget.buttonOrder.length > widget.index)) {
                    blink(widget.buttonOrder[widget.index]);
                  }
                }
              });
              greenAnimationController.forward();
              break;
            case buttons.YELLOW:
              gameController.playSound(buttons.YELLOW);

              AnimationController yellowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
              Animation animationYellow = ColorTween(begin: const Color.fromARGB(255, 255, 255, 102), end: Colors.white).animate(yellowAnimationController);
              animationYellow.addListener((){
                setState((){
                  widget.yellowButton = animationYellow.value;
                });
              });
              animationYellow.addStatusListener((status){
                if(status == AnimationStatus.completed) {
                  yellowAnimationController.reverse();
                  if(status == AnimationStatus.completed && (widget.buttonOrder != null && widget.buttonOrder.length > widget.index)) {
                    blink(widget.buttonOrder[widget.index]);
                  }
                }
              });
              yellowAnimationController.forward();
              break;
          }

        });
        if(widget.index < 3) {
          widget.index += 1;
        }
        else if(widget.index == 3){
          widget.end = true;
          playerTurn = true;
        }
      }
  }

  void blinkButton(buttons buttonColor){
      switch (buttonColor){
        case buttons.RED:

          AnimationController redAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
          Animation animationRed = ColorTween(begin: const Color.fromARGB(255, 255, 102, 102), end: Colors.white).animate(redAnimationController);
          animationRed.addListener((){
            setState((){
              widget.redButton = animationRed.value;
            });
          });
          animationRed.addStatusListener((status){
            if(status == AnimationStatus.completed) {
              redAnimationController.reverse();
            }
          });
          redAnimationController.forward();
          break;
        case buttons.BLUE:

          AnimationController blueAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
          Animation animationBlue = ColorTween(begin: const Color.fromARGB(255, 0, 102, 204), end: Colors.white).animate(blueAnimationController);
          animationBlue.addListener((){
            setState((){
              widget.blueButton = animationBlue.value;
            });
          });
          animationBlue.addStatusListener((status){
            if(status == AnimationStatus.completed) {
              blueAnimationController.reverse();
            }
          });
          blueAnimationController.forward();
          break;
        case buttons.GREEN:

          AnimationController greenAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
          Animation animationGreen = ColorTween(begin: const Color.fromARGB(255, 0, 180, 102), end: Colors.white).animate(greenAnimationController);
          animationGreen.addListener((){
            setState((){
              widget.greenButton = animationGreen.value;
            });
          });
          animationGreen.addStatusListener((status){
            if(status == AnimationStatus.completed) {
              greenAnimationController.reverse();
            }
          });
          greenAnimationController.forward();
          break;
        case buttons.YELLOW:

          AnimationController yellowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
          Animation animationYellow = ColorTween(begin: const Color.fromARGB(255, 255, 255, 102), end: Colors.white).animate(yellowAnimationController);
          animationYellow.addListener((){
            setState((){
              widget.yellowButton = animationYellow.value;
            });
          });
          animationYellow.addStatusListener((status){
            if(status == AnimationStatus.completed) {
              yellowAnimationController.reverse();
            }
          });
          yellowAnimationController.forward();
          break;
      }
  }

  Future<void> playOrder() async{
    int randomNumber;

    for(int i = 0; i < 4; i++){
      Random random = new Random();
      randomNumber = random.nextInt(4);
      widget.buttonOrder.add(buttons.values[randomNumber]);
    }

    await blink(widget.buttonOrder[0]);
  }

  void checkCorrectOrder(buttons button){
    if(button != widget.buttonOrder[widget.orderIndex]){
      widget.orderIndex=0;
      widget.index=0;
      widget.correct=0;
      widget.end=false;
      widget.buttonOrder.clear();
      widget.gameOver=true;
      if(widget.points > user.topScore){
        box.put('user', User(topScore: widget.points, username: user.username, darkMode: user.darkMode, lang:user.lang));
      }
    }
    else if(button == widget.buttonOrder[widget.orderIndex]){
      if(widget.orderIndex <= 4){
        widget.orderIndex++;
      }
      widget.correct++;
      context.read<Counter>().increment();
      widget.points = context.read<Counter>().count;
      if(widget.correct == 4){
        widget.orderIndex=0;
        widget.index=0;
        widget.correct=0;
        widget.end=false;
        widget.buttonOrder.clear();
        for(int i = 0; i < 5; i++){
          context.read<Counter>().increment();
        }
        widget.points = context.read<Counter>().count;
        playOrder();
      }
    }
  }

  Future<void> blink(buttons button) async {
    if (!widget.end) {
      Timer(
        const Duration(seconds: 1),
            () {
          buttonBlinkOn(button);
          debugPrint('buttonOn: $button');
        },
      );
    }

  }

  @override
  void initState() {
    super.initState();
    gameController = GameController();
    gameController.loadSounds();
    Hive.initFlutter();
    initBox();
    playOrder();
  }

  Future<void> initBox() async{
    box = await Hive.openBox('box');
    user = box.get('user');
    setState(() {
      darkMode = user.darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {

    final currentWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: double.infinity,

      decoration: BoxDecoration(
        color: darkMode ? Colors.grey[900] : Colors.white,
      ),

      child: Stack(
        children: [
          Align(
            alignment: currentWidth < 450 ? const Alignment(0,-0.5) : const Alignment(0,-0.75),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey
              ),
              child: Text(
                '${widget.points}',
                style: const TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: currentWidth < 450 ? const Alignment(-0.5,0.1) : const Alignment(-0.2, -0.2),
            child: GestureDetector(
              onTap: () {
                if(playerTurn){
                  blinkButton(buttons.RED);
                  gameController.playSound(buttons.RED);
                  checkCorrectOrder(buttons.RED);
                }
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.redButton
                ),
              ),
            ),
          ),
          Align(
            alignment: currentWidth < 450 ? const Alignment(0.5,0.1) : const Alignment(0.2,-0.2),
            child: GestureDetector(
              onTap: () {
                if(playerTurn){
                  blinkButton(buttons.GREEN);
                  gameController.playSound(buttons.GREEN);
                  checkCorrectOrder(buttons.GREEN);
                }
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.greenButton
                ),
              ),
            ),
          ),
          Align(
            alignment: currentWidth < 450 ? const Alignment(-0.5,0.5) : const Alignment(-0.2,0.7),
            child: GestureDetector(
              onTap: () {
                if(playerTurn){
                  blinkButton(buttons.BLUE);
                  gameController.playSound(buttons.BLUE);
                  checkCorrectOrder(buttons.BLUE);
                }
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.blueButton
                ),
              ),
            ),
          ),
          Align(
            alignment: currentWidth < 450 ? const Alignment(0.5,0.5) : const Alignment(0.2,0.7),
            child: GestureDetector(
              onTap: () {
                if(playerTurn){
                  blinkButton(buttons.YELLOW);
                  gameController.playSound(buttons.YELLOW);
                  checkCorrectOrder(buttons.YELLOW);
                }
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.yellowButton
                ),
              ),
            ),
          ),
          Material(
              color: const Color.fromARGB(100, 100, 102, 102),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (widget.gameOver) ... [
                    Text(AppLocalizations.of(context)!.gameOver,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Ink(
                        width: 120.0,
                        height: 120.0,
                        decoration: const ShapeDecoration(
                          color: Colors.black12,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.replay_outlined),
                          color: Colors.white,
                          iconSize: 100,
                          onPressed: () {
                            setState(() {
                              context.read<Counter>().reset();
                              widget.points = context.read<Counter>().count;

                              widget.gameOver=false;
                            });
                            playOrder();
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Ink(
                        width: 60.0,
                        height: 60.0,
                        decoration: const ShapeDecoration(
                          color: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.home_outlined),
                          color: Colors.white,
                          iconSize: 40,
                          onPressed: () {
                            context.read<Counter>().reset();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ColorPickLayout()),
                            );
                          },
                        ),
                      ),
                    ),
                  ]
                ],
              )
          ),
        ],
      ),
    );
  }
}