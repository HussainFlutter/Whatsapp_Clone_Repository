import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
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
    context.read<GetMyStatusCubit>().getMyStatusFunc(widget.currentUser.uid!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(0.05.mediaW(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            BlocBuilder<GetMyStatusCubit, GetMyStatusState>(
              builder: (context, state) {
                if(state is GetMyStatusLoaded)
                  {
                    return ListTile(
                          onTap: () {
                            state.status == null
                             ? context.read<StatusBloc>().add(CreateStatusEvent(currentUser: widget.currentUser))
                             : Navigator.pushNamed(
                              context,
                              RouteNames.viewStoryPage,
                              arguments: state.status!.stories,
                            );
                          },
                          leading: DefaultCircleAvatar(url: state.status?.stories![0].url,),
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
                                :"Tap to see status",
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
            Text(
              "Recent updates",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: ColorsConsts.iconGrey),
            ),
            ListTile(
              leading: const CircleAvatar(),
              title: Text(
                "Username",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              subtitle: Text(
                "Timestamp",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorsConsts.iconGrey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
