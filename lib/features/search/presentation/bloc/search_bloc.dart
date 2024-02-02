import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/get_users_usecase.dart';

import '../../../../core/failures.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetUsersUseCase getUsers;

  SearchBloc({required this.getUsers}) : super(SearchInitial()) {
    on<FetchContactsEvent>((event, emit) => _fetchContacts(event, emit));
  }

  _fetchContacts(
    FetchContactsEvent event,
    Emitter<SearchState> emit,
  ) async {
    try {
      final contactsPermission = await Permission.contacts.request();
      if (contactsPermission.isGranted) {
        debugPrint("granted");
        late Either<List<UserEntity>, Failure> user;
        List<Contact> contacts = await ContactsService.getContacts();
        Completer<void> completer = Completer<void>();
        getUsers(const UserEntity()).listen(
          (users) {
            user = users;
            completer.complete();
          },
          onDone: () => completer.complete(),
          onError: (e) => completer.complete(),
        );
        await completer.future;
        user.fold((user) {
          debugPrint(user.toString());
          // fetched users
          //user[0].phoneNumber;
          List<UserEntity> foundUsers = [];
          for (int i = 0; i < contacts.length; i++) {
            // Phone number and name of them.
            // debugPrint(contacts[i].phones![0].value.toString());
            //debugPrint(contacts[i].displayName.toString());
            // debugPrint(contacts[i].phones![0].value.toString().replaceAll(" ", "").replaceAll("-", "").toString());
            foundUsers.addAll(user.where((element) =>
                element.phoneNumber ==
                contacts[i]
                    .phones![0]
                    .value
                    .toString()
                    .replaceAll(" ", "")
                    .replaceAll("-", "")
                    .toString()));
            debugPrint("Found users = " + foundUsers.toString());
            if (foundUsers.isNotEmpty) {
              print(foundUsers.length.toString());
              emit(SearchLoaded(users: foundUsers));
            }
          }
        }, (r) {
          throw r;
        });
        // print(contacts[1].phones![0].value.toString());
      } else if (contactsPermission.isPermanentlyDenied) {
        debugPrint("not granted");
        await showDialogBox(event.context);
      } else {
        debugPrint("not granted2");
        if (event.context.mounted) {
          Navigator.pop(event.context);
        }
      }
    } catch (e) {
      rethrow;
    }
    //testing
    // if("+92 320 0840304".replaceAll(" ", "")== "+923200840304")
    //   {
    //     print("y2798esss");
    //   }
    // else
    //   {
    //     print("noo98o2o");
    //   }
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
}
