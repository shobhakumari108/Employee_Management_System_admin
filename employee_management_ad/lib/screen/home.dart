import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/screen/add_employee.dart';
import 'package:employee_management_ad/screen/edit_profile_screen.dart';
import 'package:employee_management_ad/screen/employee_list.dart';
import 'package:employee_management_ad/screen/employee_profile_screen.dart';
import 'package:employee_management_ad/screen/holiday_screen.dart';
import 'package:employee_management_ad/screen/home_screen.dart';
import 'package:employee_management_ad/screen/profile_screen.dart';
import 'package:employee_management_ad/util/appbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Widget _currentPage = HomeContent();
  final List<Widget> _pages = [
    HomeContent(),
    HolidayScreen(),
    // ProfileScreen(),
    AddEmployeeScreen(),
    // EmployeeEditScreen(
    //   employee: UserData(),
    // ),
    const EmployeeScreen(),
    EmployeeProfileScreen(
      employee: UserData(),
    ),
  ];
  int _currentIndex = 0;
  late PageController _pageController;
  bool _showAddEmployeeOptions = false;
  bool _isAddEmployeeActive = false;
  bool _isEditEmployeeActive = false;
  bool _isEmployeeListActive = false;
  bool _isEmployeeProfileActive = false;
  bool _isSidebarVisible = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void _toggleEmployeeOptions() {
    setState(() {
      _showAddEmployeeOptions = !_showAddEmployeeOptions;
    });
  }

  void _toggleAddEmployeeActive() {
    setState(() {
      _isAddEmployeeActive = !_isAddEmployeeActive;
    });
  }

  void _toggleEditEmployeeActive() {
    setState(() {
      _isEditEmployeeActive = !_isEditEmployeeActive;
    });
  }

  void _toggleEmployeeListActive() {
    setState(() {
      _isEmployeeListActive = !_isEmployeeListActive;
    });
  }

  void _toggleEmployeeProfileActive() {
    setState(() {
      _isEmployeeProfileActive = !_isEmployeeProfileActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.blueGrey[100],
      padding: const EdgeInsets.all(30),
      height: size.height,
      width: size.width,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: _isSidebarVisible ? 3 : 0,
                child: Visibility(
                  visible: _isSidebarVisible,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          title: const Text("Home"),
                          leading: const Icon(Icons.home),
                          selected: _currentIndex == 0,
                          tileColor: _currentIndex == 0
                              ? const Color.fromARGB(255, 61, 124, 251)
                              : null,
                          onTap: () {
                            _navigateToPage(0);
                          },
                        ),
                        ListTile(
                          title: const Text("HoliDay"),
                          leading: const Icon(Icons.holiday_village_rounded),
                          selected: _currentIndex == 1,
                          tileColor: _currentIndex == 1
                              ? const Color.fromARGB(255, 61, 124, 251)
                              : null,
                          onTap: () {
                            _navigateToPage(1);
                          },
                        ),
                        // ListTile(
                        //   title: const Text("Profile"),
                        //   leading: const Icon(Icons.person),
                        //   selected: _currentIndex == 2,
                        //   tileColor: _currentIndex == 2
                        //       ? const Color.fromARGB(255, 61, 124, 251)
                        //       : null,
                        //   onTap: () {
                        //     _navigateToPage(2);
                        //   },
                        // ),
                        ListTile(
                          title: const Text(
                            "Employee",
                            style: TextStyle(fontSize: 14),
                          ),
                          leading: const Icon(Icons.person),
                          onTap: () {
                            _toggleEmployeeOptions();
                          },
                        ),
                        if (_showAddEmployeeOptions) ...[
                          ListTile(
                            title: const Text(
                              "Add Employee",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                // color: _isEditEmployeeActive ? Colors.green : null,
                              ),
                            ),
                            leading: const Icon(Icons.person_add),
                            dense: true,
                            selected: _currentIndex == 2,
                            tileColor: _currentIndex == 2
                                ? const Color.fromARGB(255, 61, 124, 251)
                                : null,
                            contentPadding: const EdgeInsets.only(left: 40.0),
                            onTap: () {
                              _toggleAddEmployeeActive();
                              _navigateToPage(2);
                            },
                          ),
                          // ListTile(
                          //   title: Text(
                          //     "Edit Employee",
                          //     style: TextStyle(fontSize: 12),
                          //   ),
                          //   leading: Icon(Icons.edit),
                          //   dense: true,
                          //   contentPadding: const EdgeInsets.only(left: 40.0),
                          //   selected: _currentIndex == 4,
                          //   tileColor: _currentIndex == 4
                          //       ? Color.fromARGB(255, 61, 124, 251)
                          //       : null,
                          //   onTap: () {
                          //     _toggleEditEmployeeActive();
                          //     _navigateToPage(4);
                          //   },
                          // ),
                          ListTile(
                            title: const Text(
                              "Employee List",
                              style: TextStyle(fontSize: 12),
                            ),
                            leading: const Icon(Icons.person_search),
                            dense: true,
                            contentPadding: const EdgeInsets.only(left: 40.0),
                            selected: _currentIndex == 3,
                            tileColor: _currentIndex == 3
                                ? const Color.fromARGB(255, 61, 124, 251)
                                : null,
                            onTap: () {
                              _toggleEmployeeListActive();
                              _navigateToPage(3);
                            },
                          ),
                          // ListTile(
                          //   title: Text(
                          //     "Employee Profile",
                          //     style: TextStyle(fontSize: 12),
                          //   ),
                          //   leading: Icon(Icons.person),
                          //   dense: true,
                          //   contentPadding: const EdgeInsets.only(left: 40.0),
                          //   selected: _currentIndex == 6,
                          //   tileColor: _currentIndex == 6
                          //       ? Color.fromARGB(255, 61, 124, 251)
                          //       : null,
                          //   onTap: () {
                          //     _toggleEmployeeProfileActive();
                          //     _navigateToPage(6);
                          //   },
                          // ),
                        ],
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: _isSidebarVisible ? 7 : 9,
                child: Column(
                  children: [
                    AppBar(
                      title: Card(
                        color: Colors.blueGrey[100],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.menu,
                                      color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      _isSidebarVisible = !_isSidebarVisible;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    _currentIndex == 0
                                        ? "Home"
                                        : _currentIndex == 1
                                            ? "Holiday"
                                            // : _currentIndex == 2
                                            //     ? "Profile"
                                            : _currentIndex == 2
                                                ? "Add Employee"
                                                : _currentIndex == 3
                                                    ? "Employee List"
                                                    : "",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.person))
                          ],
                        ),
                      ),

                      // elevation: 0,
                      backgroundColor: Colors.white,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height - 124,
                            child: PageView(
                              controller: _pageController,
                              children: _pages,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

// class HomeS extends StatefulWidget {
//   const HomeS({Key? key}) : super(key: key);

//   @override
//   _HomeSState createState() => _HomeSState();
// }

// class _HomeSState extends State<HomeS> {
//   final List<Widget> _pages = [
//     HomeContent(),
//     SettingsContent(),
//     // ProfileScreen(),
//     AddEmployeeScreen(),
//     // EmployeeEditScreen(
//     //   employee: UserData(),
//     // ),
//     const EmployeeScreen(),
//     EmployeeProfileScreen(
//       employee: UserData(),
//     ),
//   ];

//   int _currentIndex = 0;
//   late PageController _pageController;
//   bool _showAddEmployeeOptions = false;
//   bool _isAddEmployeeActive = false;
//   bool _isEditEmployeeActive = false;
//   bool _isEmployeeListActive = false;
//   bool _isEmployeeProfileActive = false;
//   bool _isSidebarVisible = true;

//   //  String _appBarTitle = "Home Content";

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _currentIndex);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Color.fromARGB(255, 61, 124, 251),
//       //   title: Text(
//       //     "Home Screen",
//       //     style: TextStyle(color: Colors.white),
//       //   ),
//       //   //  title: Text(_appBarTitle),
//       //   leading: IconButton(
//       //     icon: Icon(Icons.menu, color: Colors.white),
//       //     onPressed: () {
//       //       setState(() {
//       //         _isSidebarVisible = !_isSidebarVisible;
//       //       });
//       //     },
//       //   ),
//       //   actions: [
//       //     Row(
//       //       children: [
//       //         Container(
//       //           height: 40,
//       //           width: 40,
//       //           decoration: BoxDecoration(
//       //               // border: Border.all(),
//       //               color: Colors.grey[100],
//       //               borderRadius: BorderRadius.circular(20)),
//       //           child: IconButton(
//       //             icon: Icon(Icons.person),
//       //             onPressed: () {},
//       //           ),
//       //         ),
//       //         SizedBox(
//       //           width: 30,
//       //         ),
//       //       ],
//       //     ),
//       //   ],
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Card(
//           elevation: 5,
//           child: SizedBox(
//             height: size.height,
//             child: Row(
//               children: [
//                 Visibility(
//                   visible: _isSidebarVisible,
//                   child: SizedBox(
//                     width: size.width * .3,
//                     height: size.height,
//                     child: Column(
//                       children: [
//                         ListTile(
//                           title: const Text("Home"),
//                           leading: const Icon(Icons.home),
//                           selected: _currentIndex == 0,
//                           tileColor: _currentIndex == 0
//                               ? const Color.fromARGB(255, 61, 124, 251)
//                               : null,
//                           onTap: () {
//                             _navigateToPage(0);
//                           },
//                         ),
//                         ListTile(
//                           title: const Text("Settings"),
//                           leading: const Icon(Icons.settings),
//                           selected: _currentIndex == 1,
//                           tileColor: _currentIndex == 1
//                               ? const Color.fromARGB(255, 61, 124, 251)
//                               : null,
//                           onTap: () {
//                             _navigateToPage(1);
//                           },
//                         ),
//                         ListTile(
//                           title: const Text("Profile"),
//                           leading: const Icon(Icons.person),
//                           selected: _currentIndex == 2,
//                           tileColor: _currentIndex == 2
//                               ? const Color.fromARGB(255, 61, 124, 251)
//                               : null,
//                           onTap: () {
//                             _navigateToPage(2);
//                           },
//                         ),
//                         ListTile(
//                           title: const Text(
//                             "Employee",
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           leading: const Icon(Icons.person),
//                           onTap: () {
//                             _toggleEmployeeOptions();
//                           },
//                         ),
//                         if (_showAddEmployeeOptions) ...[
//                           ListTile(
//                             title: const Text(
//                               "Add Employee",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 // color: _isEditEmployeeActive ? Colors.green : null,
//                               ),
//                             ),
//                             leading: const Icon(Icons.person_add),
//                             dense: true,
//                             selected: _currentIndex == 3,
//                             tileColor: _currentIndex == 3
//                                 ? const Color.fromARGB(255, 61, 124, 251)
//                                 : null,
//                             contentPadding: const EdgeInsets.only(left: 40.0),
//                             onTap: () {
//                               _toggleAddEmployeeActive();
//                               _navigateToPage(3);
//                             },
//                           ),
//                           // ListTile(
//                           //   title: Text(
//                           //     "Edit Employee",
//                           //     style: TextStyle(fontSize: 12),
//                           //   ),
//                           //   leading: Icon(Icons.edit),
//                           //   dense: true,
//                           //   contentPadding: const EdgeInsets.only(left: 40.0),
//                           //   selected: _currentIndex == 4,
//                           //   tileColor: _currentIndex == 4
//                           //       ? Color.fromARGB(255, 61, 124, 251)
//                           //       : null,
//                           //   onTap: () {
//                           //     _toggleEditEmployeeActive();
//                           //     _navigateToPage(4);
//                           //   },
//                           // ),
//                           ListTile(
//                             title: const Text(
//                               "Employee List",
//                               style: TextStyle(fontSize: 12),
//                             ),
//                             leading: const Icon(Icons.person_search),
//                             dense: true,
//                             contentPadding: const EdgeInsets.only(left: 40.0),
//                             selected: _currentIndex == 4,
//                             tileColor: _currentIndex == 4
//                                 ? const Color.fromARGB(255, 61, 124, 251)
//                                 : null,
//                             onTap: () {
//                               _toggleEmployeeListActive();
//                               _navigateToPage(4);
//                             },
//                           ),
//                           // ListTile(
//                           //   title: Text(
//                           //     "Employee Profile",
//                           //     style: TextStyle(fontSize: 12),
//                           //   ),
//                           //   leading: Icon(Icons.person),
//                           //   dense: true,
//                           //   contentPadding: const EdgeInsets.only(left: 40.0),
//                           //   selected: _currentIndex == 6,
//                           //   tileColor: _currentIndex == 6
//                           //       ? Color.fromARGB(255, 61, 124, 251)
//                           //       : null,
//                           //   onTap: () {
//                           //     _toggleEmployeeProfileActive();
//                           //     _navigateToPage(6);
//                           //   },
//                           // ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       AppBar(
//                         leading: IconButton(
//                           icon: const Icon(Icons.menu, color: Colors.white),
//                           onPressed: () {
//                             setState(() {
//                               _isSidebarVisible = !_isSidebarVisible;
//                             });
//                           },
//                         ),

//                         title: Text(_currentIndex == 0
//                             ? ""
//                             : _currentIndex == 1
//                                 ? ""
//                                 : ""),
//                         // elevation: 0,
//                         backgroundColor:
//                             const Color.fromARGB(255, 61, 124, 251),
//                         actions: [
//                           Row(
//                             children: [
//                               Container(
//                                 height: 40,
//                                 width: 40,
//                                 decoration: BoxDecoration(
//                                     // border: Border.all(),
//                                     color: Colors.grey[100],
//                                     borderRadius: BorderRadius.circular(20)),
//                                 child: IconButton(
//                                   icon: const Icon(Icons.person),
//                                   onPressed: () {},
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 30,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: size.height - 60,
//                         child: PageView(
//                           controller: _pageController,
//                           children: _pages,
//                           onPageChanged: (index) {
//                             setState(() {
//                               _currentIndex = index;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _navigateToPage(int index) {
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 100),
//       curve: Curves.easeInOut,
//     );
//   }

//   void _toggleEmployeeOptions() {
//     setState(() {
//       _showAddEmployeeOptions = !_showAddEmployeeOptions;
//     });
//   }

//   void _toggleAddEmployeeActive() {
//     setState(() {
//       _isAddEmployeeActive = !_isAddEmployeeActive;
//     });
//   }

//   void _toggleEditEmployeeActive() {
//     setState(() {
//       _isEditEmployeeActive = !_isEditEmployeeActive;
//     });
//   }

//   void _toggleEmployeeListActive() {
//     setState(() {
//       _isEmployeeListActive = !_isEmployeeListActive;
//     });
//   }

//   void _toggleEmployeeProfileActive() {
//     setState(() {
//       _isEmployeeProfileActive = !_isEmployeeProfileActive;
//     });
//   }

//   // void _updateTitle(String title) {
//   //   setState(() {
//   //     _appBarTitle = title;
//   //   });
//   // }
// }



class SettingsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(context, "Settings Content"),
      body: Container(
        child: const Center(
          child: Text("Settings Content"),
        ),
      ),
    );
  }
}

// AppBar buildAppBar(BuildContext context, String title) {
//   return AppBar(
//     leading: IconButton(
//       icon: Icon(Icons.menu, color: Colors.white),
//       onPressed: () {
//         setState(() {
//           _isSidebarVisible = !_isSidebarVisible;
//         });
//       },
//     ),

//     title: Text(title),
//     // elevation: 0,
//     backgroundColor: Color.fromARGB(255, 61, 124, 251),
//     actions: [
//       Row(
//         children: [
//           Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//                 // border: Border.all(),
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(20)),
//             child: IconButton(
//               icon: Icon(Icons.person),
//               onPressed: () {},
//             ),
//           ),
//           SizedBox(
//             width: 30,
//           ),
//         ],
//       ),
//     ],
//   );
// }
