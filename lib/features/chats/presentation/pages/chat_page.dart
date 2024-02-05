import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/data/models/user_model.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/get_single_user_usecase.dart';
import 'package:whatsapp_clone_repository/features/chats/presentation/widgets/no_chats_available_widget.dart';
import 'package:whatsapp_clone_repository/features/search/data/model/chat_room_model.dart';
import '../../../../core/dependency_injection.dart';
import '../widgets/chat_room_list_tile.dart';

class ChatsPage extends StatefulWidget {
  final UserEntity currentUser;
  const ChatsPage({super.key, required this.currentUser});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      body: Column(
        children: [
          StreamBuilder(
            stream: sl<FirebaseFirestore>()
                .collection(FirebaseConsts.chatRooms)
                .where("participants", arrayContains: widget.currentUser.uid!)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  List<ChatRoomModel> chatRoomFetchedList = [];
                  List<String> fetchedUsersUid = [];
                  final data = snapshot.data;
                  if (data!.docs.isNotEmpty) {
                    for (int i = 0; i < data.docs.length; i++) {
                      chatRoomFetchedList.add(ChatRoomModel.fromSnapshot(data.docs[i]));
                      fetchedUsersUid.add(chatRoomFetchedList[i].participants![0]);
                      fetchedUsersUid.add(chatRoomFetchedList[i].participants![1]);
                      fetchedUsersUid.remove(widget.currentUser.uid);
                    }
                    debugPrint("UID: ${widget.currentUser.uid!}");
                    debugPrint(fetchedUsersUid.length.toString());
                    debugPrint(chatRoomFetchedList.length.toString());
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: fetchedUsersUid.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                              stream: sl<GetSingleUserUseCase>().call(
                                  UserEntity(uid: fetchedUsersUid[index])),
                              builder: (context, snapshot) {
                                debugPrint("Active");
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasData) {
                                    debugPrint("Have data");
                                    // Show list tiles of chatRooms
                                    return snapshot.data!.fold((data) {
                                      UserEntity targetUser = data[0];
                                      customPrint(message: targetUser.toString());
                                      return ChatRoomListTile(
                                        chatRoomFetchedList:chatRoomFetchedList[index],
                                        currentUser:widget.currentUser,
                                        targetUser: targetUser,
                                      );
                                    }, (r) {
                                      return Center(
                                          child: Text(
                                        "error occurred ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(color: Colors.red),
                                      ));
                                    });
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child: Text(
                                      "error occurred ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(color: Colors.red),
                                    ));
                                  } else {
                                    return Center(
                                        child: Text(
                                      "Check your internet",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(color: Colors.red),
                                    ));
                                  }
                                } else {
                                  return const Text("ELAHEH");
                                }
                              });
                        },
                      ),
                    );
                  }
                } else if (snapshot.data!.docs.isEmpty) {
                  return Column(
                    children: [
                      Center(
                          child: NoChatsYet(currentUser: widget.currentUser)),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Some Error Occurred",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.red),
                  ));
                }
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                    child: Text(
                  "Check your internet connection",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.red),
                ));
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(
            context,
            RouteNames.searchPage,
            arguments: widget.currentUser,
          );
        },
        backgroundColor: ColorsConsts.containerGreen,
        child: Image.asset("assets/image_assets/comment_icon.png"),
      ),
    );
  }
}
