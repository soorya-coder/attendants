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

class Attend extends StatelessWidget {
  Attend(
      {super.key,
        required this.classes,
        required this.date,
        required this.period});
  Classes classes;
  String date;
  int period;
  late StuHelper stuHelper;
  late TodHelper todHelper;

  @override
  Widget build(BuildContext context) {
    stuHelper = StuHelper(cid: classes.id!);
    todHelper = TodHelper(cid: classes.id!, period: period);

    return PopScope(
      canPop: false,
      onPopInvoked: (dp) {
        route(context, const Today());
        msg('Attendants was discarded');
      },
      child: StreamBuilder<List<Stuab>>(
        stream: todHelper.getlist(),
        builder: (context, AsyncSnapshot<List<Stuab>> snapab) {
          return StreamBuilder<List<Stu>>(
            stream: stuHelper.getlist(),
            builder: (context, AsyncSnapshot<List<Stu>> snapstu) {
              if (snapstu.hasData && snapab.hasData) {

                List<Stuab> stuabs=[];
                snapstu.data!.forEach((stu){
                  stuabs.add(Stuab(sid: stu.id!, cid: stu.clid, isPresent: 'A', period: period, date: date));
                });

                snapab.data!.forEach((stuab1) {
                  for (Stuab stuab2 in stuabs) {
                    if(stuab1.sid==stuab2.sid){
                      stuab2.isPresent = stuab1.isPresent;
                    }
                  }
                });

                return Attendbody(
                  classes: classes,
                  date: date,
                  period: period,
                  stuabs: stuabs,
                  stus: snapstu.data!,
                );
              }
              if (snapstu.hasError) {
                return Errored(error: snapstu.error.toString());
              }
              return const Loading();
            },
          );
        },
      ),
    );
  }
}


class Attendbody extends StatefulWidget {
  Attendbody({
    super.key,
    required this.classes,
    required this.date,
    required this.period,
    required this.stuabs,
    required this.stus,
  });
  Classes classes;
  String date;
  int period;
  List<Stuab> stuabs;
  List<Stu> stus;

  @override
  State<Attendbody> createState() => _AttendbodyState();
}

class _AttendbodyState extends State<Attendbody> {
  late Classes classes;
  late TodHelper todHelper;
  late String date;
  late int period;
  late List<Stuab> stuabs;
  late List<Stu> stus;

  @override
  Widget build(BuildContext context) {
    classes = widget.classes;
    date = widget.date;
    period = widget.period;
    todHelper = TodHelper(cid: classes.id!, period: period);
    stuabs = widget.stuabs;
    stus = widget.stus;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark your attendants'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              margin:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.rubik(
                          color: Colors.grey,
                        ),
                        children: [
                          const TextSpan(text: 'Mark your '),
                          TextSpan(
                              text: ' [$todate] ($period) \n',
                              style: const TextStyle(color: Colors.brown)),
                          const TextSpan(
                              text: 'Attendents \n',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: 'No. of students = ${stuabs.length}\n',
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
                          vertical: 5.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.r)),
                      ),
                      child: Material(
                        elevation: 50,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(
                                    IconlyBold.heart,
                                    color: Colors.lightGreen,
                                    size: 20,
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'pr ',
                                            style: GoogleFonts.rubik(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        TextSpan(
                                            text: 'P',
                                            style: GoogleFonts.rubik(
                                                fontSize: 16)),
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
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(
                                    CupertinoIcons.heart_slash_fill,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'ab ',
                                            style: GoogleFonts.rubik(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        TextSpan(
                                            text: 'A',
                                            style: GoogleFonts.rubik(
                                                fontSize: 16)),
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stuabs.length,
                itemBuilder: (context, index) {
                  Stuab stuab = stuabs[index];
                  Stu stu = stus[index];
                  return Column(
                    children: [
                      hspace(2),
                      Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 16, 0),
                          child: Row(
                            children: [
                              wspace(10),
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundColor: Colors.yellow.shade700
                                      .withOpacity(0.8),
                                  child: Text(
                                    stu.name.substring(0, 1),
                                    style: GoogleFonts.catamaran(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              wspace(16),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      stu.name,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: GoogleFonts.rubik(
                                            color: Colors.black,
                                          ),
                                          children: [
                                            const TextSpan(
                                                text: 'Spr no: '),
                                            TextSpan(
                                                text: stu.sprno,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const TextSpan(
                                                text: ' | \ns',
                                                style: TextStyle()),
                                            const TextSpan(
                                                text: 'Reg no: '),
                                            TextSpan(
                                                text: stu.regno,
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
                                child: CupertinoSwitch(
                                  value: stuab.isPresent=='P',
                                  onLabelColor: cr_green,
                                  offLabelColor: cr_red,
                                  activeColor: cr_grey.withOpacity(0.2),
                                  onChanged: (val) {
                                    stuabs.elementAt(index).isPresent =
                                        val ? 'P' : 'A';
                                    setState(() {});
                                  },
                                ),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    await todHelper.setlist(stuabs);
                    route(context, const Today());
                    msg('Attendants is saved');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r)
                    ),
                    elevation: 4.r,
                    margin: EdgeInsets.symmetric(horizontal: 0.w,vertical: 10.h,),
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h,),
                      child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 11.sp,letterSpacing:1.sp,fontWeight: FontWeight.w900),),
                    ),
                  ),
                ),
                wspace(10),
                InkWell(
                  onTap: (){
                    route(context, const Today());
                    msg('Attendants was discarded');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r)
                    ),
                    elevation: 4.r,
                    margin: EdgeInsets.symmetric(vertical: 10.h,),
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h,),
                      child: Text('Cancel',style: TextStyle(color: Colors.white,fontSize: 11.sp,letterSpacing:1.sp,fontWeight: FontWeight.w900),),
                    ),
                  ),
                ),
                wspace(10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
