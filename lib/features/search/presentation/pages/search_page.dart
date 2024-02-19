

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/search/presentation/widgets/listTile.dart';
import 'package:whatsapp_clone_repository/features/z_global_widgets/round_button.dart';

import '../bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  final UserEntity currentUser;
  const SearchPage({super.key, required this.currentUser});

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
              BlocBuilder<SearchBloc,SearchState>(
                  builder: (context,state){
                    if(state is SearchLoaded)
                      {
                        List<UserEntity> foundUsers = state.foundUsers;
                        List<Contact> notFoundUsers = state.notFoundUsers;
                      //  debugPrint("foundUsers$foundUsers");
                      //  debugPrint("foundUsersLength: ${foundUsers.length}");
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Contacts on WhatsApp",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.iconGrey),),
                            foundUsers.isEmpty
                            ? Text("No users found",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.iconGrey),)
                            :ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                                itemCount: foundUsers.length,
                                itemBuilder: (context,index){
                                  return ListTile(
                                    onTap: (){
                                      context.read<SearchBloc>().add(CreateOrFetchChatRoomEvent(context, currentUser: widget.currentUser, targetUser: foundUsers[index]));
                                    },
                                    leading: foundUsers[index].profilePic == null
                                      || foundUsers[index].profilePic == ""
                                      ? const CircleAvatar(backgroundImage: AssetImage("assets/image_assets/default_profile_picture.jpg"),)
                                      : CircleAvatar(backgroundImage: NetworkImage(foundUsers[index].profilePic!)),
                                    title: widget.currentUser.uid! == foundUsers[index].uid ? Text("( You )",style: Theme.of(context).textTheme.displaySmall,) : Text(foundUsers[index].name!,style: Theme.of(context).textTheme.displaySmall,),
                                    subtitle: Text(foundUsers[index].about!,style: Theme.of(context).textTheme.displaySmall,),
                                  );
                                }
                            ),
                            Text("Invite to WhatsApp",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.iconGrey),),
                             notFoundUsers.isEmpty
                             ? Center(child:Text("No users found",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.iconGrey),),)
                            :ListView.builder(
                                 physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: notFoundUsers.length,
                                    itemBuilder: (context,index){
                                      return ListTile(
                                        leading: const CircleAvatar(backgroundImage: AssetImage("assets/image_assets/default_profile_picture.jpg"),),
                                        title:
                                        notFoundUsers[index].displayName == null || notFoundUsers[index].displayName == ""
                                            ?Text(notFoundUsers[index].phones![0].value.toString(),style: Theme.of(context).textTheme.displaySmall,)
                                            :Text(notFoundUsers[index].displayName!,style: Theme.of(context).textTheme.displaySmall,),
                                        trailing: RoundButton(
                                          width: 0.2.mediaW(context),
                                          onTap: (){

                                          },
                                          title: "Invite",
                                        ),
                                      );
                                    }
                                ),
                          ],
                        );
                      }
                    if(state is SearchNoContactsFound)
                      {
                        return  Center(child: Text(state.noContacts,style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.redColor),));
                      }
                    return  const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
