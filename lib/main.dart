import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:review_app/AppScreens/Admin/BottomNavBar/BottomNavBar.dart';
import 'package:review_app/AppScreens/Customer/BottomNavBar/BottomNavBar.dart';
import 'package:review_app/AppScreens/WelcomeScreens/NewOnboarding.dart';
import 'package:review_app/AppScreens/WelcomeScreens/NewSplashScreen.dart';
import 'package:review_app/AppScreens/WelcomeScreens/OnBoardingScreen.dart';
import 'package:review_app/Models/TokenPayLoad.dart';
import 'Utils/Locator.dart';
import 'Utils/Utils.dart';

void main()async {
 await GetStorage.init();
  SetupLocator();
  FirebaseMessaging().configure(
    onMessage: (Map<String, dynamic> message)async{
      showOverlayNotification((context) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: SafeArea(
            child: ListTile(
              leading:Icon(Icons.notifications,color: Theme.of(context).primaryColor,size: 40,),
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
              onTap: (){
                //push(context, MaterialPageRoute(builder: (context)=>NotificationListPage()));
              },
              trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    OverlaySupportEntry.of(context).dismiss();
                  }),
            ),
          ),
        );
      }, duration: Duration(milliseconds: 5000));
    },
    onLaunch: (Map<String, dynamic> message)async{
      print(message.toString());
    },
    onBackgroundMessage: Utils.myBackgroundMessageHandler,

  onResume: (Map<String, dynamic> message)async{
    print(message.toString());
  }
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange
        ),
        home: isloggedIn(),
      ),
    );
  }
  Widget isloggedIn(){
    try{
      String token="";
      DateTime expiryDate;
      token=locator<GetStorage>().read("token");
      print("token "+(token!=null).toString());
      if(token!=null) {
        TokenPayLoad info = TokenPayLoad.fromJson(Utils.parseJwt(token));
        print("info " + (info != null).toString());
        print("Expiry Date " + info.exp.toString());
        print("role ${info.role}");
        print("Date ${DateTime.fromMillisecondsSinceEpoch(
            int.parse(info.exp.toString() + "000"))}");
        if (info != null) {
          expiryDate = DateTime.fromMillisecondsSinceEpoch(int.parse(info.exp.toString() + "000"));
          if (expiryDate.isAfter(DateTime.now())) {
            if (info.role == "Admin") {
              return BottomNavBar();
            } else {
              return ClientBottomNavBar();
            }
          }else {
            return NewSplashScreen();
          }

        }else {
          return NewSplashScreen();
        }
      }else {
        return NewSplashScreen();
      }
    }catch(e){
      print(e);
    }
  }
}

