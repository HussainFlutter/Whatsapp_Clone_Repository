import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/status/domain/entity/status_entity.dart';
import 'package:whatsapp_clone_repository/features/status/presentation/bloc/get_my_status_cubit.dart';
import 'package:whatsapp_clone_repository/features/z_global_widgets/default_circle_avatar_or_profile_pic.dart';

import '../bloc/status_bloc.dart';

class StatusPage extends StatefulWidget {
  final UserEntity currentUser;
  const StatusPage({super.key, required this.currentUser});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  void initState() {
    super.initState();
    //print("chatRooms"+widget.currentUser.chatRoomsWith.toString());
    print("calling1");
    context.read<GetMyStatusCubit>().getMyStatusFunc(widget.currentUser.uid!);
    print("calling2");
    context.read<StatusBloc>().add(GetStatusEvent(currentUser: widget.currentUser));
  }

  @override
  Widget build(BuildContext context) {
    //print("hi");
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(0.05.mediaW(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Status",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            BlocBuilder<GetMyStatusCubit, GetMyStatusState>(
              builder: (context, state) {
                if (state is GetMyStatusLoaded) {
                  return ListTile(
                    onTap: () {
                      state.status == null
                          ? context.read<StatusBloc>().add(CreateStatusEvent(
                              context: context,
                              currentUser: widget.currentUser))
                          : Navigator.pushNamed(
                              context,
                              RouteNames.viewStoryPage,
                              arguments: state.status!.stories,
                            );
                    },
                    leading: DefaultCircleAvatar(
                      type: state.status?.stories![0].type == StatusType.video.toString() ? "video" : null,
                      url: state.status?.stories![0].url,
                    ),
                    title: Text(
                      "My Status",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 0.05.mediaW(context)),
                    ),
                    subtitle: Text(
                      state.status == null
                          ? "Tap to add status update"
                          : "Tap to see status",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: ColorsConsts.iconGrey),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            0.05.sizeH(context),
            Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: ColorsConsts.iconGrey,
                collapsedIconColor: ColorsConsts.iconGrey,
                initiallyExpanded: true,
                title: Text(
                  "Recent updates",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: ColorsConsts.iconGrey),
                ),
                children: <Widget>[
                  BlocBuilder<StatusBloc, StatusState>(
                    builder: (context, state) {
                      if(state is StatusLoadedState)
                        {
                          final status = state.statusList;
                          if(status == null || status.isEmpty)
                            {
                              return Center(
                                child: Text(
                                  "No updates",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(fontSize: 15,color: ColorsConsts.iconGrey),
                                ),
                              );
                            }
                          else
                            {
                              print("updates");
                              print(status);
                              print(status.length);
                              return ListView.builder(
                                shrinkWrap: true,
                                  itemCount: status.length,
                                  itemBuilder: (context,index){
                                    return ListTile(
                                      onTap: (){
                                       Navigator.pushNamed(
                                          context,
                                          RouteNames.viewStoryPage,
                                          arguments: status[index].stories,
                                        );
                                      },
                                      leading: DefaultCircleAvatar(
                                        type: status[index].stories![0].type == StatusType.video.toString() ? "video" : null,
                                        url: status[index].stories![0].url,
                                      ),
                                      title: Text(
                                        status[index].name!,
                                        style: Theme.of(context).textTheme.displaySmall!
                                            .copyWith(color: ColorsConsts.whiteColor,fontSize: 0.05.mediaW(context)
                                        ),
                                      ),
                                      subtitle: Text(
                                        DateFormat("hh:mma").format(status[index].createAt!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(color: ColorsConsts.iconGrey,
                                            fontSize: 0.04.mediaW(context)
                                        ),
                                      ),
                                    );
                                  }
                              );
                            }
                        }
                      return const Text("Nothing called",style: TextStyle(color: Colors.white),);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
