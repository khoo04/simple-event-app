import 'package:flutter/material.dart';
import 'package:simple_event_app/models/event.dart';
import 'package:simple_event_app/widgets/bottom_modal_sheet.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function(bool) changeModalStatusCallBack;
  const EventCard(
      {super.key,
      required this.event,
      required this.changeModalStatusCallBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          child: Image.asset(
            "assets/images/${event.imageUrl}",
            fit: BoxFit.contain,
          ),
        ),
        onTap: () {
          changeModalStatusCallBack(true);
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomModalSheet(
              eventName: event.eventName,
              eventDesc: event.eventDesc,
              callback: event.changeJoinStatus,
              isJoin: event.isJoin,
            ),
          ).then((_) => changeModalStatusCallBack(false));
        },
      ),
    );
  }
}
