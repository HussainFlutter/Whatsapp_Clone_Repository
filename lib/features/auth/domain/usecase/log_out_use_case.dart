

import '../repo/auth_repo.dart';

class LogOutUseCase {

  final AuthRepo repo;

  const LogOutUseCase({required this.repo});

  Future<void> call () => repo.logOut();

}