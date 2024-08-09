import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/validators.dart';

// ignore: must_be_immutable
class Media extends StatefulWidget {
  static const routeName = '/media';
  Media({super.key});
  @override
  MediaState createState() => MediaState();
}

class MediaState extends State<Media> {
  bool isUserValid = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Media",
              style: cHeaderText)),
      // body: (isUserValid == true) ? userForm(context) : loginPage(context),
      // body: SingleChildScrollView(child: userForm(context)),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
            child:
                (isUserValid == true) ? loginPage(context) : userForm(context)),
      ),
    );
  }

  Widget userForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () => setState(() => null),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text("your local media", style: cHeaderText),
                  SizedBox(
                width: 10,
              ),
              IconButton(
                icon: const Icon(Icons.info),
                tooltip: 'about media',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "You're media will be deleted after 3 days unless you mark it to save.")));
                },
              ),
                ],
              ),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              Image.asset("process.png"),
              const SizedBox(
                width: 10,
                height: 5,
              ),
              Row(children: [
                IconButton(
                icon: const Icon(Icons.add, color: Colors.blueAccent),
                tooltip: 'upload',
                onPressed: () {
                },
              ),
              const SizedBox(
                width: 10,
                height: 5,
              ),
              IconButton(
                icon: const Icon(Icons.save, color: Colors.brown),
                tooltip: 'save',
                onPressed: () {
                },
              ),const SizedBox(
                width: 10,
                height: 5,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent,),
                tooltip: 'delete',
                onPressed: () {
                },
              ),
              ],)
            ],
          ),
        ),
      ),
    );
  }

  Widget loginPage(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
              ),
              label: Text("please Login again, you are currently signed out.",
                  style: cErrorText)),
          const SizedBox(width: 20, height: 50),
          ElevatedButton(
            child: const Text('Login'),
            // color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/signin',
              );
            },
          ),
        ],
      ),
    );
  }
}
