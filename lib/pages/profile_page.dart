import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/item/post_item.dart';
import 'package:instagram_clone/model/user_model.dart';
import 'package:instagram_clone/profile/profile_cubit.dart';
import 'package:instagram_clone/profile/profile_state.dart';
import 'package:instagram_clone/profile/show_profile_picker.dart';
import 'package:instagram_clone/service/auth_service.dart';

import '../upload/show_picker.dart';
import '../utils/states.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  UserModel user = UserModel('', '');

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black, fontFamily: 'Billabong', fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: (){
                AuthService.signOutUser(context);
              },
              icon: const Icon(Icons.exit_to_app),
            color: const Color.fromRGBO(193, 53, 132, 1),
          )
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (BuildContext ctx, state){
          if(state is ProfileLoading){
            return viewProfile(ctx, true, user);
          }

          if(state is ProfileLoad){
            user = state.user;
            return viewProfile(ctx, false, user);
          }

          if(state is ProfileInit){
            return viewProfile(ctx, false, user);
          }

          return const Center(child: Text('Ooop!'));
        }
      )
    );
  }


  viewProfile(BuildContext context, bool isLoading, UserModel user) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [

              ////// #MyPhoto
              GestureDetector(
                onTap: (){
                  showProfilePicker(context);
                },
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        border: Border.all(
                          width: 1.5,
                          color: const Color.fromRGBO(193, 53, 132, 1),
                        )
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: user.imgUrl == null
                          ? const Image(
                          image: AssetImage(
                            'assets/Gentra.jpg'),
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        )
                            : CachedNetworkImage(
                          imageUrl: user.imgUrl!,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.add_circle,
                            color: Colors.purple,
                          )
                        ],
                      ),
                    )
                  ],
                )),



              ////// #My_info
              const SizedBox(
                height: 10,
              ),
              Text(
                user.fullName ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                user.email ?? '',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
              ),



              ////// #My_counts
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                          '0',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              'POSTS',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              user.followersCount.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              'FOLLOWERS',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              user.followingCount.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              'FOLLOWING',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),



              ////// @List or grid
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: IconButton(
                          onPressed: (){
                            BlocProvider.of<ProfileCubit>(context).changeAxisCount(1);
                          },
                          icon: const Icon(Icons.list_alt)
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: IconButton(
                          onPressed: (){
                            BlocProvider.of<ProfileCubit>(context).changeAxisCount(3);
                          },
                          icon: const Icon(Icons.grid_view)),
                    ),
                  )
                ],
              ),


              ////// #My_post
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.watch<ProfileCubit>().axisCount),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return itemOfHomePost(items[index]);
                    },),
              )
            ],
          ),
        ),
         isLoading?
         const Center(
         child: CircularProgressIndicator(),
         )
         : const SizedBox.shrink()
      ],
    );
  }
}
