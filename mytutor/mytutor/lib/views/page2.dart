import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytutor/constants.dart';
import 'package:mytutor/models/tutor.dart';
import 'package:http/http.dart' as http;

//import 'package:mytutor/models/subject.dart';
//import '../models/user.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<Tutor> tutorList = <Tutor>[];
  String titlecenter = "Loading data...";
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  late double screenHeight, screenWidth, resWidth;
  //var _tapPosition;
  var numofpage, curpage = 1;
  var color;

  @override
  void initState() {
    super.initState();
    _loadTutors(1);
  }

 @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }
    return Scaffold(
      body: tutorList.isEmpty
          ? Center(
              child: Text(
                titlecenter,
                style: (TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
            )
          : Column(children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text("Tutors Available",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                   childAspectRatio: (1 / 1),
                    children: List.generate(tutorList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          onTap: () => {_loadTutorsDetails(index)},
                          child: Card(
                              child: Column(children: [
                            Flexible(
                                flex: 8,
                                child: CachedNetworkImage(
                                    imageUrl:CONSTANTS.server +
                                        "/mytutor/mobile/assets/assets/tutors/"+
                                            tutorList[index].tutorId.toString() +
                                            '.jpg',
                                    fit: BoxFit.cover,
                                    width: resWidth)),
                            const SizedBox(height: 5),
                            Flexible(
                              flex: 2,
                              child: Column(children: [
                                Text(
                                tutorList[index].tutorName.toString(),
                                style: TextStyle(
                                    fontSize: 15),
                                    textAlign: TextAlign.center)
                              ]),
                            ),
                          ])),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                    height: 30,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: numofpage,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if ((curpage - 1) == index) {
                            color = Colors.cyan;
                          } else {
                            color = Colors.black;
                          }
                          return SizedBox(
                              width: 40,
                              child: TextButton(
                                onPressed: () => {
                                  _loadTutors(
                                    index + 1
                                    )
                                 },
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(color: color),
                                ),
                              ));
                        }))
              ],
            ),
    );
  }


  _loadTutorsDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Tutor Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/mytutor/mobile/assets/assets/tutors/" +
                          tutorList[index].tutorId.toString() +
                          '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  tutorList[index].tutorName.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),


   
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Tutor Description: \n"
                   +tutorList[index].tutorDescription.toString(),),

                  Text("Tutor Email:  " +
                     tutorList[index].tutorEmail.toString()),

                  Text("Phone Number " +
                      tutorList[index].tutorPhone.toString()),

                  Text("Date Register: " +
                      df.format(DateTime.parse(
                          tutorList[index].tutorDatereg.toString()))),
                ]),






              ],
            )),
            actions: [
              TextButton(
                child: const Text(
                  "Close",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }


    void _loadTutors(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_tutors.php"),
        body: {'pageno': pageno.toString()}).then((response) {
      print(response.body);
       print(response.statusCode);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['tutors'] != null) {
          tutorList = <Tutor>[];
          extractdata['tutors'].forEach((v) {
            tutorList.add(Tutor.fromJson(v));
          });
          titlecenter = tutorList.length.toString() + " Tutors Available";
        } else {
          titlecenter = "No Tutors  Available";
          tutorList.clear();
        }
        setState(() {});
      } else {
        titlecenter = "No Tutors  Available";
        tutorList.clear();
        setState(() {});
      }
    });
  }
}



