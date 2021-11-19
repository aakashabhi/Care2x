import 'package:flutter/material.dart';

import 'doctorsList.dart';

class DocterList extends StatelessWidget {
  const DocterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctors[index].hospitalName),
            Text(doctors[index].name),
            Text(doctors[index].specification),
          ],
        ),
      ),
    );
    },
      itemCount: doctors.length,
    );
  }
}
