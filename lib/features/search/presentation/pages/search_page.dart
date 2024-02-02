

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/search/presentation/widgets/listTile.dart';

import '../bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(FetchContactsEvent(context: context));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ColorsConsts.whiteColor,
        ),
        backgroundColor: ColorsConsts.backgroundColor,
        title: Text("Select contact",style: Theme.of(context).textTheme.displayMedium,),
        actionsIconTheme: const IconThemeData(
          color: ColorsConsts.whiteColor,
        ),
        actions: [
          InkWell(
              onTap: (){

              },
              child: Image.asset("assets/image_assets/Search.png")),
          PopupMenuButton(
            itemBuilder: (context){
              return [
                const PopupMenuItem(child: Text("Settings")),

              ];
            },
          ),

        ],
      ),
      backgroundColor: ColorsConsts.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomListTile(
                  icon: Icons.group,
                  title: "New group",
                  onTap: (){},
              ),
              CustomListTile(
                icon: Icons.person_add,
                title: "New contact",
                onTap: (){},
              ),
              CustomListTile(
                icon: Icons.groups,
                title: "New community",
                onTap: (){},
              ),
              Text("Contacts on WhatsApp",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.textGrey),),
              BlocBuilder<SearchBloc,SearchState>(
                  builder: (context,state){
                    if(state is SearchLoaded)
                      {
                        List<UserEntity> users = state.users;
                        print("users" + users.toString());
                        print("usersLength: " + users.length.toString());
                        return ListView.builder(
                          shrinkWrap: true,
                            itemCount: users.length,
                            itemBuilder: (context,index){
                              return ListTile(
                                leading: users[index].profilePic == null
                                  || users[index].profilePic == ""
                                  ? const CircleAvatar(backgroundImage: AssetImage("assets/image_assets/default_profile_picture.jpg"),)
                                  : CircleAvatar(backgroundImage: NetworkImage(users[index].profilePic!)),
                                title: Text(users[index].name!,style: Theme.of(context).textTheme.displaySmall,),
                                subtitle: Text(users[index].about!,style: Theme.of(context).textTheme.displaySmall,),
                              );
                            }
                        );
                      }
                    return const Text("here");
              }),
              Text("Invite to WhatsApp",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.textGrey),),

            ],
          ),
        ),
      ),
    );
  }
}
