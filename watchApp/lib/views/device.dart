import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/validators.dart';

// ignore: must_be_immutable
class Device extends StatefulWidget {
  static const routeName = '/device';
  Device({super.key});
  @override
  DeviceState createState() => DeviceState();
}

class DeviceState extends State<Device> {
  bool isUserValid = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Device",
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
                  Text("your local devices", style: cHeaderText),
                  SizedBox(
                width: 10,
              ),
              IconButton(
                icon: const Icon(Icons.info),
                tooltip: 'about device',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Your device data is fetch through your API provider. Please set up API to allow accessing your sensors.")));
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
                subtitle: Column(
                  children: [
                    Text("device type: Camera"),
                    Text("mfg: Arlo"),
                    Text("API: manual"),
                    Text("license: ABC1234"),
                    Text("description: "),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
                height: 5,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent,),
                tooltip: 'delete',
                onPressed: () {
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
