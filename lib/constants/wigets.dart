import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

Widget hspace(double height){
  return SizedBox(height: height.h,);
}

Widget wspace(double width){
  return SizedBox(width: width.w,);
}

Widget option(){
  return PopupMenuButton<String>(
    icon: ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (boulds) => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors:[ Colors.black54, Colors.black54],
      ).createShader(boulds),
      child: const Icon(CupertinoIcons.ellipsis_vertical,),
    ),
    itemBuilder: (context) => [
      PopupMenuItem(
        child: Row(
          children: const [
            Icon(CupertinoIcons.delete),
            Spacer(),
            Center(child: Text('')),
          ],
        ),
        value: '0',
        onTap: (){

        },
      ),
      PopupMenuItem(
        child: Row(
          children: const [
            Icon(Icons.edit,),
            SizedBox(width: 15,),
            Center(child: Text('')),
          ],
        ),
        value: '0',
        onTap: (){

        },
      )
    ],
  );
}

Widget back(Function function){
  return IconButton(
    onPressed: (){
      function;
    },
    icon: const Icon(IconlyBroken.arrow_left_2)
  );
}

