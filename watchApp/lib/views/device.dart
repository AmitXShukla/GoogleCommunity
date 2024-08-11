import 'package:commwatch/blocs/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/validators.dart';
import '../blocs/auth.bloc.dart';

// ignore: must_be_immutable
class Device extends StatefulWidget {
  static const routeName = '/device';
  Device({super.key});
  @override
  DeviceState createState() => DeviceState();
}

class DeviceState extends State<Device> {
  bool isUserValid = false;
  static List<String> list = <String>['car', 'camera', 'motion', 'CO', 'license', 'temperature', 'flood'];
  String dropdownValue = list.first;
  final _formKey = GlobalKey<FormState>();
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool _btnEnabled = false;
  String messageTxt = "";
  String messageType = "";
  List results = [];
  var model = DeviceDataModel(
      uid: '',
      type: '',
      mfg: '',
      api: '',
      license: '',
      description: '');
  final TextEditingController _mfgController = TextEditingController();
  final TextEditingController _apiController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _descrController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAuthState();
  }

  @override
  void dispose() {
    _mfgController.dispose();
    _apiController.dispose();
    _licenseController.dispose();
    _descrController.dispose();
    super.dispose();
  }

  void loadAuthState() async {
    bool res = await authBloc.loadAuthState();
    setState(() {
      isUserValid = res;
    });
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
    model.type = dropdownValue;
    await authBloc
        .setData('devices', model)
        .then((res) => {showMessage(true, "success", AppLocalizations.of(context)!.cTxtSaved)})
        .catchError((error) => {showMessage(true, "error", error.toString())});
    toggleSpinner();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Device", style: cHeaderText)),
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
      onChanged: () =>
          setState(() => _btnEnabled = _formKey.currentState!.validate()),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text("your local device", style: cHeaderText),
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
                      icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
                      tooltip: 'back',
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              Text(AppLocalizations.of(context)!.cAddDevice, style: cHeaderText),
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
                    controller: _mfgController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.mfg = value,
                    validator: (value) {
                      return Validators().evalCharSmall(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.business),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: AppLocalizations.of(context)!.cMfg1,
                      labelText: AppLocalizations.of(context)!.cMfg2,
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
                    controller: _apiController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.api = value,
                    validator: (value) {
                      return Validators().evalCharSmall(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.api),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: AppLocalizations.of(context)!.cAPI1,
                      labelText: AppLocalizations.of(context)!.cAPI2,
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
                    controller: _licenseController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.license = value,
                    validator: (value) {
                      return Validators().evalCharSmall(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.read_more),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: AppLocalizations.of(context)!.cLicense1,
                      labelText: AppLocalizations.of(context)!.cLicense2,
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
                    controller: _descrController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.description = value,
                    validator: (value) {
                      return Validators().evalCharSmall(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.deck),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: AppLocalizations.of(context)!.cDescr1,
                      labelText: AppLocalizations.of(context)!.cDescr2,
                      // errorText: snapshot.error,
                    ),
                  )),
                  Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              CustomSpinner(toggleSpinner: spinnerVisible, key: null),
              CustomMessage(
                toggleMessage: messageVisible,
                toggleMessageType: messageType,
                toggleMessageTxt: messageTxt,
                key: null,
              ),
              // signinSubmitBtn(context, authBloc),
              sendBtn(context),
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
        ],
      ),
    );
  }
}
