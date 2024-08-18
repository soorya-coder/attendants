import 'package:attendants/constants/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';

Widget bottom_bar(BuildContext context,int sclindex,Color color) {

  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    child: GNav(
      rippleColor: Colors.grey[300]!,
      hoverColor: Colors.grey[100]!,
      gap: 10,
      activeColor: Colors.white,
      iconSize: 24,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      duration: const Duration(milliseconds: 300),
      tabBackgroundColor: CupertinoColors.white,
      color: Colors.black,
      curve: Curves.ease,
      onTabChange: (index) {
        if(index != sclindex){
          switch (index) {
            case 0:{
              routename(context, '/home');
              break;
            }
            case 1:{
              routename(context, '/today');
              break;
            }
            case 2:{
              routename(context, '/class');
              break;
            }
            case 3:{
              routename(context, '/profile');
              break;
            }
          }
        }
        sclindex = index;
        setinrout(sclindex);
      },
      selectedIndex: sclindex,
      tabBackgroundGradient: LinearGradient(
        colors: [
          color.withOpacity(0.2),
          color.withOpacity(0.5),
        ],
      ),
      tabs: [
        GButton(
          icon: IconlyBold.home,
          text: 'Home',
          iconColor: Colors.purple.withOpacity(0.8),
        ),
        GButton(
          icon: IconlyBold.calendar,
          text: 'today',
          iconColor: Colors.redAccent.withOpacity(0.8),
        ),
        GButton(
          icon: IconlyBold.category,
          text: 'Class',
          iconColor: Colors.orangeAccent.withOpacity(0.8),
        ),
        GButton(
          icon: IconlyBold.profile,
          text: 'Profile',
          iconColor: Colors.brown.withOpacity(0.8),
        ),
      ],
    ),
  );
}