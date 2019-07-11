import 'package:flutter/material.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 3, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1CD8D2),
        elevation: 2,
        title: Text("iChat"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              //TODO: add actions
              if (value == 3) {
                FirebaseUtils().logOut();
              }
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("About"),
                        Icon(Icons.help_outline,color: Colors.orange,)
                      ],
                    ),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Github"),
                        Icon(LineIcons.github,color: Colors.green,)
                      ],
                    ),
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Logout"),
                        Icon(Icons.exit_to_app,color: Colors.redAccent,)
                      ],
                    ),
                    value: 3,
                  )
                ],
          )
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "Messages",
              icon: Icon(LineIcons.comments),
            ),
            Tab(
              text: "Contacts",
              icon: Icon(LineIcons.users),
            ),
            Tab(
              text: "Profile",
              icon: Icon(LineIcons.user),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
