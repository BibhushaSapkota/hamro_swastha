import 'package:flutter/material.dart';
// import 'package:mero_doctor/models/data.dart';
import 'package:mero_doctor/utils/constants.dart';
// import 'package:mero_doctor/widgets/category_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key, var id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        body: SizedBox(
          height: screen.height,
          width: screen.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Container(
                //     height: 50,
                //     width: 50,
                //     decoration: BoxDecoration(
                //         color: COLOR_WHITE,
                //         borderRadius: BorderRadius.circular(8),
                //         border: Border.all(
                //             color: COLOR_GREY.withAlpha(40), width: 2)),
                //     padding: EdgeInsets.all(8),
                //     child: Icon(
                //       Icons.menu,
                //       size: 24,
                //     )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: const Text(
                      "Find Your\nConsultant",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(fontSize: 20),
                    fillColor: Colors.black12,
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Text(
                      "Categories",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                // Expanded(
                //   child: GridView.builder(
                //     itemCount: categoryList.length,
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 2,
                //             mainAxisSpacing: 10,
                //             crossAxisSpacing: 10),
                //     itemBuilder: (BuildContext context, index) {
                //       return CategoryWidget(categoryList[index]);
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
