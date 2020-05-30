import 'package:flutter/material.dart';
import 'dart:math' as math;
void main() {
  runApp(MyApp());
}

Color lightColor = Color(0xff423f52);
Color darkColor = Color(0xff39364a);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation =CurvedAnimation(parent: controller,curve: Curves.bounceOut);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: darkColor,
      body: Stack(
        children: <Widget>[
          buildBody(),
          AnimatedBuilder(
              animation: controller,
              builder: (context, snapshot) {
                return Transform.rotate(
                  angle: -math.pi/2*animation.value,
                    origin: Offset(-size.width/2+40,-size.height/2+60),
                    child: buildMenu(size));
              })
        ],
      ),
    );
  }

  Widget buildBody() {
    return ListView(
      children: <Widget>[
        SizedBox(height: 100,),
        Image.asset('images/content_1.png'),
        Image.asset('images/content_2.png'),
      ],
    );
  }

  Widget buildMenu(Size size) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      color: lightColor,
      width: size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          buildMeuList(),
          bulidSelectedText(size)
        ],
      ),
    );
  }

  Column buildMeuList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left:4.0),
          child: InkWell(
            onTap: (){
              if(controller.isCompleted){
                controller.reverse();
                animation =CurvedAnimation(parent: controller,curve: Curves.bounceIn);

              }else{
                controller.forward();
                animation =CurvedAnimation(parent: controller,curve: Curves.bounceOut);
              }
            },
            child: Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        buildItem('images/ic_profile.png', "PROFILE"),
        SizedBox(
          height: 20,
        ),
        buildItem('images/ic_feed.png', "FEED"),
        SizedBox(
          height: 20,
        ),
        buildItem('images/ic_activity.png', "ACTIVITY", isSelected: true),
        SizedBox(
          height: 100,
        ),
        buildItem('images/ic_settings.png', "SETTINGS"),
      ],
    );
  }

  Widget buildItem(String image, String text, {bool isSelected = false}) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 100,
        ),
        Image.asset(
          image,
          width: 30,
          height: 30,
          color: isSelected ? Colors.cyanAccent : Colors.white,
        ),
        SizedBox(
          width: 30,
        ),
        Text(
          text,
          style: TextStyle(
              fontFamily: 'IntroRust',
              color: isSelected ? Colors.cyanAccent : Colors.white,
              fontSize: 25),
        )
      ],
    );
  }

  Widget bulidSelectedText(Size size) {
    return Positioned(
      top: size.width/2-40,
      child: Opacity(
        opacity: animation.value,
        child: RotatedBox(
          quarterTurns: 1,
          child: Text('ACTIVITY',style: TextStyle(
              fontFamily: 'IntroRust',
              color:  Colors.white,
              fontSize: 25),),
        ),
      ),
    );
  }
}
