import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_event_app/models/event.dart';
import 'package:simple_event_app/widgets/bottom_modal_sheet.dart';
import 'package:simple_event_app/widgets/event_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  bool _isModalOpen = false;
  List<Event> eventList = [];

  void changeModalStatusCallBack(bool isOpen) {
    _isModalOpen = isOpen;
  }

  Future<void> initializeData() async {
    //Try Get Data from Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    String? eventJson = prefs.getString("events");
    if (eventJson == null) {
      //Initialize Event List
      eventList = [
        Event(
          eventName: "UTEM Fun Run",
          imageUrl: "1.png",
          eventDesc:
              """Join us for the UTEM Fun Run, an exciting event designed for fitness enthusiasts of all levels! Whether you're a seasoned runner or just looking to enjoy a leisurely jog, this event is perfect for you. Come and experience a vibrant atmosphere filled with music, cheers, and camaraderie as we run through the scenic routes of our beautiful campus. Don't miss the chance to get active, have fun, and make new friends. Grab your running shoes and let's hit the track!

Date: 15/06/2024
Time: 9am
Location: UTEM Campus
Registration Fee: RM10
""",
        ),
        Event(
            eventName: "UTEM Recycle Event",
            imageUrl: "2.png",
            eventDesc:
                """Be part of the solution at the UTEM Recycle Event! This initiative aims to promote sustainability and environmental awareness within our community. Bring your recyclable materials, such as plastics, papers, and electronics, and help us make a difference. Learn about the importance of recycling, participate in workshops, and contribute to a cleaner, greener planet. Together, we can create a positive impact for future generations.

Date: 16/06/2024
Time: 9am-5pm
Location: UTEM Campus PPB 
Contact: 011-1111111
"""),
        Event(
            eventName: "Business Talk",
            imageUrl: "3.png",
            eventDesc:
                """Join us for an insightful Business Talk with industry leaders and experts. This event is tailored for students, entrepreneurs, and professionals eager to gain valuable knowledge about the latest trends and strategies in the business world. Network with like-minded individuals, learn from success stories, and get inspired to take your career or business to the next level. Don’t miss this opportunity to expand your horizons and stay ahead in the competitive market.
              
Date: 17/06/2024
Time: 2pm
Location: FTMK Dewan Seminar
Speakers: Dr. Sanusi
Registration: Free
""")
      ];
    } else {
      final eventMap = jsonDecode(eventJson) as List<dynamic>;
      eventList = eventMap.map((e) => Event.fromJson(e)).toList();
    }

    setState(() {
      //Create Quick Action
      const QuickActions quickActions = QuickActions();
      quickActions.setShortcutItems(eventList
          .map((item) => ShortcutItem(
              type: item.eventName, localizedTitle: item.eventName))
          .toList());

      quickActions.initialize((type) {
        Event? selectedEvent;
        try {
          selectedEvent = eventList.firstWhere(
            (event) => event.eventName == type,
          );
        } catch (e) {
          selectedEvent = null;
        }

        if (selectedEvent != null) {
          if (_isModalOpen) {
            Navigator.pop(context);
          }
          // Handle the selected event
          changeModalStatusCallBack(true);
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomModalSheet(
              eventName: selectedEvent!.eventName,
              eventDesc: selectedEvent.eventDesc,
              callback: selectedEvent.changeJoinStatus,
              isJoin: selectedEvent.isJoin,
            ),
          ).then((_) => changeModalStatusCallBack(false));
        } else {
          debugPrint('No matching event found for shortcut: $type');
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeData();
  }

  void saveDataToLocal() async {
    final prefs = await SharedPreferences.getInstance();

    //Parse List to Json
    final List<Map<String, dynamic>> eventMap =
        eventList.map((e) => e.toJson()).toList();
    final json = jsonEncode(eventMap);
    //Save events list in json
    await prefs.setString("events", json);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;
    //If App is Paused, Save Data
    if (isBackground) {
      saveDataToLocal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: Image.asset(
                "assets/images/logo.jpeg",
                height: 50.0,
              ),
            ),
            const SizedBox(width: 15.0),
            const Text("Adv Technologies"),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, top: 10.0),
            child: Text(
              "Event You May Interest",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).width * 0.4,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (context, index) => EventCard(
                event: eventList[index],
                changeModalStatusCallBack: changeModalStatusCallBack,
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Opacity(
                  opacity: 0.5,
                  child: Image.asset("assets/images/logo.jpeg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
