import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/auth.bloc.dart';

// ignore: must_be_immutable
class Devices extends StatefulWidget {
  static const routeName = '/devices';
  Devices({super.key});
  @override
  DevicesState createState() => DevicesState();
}

class DevicesState extends State<Devices> {
  bool isUserValid = false;
  final _formKey = GlobalKey<FormState>();
  bool spinnerVisible = false;
  List results = [];

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
    //getData();
  }

/*   getData() async {
    if (isUserValid) {
      results = await authBloc.getDocs("history");
    }
  } */

  toggleSpinner() {
    setState(() => spinnerVisible = !spinnerVisible);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Device", style: cHeaderText)),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
            child:
                (isUserValid == true) ? userForm(context) : loginPage(context)),
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
                  const SizedBox(
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
                  const SizedBox(
                    width: 10,
                    height: 5,
                  ),
                  IconButton(
                      icon: const Icon(Icons.add, color: Colors.blueAccent),
                      tooltip: 'add device',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/device',
                        );
                      })
                ],
              ),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              showList(context),
              /* ListTile(
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
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                tooltip: 'delete',
                onPressed: () {},
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget showList(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: authBloc.getDocs("devices"),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                width: 300,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(
                          width: 5,
                          height: 30,
                        ),
                        Text(snapshot.data?[index]["type"] ?? "-"),
                        Text(snapshot.data?[index]["mfg"] ?? "-"),
                        Text(snapshot.data?[index]["api"] ?? "-"),
                        Text(snapshot.data?[index]["license"] ?? "-"),
                        Text(snapshot.data?[index]["description"] ?? "-"),
                      ],
                    );
                    /* return Text(snapshot.data?[index]["dttm"].seconds.toString() ?? "got null"); */
                  },
                ),
              );
            }

            /// handles others as you did on question
            else {
              return const CircularProgressIndicator();
            }
          }),
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
