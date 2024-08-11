import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../shared/constants.dart';
import '../blocs/auth.bloc.dart';

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
      appBar: AppBar(title: const Text("History", style: cHeaderText)),
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
                              "Your chat history will be deleted after 7 days unless you bookmark it to save.")));
                    },
                  ),
                  const SizedBox(
                    width: 10,
                    height: 5,
                  ),
                  IconButton(
                    icon: const Icon(Icons.question_answer,
                        color: Colors.blueAccent),
                    tooltip: 'prompt',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/prompt',
                      );
                    },
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
                    tooltip: 'delete all history',
                    onPressed: () {},
                  ),
                ],
              ),
              showList(context),
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
        ],
      ),
    );
  }

  Widget showList(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: authBloc.getDocs("history"),
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
                          height: 10,
                        ),
                        Text(DateTime.fromMillisecondsSinceEpoch(
                                    snapshot.data?[index]["dttm"].seconds *
                                        1000)
                                .toString()
                                .substring(0, 10) ??
                            "-"),
                        Text(snapshot.data?[index]["prompt"] ?? "-"),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.star,
                                  color: (snapshot.data?[index]["like"] == true)
                                      ? Colors.greenAccent
                                      : Colors.grey),
//                              tooltip: 'like',
                              onPressed: null,
                            ),
                            /* const SizedBox(
                              width: 2,
                              height: 5,
                            ),
                            IconButton(
                              icon: Icon(Icons.star,
                                  color: (snapshot.data?[index]["unlike"] == true)? Colors.greenAccent : Colors.blueGrey),
                              tooltip: 'star',
                              onPressed: () {},
                            ), */
                            const SizedBox(
                              width: 10,
                              height: 5,
                            ),
                            IconButton(
                              icon: Icon(Icons.bookmark,
                                  color: (snapshot.data?[index]["bookmark"] ==
                                          true)
                                      ? Colors.greenAccent
                                      : Colors.grey),
                              //           tooltip: 'save',
                              onPressed: null,
                            ),
                          ],
                        )
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
}
