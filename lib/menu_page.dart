import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera.dart';
import 'game_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user.dart';
import 'package:provider/provider.dart';
import 'package:colorpick_flutter/providers/name_provider.dart';
import 'package:colorpick_flutter/settings.dart';
import 'package:flutter_gen/gen_l10n/colorpick_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:colorpick_flutter/camera.dart';

class MenuPage extends StatefulWidget {

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final textInputController = TextEditingController();

  late Box box;
  late User user;

  bool darkMode=true;
  String lang="";

  File? image;

  void initBox() async{
    await Hive.initFlutter();
    box = await Hive.openBox('box');
    user = box.get('user');
    setState(() {
      darkMode = user.darkMode;
      lang=user.lang;
    });
  }

  Future<void> initImage() async {
    final path =
      (await getApplicationDocumentsDirectory()).path + 'profilePicture.png';

    final file = File(path);
    if (file.existsSync()) {
      setState(() {
        image = file;
      });
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  @override
  void initState() {
    super.initState();
    initBox();
    initImage();
  }

  @override
  Widget build(BuildContext context) {

    void hide(){
      Navigator.of(context).pop();
    }

    void showNameEditDialog(BuildContext context) => showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => AlertDialog(
            content: TextField(
              controller: textInputController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'username'
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  box.put('user', User(topScore: user.topScore, username: textInputController.text, darkMode: user.darkMode, lang: user.lang));
                  debugPrint(AppLocalizations.of(context)!.username + ': ${textInputController.text}');
                  setState(() {
                    user.username = textInputController.text;
                  });
                  context.read<Name>().change(textInputController.text);
                  hide();
                  },
                child: Text(AppLocalizations.of(context)!.update),
              )
            ]
    ));

    void showSimpleDialog(BuildContext context) => showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.yourProfile),
          content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage: image?.existsSync() == true
                          ? Image.memory(
                        image!.readAsBytesSync(),
                        fit: BoxFit.fill,
                      ).image
                          : null,
                      child: image?.existsSync() != true
                          ? Icon(
                        Icons.account_circle_outlined,
                        size: 100,
                        color: Colors.black,
                      )
                          : null),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.edit),
                  onPressed: () async {
                    final cameras = await availableCameras();
                    final camera = cameras.first;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraPage(camera: camera)),
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.username + " : ${context.watch<Name>().username}"),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.edit),
                  onPressed: () async {
                    showNameEditDialog(context);
                  },
                ),
              ]
            ),
            Text(AppLocalizations.of(context)!.yourBestScore + " ${user.topScore}"),
          ],
        ),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: hide,
            )
          ],
        ));

    return Container(
      width: double.infinity,
      height: double.infinity,

      decoration: BoxDecoration(
        color: darkMode ? Colors.grey[900] : Colors.white,
      ),
      child: Stack(
          children: [
            Material(
              color: darkMode ? Colors.grey[900] : Colors.white,
              child: Center(
                child: Ink(
                  width: 120.0,
                  height: 120.0,
                  decoration: const ShapeDecoration(
                    color: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    color: Colors.white,
                    iconSize: 100,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GamePage()),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
              ),
              child: CircleAvatar(
                  radius: 70,
                  backgroundImage: image?.existsSync() == true
                      ? Image.memory(
                    image!.readAsBytesSync(),
                    fit: BoxFit.fill,
                  ).image
                      : null,
                  child: image?.existsSync() != true
                      ? Icon(
                    Icons.account_circle_outlined,
                    size: 100,
                    color: darkMode ? Colors.white : Colors.black,
                  )
                      : null),
            ),
            Row(
              children: [
                Material(
                  color: darkMode ? Colors.grey[900] : Colors.white,
                  child: Ink(
                    width: 60,
                    height: 60,
                    decoration: const ShapeDecoration(
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    ),
                    child: IconButton(
                      key: const Key("profile_info"),
                      icon: const Icon(Icons.account_circle_outlined),
                      color: Colors.white70,
                      iconSize: 40,
                      onPressed: () {
                        context.read<Name>().change(user.username);
                        debugPrint('username: ${user.username}');
                        showSimpleDialog(context);
                      },
                    ),
                  ),
                ),
                Material(
                  color: darkMode ? Colors.grey[900] : Colors.white,
                  child: Ink(
                    width: 60,
                    height: 60,
                    decoration: const ShapeDecoration(
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      color: Colors.white70,
                      iconSize: 40,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Settings()),
                        );
                      },
                    ),
                  ),
                )
              ],
            )
          ]
      )
    );
  }
}