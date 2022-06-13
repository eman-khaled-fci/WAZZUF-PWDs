import 'package:flutter/material.dart';

class ViewApplication extends StatefulWidget {
  final job;
  final status;
  const ViewApplication({Key key, this.job, this.status}) : super(key: key);

  @override
  State<ViewApplication> createState() => _ViewApplicationState();
}

class _ViewApplicationState extends State<ViewApplication> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              mainRowBuilder(title: 'Organization', details: widget.job['organization']),
              mainRowBuilder(title: 'Address', details: widget.job['address']),
              mainRowBuilder(title: 'Department', details: widget.job['department']),
              mainRowBuilder(title: 'Title', details: widget.job['title']),
              mainRowBuilder(title: 'Desability', details: widget.job['disability']),
              mainRowBuilder(title: 'Description', details: widget.job['description']),
              mainRowBuilder(title: 'Application Status', details: widget.status),
            ],
          ),
        ));
  }

  Widget mainRowBuilder({String title, String details}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title : ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: size.width, child: Text(details)),
        ],
      ),
    );
  }
}
