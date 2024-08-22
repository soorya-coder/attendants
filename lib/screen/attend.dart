import 'package:attendants/constants/functions.dart';
import 'package:attendants/main.dart';
import 'package:attendants/object/classes.dart';
import 'package:attendants/screen/today.dart';
import 'package:attendants/service/stuHelper.dart';
import 'package:attendants/service/todHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../constants/color.dart';
import '../constants/wigets.dart';
import '../object/stu.dart';
import '../object/stuab.dart';

class Attend extends StatefulWidget {
  Attend(
      {super.key,
      required this.classes,
      required this.date,
      required this.period});
  Classes classes;
  String date;
  int period;

  @override
  State<Attend> createState() => _AttendState();
}

class _AttendState extends State<Attend> {
  late Classes classes;
  late StuHelper stuHelper;
  late TodHelper todHelper;
  late String date;
  late int period;
  List<Stu> unmarkedstu = [], markedstu = [];
  List<Stuab> markedab = [];
  List<bool> hd = [];
  bool uml = true, ml = true, isload = true;

  @override
  Widget build(BuildContext context) {
    classes = widget.classes;
    stuHelper = StuHelper(cid: classes.id!);
    date = widget.date;
    period = widget.period;
    todHelper = TodHelper(cid: classes.id!, period: widget.period);

    return PopScope(
      canPop: false,
      onPopInvoked: (dp) {
        route(context, const Today());
        msg('Attendants was discarded');
      },
      child: StreamBuilder<List<Stuab>>(
          stream: todHelper.getlist(),
          builder: (context, AsyncSnapshot<List<Stuab>> absnap) {
            if (absnap.hasData) {
              return StreamBuilder<List<Stu>>(
                  stream: stuHelper.getlist(),
                  builder: (context, AsyncSnapshot<List<Stu>> snapshot) {
                    if (snapshot.hasData) {
                      //List<Stu> unmarkedstu = [], markedstu = [];
                      unmarkedstu = snapshot.data!;
                      hd = [];

                      for (int i = 0; i < unmarkedstu.length; i++) {
                        hd.add(true);
                        Stu stu = unmarkedstu[i];
                        for (Stu st in markedstu) {
                          if (st.id == stu.id) {
                            hd[i] = false;
                            break;
                          }
                        }

                        for (Stuab stuab in absnap.data!) {
                          if (stuab.sid == stu.id) {
                            hd[i] = false;
                            break;
                          }
                        }
                      }

                      return Scaffold(
                        appBar: AppBar(
                          title: const Text('Mark your attendants'),
                        ),
                        body: Stack(
                          children: [
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.redAccent.withOpacity(0.2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.red.withOpacity(0.2),
                                          offset: const Offset(4.0, 5.0),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        const BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: RichText(
                                            text: TextSpan(
                                              style: GoogleFonts.rubik(
                                                color: Colors.grey,
                                              ),
                                              children: [
                                                const TextSpan(
                                                    text: 'Mark your '),
                                                TextSpan(
                                                    text:
                                                        ' [$todate] ($period) \n',
                                                    style: const TextStyle(
                                                        color: Colors.brown)),
                                                const TextSpan(
                                                    text: 'Attendents \n',
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                  text:
                                                      'No. of students = ${snapshot.data!.length}\n',
                                                  style: const TextStyle(
                                                    color: Colors.brown,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${depl[depl.indexOf(classes.dep)]} - ${yearl[classes.year - 1]} (${secl[secl.indexOf(classes.sec)]})',
                                                  style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        wspace(10),
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h,
                                                horizontal: 10.w),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.r)),
                                            ),
                                            child: Material(
                                              elevation: 50,
                                              color: Colors.transparent,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 20,
                                                        child: Icon(
                                                          IconlyBold.heart,
                                                          color:
                                                              Colors.lightGreen,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text: 'pr ',
                                                                  style: GoogleFonts.rubik(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16)),
                                                              TextSpan(
                                                                  text: 'P',
                                                                  style: GoogleFonts
                                                                      .rubik(
                                                                          fontSize:
                                                                              16)),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  hspace(10),
                                                  Row(
                                                    children: [
                                                      const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 20,
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .heart_slash_fill,
                                                          color:
                                                              Colors.redAccent,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text: 'ab ',
                                                                  style: GoogleFonts.rubik(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16)),
                                                              TextSpan(
                                                                  text: 'A',
                                                                  style: GoogleFonts
                                                                      .rubik(
                                                                          fontSize:
                                                                              16)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      wspace(20),
                                      Text(
                                        'Students list',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: cr_brown),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    indent: 20,
                                    endIndent: 20,
                                    height: 0,
                                    thickness: 0.5,
                                    color: Colors.brown,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        Stu stu = snapshot.data![index];
                                        Stuab? stuab;
                                        for (Stuab ab in absnap.data!) {
                                          if (ab.sid == stu.id) {
                                            stuab = ab;
                                          }
                                        }

                                        for (Stuab ab in markedab) {
                                          if (ab.sid == stu.id) {
                                            stuab = ab;
                                          }
                                        }
                                        return Column(
                                          children: [
                                            hspace(2),
                                            Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 16, 0),
                                                child: Row(
                                                  children: [
                                                    wspace(10),
                                                    Expanded(
                                                      flex: 1,
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors
                                                            .yellow.shade700
                                                            .withOpacity(0.8),
                                                        child: Text(
                                                          stu.name
                                                              .substring(0, 1),
                                                          style: GoogleFonts
                                                              .catamaran(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    wspace(16),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            stu.name,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                                style:
                                                                    GoogleFonts
                                                                        .rubik(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                children: [
                                                                  const TextSpan(
                                                                      text:
                                                                          'Spr no: '),
                                                                  TextSpan(
                                                                      text: stu
                                                                          .sprno,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  const TextSpan(
                                                                      text:
                                                                          ' | \ns',
                                                                      style:
                                                                          TextStyle()),
                                                                  const TextSpan(
                                                                      text:
                                                                          'Reg no: '),
                                                                  TextSpan(
                                                                      text: stu
                                                                          .regno,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ]),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: stuab ==
                                                          null ? CupertinoSwitch(
                                                          value: false,
                                                          activeColor: cr_grey.withOpacity(0.2),
                                                          onChanged: (val) {
                                                            if (val) {
                                                              markedab.add(
                                                                Stuab(
                                                                  sid: stu.id!,
                                                                  cid: stu.clid,
                                                                  isPresent:
                                                                  'P',
                                                                  period:
                                                                  period,
                                                                  date: date,
                                                                ),
                                                              );
                                                              setState(() {});
                                                            } else {
                                                              markedab.add(
                                                                Stuab(
                                                                  sid: stu.id!,
                                                                  cid: stu.clid,
                                                                  isPresent:
                                                                  'A',
                                                                  period:
                                                                  period,
                                                                  date: date,
                                                                ),
                                                              );
                                                              setState(() {});
                                                            }
                                                          }) : CupertinoSwitch(
                                                          value: stuab.isPresent ==
                                                                  'P',
                                                          onLabelColor: cr_green,
                                                          offLabelColor: cr_red,
                                                          onChanged: (val) {
                                                            if (val) {
                                                              markedab.add(
                                                                Stuab(
                                                                  sid: stu.id!,
                                                                  cid: stu.clid,
                                                                  isPresent:
                                                                      'P',
                                                                  period:
                                                                      period,
                                                                  date: date,
                                                                ),
                                                              );
                                                              setState(() {});
                                                            } else {
                                                              markedab.add(
                                                                Stuab(
                                                                  sid: stu.id!,
                                                                  cid: stu.clid,
                                                                  isPresent:
                                                                      'A',
                                                                  period:
                                                                      period,
                                                                  date: date,
                                                                ),
                                                              );
                                                              setState(() {});
                                                            }
                                                          }),
                                                    ),
                                                  ],
                                                )),
                                            hspace(10),
                                            const Divider(
                                              indent: 20,
                                              endIndent: 20,
                                              height: 0,
                                              thickness: 0.5,
                                              color: Colors.brown,
                                            )
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    if (snapshot.hasError)
                      return Errored(error: snapshot.error.toString());
                    return const Loading();
                  });
            }
            return const Loading();
          }),
    );
  }
}
