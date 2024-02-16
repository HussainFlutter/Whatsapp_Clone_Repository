import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import '../features/auth/auth_injection.dart';
import '../features/chat_room/chat_room_injection.dart';
import '../features/search/search_injection.dart';
import '../features/status/status_injection.dart';

//Global variables

final GetIt sl = GetIt.instance;

const Uuid randomId = Uuid();

Future<void> init() async {
  await searchInIt();
  await authInjection();
  await chatRoomInit();
  await statusInjection();
  //External Sources
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}