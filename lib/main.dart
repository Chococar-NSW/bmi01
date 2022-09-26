import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(theme: ThemeData(primaryColor: Colors.pinkAccent) ,home: demo(),);
  }
}

class demo extends StatefulWidget {
  @override
   demoState createState() => demoState();
}

class demoState extends State<demo> {

   TextEditingController heightController=TextEditingController();
   TextEditingController weightController=TextEditingController();
   double? result1;
   String? bmistatus;
   bool vaildateh=false,vaildatew=false;

   Color? getTextColor(String s1){
     if(s1=="正常"){
       return Colors.green;
     }else if(s1=="過輕"){
       return Colors.amber;
     }else if(s1=="過重"){
       return Colors.red;
     }
   }

   @override
   void dispose(){
     heightController.dispose();
     weightController.dispose();
     super.dispose();
   }

   @override
   Widget build(BuildContext context) {
      return Scaffold(appBar: AppBar(title: Text("BMI Calculator"), centerTitle: true, backgroundColor: Colors.yellow,),
                               body: Container(
                                         padding: EdgeInsets.symmetric(horizontal: 10.0),
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: <Widget>[
                                             TextField(
                                               controller: heightController,
                                               keyboardType: TextInputType.number,
                                               decoration: InputDecoration(
                                                                  labelText: "身高",
                                                                  hintText: "公分",
                                                                  errorText: vaildateh? "不得為空":null,
                                                                  icon: Icon(Icons.trending_up),
                                               ),
                                             ),
                                             SizedBox(height: 10),
                                             TextField(
                                               controller: weightController,
                                               keyboardType: TextInputType.number,
                                               decoration: InputDecoration(
                                                 labelText: "體重",
                                                 hintText: "公斤",
                                                 errorText: vaildatew? "不得為空":null,
                                                 icon: Icon(Icons.trending_down),
                                               ),
                                               style: TextStyle(fontSize: 15),
                                             ),
                                             SizedBox(height: 15),
                                             ElevatedButton(
                                                 child: Text("計算", style: TextStyle(color: Colors.white),),
                                                 onPressed:() {
                                                   setState(() {
                                                   heightController.text.isEmpty? vaildateh=true:vaildateh=false;
                                                   weightController.text.isEmpty? vaildatew=true:vaildatew=false;
                                                   });
                                                   calculateBMI();},
                                               style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
                                             ),
                                             SizedBox(height: 30),
                                             Text(result1==null?"":"你的BMI值為${result1?.toStringAsFixed(2)}",
                                               style: TextStyle(color:Colors.blueAccent,
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.w500),
                                             ),
                                             RichText(text: TextSpan(style: TextStyle(color:Colors.blueAccent,
                                                 fontSize: 20,
                                                 fontWeight: FontWeight.w500,
                                                 ),
                                                 children: <TextSpan>[
                                                   TextSpan(text: bmistatus==null?"":"你的體重"),
                                                   TextSpan(text: bmistatus==null?"":"${bmistatus}",style: TextStyle(color: getTextColor("${bmistatus}"))),
                                                 ],
                                             ),
                               ),

                                           ],
                                         ),
                               ),
      );
   }
   void calculateBMI() {
     double h=double.parse(heightController.text)/100;
     double w=double.parse(weightController.text);
     double result=w/(h*h);
     result1=result;
     if(result1!<18.5){
       bmistatus="過輕";
     }else if(result1!>25){
       bmistatus="過重";
     }else{
       bmistatus="正常";
     }
     setState(() {});
   }
}