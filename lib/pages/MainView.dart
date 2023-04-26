import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/bloc/bottom_cubit.dart';
import 'package:instagram_clone/pages/favourite_page.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/profile_page.dart';
import 'package:instagram_clone/pages/search_page.dart';
import 'package:instagram_clone/pages/upload_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  var pages = [
    HomePage(),
    SearchPage(),
    UploadPage(),
    FavouritePage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: BlocBuilder<BottomNavigationCubit, int> (
        builder: (context, state) {
          return Scaffold(
            body: pages[state],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state,
              onTap: (index) {
                BlocProvider.of<BottomNavigationCubit>(context).updateTab(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(
                    Icons.home,
                    size: 32,
                  )
                ),
                BottomNavigationBarItem(
                  label: 'Search',
                  icon: Icon(
                    Icons.search,
                    size: 32,
                  )
                ),
                BottomNavigationBarItem(
                  label: 'Add',
                  icon: Icon(
                    Icons.add_box_outlined,
                    size: 32,
                  )
                ),
                BottomNavigationBarItem(
                    label: 'Favourite',
                    icon: Icon(
                      Icons.favorite_outline,
                      size: 32,
                    )
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(
                    Icons.person,
                    size: 32,
                  )
                ),
              ],
            ),
          );
        }
      )
    );
  }
}
