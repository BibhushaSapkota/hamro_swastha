import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:flutter/services.dart';

class Bookmarked extends StatefulWidget {
  const Bookmarked({Key? key}) : super(key: key);

  @override
  State<Bookmarked> createState() => _BookmarkedState();
}

class _BookmarkedState extends State<Bookmarked>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  Animation<double>? _animation2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));
    _controller!.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: COLOR_SECONDARY,
          title: Text(
            "Bookmarked Doctor",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: COLOR_WHITE,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          leading: BackButton(
            color: COLOR_WHITE,
            onPressed: () {},
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                const SizedBox(
                  height: 20,
                ),
                card("Kamal Kumar Rai", "", "Cardiologist"),
                card("Bhupraj Tamang", "", "Neurologist"),
                card("Dawa Sherpa", "", "Neurologist"),
                card("Samita Limbu", "", "Cardiologist"),
                card("Bibhusha Sapkota", "", "Cardiologist"),
                card("Kripa Thapa", "", "Psychologist"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget card(String name, String imageUrl, String specialization) {
    double _width = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation!.value,
      child: Transform.translate(
        offset: Offset(0, _animation2!.value),
        child: InkWell(
          enableFeedback: true,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {},
          child: Container(
            margin:
                EdgeInsets.fromLTRB(_width / 20, _width / 20, _width / 20, 0),
            padding: EdgeInsets.all(_width / 30),
            width: _width / 5,
            height: _width / 3.5,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: COLOR_WHITE,
                  radius: _width / 13,
                  child: const FlutterLogo(
                    size: 45,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$name",
                        textScaleFactor: 1.4,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      Text(
                        "$specialization",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.remove_circle_sharp)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyFadeRoute extends PageRouteBuilder {
  final Widget? page;
  final Widget? route;

  MyFadeRoute({this.page, this.route})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double>? animation,
              Animation<double>? secondaryAnimation,
            ) =>
                page!,
            transitionsBuilder: (
              BuildContext context,
              Animation<double>? animation,
              Animation<double>? secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animation!,
                  child: route,
                ));
}
