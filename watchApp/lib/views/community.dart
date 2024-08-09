import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/validators.dart';

// ignore: must_be_immutable
class Community extends StatefulWidget {
  static const routeName = '/community';
  Community({super.key});
  @override
  CommunityState createState() => CommunityState();
}

class CommunityState extends State<Community> {
  bool isUserValid = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // return Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children:
    //         [
    //           Text(AppLocalizations.of(context)!.cCommunity, style: cHeaderText,),
    //         ]
    // );
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.cCommunity,
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
              Text("your local community", style: cHeaderText),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              SizedBox(
                  width: 300.0,
                  // margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    // controller: _emailController,
                    cursorColor: Colors.blueAccent,
                    // keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    // onChanged: (value) => model.email = value,
                    validator: (value) {
                      return Validators().evalEmail(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.home),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: "Location",
                      labelText: "community address",
                      // errorText: snapshot.error,
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: const Icon(Icons.info),
                tooltip: 'geo location',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "You'll receive community alerts within 2 miles of this location.")));
                },
              ),
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
