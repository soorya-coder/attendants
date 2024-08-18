import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/class.dart';
import '../Screens/home.dart';
import '../Screens/login.dart';
import '../Screens/profile.dart';
import '../Screens/today.dart';
import 'color.dart';

const String credential = r'''
    {
  "type": "service_account",
  "project_id": "gsheets-338417",
  "private_key_id": "1702ba0e41ea9214437423982a42f682433d86fb",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDSvxEJbSFFu1Ib\n17WaHrTQTeE+Jg94f8kleJrJGjfG9jLsD2I0lsxhXS32XqOJptdTSeayPb1EKqOe\nZgQnF7EDfIZdlJPGGC60OQUa7u4Su/shbrKJcmg1f4ub8QUWE2+G5j5rU4FuxFem\nZgt+l3uHtqp+XnRSIWwvEU0AmDO3cPDXiXU+Ck3ZsFwp9HOnLROvfPGi/lVISBsv\nm2Ox0GfWuHDSRXD/rXRByKyjm+uiPVfq3cJSyymgNMqoRWgVugpT9F5kMC0U3zZt\nzlHR8oxwL2L34WHpkw+aHwniw/uIu6bPXWqHbS7gtsGIsvANFmE1vZJdcpwRN8UU\neKSC4323AgMBAAECggEAQ2dq6onl52inNVKDudxyVmFiVj9UGWU9j2eIkiN5jYA2\n/ztYXJuSmN11kuPoCGG9Yt0zFPUcMM42cLYOQ/aW3heY3htkPCqF3YyTLm8W5BUN\nmD7QiZd27w1xOJoY11u2Av5nHmqh7iyMICNpL78BeoGY/Dv3lkEsWc19xF/pwpSf\nS7LKPLkGUGPwR2vJ+r369+ebh4bq2KkcM9Pp/vuBmVWcNKfzBak7PPS9EQePFmk4\nfl6w0RcdzNY06MWnnWh4jVRuJb66agCHBC8UwvjfTFEK0Z8014K6h1WgDriy9YaI\ngaj86zKy2AzPDhLpayRxDyNTJU08gfTvnhGolF7c0QKBgQDrK83kcAro/XfaLH5f\nNZGzx/9Gn3hS2oUiaFdN7vqcmFtcJGoCUlaGQmZf70E1hGmyubJYxnZWlMtreqHc\nxXKukH6n2tUsUZg5VkzQqTiR5eRT4DIUFYAW5m9SS2e6AbSkOQtlMSGsLBdAdW5r\nc0eO8MMfRnLjf5lULpoE12pxWQKBgQDlaXaJpDm2G/uIEV4sf0lBw3q+aBfnP1cF\nd/bphrphaAUm0xr7N/rw/+8RdhijA/e8f/EzvVsUMKyCuATtXCxeLARR+8UVo20U\nzRPkYM0y6fFHQ9KkqtwladshUPqafD/WaOsFLRFpfQuTwChS8QL09b8zODbK3J1P\ndU9OfRT1jwKBgQCb9/RYgfqqZZi8iO/TI0sbyhPC+faqNKVBmaP1Wv65Js7IwJnS\nKluaNaWCEMLVxJj5YPEosY9AgvSatr1tF0KlBc4KczcYapEjzdmqNeD/2lFhU3rD\nGTNXfMLt+Ha1xXXRyMeG+FvVvXQ6Wue9uboG0iUGtAl0WmcNjs61UU0WGQKBgCBr\n7TK6oOVZwwyR18tWGdZPeBNcxrQJwZSmRaDvR3vopYG9J/0FBlP096ZyGD1BnEtp\nkX8MbcjGsDqxIxEgi6yrb9jeShYqyIm+CeemvplJcq3tqeFXvFEVSsDEnwYiNStq\nHHzYx7Mu1uoEqC5AnXhdGq50bVnyH9FQ9OpUxxeFAoGAe91GjGujN8PrQ+IC70s3\nbWgZC4ES9h+f4qWEDGrnQq0mTEifogpPlykx559fsqxvwn4Ol4xN2dC3Mg6LoFtU\n/dlpUpO0XBTo+d5grX51np2NW6GwPOv/5kC+p2CZYRQ8Q0DkxFzsAhKUi7uTcvOI\n/EmyH3bIv14rttvWar+nmb0=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-338417.iam.gserviceaccount.com",
  "client_id": "106348607562198950780",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-338417.iam.gserviceaccount.com"
    }
    ''';

void setinrout(int inrout) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('inrout', inrout);
}

void route(BuildContext context,Widget page){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page
    )
  );
}

void routename(BuildContext context,String route){
  Navigator.pushNamed(
    context,
    route
  );
}

void msg(String msg){
  Fluttertoast.showToast(msg: msg);
}


void inidep() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(!prefs.containsKey('dep 0')){
    for(int d = 0; d<depl.length; d++){
      prefs.setString('dep $d', depl.elementAt(d));
      // prefs.setInt('dep', );
    }
  }
}

void goback(BuildContext context){
  Navigator.pop(context);
}

TValue? selectof<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
      TValue? defaultValue,
    ]) {
  if (!branches.containsKey(selectedOption)) {
    return defaultValue;
  }
  return branches[selectedOption];
}

String get timenow {
  return DateTime.now().toIso8601String();
}

String timeof(String iso) {
  return '${iso.substring(11,13)}:${iso.substring(14,16)},${iso.substring(17,19)}';
}

String getime(DateTime dateTime){
  final DateTime now = DateTime.now();
  int min = now.difference(dateTime).inMinutes;
  int hour = now.difference(dateTime).inHours;
  int day = now.difference(dateTime).inDays;
  if(min<2){
    return 'Just now';
  }else if(min<61){
    return '$min mins ago';
  }else if(hour<25){
    return '$hour hours ago';
  }else if(day<5){
    return '$day days ago';
  }else {
    return '${dateTime.hour}:${dateTime.minute} ${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}

DateTime get nows => DateTime.now();
String today =
    '${nows.year}-'
    '${nows.month.toString().length == 1 ? '0${nows.month}' : '${nows.month}'}-'
    '${nows.day.toString().length == 1 ? '0${nows.day}' : '${nows.day}'}';

String totime = '$today@${DateTime.now().hour}:${DateTime.now().minute}';

DateTime currentDate = DateFormat('yyyy-MM-dd').parse(today);
String todate = today;

String extractSheetId(String url) {
  RegExp regExp = RegExp(r"/spreadsheets/d/([a-zA-Z0-9-_]+)");

  Match? match = regExp.firstMatch(url);

  if (match != null) {
    return match.group(1)!;
  } else {
    return ""; // or throw an exception, handle error, etc.
  }
}

String pname = '', pinstut = '', pemail = '';
int inrout = 2;

List<String> yearl = ['I', 'II', 'III', 'IV','V'];
List<Color> yearcl = [Colors.amber, Colors.orange, Colors.red, Colors.pink,Colors.redAccent];

int inofdep(String dep){
  if(!depl.contains(dep)){
    return -1;
  }
  return depl.indexOf(dep);
}

List<String> secl = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
];

List<Widget> screens = [
  const Home(),
  const Today(),
  const Class(),
  const Profile()
];

List<String> scroute = ['/home', '/today', '/class', '/profile'];
List<Widget> login = [const Login()];

List<String> depl = ['CIVIL', 'CSE', 'ECE', 'EEE', 'MECH'];

List<Color> depcl = [
  cl[29],
  cl[1],
  cl[15],
  cl[55],
  cl[81],
];