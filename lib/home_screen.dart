import 'package:flutter/material.dart';
import 'package:timestamp/Monatliste.dart';
import 'package:timestamp/loginscreen.dart';
import 'package:timestamp/registrationscreen.dart';
import 'DachCalender.dart';
import 'DachDiagram.dart';
import 'Dashboard.dart';
import 'Dashhome.dart';
import 'Vacation.dart';
import 'UserModel.dart';
import 'Zeitausgleich.dart';
import 'responsive.dart';
import 'header.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
int selectedmenu = 5;
int _selectedIndex = 0;
int _displayScreen2 = 0;
Widget screen1 = Dashhome();
Widget screen2 = DashDiagram();
String _currentTheme = "assets/1.jpg";
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        // The user is not logged in, show the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
  }
  List<String> _menuTitel = [
    "Profile",
    "Kalender",
    "Zeiterfassung",
    "Zeitausgleich",
    "Homeoffice",
    "Urlaub",
    "Krank",
    "MonatListe",
  ];
  List<Icon> _menuIcon = [
    Icon(Icons.person),
    Icon(Icons.calendar_month),
    Icon(Icons.lock_clock),
    Icon(Icons.timer),
    Icon(Icons.home_filled),
    Icon(Icons.holiday_village),
    Icon(Icons.sick),
    Icon(Icons.list)
  ];
  List<String> _themes = [
    "assets/1.jpg",
    "assets/2.jpg",
    "assets/3.jpg",
    "assets/4.jpg",
    "assets/5.jpg",
    "assets/6.jpg",
    "assets/7.jpg",
    "assets/8.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    int flex1 = 1;
    int flex2 = 3;
    int flex3 = 2;
    int flex4 = 5;
    switch (selectedmenu) {
      case 0:
        screen1 = Dashhome();
        _displayScreen2 = 0;
        break;
      case 1:
        screen1 = DashCalender();
        _displayScreen2 = 0;
        break;
      case 2:
        screen1 = Dashhome();
        _displayScreen2 = 0;
        break;
      case 3:
        screen1 = Zeitausgleich();
        _displayScreen2 = 1;
        break;
      case 4:
        screen1 = Dashhome();
        _displayScreen2 = 0;
        break;
      case 5:
        screen1 = Vacation();
        _displayScreen2 = 1;
        break;
      case 6:
        screen1 = Zeitausgleich();
        _displayScreen2 = 1;
        break;
      case 7:
        screen1 = Monatliste();
        _displayScreen2 = 1;
        break;
    }
    if (Responsive.isDesktop(context)) {
      flex1 = 2;
      flex2 = 8;
      flex3 = 5;
      flex4 = 5;
    }
    if (MediaQuery.of(context).size.width <= 1600 &&
        MediaQuery.of(context).size.width >= 1300) {
      setState(() {
        flex1 = 2;
        flex2 = 7;
        flex3 = 3;
        flex4 = 5;
      });
    }
    if (MediaQuery.of(context).size.width <= 1300) {
      setState(() {
        flex1 = 2;
        flex2 = 5;
        flex3 = 4;
        flex4 = 3;
      });
    }
    return Scaffold(
      drawer: sidebarr(),
      body: SizedBox(
        height: double.infinity,
        child: Container(
          decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.softLight,
              color: Colors.black.withOpacity(0.5),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: AssetImage(_currentTheme),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Header(),
              if (Responsive.isDesktop(context)) Container(child: sidebarr()),
              if (Responsive.isDesktop(context) && selectedmenu == 0)
                Expanded(flex: 4, child: screen1),
              if (Responsive.isDesktop(context) && selectedmenu != 0)
                Expanded(flex: flex2, child: screen1),
              if (Responsive.isMobile(context) || Responsive.isTablet(context))
                Expanded(
                    flex: flex2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          screen1,
                          Divider(
                            color: Colors.transparent,
                          ),
                          if (_displayScreen2 == 0 && selectedmenu != 1) screen2
                        ],
                      ),
                    )),
              if (selectedmenu == 0)
                if (Responsive.isDesktop(context))
                  Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            DashCalender(),
                            DashDiagram(),
                          ],
                        ),
                      )),
              /*    if (selectedmenu != 0 && selectedmenu != 1)
                if (Responsive.isDesktop(context))
                  Expanded(flex: flex4, child: Text('')), */
            ]),
          ),
        ),
      ),
    );
  }
  Widget sidebarr() {
    return StreamBuilder<DocumentSnapshot>(
      // Get a stream of document snapshots using the user's UID
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // Check if the snapshot has data
        if (snapshot.hasData) {
          // Get the data from the snapshot
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Drawer(
            width: 250,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  color: Color.fromARGB(80, 43, 181, 216).withOpacity(0.1),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Divider(
                            height: 10,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              data['image'],
                            ),
                            radius: 70,
                          ),
                          Center(
                              child: Text("\n" +
                                  data['firstName'] +
                                  " " +
                                  data['secondName'])),
                          Divider(
                            height: 30,
                            color: Colors.transparent,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _menuTitel.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ListTile(
                              title: Text(_menuTitel[index]),
                              selected: index == _selectedIndex,
                              leading: _menuIcon[index],
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                  selectedmenu = index;
                                });
                              },
                            ),
                          ),
                          GridView.builder(
                            padding: EdgeInsets.all(20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _themes.length,
                            itemBuilder: (BuildContext context, int index) =>
                                GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1),
                              children: [
                                Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(50),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: InkWell(
                                    onTap: (() {
                                      setState(() {
                                        setState(() {
                                          _currentTheme = _themes[index];
                                        });
                                      });
                                    }),
                                    child: Image.asset(
                                      _themes[index],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Container(
                                  child: Column(
                                children: <Widget>[
                                  Divider(
                                    height: 100,
                                    color: Colors.transparent,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.help),
                                    title: Text(
                                      'Help and Feedback',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.logout),
                                    title: Text(
                                      'Log out',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      logout(context);
                                    },
                                  )
                                ],
                              ))),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container(
            width: 150,
            height: 150,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }
}
/* ListTile(
          title: Text(
            "Profil",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          selected: true,
          leading: Icon(
            Icons.person,
          ),
          onTap: () {
            setState(() {
              selectedmenu = 0;
            });
          },
        ),
        ListTile(
          title: Text(
            "Kalender",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: Icon(
            Icons.calendar_month,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Zeiterfassung",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: Icon(
            Icons.lock_clock,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Zeitausgleich",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: Icon(
            Icons.timer,
          ),
          onTap: () {
            setState(() {
              selectedmenu = 2;
            });
          },
        ),
        ListTile(
          title: Text(
            "Homeoffice",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: Icon(
            Icons.home_filled,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Urlaub",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: Icon(
            Icons.holiday_village_rounded,
          ),
          onTap: () {
            setState(() {
              selectedmenu = 1;
            });
          },
        ),
        ListTile(
          title: Text(
            "Krank",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: Icon(
            Icons.sick,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Monatliste",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: Icon(
            Icons.list,
          ),
          onTap: () {},
        ), */
/* 
        ListView(children: [
        Divider(
          height: 10,
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(
            'https://as1.ftcdn.net/v2/jpg/02/09/95/42/1000_F_209954204_mHCvAQBIXP7C2zRl5Fbs6MEWOEkaX3cA.jpg',
          ),
          radius: 70,
        ),
        Center(child: Text("\n Max Muster")),
        Divider(
          height: 30,
          color: Colors.transparent,
        ),
        ListView.builder(
          itemCount: _menuTitel.length,
          itemBuilder: (BuildContext context, int index) =>
              ListTile(title: Text(_menuTitel[index])),
        ),
        Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
                child: Column(
              children: <Widget>[
                Divider(
                  height: 250,
                  color: Colors.transparent,
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text(
                    'Help and Feedback',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Log out',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {},
                )
              ],
            ))),
      ]), */
