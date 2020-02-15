

import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

final Color backgroundColor = Color(0xFF4A4A5B);
var httpClient = new HttpClient();

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollpased = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuscaleAnimation;
  Animation<Offset> _slideAnimation;
  var _ipAddress = 'Unknown';
  
  _getIPAddress() async {
    var url = 'https://joke3.p.rapidapi.com/v1/joke';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      request.headers.add("x-rapidapi-host", "joke3.p.rapidapi.com");
      request.headers.add("x-rapidapi-key", "c887fdab6amsheb88082d8dcbcf9p1dd6b5jsn36c0552e2fdf");
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        result = data['content'];
       log(json);
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      _ipAddress = result;
    });
  }

  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);

    _menuscaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    _getIPAddress();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    //_getIPAddress();
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    //   Slide Menu
    /*
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            children: <Widget>[
               menu(context),
               dashboard(context),
            ]));
*/
//Testing call api
    
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Your current IP address is:'),
            new Text('$_ipAddress.'),
            new SizedBox(height: 32.0),
            new RaisedButton(
              onPressed: _getIPAddress,
              child: new Text('Get IP address'),
            ),
          ],
        ),
      ),
    );
    
  }

  Widget menu(context) {
    return SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
            scale: _menuscaleAnimation,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Dashboard',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(height: 10),
                        Text('Message',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(height: 10),
                        Text('Utility Bils',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(height: 10),
                        Text('Funds',
                            style: TextStyle(color: Colors.white, fontSize: 20))
                      ])),
            )));
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollpased ? 0 : 0.6 * screenWidth,
        right: isCollpased ? 0 : -0.2 * screenWidth,
        child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
                animationDuration: duration,
                borderRadius:
                    BorderRadius.all(Radius.circular(isCollpased ? 0 : 25)),
                elevation: 8,
                color: backgroundColor,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  child: Container(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  child: Icon(Icons.menu, color: Colors.white),
                                  onTap: () {
                                    setState(() {
                                      if (isCollpased)
                                        _controller.forward();
                                      else
                                        _controller.reverse();

                                      isCollpased = !isCollpased;
                                    });
                                  },
                                ),
                                Text('My Card',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white)),
                                Icon(Icons.settings, color: Colors.white),
                              ]),
                          SizedBox(height: 50),
                          Container(
                              height: 200,
                              child: PageView(
                                controller:
                                    PageController(viewportFraction: 0.8),
                                scrollDirection: Axis.horizontal,
                                pageSnapping: true,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    color: Colors.redAccent,
                                    width: 100,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    color: Colors.blueAccent,
                                    width: 100,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    color: Colors.greenAccent,
                                    width: 100,
                                  )
                                ],
                              )),
                          SizedBox(height: 20),
                          Text(
                            'Trans',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          ListView.separated(
                              scrollDirection: Axis.vertical,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("Testing"),
                                  subtitle: Text('text'),
                                  trailing: Text('text'),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(height: 16);
                              },
                              itemCount: 10)
                        ],
                      )),
                ))));
  }
}
