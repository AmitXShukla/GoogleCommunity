import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/constants.dart';
import '../blocs/auth.bloc.dart';

// ignore: must_be_immutable
class Media extends StatefulWidget {
  static const routeName = '/media';
  Media({super.key});
  @override
  MediaState createState() => MediaState();
}

class MediaState extends State<Media> {
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
    // getData();
  }

  /* getData() async {
    if (isUserValid) {
      results = await authBloc.getDocs("media");
    }
  } */

  toggleSpinner() {
    setState(() => spinnerVisible = !spinnerVisible);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Media", style: cHeaderText)),
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
                  Text("your local media", style: cHeaderText),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    tooltip: 'about media',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "You're media will be deleted after 3 days unless you mark it to save.")));
                    },
                  ),
                  const SizedBox(
                    width: 10,
                    height: 5,
                  ),
                  const IconButton(
                    icon: const Icon(Icons.upload,
                        color: Colors.grey),
                    tooltip: 'upload',
                    onPressed: null,
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
                    tooltip: 'delete all media',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              showList(context),
            ],
          ),
        ),
      ),
    );
  }
Widget showList(BuildContext context) {
  return Column(
    children: [
      Image.asset("assets/images/sensors.jpg", width:  700, height: 820,),
      Image.asset("assets/images/sensor_2.png", width: 700, height: 820,),
      Image.asset("assets/images/pic_1.png", width:  700, height: 820,),
      Image.asset("assets/images/pic_2.png", width:  700, height: 820,),
      Image.asset("assets/images/pic_3.png", width:  700, height: 820,),
      Image.asset("assets/images/pic_4.png", width:  700, height: 820,),
      Image.asset("assets/images/pic_5.png", width:  700, height: 820,),
      Image.asset("assets/images/pic_6.png", width:  700, height: 820,),
      Image.asset("assets/images/pic_7.png", width:  700, height: 820,),
      Image.asset("assets/images/pic_8.png", width:  700, height: 820,),
      Image.asset("assets/images/hz_1.png", width: 700, height: 820,),
      Image.asset("assets/images/hz_2.png", width: 700, height: 820,),
      Image.asset("assets/images/hz_3.png", width: 700, height: 820,),
      Image.asset("assets/images/hz_4.png", width: 700, height: 820,),
      Image.asset("assets/images/hz_5.png", width: 700, height: 820,),
      Image.asset("assets/images/hz_6.png", width: 700, height: 820,),
      Image.asset("assets/images/hz_7.png", width: 700, height: 820,),
      Image.asset("assets/images/hz_8.png", width: 700, height: 820,),
    ],
  );
    /* return SingleChildScrollView(
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
                        const SizedBox(width: 5, height: 10,),
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
                                  color: (snapshot.data?[index]["like"] == true)? Colors.greenAccent : Colors.grey),
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
                                  color: (snapshot.data?[index]["bookmark"] == true)? Colors.greenAccent : Colors.grey),
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
     */
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
