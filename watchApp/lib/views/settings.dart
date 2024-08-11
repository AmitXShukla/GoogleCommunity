import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/validators.dart';
import '../blocs/datamodel.dart';
import '../blocs/auth.bloc.dart';

// ignore: must_be_immutable
class Settings extends StatefulWidget {
  static const routeName = '/settings';
  Settings({super.key});
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool isUserValid = false;
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
      userType: '',
      name: '',
      email: '',
      phone: '',
      address: '',
      ephone1: '');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ephoneController = TextEditingController();
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
    _ephoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void loadAuthState() async {
    bool res = await authBloc.loadAuthState();
    setState(() {
      isUserValid = res;
    });
    model.userType = dropdownValue;
    getData();
  }

  getData() async {
    messageVisible = true;
      if (isUserValid) {
         await authBloc
            .getData("settings")
            .then((res) => setState(
                () => updateFormData(UserDataModel.fromJson(res.data()))))
            .catchError((error) => showMessage(
                true, "error", error.message));
      }
  }

  updateFormData(data) {
    _nameController.text = data.name;
    _emailController.text = data.email;
    _phoneController.text = data.phone;
    _addressController.text = data.address;
    _ephoneController.text = data.ephone1;
    model.name = data.name;
    model.email = data.email;
    model.phone = data.phone;
    model.address = data.address;
    model.ephone1 = data.ephone1;
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
    messageVisible = true;
    await authBloc
        .setData('settings', model)
        .then((res) => {showMessage(true, "success", AppLocalizations.of(context)!.cTxtSaved)})
        .catchError((error) => {showMessage(true, "error", error.toString())});
    toggleSpinner();
 }

  void navigateToUser() {
    Navigator.pushReplacementNamed(context, '/');
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
                      hintText: AppLocalizations.of(context)!.cEMailID1,
                      labelText: AppLocalizations.of(context)!.cEMailID2,
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
                      hintText: AppLocalizations.of(context)!.cPhone1,
                      labelText: AppLocalizations.of(context)!.cPhone2,
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
                      hintText: AppLocalizations.of(context)!.cAddress1,
                      labelText: AppLocalizations.of(context)!.cAddress2,
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
                    controller: _ephoneController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.ephone1 = value,
                    validator: (value) {
                      return Validators().evalPhone(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: AppLocalizations.of(context)!.cEContact1,
                      labelText: AppLocalizations.of(context)!.cEContact2,
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
              /* Container(
                margin: const EdgeInsets.only(top: 15.0),
              ),
              ElevatedButton(
                child: const Text('Log out'),
                // color: Colors.blue,
                onPressed: () {
                  logout();
                },
              ), */
            ],
          ),
        ),
      ),
    );
  }

  Widget sendBtn(context) {
    return ElevatedButton(
        onPressed: _btnEnabled == true ? () => setData() : null,
        child: Text(AppLocalizations.of(context)!.cBtnSave));
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
          /* ElevatedButton(
            child: Text(AppLocalizations.of(context)!.cSignIn),
            // color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/',
              );
            },
          ), */
        ],
      ),
    );
  }
}