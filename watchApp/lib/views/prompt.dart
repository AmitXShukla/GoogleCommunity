import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/validators.dart';
import '../blocs/auth.bloc.dart';
import '../blocs/datamodel.dart';

// ignore: must_be_immutable
class Prompt extends StatefulWidget {
  static const routeName = '/prompt';
  Prompt({super.key});
  @override
  PromptState createState() => PromptState();
}

class PromptState extends State<Prompt> {
  bool isUserValid = false;
  bool spinnerVisible = false;
  String result = "";
  final _formKey = GlobalKey<FormState>();
  var model = PromptDataModel(
      uid: '',
      dttm: DateTime.now(),
      prompt: '',
      res: '',
      like: false,
      unlike: false,
      bookmark: false,
      file: '');

  @override
  void initState() {
    super.initState();
    loadAuthState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadAuthState() async {
    bool res = await authBloc.loadAuthState();
    setState(() {
      isUserValid = res;
    });
  }

  getData() async {
    toggleSpinner();
    if (isUserValid) {
      await authBloc
          .getPrompt(model)
          .then((res) => setState(() => result = res))
          .catchError((error) => print(error.message));
    }
    toggleSpinner();
  }

    toggleSpinner() {
    setState(() => spinnerVisible = !spinnerVisible);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Prompt", style: cHeaderText)),
        body: Padding(
            padding: const EdgeInsets.all(28.0),
            child: SingleChildScrollView(
                child: (isUserValid == true)
                    ? userForm(context)
                    : loginPage(context))));
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
              Text("ask Gemini", style: cHeaderText),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              TextFormField(
                // controller: _emailController,
                cursorColor: Colors.blueAccent,
                // keyboardType: TextInputType.emailAddress,
                maxLength: 300,
                obscureText: false,
                onChanged: (value) => model.prompt = value,
                validator: (value) {
                  return Validators().evalChar(value!);
                },
                // onSaved: (value) => _email = value,
                decoration: InputDecoration(
                  icon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  hintText: "prompt",
                  labelText: "question Gemini",
                  // errorText: snapshot.error,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.info),
                    tooltip: 'info',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Your prompts are stored in history for 7 days, please delete those anytime you want.")));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.book_online_rounded,
                        color: Colors.brown),
                    tooltip: 'chat history',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/history',
                      );
                    },
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  CustomSpinner(toggleSpinner: spinnerVisible, key: null),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blueAccent),
                    tooltip: 'send',
                    onPressed: () {
                      getData();
                    },
                  ),
                ],
              ),
              Text(result)
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
          Chip(
              avatar: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
              ),
              label: Text(AppLocalizations.of(context)!.cTxtReLogin,
                  style: cErrorText)),
                  const SizedBox(width: 20, height: 50),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.cBtnCancel),
            // color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/',
              );
            },
          ),
        ],
      ),
    );
  }
}
