import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class SideBarState with ChangeNotifier {
  final PageController pageController = PageController();
  final SideMenuController sideMenuController = SideMenuController();

  SideBarState() {
    sideMenuController.addListener((index) {
      pageController.jumpToPage(index);
    });
  }

  void setPage(int index) {
    sideMenuController.changePage(index);
    notifyListeners();
  }

  void disposeControllers() {
    pageController.dispose();
    sideMenuController.dispose();
  }
}
