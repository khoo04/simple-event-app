import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class BottomModalSheet extends StatefulWidget {
  final String eventName;
  final String eventDesc;
  final bool isJoin;
  final Function(bool) callback;

  const BottomModalSheet(
      {super.key,
      required this.eventName,
      required this.eventDesc,
      required this.callback,
      required this.isJoin});

  @override
  State<BottomModalSheet> createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      height: MediaQuery.sizeOf(context).height * 0.5,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.eventName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              CloseButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: createFormattedTextSpans(widget.eventDesc),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: AdvancedSwitch(
              activeColor: Colors.green,
              inactiveColor: Colors.red,
              activeChild: const Text('Join'),
              inactiveChild: const Text('No'),
              width: 80,
              initialValue: widget.isJoin,
              onChanged: (value) => widget.callback(value),
            ),
          ),
        ],
      ),
    );
  }
}

List<TextSpan> createFormattedTextSpans(String text) {
  List<TextSpan> spans = [];
  List<String> lines = text.split('\n');
  for (String line in lines) {
    if (line.contains(':')) {
      List<String> parts = line.split(':');
      if (parts.length == 2) {
        spans.add(TextSpan(
          text: '${parts[0]}: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
        spans.add(TextSpan(text: '${parts[1].trim()}\n'));
      } else {
        spans.add(TextSpan(text: '$line\n'));
      }
    } else {
      spans.add(TextSpan(text: '$line\n'));
    }
  }

  return spans;
}
