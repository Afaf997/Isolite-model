import 'dart:isolate';

import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: ()async{
            final receivePort =ReceivePort();
            await Isolate.spawn(computeHeavyTask,receivePort.sendPort);
           receivePort.listen((sum) { 
              print(sum);
           });
            
          },
           child:Text("start task"))
        ],
      )),

    );
  }}


   computeHeavyTask(SendPort sendPort){
    print("task started");
    int sum=0;
    for(int i=0;i< 1000; i++){
         sum +=i;
    }
    print("task finished");
    sendPort.send(sum);
    
  }
