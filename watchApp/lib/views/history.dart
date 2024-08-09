import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/validators.dart';

// ignore: must_be_immutable
class History extends StatefulWidget {
  static const routeName = '/history';
  History({super.key});
  @override
  HistoryState createState() => HistoryState();
}

class HistoryState extends State<History> {
  bool isUserValid = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("History",
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
                  Text("your local chat history", style: cHeaderText),
                  SizedBox(
                width: 10,
              ),
              IconButton(
                icon: const Icon(Icons.info),
                tooltip: 'about chat',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Your chat history will be deleted after 7 days unless you mark it to save.")));
                },
              ),
                ],
              ),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              ListTile(
                title: Text("data"),
                subtitle: Text("prompt"),
              ),
              const SizedBox(
                width: 10,
                height: 5,
              ),
              Row(children: [
                IconButton(
                icon: const Icon(Icons.thumb_up, color: Colors.blueGrey),
                tooltip: 'like',
                onPressed: () {
                },
              ),
              const SizedBox(
                width: 2,
                height: 5,
              ),
              IconButton(
                icon: const Icon(Icons.thumb_down, color: Colors.blueGrey),
                tooltip: 'unlike',
                onPressed: () {
                },
              ),
                const SizedBox(
                width: 30,
                height: 5,
              ),
                IconButton(
                icon: const Icon(Icons.question_answer, color: Colors.blueAccent),
                tooltip: 'prompt',
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
