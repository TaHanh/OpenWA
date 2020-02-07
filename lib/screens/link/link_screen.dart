import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:share/share.dart';

class LinkScreen extends StatefulWidget {
  LinkScreen({Key key}) : super(key: key);
  @override
  _LinkScreenState createState() => new _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  // AdmobInterstitial interstitialAd;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController phoneTxtController = new TextEditingController();
  TextEditingController messageTxtController = new TextEditingController();
  List<Map<String, String>> numbers = new List<Map<String, String>>();
  bool isSaveNumber = false;
  String code = "+84";
  // String code = "+1";
  String phone = "";
  List statusLink = [false, false, false, false];
  @override
  void initState() {
    super.initState();
    // getNumver();
  }

  @override
  void clipTxt(String txt) {
    Clipboard.setData(
      new ClipboardData(text: txt),
    );
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text("Clipboard succes"),
      duration: Duration(seconds: 1),
      backgroundColor: Color(0xFF009688).withOpacity(0.5),
    ));
  }

  @override
  void shareLink(String txt) {
    Share.share(txt);
  }

  @override
  void createLink() {
    if (phoneTxtController.text != "") {
      phone = code.substring(1) + phoneTxtController.text;
      print(phone);
      // print(messageTxtController.text);
      // FlutterOpenWhatsapp.sendSingleMessage(phone, messageTxtController.text);
      if (messageTxtController.text != "") {
        setState(() {
          statusLink = [true, true, true, true];
        });
      } else {
        setState(() {
          statusLink = [true, false, true, false];
        });
      }
    } else {
      scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Please enter phone number !"),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF009688).withOpacity(0.5),
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    // if (interstitialAd != null) {
    //   interstitialAd.dispose();
    // }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/images/banner.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                padding: EdgeInsets.fromLTRB(0, 5.0, 10.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        3.0,
                        3.0,
                      ),
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            child: CountryCodePicker(
                              // initialSelection: 'US',
                              initialSelection: 'VN',
                              onChanged: (code) {
                                print(code.dialCode);
                                setState(() {
                                  this.code = code.dialCode;
                                });
                              },
                              alignLeft: true,
                              onInit: (code) {
                                print("${code.name} ${code.dialCode}");
                              },
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: phoneTxtController,
                              decoration: InputDecoration(hintText: 'Phone number - require'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 15.0),
                      child: TextField(
                        controller: messageTxtController,
                        decoration: InputDecoration(hintText: 'Message - optional'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: FlatButton(
                        onPressed: () {
                          createLink();
                        },
                        color: Color(0xFF075e54),
                        child: Text(
                          "CREATE WHATSAPP LINK",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    statusLink[0]
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            padding: EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    3.0,
                                    3.0,
                                  ),
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text("https://wa.me/${phone}"),
                                ),
                                IconButton(
                                  icon: Icon(Icons.content_copy),
                                  onPressed: () {
                                    clipTxt("https://wa.me/${phone}");
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed: () {
                                    shareLink("https://wa.me/${phone}");
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    statusLink[1]
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            padding: EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    3.0,
                                    3.0,
                                  ),
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text("https://wa.me/${phone}?text=${messageTxtController.text}"),
                                ),
                                IconButton(
                                  icon: Icon(Icons.content_copy),
                                  onPressed: () {
                                    clipTxt("https://wa.me/${phone}?text=${messageTxtController.text}");
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed: () {
                                    shareLink("https://wa.me/${phone}?text=${messageTxtController.text}");
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    statusLink[2]
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            padding: EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    3.0,
                                    3.0,
                                  ),
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(child: Text("https://api.whatsapp.com/send?phone=${phone}")),
                                IconButton(
                                  icon: Icon(Icons.content_copy),
                                  onPressed: () {
                                    clipTxt("https://api.whatsapp.com/send?phone=${phone}");
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed: () {
                                    shareLink("https://api.whatsapp.com/send?phone=${phone}");
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    statusLink[3]
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            padding: EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    3.0,
                                    3.0,
                                  ),
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                      "https://api.whatsapp.com/send?phone=${phone}&text=${messageTxtController.text}"),
                                ),
                                IconButton(
                                  icon: Icon(Icons.content_copy),
                                  onPressed: () {
                                    clipTxt(
                                        "https://api.whatsapp.com/send?phone=${phone}&text=${messageTxtController.text}");
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed: () {
                                    shareLink(
                                        "https://api.whatsapp.com/send?phone=${phone}&text=${messageTxtController.text}");
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                  physics: BouncingScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
