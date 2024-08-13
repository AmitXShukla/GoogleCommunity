import 'package:flutter/material.dart';

const cAppTitle = "community watch";
const cSettings = "settings";
const cPersonal = "personal";
const cSearch = "snooze";
const cBookmark = "bookmark";
const cGemini = "Gemini";
const cHistory = "history";
const cMedia = "media";
const cCommunity = "community";
const cDevices = "devices";
const cDarkMode = "dark mode";
const cLanguage = "language";
const cSignIn = "sign-in";
const cAboutUs = "about us";
const cMenu = "Menu";

enum cMessageType { error, success }

const cHeaderText = TextStyle(
    color: Colors.blueGrey,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'RobotoFlex',
    fontStyle: FontStyle.italic);

const cWarnText = TextStyle(
    color: Colors.orangeAccent,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'RobotoFlex',
    fontStyle: FontStyle.italic);

const cInfoText = TextStyle(
    color: Colors.greenAccent,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'RobotoFlex',
    fontStyle: FontStyle.italic);

const cBodyText = TextStyle(
    color: Colors.black45,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'Consola',
    fontStyle: FontStyle.normal);

const cErrorText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.red,
);

const cSuccessText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.green,
);

class CustomSpinner extends StatelessWidget {
  final bool toggleSpinner;
  const CustomSpinner({super.key, required this.toggleSpinner});

  @override
  Widget build(BuildContext context) {
    return Center(child: toggleSpinner ? const CircularProgressIndicator() : null);
  }
}

class CustomMessage extends StatelessWidget {
  final bool toggleMessage;
  // ignore: prefer_typing_uninitialized_variables
  final toggleMessageType;
  final String toggleMessageTxt;
  const CustomMessage(
      {super.key,
      required this.toggleMessage,
      this.toggleMessageType,
      required this.toggleMessageTxt})
      : super();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: toggleMessage
            ? Text(toggleMessageTxt,
                style: toggleMessageType == cMessageType.error.toString()
                    ? cErrorText
                    : cSuccessText)
            : null);
  }
}