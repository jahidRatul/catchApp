import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverInfo extends StatefulWidget {
  @override
  _DriverInfoState createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo>
    with SingleTickerProviderStateMixin {
  Animation<Offset> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
    animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.1, 0.0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));

    // Future<void>.delayed(Duration(seconds: 1), () {
    //   animationController.forward();
    // });
  }

  @override
  void dispose() {
    // Don't forget to dispose the animation controller on class destruction
    animationController.dispose();
    super.dispose();
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.8103, 90.4125),
    zoom: 14.4746,
  );

  Animation<Offset> _animation;

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void _callNumber() async {
    String url = "tel://016739";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            height: double.infinity,
          ),
          Stack(
            children: [
              SizedBox.expand(
                child: DraggableScrollableSheet(
                  maxChildSize: .8,
                  minChildSize: .4,
                  initialChildSize: .4,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 18,
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    backgroundImage: NetworkImage(
                                                        'https://picsum.photos/200'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Driver Name',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22),
                                                    ),
                                                    Text(
                                                      'Rating 4.5',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Car Model',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22),
                                                ),
                                                Text(
                                                  'Car Name',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.blueGrey,
                                        thickness: 1,
                                      ),
                                      Container(
                                        color: Colors.greenAccent,
                                        child: SlideTransition(
                                          position: animation,
                                          child: SwipeTo(
                                            child: Container(
                                              color: Colors.blueAccent[100],
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    color: Colors.greenAccent,
                                                    size: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Call in app',
                                                    style:
                                                        TextStyle(fontSize: 22),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onRightSwipe: () {
                                              _callNumber();
                                            },
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.blueGrey,
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 25),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Are you coming?",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.account_circle,
                                                  color: Colors.blue,
                                                  size: 35,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 18,
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    backgroundImage: NetworkImage(
                                                        'https://picsum.photos/200'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "I am on my way.",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[150],
                                        thickness: .5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintStyle: TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.grey),
                                                    hintText:
                                                        'Write message to Driver'),
                                              ),
                                            ),
                                            IconButton(
                                                icon: Icon(Icons.send),
                                                onPressed: () {}),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[150],
                                        thickness: 10,
                                      ),
                                      TripDetails(),
                                      ShareCancelTripButtons(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 30),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 35),
                                              child: Image.asset(
                                                  'assets/images/ridePageImg1.png'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'If you face any you can call customer care anytime. We are always on the other side to help you.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _callNumber();
                                              },
                                              child: Text(
                                                'Call Now.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[150],
                                        thickness: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 30),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 35),
                                              child: Image.asset(
                                                  'assets/images/ridePageImg2.png'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'If you are in trouble press panic button. After pressing the button an alert message will be automatically send to our Customer Care that you are in trouble',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[150],
                                        thickness: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 30),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 35),
                                              child: Image.asset(
                                                  'assets/images/ridePageImg3.png'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                // text: 'Can you ',
                                                style: TextStyle(
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: "You can call"),
                                                  TextSpan(
                                                    text: ' 999 ',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            _callNumber();
                                                          },
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          "if is there any emergency."),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff353287)),
                                child: Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            elevation: 5,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Your Ride Code asdf234',
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShareCancelTripButtons extends StatelessWidget {
  const ShareCancelTripButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(12),
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue, width: 1.3),
              ),
              child: Text(
                'Share trip details',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(12),
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue, width: 1.3),
              ),
              child: Text(
                'Cancel trip',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TripDetails extends StatelessWidget {
  const TripDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'From: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Mirpur 12',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Destination: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Flexible(
                      child: Text(
                        'Banani 11, Block A',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Distance: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '106 KM',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Time: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '36 Minutes',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "350 BDT",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                color: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  "Fare Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
