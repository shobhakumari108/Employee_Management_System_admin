import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/screen/add_employee.dart';
import 'package:employee_management_ad/screen/edit_profile_screen.dart';
import 'package:employee_management_ad/screen/employee_list.dart';
import 'package:employee_management_ad/screen/employee_profile_screen.dart';
import 'package:employee_management_ad/screen/profile_screen.dart';
import 'package:employee_management_ad/util/appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    HomeContent(),
    SettingsContent(),
    ProfileScreen(),
    AddEmployeeScreen(),
    // EditEmployeeScreen(

    // ),
    EmployeeScreen(),
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

  //  String _appBarTitle = "Home Content";

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

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 61, 124, 251),
      //   title: Text(
      //     "Home Screen",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   //  title: Text(_appBarTitle),
      //   leading: IconButton(
      //     icon: Icon(Icons.menu, color: Colors.white),
      //     onPressed: () {
      //       setState(() {
      //         _isSidebarVisible = !_isSidebarVisible;
      //       });
      //     },
      //   ),
      //   actions: [
      //     Row(
      //       children: [
      //         Container(
      //           height: 40,
      //           width: 40,
      //           decoration: BoxDecoration(
      //               // border: Border.all(),
      //               color: Colors.grey[100],
      //               borderRadius: BorderRadius.circular(20)),
      //           child: IconButton(
      //             icon: Icon(Icons.person),
      //             onPressed: () {},
      //           ),
      //         ),
      //         SizedBox(
      //           width: 30,
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Card(
          child: Row(
            children: [
              Visibility(
                visible: _isSidebarVisible,
                child: Expanded(
                  flex: 2,
                  child: Material(
                    // elevation: 10,
                    child: Container(
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text("Home"),
                            leading: Icon(Icons.home),
                            selected: _currentIndex == 0,
                            tileColor: _currentIndex == 0
                                ? Color.fromARGB(255, 61, 124, 251)
                                : null,
                            onTap: () {
                              _navigateToPage(0);
                            },
                          ),
                          ListTile(
                            title: Text("Settings"),
                            leading: Icon(Icons.settings),
                            selected: _currentIndex == 1,
                            tileColor: _currentIndex == 1
                                ? Color.fromARGB(255, 61, 124, 251)
                                : null,
                            onTap: () {
                              _navigateToPage(1);
                            },
                          ),
                          ListTile(
                            title: Text("Profile"),
                            leading: Icon(Icons.person),
                            selected: _currentIndex == 2,
                            tileColor: _currentIndex == 2
                                ? Color.fromARGB(255, 61, 124, 251)
                                : null,
                            onTap: () {
                              _navigateToPage(2);
                            },
                          ),
                          ListTile(
                            title: Text(
                              "Employee",
                              style: TextStyle(fontSize: 14),
                            ),
                            leading: Icon(Icons.person),
                            onTap: () {
                              _toggleEmployeeOptions();
                            },
                          ),
                          if (_showAddEmployeeOptions) ...[
                            ListTile(
                              title: Text(
                                "Add Employee",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  // color: _isEditEmployeeActive ? Colors.green : null,
                                ),
                              ),
                              leading: Icon(Icons.person_add),
                              dense: true,
                              selected: _currentIndex == 3,
                              tileColor: _currentIndex == 3
                                  ? Color.fromARGB(255, 61, 124, 251)
                                  : null,
                              contentPadding: const EdgeInsets.only(left: 40.0),
                              onTap: () {
                                _toggleAddEmployeeActive();
                                _navigateToPage(3);
                              },
                            ),
                            ListTile(
                              title: Text(
                                "Edit Employee",
                                style: TextStyle(fontSize: 12),
                              ),
                              leading: Icon(Icons.edit),
                              dense: true,
                              contentPadding: const EdgeInsets.only(left: 40.0),
                              selected: _currentIndex == 4,
                              tileColor: _currentIndex == 4
                                  ? Color.fromARGB(255, 61, 124, 251)
                                  : null,
                              onTap: () {
                                _toggleEditEmployeeActive();
                                _navigateToPage(4);
                              },
                            ),
                            ListTile(
                              title: Text(
                                "Employee List",
                                style: TextStyle(fontSize: 12),
                              ),
                              leading: Icon(Icons.person_search),
                              dense: true,
                              contentPadding: const EdgeInsets.only(left: 40.0),
                              selected: _currentIndex == 5,
                              tileColor: _currentIndex == 5
                                  ? Color.fromARGB(255, 61, 124, 251)
                                  : null,
                              onTap: () {
                                _toggleEmployeeListActive();
                                _navigateToPage(5);
                              },
                            ),
                            ListTile(
                              title: Text(
                                "Employee Profile",
                                style: TextStyle(fontSize: 12),
                              ),
                              leading: Icon(Icons.person),
                              dense: true,
                              contentPadding: const EdgeInsets.only(left: 40.0),
                              selected: _currentIndex == 6,
                              tileColor: _currentIndex == 6
                                  ? Color.fromARGB(255, 61, 124, 251)
                                  : null,
                              onTap: () {
                                _toggleEmployeeProfileActive();
                                _navigateToPage(6);
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: _isSidebarVisible ? 7 : 9,
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
      ),
    );
  }

  void _navigateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 100),
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

  // void _updateTitle(String title) {
  //   setState(() {
  //     _appBarTitle = title;
  //   });
  // }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Home Content"),
      body: Container(
        child: Center(
          child: Text("Home Content"),
        ),
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Settings Content"),
      body: Container(
        child: Center(
          child: Text("Settings Content"),
        ),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.menu, color: Colors.white),
      onPressed: () {
        // setState(() {
        //   _isSidebarVisible = !_isSidebarVisible;
        // });
      },
    ),

    title: Text(title),
    // elevation: 0,
    backgroundColor: Color.fromARGB(255, 61, 124, 251),
    actions: [
      Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                // border: Border.all(),
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20)),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    ],
  );
}
