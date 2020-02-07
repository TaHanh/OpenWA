import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key key, this.number}) : super(key: key);

  final int number;
  @override
  _AboutScreenState createState() => new _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String unsafeHtml =
      'Welcome to <a href="https://www.woolha.com">woolha.com</a>. The \'cutest\' programming blog ever.';
  HtmlEscape htmlEscape = const HtmlEscape();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Benifit to use this app"),
        backgroundColor: Color(0xFF075e54),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
      ),
      body: Container(
        // height: h,
        child: SingleChildScrollView(
          child: Html(
            data: """ <div>
                              <h4><b>Open in WhatsApp | Chat without save number</b></h4>
                                <p>The main benifit of this app is chat in WhatsApp with someone without save their number in your contact list. So if you don't want to save number in contact list then you can also chat with person without save number in your phone contact list using this app. There are some more benifits of this app is given below. </p>
                                <h4><b>Features of this app:</b></h4>
                                <ul>
                                    <li>Chat without save number in WhatsApp.</li>
                                    <li>Chat yourself in WhatsApp.</li>
                                    <li>No seen your profile picture if your profile privacy is only my contacts.</li>
                                    <li>No seen your status if your status privacy is only my contacts.</li>
                                    <li>No seen your story if your story privacy is only my contacts.</li>
                                    <li>Save temporary contact number in this app with their name.</li>
                                    <li>Open contact number in WhatsApp app./li>
                                    <li>If you don't need some contacts from our app then you can also delete that contact easily from our app.</li>
                                </ul>
                                <h4><b>Chat without save number in WhatsApp</b></h4>
                                <ul>
                                    <li>If you want to chat any person without save number in WhatsApp then this app is best app for you.</li>
                                    <li>You don't need to save number in contact list for chat in some person.</li>
                                    <li>You just open our app and then click on dial button in bottom right cornor and enter that number and click on open on WhatsApp butotn. You redirect in WhatsApp.</li>
                                    <li>If you want to chat with yourself in WhatsApp then it's possible using our app. Benifit of chat yourself in WhatsApp is you can save some important message so you can find easily that message. You can also save some good message in yourself chat.</li>
                                </ul>
                            </div>
                        """,
            padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 25.0),
          ),
        ),
      ),
    );
  }
}
