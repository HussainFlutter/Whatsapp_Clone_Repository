

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/create_user_usecase.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main () {

  late CreateUserUseCase usecase;
  late AuthRepo repo;
  setUp(() {
    repo = MockAuthRepo();
    usecase = CreateUserUseCase(repo: repo);
  });

  test(
      "should call the [Repository.createUser]", () async {
        //AAA
    // Arrange
    final user = UserEntity(
      uid: "",
      createAt: DateTime.now(),
      about: "",
      presence: false,
      phoneNumber: "",
      profilePic: "",
    );
    //Act
    usecase(
      user,
    );
    //Assert
  }
  );
}

// https://www.youtube.com/watch?v=_E3EF1jPumM&t=6604s
//watch 2:10:00