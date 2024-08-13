import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/validators.dart';
import '../blocs/datamodel.dart';
import '../blocs/auth.bloc.dart';

// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  static const routeName = '/signin';
  SignIn({super.key});
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  bool isUserValid = false;
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool _btnEnabled = false;
  String messageTxt = "";
  String messageType = "";
  final _formKey = GlobalKey<FormState>();
  var model = LoginDataModel(
    email: '-',
    password: 'na',
  );
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAuthState();
    model.password = "";
    _passwordController.clear();
    _btnEnabled = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

  void login(String loginType) async {
    toggleSpinner();
    String? userAuth;
    if (loginType == "Google") {
       await authBloc.signInWithGoogle();
    } else {
      userAuth = await authBloc.loginWithEmail(model);
    }
    if (userAuth == "success") {
      showMessage(
          true, "success", AppLocalizations.of(context)!.cSigninSuccess);
      await Future.delayed(const Duration(seconds: 1));
      loadAuthState();
    } else {
      showMessage(true, "error", userAuth);
    }
    toggleSpinner();
  }

  void navigateToUser() {
    Navigator.pushReplacementNamed(context, '/');
  }

  void logout() async {
    toggleSpinner();
    await authBloc.logout();
    loadAuthState();
    toggleSpinner();
  }
    void forgotPassword() async {
    toggleSpinner();
    String? userAuth = await authBloc.resetPassword(model);
    if (userAuth == "success") {
      showMessage(
          true, "success", AppLocalizations.of(context)!.cResetPasswordEmail);
    } else {
      showMessage(true, "error", userAuth);
    }
    toggleSpinner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(AppLocalizations.of(context)!.cSignIn, style: cHeaderText)),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
            child:
                isUserValid ? loginPage(context) : userForm(context)),
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
              Text(AppLocalizations.of(context)!.cLogin, style: cHeaderText),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              SizedBox(
                  width: 300.0,
                  // margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.email = value,
                    validator: (value) {
                      return Validators().evalEmail(context, value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: AppLocalizations.of(context)!.cEmailID,
                      labelText: AppLocalizations.of(context)!.cEmailHint,
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
                    controller: _passwordController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 50,
                    obscureText: true,
                    onChanged: (value) => model.password = value,
                    validator: (value) {
                      return Validators().evalPassword(context, value!);
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: AppLocalizations.of(context)!.cEnterPassword,
                      labelText: AppLocalizations.of(context)!.cPassword,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              CustomSpinner(toggleSpinner: spinnerVisible, key: null),
              CustomMessage(
                toggleMessage: messageVisible,
                toggleMessageType: messageType,
                toggleMessageTxt: messageTxt,
                key: null,
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              // signinSubmitBtn(context, authBloc),
              signinSubmitBtn(context),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/signup',
                  );
                },
                child: Chip(
                    avatar: const CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: Text("+"),
                    ),
                    label: Text(AppLocalizations.of(context)!.cNAccount)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
              ),
              GestureDetector(
                onTap: () {
                  login("Google");
                },
                child: Chip(
                    backgroundColor: Colors.red,
                    // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )),
                    label: Text(AppLocalizations.of(context)!.cSignGoogle)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
              ),
              TextButton(
                  onPressed: () {
                    // forgotPassword();
                    showAlertDialog(context);
                  },
                  child: Text(AppLocalizations.of(context)!.cFPassword))
            ],
          ),
        ),
      ),
    );
  }

  Widget signinSubmitBtn(context) {
    return ElevatedButton(
        onPressed: _btnEnabled == true ? () => login("email") : null,
        child: Text(AppLocalizations.of(context)!.cSignIn));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(AppLocalizations.of(context)!.cBtnCancel),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(AppLocalizations.of(context)!.cBtnContinue),
      onPressed: () {
        forgotPassword();
        Navigator.pop(context);
      },
    );

    AlertDialog alert;
    if (model.email.toString() == "-") {
      // set up the AlertDialog
      alert = AlertDialog(
        title: Text(AppLocalizations.of(context)!.cTxtConfirm),
        content: Text(AppLocalizations.of(context)!.cTxtConfirmDtl),
        actions: [
          cancelButton,
        ],
      );
    } else {
      // set up the AlertDialog
      alert = AlertDialog(
        title: Text(AppLocalizations.of(context)!.cTxtConfirm),
        content: Text(AppLocalizations.of(context)!.cTxtPswdReset),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
    }

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
                  Icons.info,
                  color: Colors.greenAccent,
                ),
              ),
              label: Text(AppLocalizations.of(context)!.cSigninSuccess,
                  style: cErrorText)),
          const SizedBox(width: 20, height: 50),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.cSignOut),
            // color: Colors.blue,
            onPressed: () {
              logout();
              /* Navigator.pushNamed(
                context,
                '/signin',
              ); */
            },
          ),
        ],
      ),
    );
  }
}
