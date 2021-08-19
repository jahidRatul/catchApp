import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PickDestinationScreen extends StatefulWidget {
  @override
  _PickDestinationScreenState createState() => _PickDestinationScreenState();
}

class _PickDestinationScreenState extends State<PickDestinationScreen>
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
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        height: double.infinity,
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: SingleChildScrollView(
          // controller: scrollController,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 15),
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
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 15, bottom: 5),
                          child: ShareCancelTripButtons(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 25),
                          child: TextField(
                            decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.3),
                                ),
                                hintText: 'Mirpur 12'),
                            style: TextStyle(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.3)),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            // border:
                                            //     new OutlineInputBorder(
                                            //         borderSide:
                                            //             new BorderSide(
                                            //                 color: Colors
                                            //                     .teal)),
                                            // enabledBorder:
                                            //     OutlineInputBorder(
                                            //   borderSide: BorderSide(
                                            //       color: Colors.grey,
                                            //       width: 1.3),
                                            // ),
                                            hintText: 'Type Destination'),
                                        style: TextStyle(),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.lightBlueAccent,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: Colors.grey,
                                                width: 1.3))),
                                    child: Center(
                                        child: Text(
                                      'Schedule',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 25),
                          child: Row(
                            children: [
                              Image.asset('assets/icons/Icon awesome-home.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '(Niketon, Gulsan)',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          endIndent: 25,
                          color: Colors.grey[150],
                          thickness: .5,
                          indent: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 25),
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/icons/Icon awesome-building.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Office',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '(Mirpur DOHS, Road 14)',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          endIndent: 25,
                          color: Colors.grey[150],
                          thickness: .5,
                          indent: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 25),
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/icons/Icon awesome-map-pin.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Set on map',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 25),
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff353287)),
                child: Center(
                  child: Text(
                    ' *  Add promo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
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
      color: Colors.white,
      // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                padding: EdgeInsets.all(12),
                backgroundColor: Colors.lightBlueAccent,
                side: BorderSide(color: Colors.lightBlueAccent, width: 1.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'For me ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 13,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                padding: EdgeInsets.all(12),
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey, width: 1.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Business trip',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.black,
                    size: 13,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
