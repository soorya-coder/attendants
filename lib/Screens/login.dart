import 'package:attendants/constants/functions.dart';
import 'package:attendants/constants/wigets.dart';
import 'package:attendants/object/register.dart';
import 'package:attendants/service/authHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _LoginState extends State<Login> {

  List<Widget> page = [const firstpage(),const secondpage()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  'Attendants',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/logpic.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Attending Made Simple, Memories Made Rich',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.black54,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 50),
                child: InkWell(
                  onTap: (){
                    AuthHelper().signInGoogle();
                  },
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.blueAccent,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.deepOrangeAccent,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          const Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                child: Text(
                                  'Sign in with google',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


int np = 1;

List<bool> page = [true,false,false];

class _firstpageState extends State<firstpage> {

  List<Register> det = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.redAccent.withOpacity(0.2),
            Colors.redAccent.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
            child: Column(
              children:  [
                const Text('Enter your details',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                hspace(20),
                TextField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person,color: Colors.redAccent.shade700,),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.8))
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.2),width: 2)
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Username',
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.redAccent.withOpacity(0.5)),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                  onChanged: (String name){
                    setState(() {
                      pname = name;
                    });
                  },
                ),
                hspace(20),
                TextField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.building_2_fill,color: Colors.redAccent.shade700,),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.8))
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.2),width: 2)
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Name of Institution',
                    labelText: 'Institution',
                    labelStyle: TextStyle(color: Colors.redAccent.withOpacity(0.5)),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                  onChanged: (instition){
                    setState(() {
                      pinstut = instition;
                    });
                  },
                ),
                hspace(20,),
                TextField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    suffix: const Text('@gmail.com'),
                    prefixIcon: Icon(Icons.email_outlined,color: Colors.redAccent.shade700,),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.8))
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.2),width: 2)
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Useremail',
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.redAccent.withOpacity(0.5)),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                  onChanged: (email){
                    setState(() {
                      pemail = email;
                    });
                  },
                ),
                hspace(30),
                Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () async{
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.setString('pname', pname);
                        pref.setString('pinstution', pinstut);
                        pref.setString('pemail', pemail);

                        route(context, screens[inrout]);
                        /*setState(() {
                    np = 1;
                  });*/

                      },
                      child: SizedBox(
                        width: 120,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.redAccent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Next',style: TextStyle(fontSize: 20,color: Colors.white70,),),
                              wspace(10),
                              const Icon(CupertinoIcons.arrow_right,color: Colors.white70,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    wspace(20),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _secondpageState extends State<secondpage> {

  List<Register> det = [];

  @override
  void initState() {
    super.initState();
    det = [
      Register(type: 'Spr number', yn: true),
      Register(type: 'Name', yn: false),
      Register(type: 'Register number', yn: true)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.redAccent.withOpacity(0.2),
            Colors.redAccent.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 50,bottom: 50,left: 20,right: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children:  [
                  const Text('Select register details',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  hspace(20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: det.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(det.elementAt(index).type),
                        leading: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.red,
                          focusColor: Colors.yellowAccent,
                          hoverColor: Colors.redAccent,
                          value: det.elementAt(index).yn,
                          onChanged: (bool? value) {
                            setState(() {
                              det.elementAt(index).yn = value!;
                            });
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: InkWell(
                  onTap: () {
                    /*setState(() {
                      np--;
                    });

                     */
                  },
                  child: SizedBox(
                    width: 120,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.redAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Next ',style: TextStyle(fontSize: 20,color: Colors.white70,),),
                          wspace(10),
                          const Icon(CupertinoIcons.arrow_right,color: Colors.white70,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class secondpage extends StatefulWidget {
  const secondpage({Key? key}) : super(key: key);

  @override
  _secondpageState createState() => _secondpageState();
}

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  _firstpageState createState() => _firstpageState();
}
