import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';

// ignore: must_be_immutable
class LCommunity extends StatefulWidget {
  static const routeName = '/community';
  LCommunity({super.key});
  @override
  LCommunityState createState() => LCommunityState();
}

class LCommunityState extends State<LCommunity> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("community"),),
    body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Text(AppLocalizations.of(context)!.cCommunity, style: cHeaderText,),
          ]
        ),
  );
  }
}