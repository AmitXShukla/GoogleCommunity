import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';

// ignore: must_be_immutable
class Community extends StatefulWidget {
  static const routeName = '/community';
  Community({super.key});
  @override
  CommunityState createState() => CommunityState();
}

class CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
  return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Text(AppLocalizations.of(context)!.cCommunity, style: cHeaderText,),
          ]
  );
  }
}