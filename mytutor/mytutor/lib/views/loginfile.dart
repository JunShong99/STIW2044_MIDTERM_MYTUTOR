// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers


import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutor/models/user.dart';
import 'package:mytutor/views/mainscreeen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mytutor/views/page1.dart';
import 'package:mytutor/views/page2.dart';
//import '../constants.dart';
//import '../models/subject.dart';

const String page1 = "Subjects";
const String page2 = "Tutors";
const String page3 = "Subscribe";
const String page4 = "Favourite";
const String page5 = "Profile";
const String title = "Demo";

class LoginFile extends StatefulWidget {
  final User user;
  const LoginFile({Key? key, required this.user}) : super(key: key);

  @override
  State<LoginFile> createState() => _LoginFileState();
}

class _LoginFileState extends State<LoginFile> {
  late double screenHeight, screenWidth, resWidth;
  late List<Widget> _pages;
  late Widget _page1;
  late Widget _page2;
  late Widget _page3;
  late Widget _page4;
  late Widget _page5;
  late int _currentIndex;
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();
    //_loadProducts(1, search);

    _page1 = Page1();
    _page2 = Page2();
    _page3 = const Page3();
    _page4 = const Page4();
    _page5 = Page5(changePage: _changeTab);
    _pages = [_page1, _page2, _page3, _page4, _page5];
    _currentIndex = 0;
    _currentPage = _page1;
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
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
      appBar: AppBar(
        title: const Text('MyTutor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          )
        ],
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _changeTab(index);
          },
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              label: page1,
              backgroundColor: Colors.cyan,
              icon: Icon(Icons.book),
            ),
            BottomNavigationBarItem(
              label: page2,
              backgroundColor: Colors.cyan,
              icon: Icon(Icons.perm_identity),
            ),
            BottomNavigationBarItem(
              label: page3,
              backgroundColor: Colors.cyan,
              icon: Icon(Icons.subscriptions),
            ),
            BottomNavigationBarItem(
              label: page4,
              backgroundColor: Colors.cyan,
              icon: Icon(Icons.folder_special),
            ),
            BottomNavigationBarItem(
              label: page5,
              backgroundColor: Colors.cyan,
              icon: Icon(Icons.person),
            ),
          ]),
      drawer: Drawer(
        child: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              _navigationItemListTitle(page1, 0),
              _navigationItemListTitle(page2, 1),
              _navigationItemListTitle(page3, 2),
              _navigationItemListTitle(page4, 3),
              _navigationItemListTitle(page5, 4),
              _createDrawerItem(
                icon: Icons.exit_to_app,
                text: 'Logout',
                onTap: () {
                  _yesno();
                },
              ),
            ],
          ),
        ),
      ),
    );

    // drawer: Drawer(
    //   child: ListView(
    //     children: [
    //       UserAccountsDrawerHeader(
    //         accountName: Text(widget.user.name.toString()),
    //         accountEmail: Text(widget.user.email.toString()),
    //         currentAccountPicture: const CircleAvatar(
    //           backgroundImage: NetworkImage(
    //               "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
    //         ),
    //       ),
    //       _createDrawerItem(
    //         icon: Icons.tv,
    //         text: 'Subjects',
    //         onTap: () {
    //           Navigator.pop(context);
    //           Navigator.pushReplacement(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (content) => LoginFile(
    //                         user: widget.user,
    //                       )));
    //         },
    //       ),
    //       _createDrawerItem(
    //         icon: Icons.local_shipping_outlined,
    //         text: 'My Cart',
    //         onTap: () {},
    //       ),
    //       _createDrawerItem(
    //         icon: Icons.supervised_user_circle,
    //         text: 'My Orders',
    //         onTap: () {},
    //       ),
    //       _createDrawerItem(
    //         icon: Icons.verified_user,
    //         text: 'My Profile',
    //         onTap: () {},
    //       ),
    //       _createDrawerItem(
    //         icon: Icons.exit_to_app,
    //         text: 'Logout',

    //         onTap: () {
    //                   _yesno();

    //           //                Navigator.pop(context);
    //           // Navigator.pushReplacement(
    //           //     context,
    //           //     MaterialPageRoute(
    //           //         builder: (content) => MyTutor(
    //           //               //user: widget.user,
    //           //             )));
    //         },

    //       ),
    //     ],
    //   ),
    // ),

    // body: productList.isEmpty
    //     ? Center(
    //         child: Text(titlecenter,
    //             style: const TextStyle(
    //                 fontSize: 22, fontWeight: FontWeight.bold)))
    //     : Column(children: [
    //         const Padding(
    //           padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
    //           child: Text("Products Available",
    //               style:
    //                   TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    //         ),
    //         Expanded(
    //             child: GridView.count(
    //                 crossAxisCount: 2,
    //                 childAspectRatio: (1 / 1),
    //                 children: List.generate(productList.length, (index) {
    //                   return InkWell(
    //                     splashColor: Colors.amber,
    //                     onTap: () => {_loadProductDetails(index)},
    //                     child: Card(
    //                         child: Column(
    //                       children: [
    //                         Flexible(
    //                           flex: 6,
    //                           child: CachedNetworkImage(
    //                             imageUrl: CONSTANTS.server +
    //                                 "/slumshop/mobile/assets/products/" +
    //                                 productList[index].productId.toString() +
    //                                 '.jpg',
    //                             fit: BoxFit.cover,
    //                             width: resWidth,
    //                             placeholder: (context, url) =>
    //                                 const LinearProgressIndicator(),
    //                             errorWidget: (context, url, error) =>
    //                                 const Icon(Icons.error),
    //                           ),
    //                         ),
    //                         Flexible(
    //                             flex: 4,
    //                             child: Column(
    //                               children: [
    //                                 Text(
    //                                   productList[index]
    //                                       .productName
    //                                       .toString(),
    //                                   style: const TextStyle(
    //                                       fontSize: 16,
    //                                       fontWeight: FontWeight.bold),
    //                                 ),
    //                                 Text("RM " +
    //                                     double.parse(productList[index]
    //                                             .productPrice
    //                                             .toString())
    //                                         .toStringAsFixed(2)),
    //                                 Text(productList[index]
    //                                         .productQty
    //                                         .toString() +
    //                                     " units"),
    //                                 Text(productList[index]
    //                                     .productStatus
    //                                     .toString()),
    //                               ],
    //                             ))
    //                       ],
    //                     )),
    //                   );
    //                 }))),
    //         SizedBox(
    //           height: 30,
    //           child: ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: numofpage,
    //             scrollDirection: Axis.horizontal,
    //             itemBuilder: (context, index) {
    //               if ((curpage - 1) == index) {
    //                 color = Colors.red;
    //               } else {
    //                 color = Colors.black;
    //               }
    //               return SizedBox(
    //                 width: 40,
    //                 child: TextButton(
    //                     onPressed: () => {_loadProducts(index + 1, "")},
    //                     child: Text(
    //                       (index + 1).toString(),
    //                       style: TextStyle(color: color),
    //                     )),
    //               );
    //             },
    //           ),
    //         ),
    //       ]),
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void _yesno() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Logout",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                // Navigator.of(context).pop();

                Fluttertoast.showToast(
                    msg: "Logout Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MyTutor(
                            //user: widget.user,
                            )));

                //  Navigator.pop(context);
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (content) => MyTutor(
                //               //user: widget.user,
                //             )));

                // MaterialPageRoute(
                //       builder: (content) => MyTutor(
                //             //user: widget.user,
                //           ));

                // _insertProduct();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loadSearchDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                  title: const Text(
                    "Search ",
                  ),
                  content: SizedBox(
                    height: screenHeight / 5.8,
                    child: Column(
                      children: [
                        TextField(
                          //controller: searchController,
                          decoration: InputDecoration(
                              labelText: 'Search',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                        const SizedBox(height: 5),
                        // Container(
                        //   height: 60,
                        //   padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        //   decoration: BoxDecoration(
                        //       border: Border.all(color: Colors.grey),
                        //       borderRadius:
                        //           const BorderRadius.all(Radius.circular(5.0))),
                        //   // child: DropdownButton(
                        //   //   value: dropdownvalue,
                        //   //   underline: const SizedBox(),
                        //   //   isExpanded: true,
                        //   //   icon: const Icon(Icons.keyboard_arrow_down),
                        //   //   items: types.map((String items) {
                        //   //     return DropdownMenuItem(
                        //   //       value: items,
                        //   //       child: Text(items),
                        //   //     );
                        //   //   }).toList(),
                        //   //   onChanged: (String? newValue) {
                        //   //     setState(() {
                        //   //       dropdownvalue = newValue!;
                        //   //     });
                        //   //   },
                        //   // ),
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            //search = searchController.text;
                            Navigator.of(context).pop();
                            //_loadProducts(1, search);
                          },
                          child: const Text("Search"),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        "Close",
                        style: TextStyle(),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ]);
            },
          );
        });
  }

  Widget _navigationItemListTitle(String title, int index) {
    return ListTile(
      title: Text(
        '$title Page',
        style: TextStyle(color: Colors.blue[400], fontSize: 22.0),
      ),
      onTap: () {
        Navigator.pop(context);
        _changeTab(index);
      },
    );
  }
}



class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$page3 Page', style: Theme.of(context).textTheme.headline6),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$page4 Page', style: Theme.of(context).textTheme.headline6),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key, required this.changePage}) : super(key: key);
  final void Function(int) changePage;

  @override
  Widget build(BuildContext context) {
    // return Scaffold();

    return Center(
      child: Text('$page5 Page', style: Theme.of(context).textTheme.headline6),
    );

    // return Align(
    //   alignment: Alignment.center,
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Text('$page3 Page', style: Theme.of(context).textTheme.headline6),
    //       ElevatedButton(
    //         onPressed: () => changePage(0),
    //         child: const Text('Switch to Home Page'),
    //       )
    //     ],
    //   ),
    // );
  }
}
