import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Presentations/Category/category_screen.dart';
import '../../Presentations/Home/home_screen.dart';
import '../../Presentations/Profile/profile_screen.dart';
import '../../Repository/Home/home_repo.dart';
final homeScreenController =
ChangeNotifierProvider((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  HomeRepository homeRepository = HomeRepository();
  var _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setPageIndex({index}) => _currentIndex = index;




  //------------------ List Declare------------------------//
  List<Widget> pageList = [ const HomeScreen(),const CategoryScreen(),const ProfileScreen()];



}

