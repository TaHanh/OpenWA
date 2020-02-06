import 'dart:convert';
import 'dart:math';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:guide_ice_scream/screens/link/link_screen.dart';
import 'package:guide_ice_scream/screens/open_wa/open_wa_screen.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // AdmobInterstitial interstitialAd;
  // AdmobBannerSize bannerSize;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  final List<Widget> _children = [OpenWAScreen(), LinkScreen()];
  @override
  void initState() {
    super.initState();
    // bannerSize = AdmobBannerSize.BANNER;
  }

  void onTabTapped(int index) {
    print(_currentIndex);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    // if (interstitialAd != null) {
    //   interstitialAd.dispose();
    // }
  }

  @override
  launchURL() async {
    const url = 'mailto:tahanh.aib@gmail.com?subject=News&body=New%20plugin';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Open WhatsApp"),
        backgroundColor: Color(0xFF075e54),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          )
        ],
      ),
      body: _children[_currentIndex],
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Share app'),
              onTap: () {
                Share.share("https://play.google.com/store");
              },
            ),
            ListTile(
              title: Text('Feedback to us'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30.0,
        selectedItemColor: Color(0xFF075e54),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
            ),
            title: new Text(''),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.link),
            title: new Text(''),
          ),
        ],
      ),
    );
  }
}
