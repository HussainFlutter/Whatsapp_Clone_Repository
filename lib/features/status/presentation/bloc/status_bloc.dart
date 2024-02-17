import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/dependency_injection.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/widgets/dialog_loading.dart';
import 'package:whatsapp_clone_repository/features/status/domain/entity/custom_story_entity.dart';
import 'package:whatsapp_clone_repository/features/status/domain/entity/status_entity.dart';
import 'package:whatsapp_clone_repository/features/status/domain/usecase/upload_image_use_case.dart';
import '../../domain/usecase/create_status_usecase.dart';
import '../../domain/usecase/delete_status_usecase.dart';
import '../../domain/usecase/get_status_usecase.dart';
import '../../domain/usecase/update_status_usecase.dart';
import 'package:path/path.dart' as path;

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final CreateStatusUseCase create;
  final DeleteStatusUseCase delete;
  final UpdateStatusUseCase update;
  final GetStatusUseCase getStatus;
  final UploadImageUseCase upload;
  StatusBloc({
    required this.upload,
    required this.update,
    required this.delete,
    required this.create,
    required this.getStatus,
}) : super(StatusInitial()) {
    on<CreateStatusEvent>((event, emit) =>_createStatus(event));
    on<GetStatusEvent>((event, emit) => _getStatus(event,emit));
    on<DemoEvent>((event, emit) => _demoEvent(event, emit));
  }
  _createStatus (
      CreateStatusEvent event,
      ) async {
    try{
      ImagePicker  picker = ImagePicker();
      List<XFile>? pickedFiles =  await picker.pickMultipleMedia();
      if(pickedFiles.isNotEmpty){
        showDialog(
          barrierDismissible: false,
            context: event.context,
            builder: (context){
          return Center(
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                DialogLoading(),
              ],
            ),
          );
        },
        );
        List<CustomStoryEntity> stories = [];
        for(int i = 0 ; i < pickedFiles.length ; i++)
          {
           String extension = path.extension(pickedFiles[i].path.toLowerCase());
           if (extension == '.jpg' || extension == '.jpeg' ||
               extension == '.png') {
             // Upload image and then return url
             final result = await upload(pickedFiles[i].path);
             result.fold((url){
               stories.add(CustomStoryEntity(
                 type: StatusType.image.toString(),
                 url: url,
               ));
             },
             (r) => throw r);
           } else if (extension == '.mp4' || extension == '.mov' ||
               extension == '.avi') {
             // Upload video and then return url
             final result = await upload(pickedFiles[i].path);
             result.fold((url){
               stories.add(CustomStoryEntity(
                 type: StatusType.video.toString(),
                 url: url,
               ));
             },
             (r) => throw r);
           }
          }
        await create(
          StatusEntity(
          statusId: randomId.v1(),
          profilePic: event.currentUser?.profilePic,
          creatorUid: event.currentUser!.uid,
          name: event.currentUser!.name,
          createAt: DateTime.now(),
          stories: stories,
        ));
        if(event.context.mounted)
          {
            toast(message: "Uploaded",backgroundColor: ColorsConsts.containerGreen);
            Navigator.pop(event.context);
          }
      }
    }catch(e){
      if(event.context.mounted)
      {
        toast(message: "Failed to Upload");
        Navigator.pop(event.context);
      }
      customPrint(message: e.toString());
      rethrow;
    }
  }

  _getStatus (
      GetStatusEvent event,
      Emitter<StatusState> emit,
      ) {
   // print("calling");
    getStatus.call(const StatusEntity(), event.currentUser).listen((event) {
   //   print("called");
      add(DemoEvent(statusList: event));
    //  print("emittted");
    });
  }
  _demoEvent (
      DemoEvent event,
      Emitter<StatusState> emit,
      ) {
    emit(StatusLoadedState(statusList: event.statusList));
  }
}
