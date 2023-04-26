import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/search/search_cubit.dart';
import 'package:instagram_clone/search/search_state.dart';

import '../item/search_item.dart';
import '../model/user_model.dart';
import '../utils/states.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  var searchController = TextEditingController();
  List<UserModel> users = [];

  @override

  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context).searchUser('');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 25),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState> (
        builder: (ctx, state) {
          if(state is SearchLoading){
            return view(ctx, true);
          }
          if(state is SearchLoad){
            users = state.users;
            return view(ctx, false);
          }

          return const Center(child: Text('Ooop'),);
        },
      )
    );
  }






  Widget view(BuildContext context, bool isLoading){
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [

              ////// #Search_member
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7)),
                child: TextField(
                  style: const TextStyle(color: Colors.black87),
                  controller: searchController,
                  decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      )
                  ),
                ),
              ),



              ////// #Member_list
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (ctx, index) {
                    return itemOfUser(users[index]);
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
