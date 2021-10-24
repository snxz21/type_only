// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:toast/toast.dart';
//
// import '../../main.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String tab = "Транзакции";
//   Widget currentWidget;
//   List<Widget> allWidget = [
//     HistoryTransactionsScreen(),
//     Text("Скоро тут что-то будет"),
//     ProductListScreen(),
//     Text("Скоро тут что-то будет"),
//     SotrudnikiTable(),
//     Text("Скоро тут что-то будет"),
//     TablesScreen(),
//     Text("Скоро тут что-то будет"),
//     PlaceScreen(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//       print('Message data: ${message.data.keys}');
//       print('Message data: ${message.data.values}');
//       print('Message data: ${message.senderId}');
//       print('Message data: ${message.sentTime}');
//       // print('Message data: ${message.notification.}');
//
//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification.title}');
//         print('Message also contained a notification: ${message.notification.body}');
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               content: Container(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(message.notification.title),
//                     Text(message.notification.body),
//                   ],
//                 ),
//               ),
//               actions: [
//                 ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Ок, это уведомление мною прочитано\n да закрыть уведомление.",textAlign: TextAlign.center,),)
//               ],
//             );
//           },
//         );
//       }
//     },
//     // onError: (qwe){}
//
//     );
//     currentWidget = allWidget[0];
//     // print(placeDataSave.staffList);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   List item = [];
//   Map data = {};
//
//   setTab(String newTab) {
//     // BlocProvider.of<TablesBloc>(context).add(TablesInitialEvent(userDataSave.currentObjectWay));
//     switch (newTab) {
//       case "Транзакции":
//         BlocProvider.of<HistoryTransactionsBloc>(context).add(HistoryTransactionsLoadingEvent(userDataSave.currentObjectWay,
//             DateTime.now().year.toString(), DateTime.now().toString().substring(5, 7), DateTime.now().toString().substring(8, 10)));
//         setState(() {
//           currentWidget = allWidget[0];
//         });
//         break;
//
//       case "Отчет":
//         setState(() {
//           currentWidget = allWidget[1];
//         });
//         break;
//       case "Товары":
//         BlocProvider.of<ProductListBloc>(context).add(ProductListLoadingEvent(userDataSave.currentObjectWay));
//         setState(() {
//           currentWidget = allWidget[2];
//         });
//         break;
//       case "Отчет по движению":
//         setState(() {
//           currentWidget = allWidget[3];
//         });
//         break;
//       case "Зарпалата":
//         BlocProvider.of<SotrudnikiBloc>(context).add(SotrudnikiLoadingEvent());
//         setState(() {
//
//           currentWidget = allWidget[4];
//         });
//         break;
//       case "Отчет по сменам":
//         setState(() {
//           currentWidget = allWidget[5];
//         });
//         break;
//       case "Столы":
//         BlocProvider.of<TablesBloc>(context).add(TablesLoadingEvent(userDataSave.currentObjectWay));
//         setState(() {
//           currentWidget = allWidget[6];
//         });
//
//         break;
//       case "Отчет по посадке":
//         setState(() {
//           currentWidget = allWidget[7];
//         });
//         break;
//       case "Редактирование профиля компании":
//         BlocProvider.of<TablesBloc>(context).add(TablesLoadingEvent(userDataSave.currentObjectWay));
//         BlocProvider.of<PlaceBloc>(context).add(PlaceLoadingEvent(userDataSave.currentObjectWay));
//         setState(() {
//           currentWidget = allWidget[8];
//         });
//         break;
//       default:
//         setState(() {
//           currentWidget = Text("Ooops, что-то сломалось");
//         });
//         break;
//     }
//     setState(() {
//       tab = newTab;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
//       if (state is UserInitialState) {
//         return Scaffold(
//           body: CircularProgressIndicator(),
//         );
//       } else if (state is UserLoadedState) {
//         userDataSave = state.userData;
//         BlocProvider.of<PlaceBloc>(context).add(PlaceLoadingEvent(userDataSave.currentObjectWay));
//
//         return ResponsiveScaffold(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "",
//                 ),
//                 Text(tab),
//                 InkWell(
//                   onTap: () {
//                     Toast.show("Сюда пока не тыкать", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//                   },
//                   child: Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: Colors.transparent,
//                             backgroundImage: NetworkImage(userDataSave.avatar),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "${userDataSave.firstName} ${userDataSave.lastName}",
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text(
//                             "  |  ",
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text(
//                             "${placeDataSave.name}",
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             body: Center(
//               child: currentWidget,
//             ),
//             tabs: [
//               {
//                 'title': 'Финансы',
//                 'children': [
//                   {'title': 'Транзакции'},
//                   {'title': 'Отчет'},
//                 ],
//               },
//               {
//                 'title': 'Склад',
//                 'children': [
//                   {'title': 'Товары'},
//                   {'title': 'Отчет по движению'},
//                 ],
//               },
//               {
//                 'title': 'Сотрудники',
//                 'children': [
//                   {'title': 'Зарпалата'},
//                   {'title': 'Отчет по сменам'},
//                 ],
//               },
//               {
//                 'title': 'Столы',
//                 'children': [
//                   {'title': 'Столы'},
//                   {'title': 'Отчет по посадке'},
//                 ],
//               },
//               {
//                 'title': 'Редактирование профиля компании',
//                 // 'children': [
//                 //   {'title': 'Столы'},
//                 //   {'title': 'Отчет по посадке'},
//                 // ],
//               },
//             ],
//             onTabChanged: setTab
//             // (newTab){
//             // setState(() {
//             //   headerText = newTab;
//             // });
//             // setTab(newTab);
//             // },
//             );
//       } else {
//         return Container(
//           color: Colors.blue,
//         );
//       }
//       // );
//     });
//   }
// }
// //
// // class SideBarMenu extends StatefulWidget {
// //   @override
// //   _SideBarMenuState createState() => _SideBarMenuState();
// // }
// //
// // class _SideBarMenuState extends State<SideBarMenu> with SingleTickerProviderStateMixin {
// //   int _selectedIndex = 0;
// //
// //   List<Widget> pages = [];
// //   bool isCall = true;
// //   TabController myCont;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     myCont = TabController(length: 7, vsync: this);
// //     pages = [
// //       // List of pages of example, this is the principal app content
// //       // Text("Dashboard page"),
// //       // NewsScreen(),
// //       // Container(height: doublNewsScreene.infinity,width: double.infinity, color: Colors.transparent ,),
// //
// //       BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
// //         if (state is NewsInitialState) {
// //           // UntitledBlocProvider.of<NewsBloc>(context).add(NewsLoadEvent());
// //           // isCall ? BlocProvider.of<NewsBloc>(context).add(NewsLoadEvent()):print(isCall);
// //           return Align(
// //             alignment: Alignment.center,
// //             child: SizedBox(
// //               width: MediaQuery.of(context).size.width * 0.3,
// //               height: MediaQuery.of(context).size.width * 0.3,
// //               child: Container(
// //                 width: 250,
// //                 height: 250,
// //                 child: CupertinoActivityIndicator(),
// //                 // FlareActor('assets/astronaught.flr',
// //                 //     alignment: Alignment.center, fit: BoxFit.contain, animation: "Untitled"),
// //               ),
// //             ),
// //           );
// //         } else if (state is NewsLoadedState) {
// //           // isCall ? isCall = !isCall : isCall = isCall;
// //           return NewsScreen(state.loadedData);
// //           // return OopportunitiesPage(state.loadedData);
// //         } else if (state is NewsOnErrorState) {
// //           return Column(
// //             children: [
// //               Text("Error Loading. try again."),
// //               Align(
// //                 alignment: Alignment.center,
// //                 child: SizedBox(
// //                   width: MediaQuery.of(context).size.width * 0.3,
// //                   height: MediaQuery.of(context).size.width * 0.3,
// //                   child: Container(
// //                     width: 250,
// //                     height: 250,
// //                     color: Colors.red,
// //                     child: CircularProgressIndicator(),
// //                     // FlareActor('assets/astronaught.flr',
// //                     //     alignment: Alignment.center, fit: BoxFit.contain, animation: "Untitled"),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           );
// //         }
// //         return null;
// //       }),
// //       AddNewPlace(),
// //       Container(
// //         height: double.infinity,
// //         width: double.infinity,
// //         color: Colors.transparent,
// //       ),
// //       // NewsScreen(),
// //       // Text("Online orders page"),
// //       TestBlocB(),
// //       Text("Codes page"),
// //       Text("Settings page"),
// //       Text("About page"),
// //     ];
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // appBar: AppBar(
// //       //   title: const Text('Plugin example app'),
// //       // ),
// //       body: Row(
// //         children: [
// //           // SideBar Big Eagle
// //           SideBar(
// //               color: Theme.of(context).bottomAppBarTheme.color,
// //               appColor: Colors.grey[850],
// //               // Optional, white is default
// //               accentColor: Colors.white,
// //               // Optional, white is default
// //               onHoverScale: 1.2,
// //               // Recomended value: 1.2, min: 0.5 max: 2
// //               logo: InkWell(
// //                 onTap: () {
// //                   Navigator.pushNamed(context, 'secondScreen');
// //                 },
// //                 child: Container(
// //                   height: 150,
// //                   child: Image.asset(
// //                     "assets/Logo (1).png",
// //                     // fit: BoxFit,
// //                   ),
// //                 ),
// //               ),
// //               children: [
// //                 // Button list
// //                 SideBarButtonFlat(title: "Dashboard", icon: Icons.dashboard),
// //                 SideBarButtonFlat(title: "Inventory", icon: Icons.view_list),
// //                 SideBarButtonFlat(title: "Search", icon: Icons.search),
// //                 SideBarButtonFlat(title: "Online orders", icon: Icons.receipt),
// //                 SideBarButtonFlat(title: "Codes", icon: Icons.qr_code_scanner),
// //                 SideBarButtonFlat(title: "Settings", icon: Icons.settings),
// //                 SideBarButtonFlat(title: "About", icon: Icons.info),
// //               ],
// //               onChange: (value) {
// //                 // When the selection changes, value it's an int
// //                 setState(() {
// //                   _selectedIndex = value;
// //                   myCont.index = value;
// //                 });
// //               }),
// //
// //           Expanded(
// //             child: TabBarView(
// //               physics: NeverScrollableScrollPhysics(),
// //               controller: myCont,
// //               children: [
// //                 BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
// //                   if (state is NewsInitialState) {
// //                     // UntitledBlocProvider.of<NewsBloc>(context).add(NewsLoadEvent());
// //                     // isCall ? BlocProvider.of<NewsBloc>(context).add(NewsLoadEvent()):print(isCall);
// //                     return Align(
// //                       alignment: Alignment.center,
// //                       child: SizedBox(
// //                         width: MediaQuery.of(context).size.width * 0.3,
// //                         height: MediaQuery.of(context).size.width * 0.3,
// //                         child: Container(
// //                           width: 250,
// //                           height: 250,
// //                           child: CupertinoActivityIndicator(),
// //                           // FlareActor('assets/astronaught.flr',
// //                           //     alignment: Alignment.center, fit: BoxFit.contain, animation: "Untitled"),
// //                         ),
// //                       ),
// //                     );
// //                   } else if (state is NewsLoadedState) {
// //                     // isCall ? isCall = !isCall : isCall = isCall;
// //                     return NewsScreen(state.loadedData);
// //                     // return OopportunitiesPage(state.loadedData);
// //                   } else if (state is NewsOnErrorState) {
// //                     return Column(
// //                       children: [
// //                         Text("Error Loading. try again."),
// //                         Align(
// //                           alignment: Alignment.center,
// //                           child: SizedBox(
// //                             width: MediaQuery.of(context).size.width * 0.3,
// //                             height: MediaQuery.of(context).size.width * 0.3,
// //                             child: Container(
// //                               width: 250,
// //                               height: 250,
// //                               color: Colors.red,
// //                               child: CircularProgressIndicator(),
// //                               // FlareActor('assets/astronaught.flr',
// //                               //     alignment: Alignment.center, fit: BoxFit.contain, animation: "Untitled"),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     );
// //                   }
// //                   return null;
// //                 }),
// //                 AddNewPlace(),
// //                 Container(
// //                   height: double.infinity,
// //                   width: double.infinity,
// //                   color: Colors.transparent,
// //                 ),
// //                 // NewsScreen(),
// //                 TestBlocB(),
// //                 Text("Codes page"),
// //                 Text("Settings page"),
// //                 Text("About page"),
// //               ],
// //             ),
// //             // child: pages[_selectedIndex],
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// // class DrawerScreen extends StatefulWidget {
// //   DrawerScreen({Key key}) : super(key: key);
// //
// //   @override
// //   _DrawerScreenState createState() {
// //     return _DrawerScreenState();
// //   }
// // }
// //
// // class _DrawerScreenState extends State<DrawerScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //   }
// //
// //   @override
// //   void dispose() {
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
// //       if (state is UserInitialState) {
// //         return CircularProgressIndicator();
// //       } else if (state is UserLoadedState) {
// //         userDataSave = state.userData;
// //         return Drawer(
// // // Add a ListView to the drawer. This ensures the user can scroll
// // // through the options in the drawer if there isn't enough vertical
// // // space to fit everything.
// // //         semanticLabel: "vaer",
// //           elevation: 0,
// //           child: Stack(
// //             children: [
// //               BackdropFilter(
// //                   filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0), //this is dependent on the import statment above
// //                   child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.55)))),
// //               ListView(
// // // Important: Remove any padding from the ListView.
// //                 padding: EdgeInsets.zero,
// //                 children: <Widget>[
// //                   Padding(
// //                     padding: const EdgeInsets.all(20.0),
// //                     child: Image.asset("assets/logo#2.png"),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         // color: HexColor("ffd2a0"),
// //                         gradient: LinearGradient(
// //                           colors: [
// //                             HexColor("0cbbe2").withOpacity(0.9),
// //                             HexColor("fcc535").withOpacity(0.9),
// //                           ],
// //                           begin: Alignment.topCenter,
// //                           end: Alignment.bottomCenter,
// //                         ),
// //                         // color: ,
// //                         borderRadius: BorderRadius.circular(15.0),
// //                       ),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(15.0),
// //                         child: Column(
// //                           // crossAxisAlignment: CrossAxisAlignment.start,
// //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                           children: [
// //                             Text(
// //                               state.userData.name,
// //                               textAlign: TextAlign.center,
// //                               style: TextStyle(
// //                                 // color: Colors.white,
// //                                 fontSize: 25,
// //                                 fontWeight: FontWeight.w600,
// //                               ),
// //                               maxLines: 2,
// //                             ),
// //                             SizedBox(
// //                               height: 15,
// //                             ),
// //                             Text(
// //                               state.userData.email,
// //                               textAlign: TextAlign.left,
// //                               style: TextStyle(
// //                                 // color: Colors.white,
// //                                 fontSize: 20,
// //                                 fontWeight: FontWeight.w500,
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               height: 5,
// //                             ),
// //                             Text(
// //                               state.userData.phone,
// //                               textAlign: TextAlign.left,
// //                               style: TextStyle(
// //                                 // color: Colors.white,
// //                                 fontSize: 20,
// //                                 fontWeight: FontWeight.w500,
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               height: 15,
// //                             ),
// //                             Text(state.userData.paymentsHistory.length.toString()),
// //                             Text(
// //                               "Подписка: ${state.userData.isPayment ? "активна" : "не активна"}",
// //                               textAlign: TextAlign.left,
// //                               style: TextStyle(
// //                                 // color: Colors.white,
// //                                 fontSize: 23,
// //                                 fontWeight: FontWeight.w500,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   ListTile(
// //                     title: Row(
// //                       children: [
// //                         Icon(
// //                           Icons.account_balance_wallet_outlined,
// //                           size: 35,
// //                         ),
// //                         SizedBox(
// //                           width: 15,
// //                         ),
// //                         Text(
// //                           'Подписка',
// //                           style: TextStyle(
// //                             // color: Colors.white,
// //                             fontSize: 23,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => PaymentScreen()),
// //                       );
// //                     },
// //                   ),
// //                   ListTile(
// //                     title: Row(
// //                       children: [
// //                         Icon(
// //                           Icons.logout,
// //                           size: 35,
// //                         ),
// //                         SizedBox(
// //                           width: 15,
// //                         ),
// //                         Text(
// //                           'Выход',
// //                           style: TextStyle(
// //                             // color: Colors.white,
// //                             fontSize: 23,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     onTap: () {
// //                       BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedOut());
// //                     },
// //                   ),
// //                 ],
// //               ),
// //               Align(
// //                 alignment: Alignment(-0.0, 0.95),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Text(
// //                       "Разарботано компанией",
// //                       style: TextStyle(
// //                         // color: Colors.white,
// //                         fontSize: 22,
// //
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                     SizedBox(
// //                       height: 5,
// //                     ),
// //                     Text(
// //                       "HSearch team",
// //                       style: TextStyle(
// //                         // color: Colors.white,
// //                         fontSize: 24,
// //
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ],
// //                 ),
// //               )
// //             ],
// //           ),
// //         );
// //       } else if (state is UserOnErrorState) {
// //         return Container();
// //       }
// //       return Container();
// //       // );
// //     });
// //   }
// // }
