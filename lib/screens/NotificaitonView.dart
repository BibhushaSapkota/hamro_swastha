import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ), onPressed: () {
        },
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          "Appointment history",style: TextStyle(fontSize: 20),
        ),
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: listView(),
    );
  }
  PreferredSizeWidget(){
    return AppBar(
      title: const Text("Notification Screen"),
    );
  }

  Widget listView(){
    return ListView.separated(itemBuilder: (context , index){
      return listViewItem(index);
    }, separatorBuilder: (context , index){
      return const Divider(height: 0);
    }, itemCount: 15);
  }

  Widget listViewItem(int index){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(index),
                  tineAndDate(index),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade300,
        ),
        child: Icon(Icons.notifications,size: 25,color: Colors.grey.shade700,),
      ),
    );
  }

  Widget message(int index){
    double textSize = 14;
    return Container(
      child: Column(
        children: [
          RichText(
              maxLines:3,
              overflow:TextOverflow.ellipsis,
              text:TextSpan(
                  text: 'Notification :',
                  style: TextStyle(
                      fontSize: textSize,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                  children: const [
                    TextSpan(
                      text: 'Notification Description',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ]
              )
          ),
        ],
      ),
    );
  }

  Widget tineAndDate(int index){
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            '23-08-2022',
            style: TextStyle(
              fontSize: 10,
            ),
          ),

          Text(
            '10:30 am',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
