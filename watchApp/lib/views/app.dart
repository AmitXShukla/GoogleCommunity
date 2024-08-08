import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../shared/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import './aboutus.dart';
import './community.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State createState() => _AppState();
}

enum Menu { preview, share, getLink, remove, download }

class _AppState extends State<App> {
  late ScrollController _controller;
  bool _showFab = true;
  bool _isElevated = true;
  bool _isVisible = true;
  ThemeMode themeMode = ThemeMode.system;
  bool isBright = true;

  FloatingActionButtonLocation get _fabLocation => _isVisible
      ? FloatingActionButtonLocation.endFloat
      : FloatingActionButtonLocation.centerFloat;

  void _listen() {
    switch (_controller.position.userScrollDirection) {
      case ScrollDirection.idle:
        break;
      case ScrollDirection.forward:
        _show();
      case ScrollDirection.reverse:
        _hide();
    }
  }

  void _show() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
    }
  }

  void _hide() {
    if (_isVisible) {
      setState(() => _isVisible = false);
    }
  }

  void _onShowFabChanged(bool value) {
    setState(() {
      _showFab = value;
    });
  }

  void _onElevatedChanged(bool value) {
    setState(() {
      _isElevated = value;
    });
  }

  bool get useLightMode => switch (themeMode) {
        ThemeMode.system =>
          View.of(context).platformDispatcher.platformBrightness ==
              Brightness.light,
        ThemeMode.light => true,
        ThemeMode.dark => false
      };

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  // Locale _locale = "en" as Locale;
  Locale _locale = const Locale('en');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_listen);
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(useMaterial3: true),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // locale: _locale,
      // locale: const Locale('en'),
      // supportedLocales: const [
      //   Locale('en'), // English
      //   Locale('es'), // Spanish
      //   Locale('hi'), // Hindi
      //   Locale('zh'), // Chinese
      // ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      themeMode: themeMode,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.light(),
      home: Scaffold(
        // appBar: AppBar(
        //   leading:
        //   // title: Text(AppLocalizations.of(context)!.title,
        //   //   style: cHeaderText,
        //   // ),
        // ),
        body: Column(
          children: <Widget>[
            // SwitchListTile(
            //   title: Text(AppLocalizations.of(context)!.cAppTitle),
            //   value: _showFab,
            //   onChanged: _onShowFabChanged,
            // ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: 400,
                height: 400,
                child: SingleChildScrollView(
                  child: Community(),
                ),
              ),
            )
            // SwitchListTile(
            //   title: const Text('Bottom App Bar Elevation'),
            //   value: _isElevated,
            //   onChanged: _onElevatedChanged,
            // ),
          ],
        ),
        floatingActionButton: _showFab
            ? FloatingActionButton(
                onPressed: () => {
                      Navigator.pushNamed(
                      context,
                      '/aboutus',
                    )
                  },
                tooltip: "Gemini",
                elevation: _isVisible ? 0.0 : null,
                child: const Icon(Icons.question_answer),
              )
            : null,
        floatingActionButtonLocation: _fabLocation,
        bottomNavigationBar: BottomAppBar(
            isElevated: _isElevated,
            isVisible: _isVisible,
            handleBrightnessChange: handleBrightnessChange,
            setLocale: setLocale),
      ),
      routes: {
        // '/': (context) => const LogIn(), //- can not set if home: ERPHomePage() is setup, only works with initiated route
        AboutUs.routeName: (context) => AboutUs(),
        Community.routeName: (context) => Community(),
      },
    );
  }
}

// ignore: must_be_immutable
class BottomAppBar extends StatefulWidget {
  BottomAppBar(
      {super.key,
      required this.isElevated,
      required this.isVisible,
      required this.handleBrightnessChange,
      required this.setLocale});

  bool isElevated;
  bool isVisible;
  Function(bool useLightMode) handleBrightnessChange;
  Function(Locale _locale) setLocale;
  @override
  BottomAppBarState createState() => BottomAppBarState();
}

class BottomAppBarState extends State<BottomAppBar> {
  bool isBright = true;
  static List<String> lang = <String>['english', 'español', '中国人', 'हिंदी'];
  String dropdownValue = lang.first;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: widget.isVisible ? 80.0 : 0,
      child: Row(
        children: <Widget>[
          PopupMenuButton<Menu>(
            popUpAnimationStyle: AnimationStyle(
              curve: Easing.emphasizedDecelerate,
              duration: const Duration(seconds: 1),
            ),
            icon: const Icon(
              Icons.more_vert,
              color: Colors.blueGrey,
            ),
            onSelected: (Menu item) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                value: Menu.preview,
                child: ListTile(
                  leading: Icon(Icons.book_online_rounded),
                  title: Text(cHistory),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.share,
                child: ListTile(
                  leading: Icon(Icons.photo),
                  title: Text(cMedia),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.getLink,
                child: ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text(cCommunity),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.getLink,
                child: ListTile(
                  leading: Icon(Icons.device_hub),
                  title: Text(cDevices),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<Menu>(
                value: Menu.remove,
                child: const ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text(cDarkMode),
                ),
                onTap: () {
                  isBright = !isBright;
                  widget.handleBrightnessChange(isBright);
                },
              ),
              PopupMenuItem<Menu>(
                value: Menu.download,
                child: ListTile(
                  leading: const Icon(Icons.language),
                  // title: Text(cLanguage),
                  subtitle: DropdownButton<String>(
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
                        switch (value) {
                          // Your Enum Value which you have passed
                          case "english":
                            widget.setLocale(
                                const Locale.fromSubtags(languageCode: 'en'));
                            break;
                          case "español":
                            widget.setLocale(
                                const Locale.fromSubtags(languageCode: 'es'));
                            break;
                          case "中国人":
                            widget.setLocale(
                                const Locale.fromSubtags(languageCode: 'zh'));
                            break;
                          case "हिंदी":
                            widget.setLocale(
                                const Locale.fromSubtags(languageCode: 'hi'));
                            break;
                        }
                      });
                    },
                    items: lang.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.download,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(cSettings),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<Menu>(
                value: Menu.download,
                child: ListTile(
                  leading: Icon(Icons.login),
                  title: Text(cSignIn),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<Menu>(
                value: Menu.download,
                child: ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text(cAboutUs),
                  onTap: () => {
                      Navigator.pushNamed(
                      context,
                      '/aboutus',
                    )
                  },
                ),
              ),
            ],
          ),
          IconButton(
            tooltip: cHome,
            icon: const Icon(
              Icons.home,
              color: Colors.blueAccent,
            ),
            onPressed: () {},
          ),
          IconButton(
            tooltip: cSearch,
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            tooltip: cBookmark,
            icon: const Icon(Icons.bookmarks),
            onPressed: () {},
          ),
          Row(
            children: [
              // const Icon(
              //   Icons.wind_power,
              //   color: Colors.blueGrey,
              // ),
              const SizedBox(
                width: 20,
              ),
              Text(
                AppLocalizations.of(context)!.cAppTitle,
                style: cHeaderText,
              )
            ],
          ),
        ],
      ),
      // ),
    );
  }
}