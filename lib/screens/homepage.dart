import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dehas_admin/screens/loading.dart';
import 'package:dehas_admin/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatelessWidget {
   HomePage({super.key});

  final db = DatabaseServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.getAlert(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: Text(
                    'Alerts',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map alert = snapshot.data![index];
                      String t = DateFormat('dd MMM yyyy  HH:mm:ss')
                          .format((alert['timestamp'] as Timestamp).toDate());

                      return FutureBuilder<Map>(
                          future: db.getUser(alert['uid']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/logo.png'),
                                    const Text(
                                      'D.E.H.A.S',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CircularProgressIndicator(
                                      color: Colors.blue[300],
                                    ),
                                  ],
                                ),
                              );
                            }

                            if (snapshot.hasData) {
                              return ListTile(
                                leading: const Icon(Icons.warning, size: 25),
                                title: Text(
                                    '${snapshot.data!['name']}  - ${snapshot.data!['email']}'),
                                subtitle: Text(t),
                                trailing: IconButton(
                                  icon: const Icon(Icons.map),
                                  onPressed: () => launchUrl(Uri.parse(
                                      'https://maps.google.com/?q=${alert['latitude']},${alert['longitude']}')),
                                ),
                              );
                            }
                            return const Text('hello');
                          });
                    }),
              ],
            );
          }
          return const Center(child: Text('No alerts available'));
        });
  }
}
