import 'package:care2x/ViewRemedies/Remedy_description.dart';
import 'package:care2x/ViewRemedies/remedy.dart';
import 'package:flutter/material.dart';

class ViewRemedy extends StatefulWidget {
  const ViewRemedy({Key? key}) : super(key: key);

  @override
  _ViewRemedyState createState() => _ViewRemedyState();
}

class _ViewRemedyState extends State<ViewRemedy> {
  List<Remedy> remedies = [
    Remedy(
        title: 'Type 2 diabetes',
        description:
            'Several studies in England have looked at the effects of a very low-calorie diet on diabetes. Two had people follow a mostly liquid diet of 625-850 calories a day for 2-5 months, followed by a less restricted diet designed to help them keep off the weight they lost. Both studies found that nearly half the people who took part reversed their diabetes and kept their blood glucose near the normal range for at least 6 months to a year.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
    Remedy(
        title: 'High Triglyceride',
        description:
            'Carrying even a few extra pounds contributes to high cholesterol. Small changes add up. If you drink sugary beverages, switch to tap water. Snack on air-popped popcorn or pretzels — but keep track of the calories. If you crave something sweet, try sherbet or candies with little or no fat, such as jelly beans.'),
  ];
  @override
  Widget build(BuildContext context) {
    void _showDescriptionPanel(Remedy Rem) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Description(rem: Rem),
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Remedies'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: ListView.builder(
            itemCount: remedies.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  onTap: () {},
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        remedies[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: MaterialButton(
                          onPressed: () =>
                              _showDescriptionPanel(remedies[index]),
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "View Remedy",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
