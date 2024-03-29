import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/get_users_usecase.dart';

import '../../../../core/failures.dart';
import '../../domain/usecase/create_chat_room_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetUsersUseCase getUsers;
  final CreateChatRoomUseCase createChatRoom;
  SearchBloc({required this.getUsers,required this.createChatRoom}) : super(SearchInitial()) {
    on<FetchContactsEvent>((event, emit) => _fetchContacts(event, emit));
    on<CreateOrFetchChatRoomEvent>((event, emit) => _createChatRoom(event));
  }

  _fetchContacts(
    FetchContactsEvent event,
    Emitter<SearchState> emit,
  ) async {
    try {
      final contactsPermission = await Permission.contacts.request();
      if (contactsPermission.isGranted) {
        // when permission is granted we fetch users from firebase
        //  debugPrint("granted");
        late Either<List<UserEntity>, Failure> user;
        // Getting contacts
        List<Contact> contactsFromDevice = await ContactsService.getContacts(withThumbnails: false);
        List<Contact> contacts = [];
        // print(contacts[0].phones![0].value.toString());
        // print(contacts[1].phones![0].value.toString());
        // print(contacts[2].phones![0].value.toString());
        // print(contacts[3].phones![0].value.toString());
        // print(contacts[4].phones![0].value.toString());
        print("contacts length "+contactsFromDevice.length.toString());
        for(int i = 0 ; i < contactsFromDevice.length;i++)
          {
            if(contactsFromDevice[i].phones!.isNotEmpty)
              {
                print("hi");
                contacts.add(contactsFromDevice[i]);
              }
            print(contacts);
          }
        print(contacts);
        Completer<void> completer = Completer<void>();
        if (contacts.isNotEmpty) {
          // Getting all users from firebase
          getUsers(const UserEntity()).listen(
                (users) {
              user = users;
              completer.complete();
            },
            onDone: () => completer.complete(),
            onError: (e) => completer.complete(),
          );
          await completer.future;
          // after the stream is done we now fold the user and check if
          //any of the contacts phoneNumber match the phoneNumber in user aka firebase list
          //Users that are have a account on whatsapp clone
          user.fold((user) {
            //debugPrint(user.toString());
            // fetched users
            //user[0].phoneNumber;
            List<UserEntity> foundUsers = [];
            List<Contact> notFoundUsers = [];
            List<Contact> cloneList = [];
            customPrint(message: "USERS$user");
            //found users loop
            for (int i = 0; i < user.length; i++) {
              // adding users that are found in foundUsers
              for (int j = 0; j < contacts.length; j++) {
                if (
                user[i].phoneNumber!.contains(
                    contacts[j]
                        .phones![0]
                        .value
                        .toString()
                        .replaceAll(" ", "")
                        .replaceAll("-", "")
                        .toString()
                )) {
                  foundUsers.add(
                    user[i],
                  );
                  customPrint(message: "${foundUsers}empty");
                }
                else {}
              }
            }

            // Not found users loop
            for (int i = 0; i < contacts.length; i++) {
              // adding users that are found in foundUsers
              cloneList = contacts;
              for (int j = 0; j < foundUsers.length; j++) {
                if (
                contacts[i]
                    .phones![0]
                    .value
                    .toString()
                    .replaceAll(" ", "")
                    .replaceAll("-", "")
                    .toString().contains(
                  foundUsers[j].phoneNumber!,
                )
                ) {
                  cloneList.removeAt(i);
                  notFoundUsers = cloneList;
                }
              }
            }
            if (foundUsers.isNotEmpty) {
              emit(SearchLoaded(
                  foundUsers: foundUsers, notFoundUsers: notFoundUsers));
            }
          }, (r) {
            throw r;
          });
        }
        else {
          emit(SearchNoContactsFound());
        }
      }
      else if (contactsPermission.isPermanentlyDenied) {
        //       debugPrint("not granted");
        await showDialogBox(event.context);
      } else {
        //  debugPrint("not granted2");
        if (event.context.mounted) {
          Navigator.pop(event.context);
        }
      }
    }
  catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
 }

  _createChatRoom (
      CreateOrFetchChatRoomEvent event,
      ) async {
    try{
    final result =  await createChatRoom(event.currentUser,event.targetUser);
    result.fold((chatRoom) {
      if(event.context.mounted)
      {
        Navigator.pushNamed(
            event.context,
            RouteNames.chatRoomPage,
            arguments: {
              "currentUser" : event.currentUser,
              "targetUser" : event.targetUser,
              "chatRoomEntity" : chatRoom,
            }
        );
      }
    }, (r) {
      toast(message: r.message!);
    });
    }catch(e){
      customPrint(message: e.toString());
      rethrow;
    }
  }

}

  Future showDialogBox(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorsConsts.backgroundColor,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "WhatsApp clone needs contacts permission to work, Please grant contacts permission from apps Settings",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  "Click Open Settings to Open App Settings",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    await openAppSettings();
                  },
                  child: Text(
                    "Open Settings",
                    style: Theme.of(context).textTheme.displaySmall,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    toast(message: "Permission not granted");
                  },
                  child: Text(
                    "Back",
                    style: Theme.of(context).textTheme.displaySmall,
                  ))
            ],
          );
        });
  }

