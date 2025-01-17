import "package:flutter/material.dart";
import "package:getteacher/net/rate_meeting/rate_meeting.dart";
import "package:getteacher/net/rate_meeting/rate_meeting_net_model.dart";
import "package:getteacher/views/meeting_summary_screen/star_rating_input.dart";

class StarRatingScreen extends StatefulWidget {
  StarRatingScreen({required this.meetingGuid});
  final String meetingGuid;

  @override
  StarRatingScreenState createState() => StarRatingScreenState();
}

class StarRatingScreenState extends State<StarRatingScreen> {
  int currentRating = 5;
  bool isFavoriteTeacher = false;

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Rate this meeting:",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              StarWidget(
                rating: currentRating,
                onChanged: (final int newRating) {
                  setState(() {
                    currentRating = newRating;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: isFavoriteTeacher,
                    onChanged: (final bool? newValue) {
                      setState(() {
                        isFavoriteTeacher = newValue ?? false;
                      });
                    },
                  ),
                  const Text("Mark as favorite teacher"),
                ],
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text("Submit"),
                onPressed: () async {
                  await rateMeeting(
                    RateMeetingRequestModel(
                      guid: widget.meetingGuid,
                      rating: currentRating,
                      favoriteTeacher: isFavoriteTeacher,
                    ),
                  );

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
}
