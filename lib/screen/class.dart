// ignore_for_file: deprecated_member_use, camel_case_types

import 'package:attendants/Screens/students.dart';
import 'package:attendants/constants/color.dart';
import 'package:attendants/constants/functions.dart';
import 'package:attendants/constants/wigets.dart';
import 'package:attendants/main.dart';
import 'package:attendants/object/classes.dart';
import 'package:attendants/service/authHelper.dart';
import 'package:attendants/service/classHelper.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendants/constants/Drawer.dart';
import 'package:attendants/constants/Bottom%20bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Class extends StatefulWidget {
  const Class({Key? key}) : super(key: key);

  @override
  _ClassState createState() => _ClassState();
}

class _ClassState extends State<Class> {
  @override
  void initState() {
    super.initState();
    getclsindex();
  }

  bool addview = false;
  int clsindex = 0;
  int clindex = 0;
  ClassHelper classHelper = ClassHelper();

  void setclsindex(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('clsindex', index);
    clsindex = (pref.getInt('clsindex') ?? 0);
  }

  void getclsindex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    clsindex = (pref.getInt('clsindex') ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/home');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Class'),
          backgroundColor: cr_amber,
          actions: [
            Chip(
              label: Text('cse ii'),
              backgroundColor: Colors.cyan,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.ellipsis_vertical),
            ),
          ],
        ),
        drawer: drawer(
          headcolor: Colors.orangeAccent,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.rubik(color: Colors.black26),
                    children: const [
                      TextSpan(
                          text: 'Select your', style: TextStyle(fontSize: 20)),
                      TextSpan(
                          text: ' class ',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: 'for attendents',
                          style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),
              StreamBuilder<List<Classes>>(
                  stream: classHelper.getlist(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Classes>> snapshot) {
                    if (!snapshot.hasError) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          List<Classes> claslist = snapshot.data!;
                          return RefreshIndicator(
                            onRefresh: () async {
                              await Future.delayed(const Duration(seconds: 2));
                              setState(() {});
                            },
                            color: Colors.amber.shade400,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.only(top: 20.h),
                              itemCount: claslist.length,
                              itemBuilder: (context, index) {
                                Classes clas = claslist.elementAt(index);
                                /*FutureBuilder(
                                future: studata.instance.getlist(),
                                builder: (context,AsyncSnapshot snapstu){
                                  if(snapstu.hasData){
                                    List<Stu> data = snapstu.data ?? [];
                                    List<Stu> stulist = [];
                                    for (var element in data) {
                                      if(clas.id == element.clid) {
                                        stulist.add(element);
                                      }
                                    }
                                    return Slidable(
                                      endActionPane: ActionPane(motion: const ScrollMotion(), children:  [
                                        MaterialButton(
                                          color: Colors.redAccent.withOpacity(0.15),
                                          elevation: 0,
                                          height: 50,
                                          minWidth: 50,
                                          shape: const CircleBorder(),
                                          child: Icon(Icons.center_focus_strong, color: Colors.redAccent.shade200, size: 30,),
                                          onPressed: () {
                                            setState(() {
                                              setclsindex(index);
                                              //classdata.instance.upfocus(clas.id!);
                                              //clas.deindex = 1;
                                            });
                                          },
                                        ),
                                        MaterialButton(
                                          color: Colors.blue.withOpacity(0.15),
                                          elevation: 0,
                                          height: 50,
                                          minWidth: 50,
                                          shape: const CircleBorder(),
                                          child: const Icon(IconlyBold.delete, color: Colors.blue, size: 30,),
                                          onPressed: () {
                                            setState(() {
                                              //classdata.instance.remove(clas.id!);
                                            });
                                          },
                                        ),
                                      ]),
                                      child: InkWell(
                                        onTap: (){
                                          route(
                                              context,
                                              student(
                                                classs: clas,
                                                stulist: stulist,
                                              )
                                          );
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                            width: double.maxFinite,
                                            height: 90.h,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                                              color: Colors.purpleAccent,
                                              gradient: LinearGradient(
                                                colors: [
                                                  depcl[clas.dep].withOpacity(0.5),
                                                  yearcl[clas.year].withOpacity(0.2)
                                                ],
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        hspace(15),
                                                        Expanded(
                                                          flex: 4,
                                                          child: CircleAvatar(
                                                            backgroundColor: depcl[clas.dep],
                                                            foregroundColor: Colors.white,
                                                            child: Text(year[clas.year],style: GoogleFonts.rubik(fontWeight: FontWeight.bold),),
                                                          ),
                                                        ),
                                                        hspace(5),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text.rich(
                                                                  TextSpan(
                                                                    style: GoogleFonts.rubik(color: Colors.white70),
                                                                    children: [
                                                                      TextSpan(text: dep[clas.dep], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                                      const TextSpan(text: ' - ', style: TextStyle(fontSize: 10),),
                                                                      TextSpan(text: year[clas.year], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text.rich(
                                                                      TextSpan(
                                                                        style: GoogleFonts.rubik(color: Colors.black26),
                                                                        children: [
                                                                          const TextSpan(
                                                                            text: 'Number of student : ',
                                                                            style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,letterSpacing: 2),
                                                                          ),
                                                                          TextSpan(
                                                                              text: '${stulist.length}',
                                                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900,color: cr_brown)
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const Spacer(),
                                                                    RichText(
                                                                      text: TextSpan(
                                                                        style: GoogleFonts.rubik(color: Colors.brown),
                                                                        children: [
                                                                          const TextSpan(text: 'Faculty : ', style: TextStyle(fontSize: 9,),),
                                                                          TextSpan(text: pname, style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            )
                                                        ),
                                                        hspace(15),
                                                      ]
                                                  ),
                                                ),
                                                Container(
                                                  child: /*clas.deindex*/ 0 == 1 ?  Positioned(
                                                    top: 0,
                                                    right: 1,
                                                    child: Container(
                                                        width: 35,
                                                        height: 35,
                                                        decoration: const BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(20),
                                                              topLeft: Radius.circular(0),
                                                              bottomLeft: Radius.circular(10),
                                                              bottomRight: Radius.circular(0)
                                                          ),
                                                        ),
                                                        child: const Icon(IconlyBold.show,size: 20,color: Colors.white,)
                                                    ),
                                                  ) : null,
                                                ),
                                              ],
                                            )
                                          /*Stack(
                                      children: [
                                        ListTile(
                                          contentPadding: const EdgeInsets.fromLTRB(16, 70, 10, 10),
                                          title: RichText(
                                            text: TextSpan(
                                              style: GoogleFonts.rubik(color: Colors.white70),
                                              children: [
                                                TextSpan(text: dep[clas.dep], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                const TextSpan(text: ' - ', style: TextStyle(fontSize: 10),),
                                                TextSpan(text: year[clas.year], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          subtitle: Text.rich(
                                            TextSpan(
                                              style: GoogleFonts.rubik(color: Colors.black26),
                                              children: [
                                                const TextSpan(
                                                  text: 'Number of student : ',
                                                  style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,letterSpacing: 2),
                                                ),
                                                TextSpan(
                                                  text: '${stulist.data!.length}',
                                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900,color: cr_brown)
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          left: 10,
                                          child: CircleAvatar(
                                            backgroundColor: depcl[clas.dep],
                                            foregroundColor: Colors.white,
                                            child: Text(year[clas.year],style: GoogleFonts.rubik(fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                        Container(
                                          child: clas.deindex == 1 ?  Positioned(
                                            top: 0,
                                            right: 1,
                                            child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(20),
                                                      topLeft: Radius.circular(0),
                                                      bottomLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(0)
                                                  ),
                                                ),
                                                child: const Icon(FontAwesomeIcons.eye,size: 20,color: Colors.white,)
                                            ),
                                          ) : null,
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: RichText(
                                            text: TextSpan(
                                              style: GoogleFonts.rubik(color: Colors.brown),
                                              children: [
                                                const TextSpan(text: 'Faculty : ', style: TextStyle(fontSize: 9,),),
                                                TextSpan(text: pname, style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                     */
                                        ),
                                      ),
                                    );
                                  }else {
                                    return Center(
                                      child: JumpingDotsProgressIndicator(
                                        fontSize: 40.0,
                                        color: depcl[clas.dep],
                                      ),
                                    );
                                  }
                                },
                              )*/
                                if (clas.oid != AuthHelper.myuser!.uid)
                                  return const SizedBox();
                                return Slidable(
                                  endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        MaterialButton(
                                          color: Colors.redAccent
                                              .withOpacity(0.15),
                                          elevation: 0,
                                          height: 50,
                                          minWidth: 50,
                                          shape: const CircleBorder(),
                                          child: Icon(
                                            Icons.center_focus_strong,
                                            color: Colors.redAccent.shade200,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              //setclsindex(index);
                                              ClassHelper.setfocus(clas);
                                              //clas.deindex = 1;
                                            });
                                          },
                                        ),
                                        MaterialButton(
                                          color: Colors.blue.withOpacity(0.15),
                                          elevation: 0,
                                          height: 50,
                                          minWidth: 50,
                                          shape: const CircleBorder(),
                                          child: const Icon(
                                            IconlyBold.delete,
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              classHelper.delete(clas);
                                              msg('Class Deleted');
                                            });
                                          },
                                        ),
                                      ],
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.sp)),
                                    onTap: () {
                                      route(context, Student(classs: clas));
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        width: double.maxFinite,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.purpleAccent,
                                          gradient: LinearGradient(
                                            colors: [
                                              depcl[depl.indexOf(clas.dep)]
                                                  .withOpacity(0.5),
                                              yearcl[clas.year].withOpacity(0.2)
                                            ],
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    hspace(15),
                                                    Expanded(
                                                      flex: 4,
                                                      child: CircleAvatar(
                                                        backgroundColor: depcl[
                                                            depl.indexOf(
                                                                clas.dep)],
                                                        foregroundColor:
                                                            Colors.white,
                                                        child: Text(
                                                          yearl[clas.year],
                                                          style:
                                                              GoogleFonts.rubik(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    hspace(5),
                                                    Expanded(
                                                        flex: 5,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text.rich(
                                                              TextSpan(
                                                                style: GoogleFonts.rubik(
                                                                    color: Colors
                                                                        .white70),
                                                                children: [
                                                                  TextSpan(
                                                                    text: clas
                                                                        .dep,
                                                                    style: TextStyle(
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  TextSpan(
                                                                    text: ' - ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            8.sp),
                                                                  ),
                                                                  TextSpan(
                                                                    text: yearl[
                                                                        clas.year],
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: ' (',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                      text: clas
                                                                          .sec,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      )),
                                                                  TextSpan(
                                                                    text: ') ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14.sp),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text.rich(
                                                                  TextSpan(
                                                                    style: GoogleFonts.rubik(
                                                                        color: Colors
                                                                            .black26),
                                                                    children: [
                                                                      const TextSpan(
                                                                        text:
                                                                            'Number of student : ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            letterSpacing: 2),
                                                                      ),
                                                                      TextSpan(
                                                                          text:
                                                                              '12',
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w900,
                                                                              color: cr_brown)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    style: GoogleFonts.rubik(
                                                                        color: Colors
                                                                            .brown),
                                                                    children: [
                                                                      const TextSpan(
                                                                        text:
                                                                            'Faculty : ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              9,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                          text: AuthHelper
                                                                              .myuser!
                                                                              .displayName!,
                                                                          style: const TextStyle(
                                                                              fontSize: 11,
                                                                              fontWeight: FontWeight.bold)),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                    hspace(15),
                                                  ]),
                                            ),
                                            FutureBuilder<String>(
                                                future: ClassHelper.getfocus(),
                                                builder: (context,
                                                    AsyncSnapshot<String>
                                                        snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Container(
                                                      child:
                                                          clas.id ==
                                                                  snapshot.data
                                                              ? Positioned(
                                                                  top: 0,
                                                                  right: 1,
                                                                  child: Container(
                                                                      width: 35,
                                                                      height: 35,
                                                                      decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius: BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(20),
                                                                            topLeft: Radius.circular(0),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(0)),
                                                                      ),
                                                                      child: const Icon(
                                                                        IconlyBold
                                                                            .show,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                )
                                                              : null,
                                                    );
                                                  }
                                                  return const SizedBox();
                                                }),
                                          ],
                                        )
                                        /*Stack(
                                      children: [
                                        ListTile(
                                          contentPadding: const EdgeInsets.fromLTRB(16, 70, 10, 10),
                                          title: RichText(
                                            text: TextSpan(
                                              style: GoogleFonts.rubik(color: Colors.white70),
                                              children: [
                                                TextSpan(text: dep[clas.dep], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                const TextSpan(text: ' - ', style: TextStyle(fontSize: 10),),
                                                TextSpan(text: year[clas.year], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          subtitle: Text.rich(
                                            TextSpan(
                                              style: GoogleFonts.rubik(color: Colors.black26),
                                              children: [
                                                const TextSpan(
                                                  text: 'Number of student : ',
                                                  style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,letterSpacing: 2),
                                                ),
                                                TextSpan(
                                                  text: '${stulist.data!.length}',
                                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900,color: cr_brown)
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          left: 10,
                                          child: CircleAvatar(
                                            backgroundColor: depcl[clas.dep],
                                            foregroundColor: Colors.white,
                                            child: Text(year[clas.year],style: GoogleFonts.rubik(fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                        Container(
                                          child: clas.deindex == 1 ?  Positioned(
                                            top: 0,
                                            right: 1,
                                            child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(20),
                                                      topLeft: Radius.circular(0),
                                                      bottomLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(0)
                                                  ),
                                                ),
                                                child: const Icon(FontAwesomeIcons.eye,size: 20,color: Colors.white,)
                                            ),
                                          ) : null,
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: RichText(
                                            text: TextSpan(
                                              style: GoogleFonts.rubik(color: Colors.brown),
                                              children: [
                                                const TextSpan(text: 'Faculty : ', style: TextStyle(fontSize: 9,),),
                                                TextSpan(text: pname, style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                     */
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('You have no classes'),
                          );
                        }
                      } else {
                        return Center(
                          child: LoadingAnimationWidget.newtonCradle(
                            color: Colors.blue,
                            size: 30.r,
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                          style: TextStyle(
                              color: Colors.redAccent.withOpacity(0.5)),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
        bottomNavigationBar: bottom_bar(context, 2, Colors.orangeAccent),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            routename(context, '/addclass');
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.orangeAccent.shade100,
          child: const Icon(
            CupertinoIcons.collections_solid,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
/*
  Widget mainview(){
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.rubik(color: Colors.black26),
              children: const [
                TextSpan(text: 'Select your',style: TextStyle(fontSize: 20)),
                TextSpan(text: ' class ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                TextSpan(text: 'for attendents',style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: classdata.instance.getlist(),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                List<Classes> classs = snapshot.data;
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 30),
                  shrinkWrap: true,
                  itemCount: classs.length,
                  itemBuilder: (BuildContext context,int index){
                    Classes clas = classs.elementAt(index);
                    return Slidable(
                      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
                        MaterialButton(
                          color: Colors.redAccent.withOpacity(0.15),
                          elevation: 0,
                          height: 50,
                          minWidth: 50,
                          shape: const CircleBorder(),
                          child: Icon(Icons.center_focus_strong, color: Colors.redAccent.shade200, size: 30,),
                          onPressed: () {setclsindex(index);},
                        ),
                        MaterialButton(
                          color: Colors.blue.withOpacity(0.15),
                          elevation: 0,
                          height: 50,
                          minWidth: 50,
                          shape: const CircleBorder(),
                          child: const Icon(Icons.edit, color: Colors.blue, size: 30,),
                          onPressed: () {

                          },
                        ),
                      ]),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: Colors.purpleAccent,
                          gradient: LinearGradient(
                            colors: [
                              depcl[index].withOpacity(0.5),
                              depcl[index].withOpacity(0.2)
                            ],
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.fromLTRB(16, 70, 10, 10),
                              title: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.rubik(color: Colors.white70),
                                  children: [
                                    TextSpan(text: dep[clas.dep], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    const TextSpan(text: ' - ', style: TextStyle(fontSize: 10),),
                                    TextSpan(text: year[clas.year], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              subtitle: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.rubik(color: Colors.black26),
                                  children: const [
                                    TextSpan(text: 'Number of student', style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                    TextSpan(text: ' : ', style: TextStyle(fontSize: 5),),
                                    TextSpan(text: '50', style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 10,
                              child: CircleAvatar(
                                backgroundColor: depcl[index],
                                foregroundColor: Colors.white,
                                child: Text(dep[clas.dep].substring(0,1),style: GoogleFonts.rubik(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Container(
                              child: clsindex==index ?  Positioned(
                                top: 0,
                                right: 1,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(0),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(0)
                                      ),
                                    ),
                                    child: const Icon(FontAwesomeIcons.eye,size: 20,color: Colors.white,)
                                ),
                              ) : null,
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.rubik(color: Colors.brown),
                                  children: const [
                                    TextSpan(text: 'Faculty : ', style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                    TextSpan(text: 'clas.teacher', style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }else {
              return const Center(
                child: Text('no connection'),
              );
            }
          }
        ),
      ],
    );
  }
*/
}

class _Add_classState extends State<Add_class> {
  int seldep = 0;
  int selyr = 0;
  int selsec = 0;

  ClassHelper classHelper = ClassHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add class'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/class');
            },
            icon: const Icon(IconlyBroken.arrow_left_2)),
        backgroundColor: Colors.orange.withOpacity(0.5),
        actions: [
          option(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10.h),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(top: 10),
                  width: double.maxFinite,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.rubik(color: Colors.black),
                      children: const [
                        TextSpan(
                            text: 'Select ',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        TextSpan(
                            text: 'department',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' of this class',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: GridView.count(
                    crossAxisCount: 4,
                    physics: const BouncingScrollPhysics(),
                    children: List.generate(depl.length, (index) {
                      return Container(
                        width: 100,
                        height: 50,
                        margin: const EdgeInsets.all(10),
                        decoration: seldep == index
                            ? BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    depcl.elementAt(index).withOpacity(0.6),
                                    depcl.elementAt(index).withOpacity(0.3)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              )
                            : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: seldep == index
                                    ? Border.all()
                                    : Border.all(
                                        width: 1,
                                        color: depcl
                                            .elementAt(index)
                                            .withOpacity(1)),
                              ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            setState(() {
                              seldep = index;
                            });
                          },
                          child: Center(child: Text(depl.elementAt(index))),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.rubik(color: Colors.black),
                      children: const [
                        TextSpan(
                            text: 'Select  ',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        TextSpan(
                            text: 'Year',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '  of this class',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: yearl.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          onTap: () {
                            setState(() {
                              selyr = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 5.w),
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10.w),
                            decoration: selyr == index
                                ? BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    gradient: LinearGradient(
                                      colors: [
                                        yearcl
                                            .elementAt(index)
                                            .withOpacity(0.2),
                                        yearcl
                                            .elementAt(index)
                                            .withOpacity(0.7),
                                      ],
                                    ),
                                  )
                                : BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(
                                        color: yearcl.elementAt(index))),
                            child: Center(
                              child: Text('${yearl.elementAt(index)} year'),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.rubik(color: Colors.black),
                      children: const [
                        TextSpan(
                            text: 'Select  ',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        TextSpan(
                            text: 'Section',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '  of this class',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: secl.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          onTap: () {
                            setState(() {
                              selsec = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 5.w),
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10.w),
                            decoration: selsec == index
                                ? BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    gradient: LinearGradient(
                                      colors: [
                                        cl[index].withOpacity(0.2),
                                        cl[index].withOpacity(0.7),
                                      ],
                                    ),
                                  )
                                : BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(color: cl[index])),
                            child: Center(
                              child: Text("'${secl[index]}'"),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: AvatarGlow(
        glowColor: Colors.brown,
        child: FloatingActionButton(
            onPressed: () {
              ClassHelper().create(seldep, selyr, selsec).then((val) {
                msg('Class created');
              }, onError: (e) {
                route(context, Errored(error: e.toString()));
              });
              routename(context, '/class');
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.amber.shade800,
            child: const Icon(
              FontAwesomeIcons.check,
            )),
      ),
    );
  }
}

class Add_class extends StatefulWidget {
  const Add_class({super.key});

  @override
  _Add_classState createState() => _Add_classState();
}
