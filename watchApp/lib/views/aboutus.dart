import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';

// ignore: must_be_immutable
class AboutUs extends StatefulWidget {
  static const routeName = '/aboutus';
  AboutUs({super.key});
  @override
  AboutUsState createState() => AboutUsState();
}

class AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text(AppLocalizations.of(context)!.cAboutUs, style: cHeaderText)),
    body: Padding(
      padding: const EdgeInsets.all(28.0),
      child: SingleChildScrollView(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Text(AppLocalizations.of(context)!.cAboutUsContent1, style: cHeaderText,),
                const SizedBox(width: 10, height: 20),
                Text(AppLocalizations.of(context)!.cAboutUsContent2, style: cHeaderText,),
                const SizedBox(width: 10, height: 20),
                Text(AppLocalizations.of(context)!.cAboutUsContent3, style: cInfoText,),
                const SizedBox(width: 10, height: 20),
                Text(AppLocalizations.of(context)!.cAboutUsContent4, style: cWarnText,),
                const SizedBox(width: 10, height: 20),
                Image.asset("process.png"),
                const SizedBox(width: 10, height: 20),
                Image.asset("ai_1.png"),
                const SizedBox(width: 10, height: 20),
                Image.asset("ai_2.png")
              ]
            ),
      ),
    ),
  );
  }
}