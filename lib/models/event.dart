class Event {
  final String eventName;
  final String imageUrl;
  final String eventDesc;
  bool isJoin;

  Event({
    required this.eventName,
    required this.imageUrl,
    required this.eventDesc,
    this.isJoin = false, //Is Not Join By Default
  });

  void changeJoinStatus(bool isJoin) {
    this.isJoin = isJoin;
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        eventName: json['eventName'] as String,
        imageUrl: json['imageUrl'] as String,
        eventDesc: json['eventDesc'] as String,
        isJoin: json['isJoin'] as bool);
  }

  Map<String, dynamic> toJson() => {
        'eventName': eventName,
        'imageUrl': imageUrl,
        'eventDesc': eventDesc,
        'isJoin': isJoin,
      };

  static final events = [
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
"""),
    Event(
        eventName: "Code Hunt",
        imageUrl: "4.png",
        eventDesc:
            """Get ready for an exhilarating challenge at the Code Hunt! This coding competition is designed for programmers of all skill levels. Test your problem-solving abilities, showcase your coding skills, and compete against the best minds in the field. With exciting prizes and the thrill of competition, Code Hunt promises to be an unforgettable experience. Whether you're a beginner or a pro, join us for a day of coding, learning, and fun!

Date: 20/06/2024
Time: 9am-5pm
Location: UTEM Computer Lab
Registration Fee: Free
Prizes: RM200 for gold

Feel free to adjust the dates, times, and other specific details as needed!
"""),
  ];
}
