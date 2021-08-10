import 'package:flutter/material.dart';

import './login_drawer.dart';
import './logout_drawer.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: LogoutDrawer(),
      ),
    );
  }
}
