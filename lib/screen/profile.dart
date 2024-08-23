import 'package:attendants/constants/color.dart';
import 'package:attendants/constants/functions.dart';
import 'package:attendants/constants/wigets.dart';
import 'package:attendants/service/authHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendants/constants/Drawer.dart';
import 'package:attendants/constants/Bottom%20bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        routename(context, '/home');
        return true;
      },
      child: Scaffold(
        drawer: drawer(headcolor: cr_brown),
        drawerEnableOpenDragGesture: false,
        bottomNavigationBar: bottom_bar(context, 3, cr_brown),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.brown.shade100,
                            elevation: 5,
                            child: Icon(CupertinoIcons.bars)),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.brown.shade400,
                        elevation: 5,
                        child: option(),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              hspace(10),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.brown.shade400.withOpacity(0.5),
                  ),
                  child: Icon(
                    IconlyBold.profile,
                    size: 30.r,
                    color: Colors.white,
                  ),
                ),
                title: Text(AuthHelper.myuser!.displayName!,
                    style: TextStyle(
                        color: cr_brown,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold)),
                subtitle: Text(
                  AuthHelper.myuser!.email!,
                  style: TextStyle(color: cr_brown, fontSize: 10.sp),
                ),
              ),
              hspace(10),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.amber.withOpacity(0.4)),
                child: Column(
                  children: [
                    hspace(5),
                    Row(
                      children: [
                        wspace(10),
                        Text(
                          'Departments',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          scrollDirection: Axis.horizontal,
                          itemCount: depl.length + 1,
                          itemBuilder: (context, int index) {
                            if (index == depl.length) {
                              return addDep();
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  width: 70.w,
                                  height: 50.h,
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        color: depcl
                                            .elementAt(index)
                                            .withOpacity(0.5),
                                        child: Center(
                                          child: Text(depl.elementAt(index)),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: IconButton(
                                          icon: const Icon(
                                            IconlyBroken.delete,
                                            color: CupertinoColors.white,
                                            size: 20,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget addDep() {
    String addep = '';
    return Container(
      width: 80.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: InkWell(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 80.h,
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(children: const [
                        TextSpan(text: 'Add your '),
                        TextSpan(
                            text: 'Departments',
                            style: TextStyle(fontSize: 20)),
                      ], style: GoogleFonts.rubik(color: Colors.black)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: const InputDecoration(),
                              onChanged: (String note) {
                                addep = note;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: IconButton(
                              icon: const Icon(CupertinoIcons.checkmark_alt),
                              onPressed: () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setString('dep 3', addep);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          color: Colors.grey.withOpacity(0.5),
          child: Center(
            child: Icon(
              CupertinoIcons.add,
              size: 20.r,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void adddepsh(String dep) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('dep \$', dep);
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}
