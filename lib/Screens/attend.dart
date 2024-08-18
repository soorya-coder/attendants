import 'package:attendants/Screens/today.dart';
import 'package:attendants/constants/functions.dart';
import 'package:attendants/main.dart';
import 'package:attendants/object/classes.dart';
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
  bool uml = true, ml = true,isload=true;

  @override
  Widget build(BuildContext context) {

    classes = widget.classes;
    stuHelper = StuHelper(cid: classes.id!);
    date = widget.date;
    period = widget.period;
    todHelper = TodHelper(cid: classes.id!, period: period);

    return PopScope(
      canPop: false,
      onPopInvoked: (dp) {
        route(context, const Today());
        msg('Attendants was discarded');
      },
      child: StreamBuilder<List<Stuab>>(
        stream: todHelper.getlist(),
        builder: (context,AsyncSnapshot<List<Stuab>> absnap) {
          if(absnap.hasData){
            return StreamBuilder<List<Stu>>(
                stream: stuHelper.getlist(),
                builder: (context, AsyncSnapshot<List<Stu>> snapshot) {
                  if (snapshot.hasData) {
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

                      for(Stuab stuab in absnap.data!){
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
                                                  text: ' [$todate] \n',
                                                  style: const TextStyle(
                                                      color: Colors.brown)),
                                              const TextSpan(
                                                  text: 'Attendents \n',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold)),
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
                                                                    fontWeight:
                                                                    FontWeight.bold,
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
                                                                    fontWeight:
                                                                    FontWeight.bold,
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
                                    const Spacer(),
                                    Text('${hd.where((element) => element).length}'),
                                    wspace(10),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          uml = !uml;
                                        });
                                      },
                                      icon: Icon(
                                        uml
                                            ? IconlyBold.arrow_up_2
                                            : IconlyBold.arrow_down_2,
                                        color: cr_red,
                                      ),
                                    ),
                                    wspace(20),
                                  ],
                                ),
                                const Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 0,
                                  thickness: 0.5,
                                  color: Colors.brown,
                                ),
                                Visibility(
                                  visible: uml,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: unmarkedstu.length,
                                      itemBuilder: (context, index) {
                                        Stu stu = unmarkedstu[index];
                                        if (!hd[index]) {
                                          return const SizedBox();
                                        }
                                        return Column(
                                          children: [
                                            hspace(2),
                                            Container(
                                                padding: const EdgeInsets.fromLTRB(
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
                                                                          FontWeight
                                                                              .bold)),
                                                                  const TextSpan(
                                                                      text: ' | \ns',
                                                                      style: TextStyle()),
                                                                  const TextSpan(
                                                                      text: 'Reg no: '),
                                                                  TextSpan(
                                                                      text: stu.regno,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                                ]),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color: Colors.black12,
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    15.r),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: IconButton(
                                                                      icon: Icon(
                                                                        CupertinoIcons
                                                                            .clear_thick_circled,
                                                                        color: Colors
                                                                            .redAccent
                                                                            .withOpacity(
                                                                            0.7),
                                                                        size: 25.r,
                                                                      ),
                                                                      onPressed: () {
                                                                        unmarkedstu
                                                                            .removeAt(
                                                                            index);
                                                                        markedstu
                                                                            .add(stu);
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
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: IconButton(
                                                                      icon: Icon(
                                                                        CupertinoIcons
                                                                            .checkmark_alt_circle_fill,
                                                                        color: Colors
                                                                            .lightGreen
                                                                            .withOpacity(
                                                                            0.9),
                                                                        size: 25.r,
                                                                      ),
                                                                      onPressed: () {
                                                                        unmarkedstu
                                                                            .removeAt(
                                                                            index);
                                                                        markedstu
                                                                            .add(stu);
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
                                                                      },
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
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
                                ),
                                Row(
                                  children: [
                                    wspace(20),
                                    Text(
                                      'Attendant list',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: cr_brown),
                                    ),
                                    const Spacer(),
                                    Text('${markedab.length}'),
                                    wspace(10),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          ml = !ml;
                                        });
                                      },
                                      icon: Icon(
                                        ml
                                            ? IconlyBold.arrow_up_2
                                            : IconlyBold.arrow_down_2,
                                        color: cr_red,
                                      ),
                                    ),
                                    wspace(20),
                                  ],
                                ),
                                markedab.isNotEmpty
                                    ? const Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 0,
                                  thickness: 0.5,
                                  color: Colors.brown,
                                )
                                    : const SizedBox(),
                                Visibility(
                                  visible: ml,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: markedab.length,
                                    itemBuilder: (context, index) {
                                      Stuab stuab = markedab[index];
                                      Stu? stu;
                                      for (Stu st in markedstu) {
                                        if (stuab.sid == st.id) {
                                          stu = st;
                                        }
                                      }
                                      return Column(
                                        children: [
                                          hspace(2.h),
                                          Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 10.w),
                                            child: Row(
                                              children: [
                                                wspace(10),
                                                Expanded(
                                                  flex: 1,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                    stuab.isPresent == 'P'
                                                        ? Colors.lightGreen
                                                        .withOpacity(0.8)
                                                        : Colors.redAccent
                                                        .withOpacity(0.8),
                                                    child: Text(
                                                      stuab.isPresent,
                                                      //studename.substring(0,1),
                                                      style: GoogleFonts.catamaran(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w900),
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
                                                        stu!.name.toUpperCase(),
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.w900,
                                                            letterSpacing: 1),
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          style: GoogleFonts.rubik(
                                                              color: Colors.black26),
                                                          children: [
                                                            const TextSpan(
                                                                text: 'Spr no: '),
                                                            TextSpan(
                                                                text: stu.sprno,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    color:
                                                                    Colors.black54)),
                                                            const TextSpan(
                                                                text: ' | \n',
                                                                style: TextStyle()),
                                                            const TextSpan(
                                                                text: 'Reg no: '),
                                                            TextSpan(
                                                                text: stu.regno,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    color:
                                                                    Colors.black54)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: stuab.isPresent == 'P'
                                                      ? Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.lightGreen,
                                                      borderRadius:
                                                      BorderRadius.circular(20),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: IconButton(
                                                              icon: const Icon(
                                                                CupertinoIcons
                                                                    .clear_thick_circled,
                                                                color: Colors.white,
                                                                size: 40,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  stuab.isPresent =
                                                                  'A';
                                                                  //toddata.instance.upab(studen.id, studen.is_present);
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Opacity(
                                                              opacity: 0.2,
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                  CupertinoIcons
                                                                      .checkmark_alt_circle_fill,
                                                                  color:
                                                                  Colors.white,
                                                                  size: 40,
                                                                ),
                                                                onPressed: () {},
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 60,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.7),
                                                      borderRadius:
                                                      BorderRadius.circular(20),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Opacity(
                                                              opacity: 0.4,
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                  CupertinoIcons
                                                                      .clear_thick_circled,
                                                                  color:
                                                                  Colors.white,
                                                                  size: 40,
                                                                ),
                                                                onPressed: () {},
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                  CupertinoIcons
                                                                      .checkmark_alt_circle_fill,
                                                                  color:
                                                                  Colors.white,
                                                                  size: 40,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    stuab.isPresent =
                                                                    'P';
                                                                    //toddata.instance.upab(studen.id, studen.is_present);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          hspace(5.h),
                                          const Divider(
                                            indent: 20,
                                            endIndent: 20,
                                            height: 0,
                                            thickness: 0.5,
                                            color: Colors.brown,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await todHelper.setlist(markedab);
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
        }
      ),
    );
  }
}
