import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/validators.dart';
import '../blocs/datamodel.dart';

// ignore: must_be_immutable
class Settings extends StatefulWidget {
  static const routeName = '/settings';
  Settings({super.key});
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool isUserValid = true;
  static List<String> list = <String>['individual', 'community'];
  String dropdownValue = list.first;
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool _btnEnabled = false;
  String messageTxt = "";
  String messageType = "";
  final _formKey = GlobalKey<FormState>();
  var model = UserDataModel(
      uid: '',
      userName: '',
      userType: '',
      name: '',
      email: '',
      phone: '',
      address: '',
      ephone1: '');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAuthState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void loadAuthState() async {
    toggleSpinner();
    // final userState = await authBloc.isSignedIn();
    // setState(() => isUserValid = userState);
    model.userType = dropdownValue;
    // await authBloc.getUserSettingsDoc().then((res) => {
    //       if (res != null)
    //         {
    //           setState(() {
    //             model.uid = res["uid"];
    //             model.objectId = res["objectId"];
    //             model.name = res["name"];
    //             _nameController.text = res["name"];
    //             model.email = res["email"];
    //             _emailController.text = res["email"];
    //             model.phone = res["phone"];
    //             _phoneController.text = res["phone"];
    //             model.address = res["address"];
    //             _addressController.text = res["address"];
    //             dropdownValue = res["userType"];
    //           })
    //         }
    //       else
    //         {
    //           setState(() {
    //             model.objectId = "-";
    //           })
    //         }
    //     });
    // if (model.objectId != "-") {
    //   setState(() {
    //     fileUpload = true;
    //   });
    // }
    toggleSpinner();
  }

  toggleSpinner() {
    setState(() => spinnerVisible = !spinnerVisible);
  }

  showMessage(bool msgVisible, msgType, message) {
    messageVisible = msgVisible;
    setState(() {
      messageType = msgType == "error"
          ? cMessageType.error.toString()
          : cMessageType.success.toString();
      messageTxt = message;
    });
  }

  void setData() async {
    toggleSpinner();
    // ignore: prefer_typing_uninitialized_variables
    var userData;
    model.userType = dropdownValue;
    // userData = await authBloc.setUserSettingsDoc(model);
    // if (userData == true) {
    //   showMessage(true, "success", "user settings updated.");
    //   loadAuthState();
    // } else {
    //   showMessage(
    //       true, "error", "something went wrong, please contact your Admin.");
    // }
    toggleSpinner();
  }

  void navigateToUser() {
    Navigator.pushReplacementNamed(context, '/');
  }

  void logout() async {
    // setState(() {
    //   model.password = "";
    //   _passwordController.clear();
    //   _btnEnabled = false;
    // });
    toggleSpinner();
    // var val = await authBloc.logout();
    // if (val == true) {
    //   showMessage(true, "success", "Successfully signed out.");
    //   setState(() => isUserValid = false);
    //   navigateToUser();
    // } else {
    //   showMessage(true, "error", val.error!.message);
    // }
    toggleSpinner();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text(AppLocalizations.of(context)!.cSettings, style: cHeaderText)),
    body: Padding(
      padding: const EdgeInsets.all(28.0),
      child: SingleChildScrollView(
        child: (isUserValid == true)
                    ? userForm(context)
                    : loginPage(context)
      ),
    ),
  );
  }

  Widget userForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () =>
          setState(() => _btnEnabled = _formKey.currentState!.validate()),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(AppLocalizations.of(context)!.cSettings1, style: cHeaderText),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                // style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Container(
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _nameController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.name = value,
                    validator: (value) {
                      return Validators().evalName(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: AppLocalizations.of(context)!.cName1,
                      labelText: AppLocalizations.of(context)!.cName2,
                      // errorText: snapshot.error,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              Container(
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.email = value,
                    validator: (value) {
                      return Validators().evalEmail(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'EmailID *',
                      labelText: 'emailID',
                      // errorText: snapshot.error,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              Container(
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _phoneController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.phone = value,
                    validator: (value) {
                      return Validators().evalPhone(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'Phone *',
                      labelText: 'phone',
                      // errorText: snapshot.error,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              Container(
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _addressController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.address = value,
                    validator: (value) {
                      return Validators().evalChar(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.home_filled),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'Address *',
                      labelText: 'address',
                      // errorText: snapshot.error,
                    ),
                  )),
                  Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              Container(
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _phoneController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.phone = value,
                    validator: (value) {
                      return Validators().evalPhone(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'Emergency *',
                      labelText: 'emergency contact',
                      // errorText: snapshot.error,
                    ),
                  )),
              CustomSpinner(toggleSpinner: spinnerVisible, key: null),
              CustomMessage(
                toggleMessage: messageVisible,
                toggleMessageType: messageType,
                toggleMessageTxt: messageTxt,
                key: null,
              ),
              // signinSubmitBtn(context, authBloc),
              sendBtn(context),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
              ),
              ElevatedButton(
                child: const Text('Log out'),
                // color: Colors.blue,
                onPressed: () {
                  logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sendBtn(context) {
    return ElevatedButton(
        onPressed: _btnEnabled == true ? () => setData() : null,
        child: const Text('save'));
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