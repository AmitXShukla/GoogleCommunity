import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/validators.dart';
import '../blocs/datamodel.dart';
import '../blocs/auth.bloc.dart';

// ignore: must_be_immutable
class Community extends StatefulWidget {
  static const routeName = '/community';
  Community({super.key});
  @override
  CommunityState createState() => CommunityState();
}

class CommunityState extends State<Community> {
  bool isUserValid = false;
  bool spinnerVisible = false;
  bool messageVisible = false;
  String messageTxt = "";
  String messageType = "";
  bool _btnEnabled = false;
  final _formKey = GlobalKey<FormState>();
  var model = CommunityDataModel(uid: '', name: '');
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAuthState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void loadAuthState() async {
    bool res = await authBloc.loadAuthState();
    setState(() {
      isUserValid = res;
    });
    getData();
  }

  getData() async {
    messageVisible = true;
    if (isUserValid) {
      await authBloc
          .getData("community")
          .then((res) => setState(
              () => updateFormData(CommunityDataModel.fromJson(res.data()))))
          .catchError((error) => showMessage(true, "error", error.message));
    }
  }

  updateFormData(data) {
    _nameController.text = data.name;
    model.name = data.name;
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
        .setData('community', model)
        .then((res) => {
              showMessage(
                  true, "success", AppLocalizations.of(context)!.cTxtSaved)
            })
        .catchError((error) => {showMessage(true, "error", error.toString())});
    toggleSpinner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.cCommunity,
              style: cHeaderText)),
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
              Text("your local community", style: cHeaderText),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              SizedBox(
                  width: 300.0,
                  // margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _nameController,
                    cursorColor: Colors.blueAccent,
                    // keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.name = value,
                    validator: (value) {
                      return Validators().evalChar(context, value!);
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
              const SizedBox(
                width: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.info),
                    tooltip: 'geo location',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "You'll receive community alerts within 2 miles of this location.")));
                    },
                  ),
                  CustomSpinner(toggleSpinner: spinnerVisible, key: null),
                  CustomMessage(
                    toggleMessage: messageVisible,
                    toggleMessageType: messageType,
                    toggleMessageTxt: messageTxt,
                    key: null,
                  ),
                  const SizedBox(width: 30),
                  sendBtn(context),
                ],
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
