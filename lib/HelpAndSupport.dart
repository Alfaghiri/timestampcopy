import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
       
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                color: Color.fromARGB(0, 201, 243, 13),
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height: 200,
                            child: Image.asset(
                              "assets/logo.png",
                              fit: BoxFit.contain,
                            )),
                        Divider(height: 30, color: Colors.transparent),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Diese App ist so intuitiv gestaltet, dass der Benutzer \n sie ohne Hilfe oder Anweisungen bedienen kann.\n Sollten dennoch Fragen oder Unklarheiten auftreten, steht unsere \n Unterstützung jederzeit zur Verfügung.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                         
                                    fontWeight: FontWeight.normal,
                                    fontSize: 24),
                              ),
                              Divider(height: 100,
                              color: Colors.transparent,),
                              ElevatedButton.icon(
                                icon: Icon(Icons.email_rounded),
                                label: Text('Nouzad Mohammad'),
                                onPressed: () {
                                  launch(
                                      'mailto: nouzad.Mohammad@stud.sbg.ac.at?subject=Support');
                                },
                              ),
                             Divider(height: 50,
                              color: Colors.transparent,),
                              ElevatedButton.icon(
                                icon: Icon(Icons.email_rounded),
                                label: Text('Abdul Wahhab Alfaghiri Al Anzi'),
                                onPressed: () {
                                  launch(
                                      'mailto: abdul.alfaghiri-al-anzi@stud.sbg.ac.at?subject=Support');
                                },
                              ),
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}