import 'package:colorpick_flutter/colorpick_layout.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user.dart';
import 'package:flutter_gen/gen_l10n/colorpick_localization.dart';
late Box box;
late User user;
class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();

}

class _SettingsState extends State<Settings> {
  bool darkMode=true;
  String lang="";

  @override
  void initState() {
    super.initState();
    initBox();
  }

  void initBox() async{
    await Hive.initFlutter();
    box = await Hive.openBox('box');
    user = box.get('user');
    setState(() {
      darkMode = user.darkMode;
      lang = user.lang;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: darkMode ? Colors.grey[900] : Colors.white,
        ),
        child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                child: Material(
                  color: darkMode ? Colors.grey[900] : Colors.white,
                  child: Ink(
                    width: 40,
                    height: 40,
                    decoration: const ShapeDecoration(
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white70,
                      iconSize: 20,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ColorPickLayout()),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100.0, left: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.darkMode,
                          style: TextStyle(
                              color: darkMode ? Colors.indigo : Colors.black,
                              decoration: TextDecoration.none,
                              fontSize: 16
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: darkMode ? MaterialStateProperty.all<Color>(Colors.lightGreen) : MaterialStateProperty.all<Color>(Colors.grey),
                            shadowColor: MaterialStateProperty.all<Color>(Colors.black12),
                          ),
                          onPressed: () {
                            setState(() {
                              darkMode = true;
                              box.put('user', User(topScore: user.topScore, username: user.username, darkMode: true, lang: user.lang));
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context)!.enable,
                            style: TextStyle(
                                color: Colors.black45,
                                decoration: TextDecoration.none,
                                fontSize: 13
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: darkMode ? MaterialStateProperty.all<Color>(Colors.grey) : MaterialStateProperty.all<Color>(Colors.lightGreen),
                              shadowColor: MaterialStateProperty.all<Color>(Colors.black12)
                          ),
                          onPressed: () {
                            setState(() {
                              darkMode = false;
                              box.put('user', User(topScore: user.topScore, username: user.username, darkMode: false, lang: user.lang));
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context)!.disable,
                            style: TextStyle(
                                color: Colors.black45,
                                decoration: TextDecoration.none,
                                fontSize: 13
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.language,
                          style: TextStyle(
                              color: darkMode ? Colors.indigo : Colors.black,
                              decoration: TextDecoration.none,
                              fontSize: 16
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: (lang == "hu") ? MaterialStateProperty.all<Color>(Colors.lightGreen) : MaterialStateProperty.all<Color>(Colors.grey),
                              shadowColor: MaterialStateProperty.all<Color>(Colors.black12)
                          ),
                          child: Text(
                              AppLocalizations.of(context)!.hungary,
                            style: TextStyle(
                                color: Colors.black45,
                                decoration: TextDecoration.none,
                                fontSize: 13
                              )
                            ),
                          onPressed: () {
                            setState(() {
                              lang = "hu";
                              box.put('user', User(topScore: user.topScore, username: user.username, darkMode: user.darkMode, lang: "hu"));
                              AppLocalizations.delegate.load(Locale.fromSubtags(languageCode: user.lang));
                            });
                          },
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: (lang == "en") ? MaterialStateProperty.all<Color>(Colors.lightGreen) : MaterialStateProperty.all<Color>(Colors.grey),
                              shadowColor: MaterialStateProperty.all<Color>(Colors.black12)
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.english,
                              style: TextStyle(
                                  color: Colors.black45,
                                  decoration: TextDecoration.none,
                                  fontSize: 13
                              ),
                            ),
                          onPressed: () {
                            setState(() {
                              lang = "en";
                              box.put('user', User(topScore: user.topScore, username: user.username, darkMode: user.darkMode, lang: "en"));
                              AppLocalizations.delegate.load(Locale.fromSubtags(languageCode: user.lang));
                            });
                          },
                        ),
                      ],
                    )
                  ]
                ),
              ),
            ]
        )
    );
  }
}