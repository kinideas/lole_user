import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

import '../services/api/placesapi.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
   AddressSearch({required this.sessionToken}) {
    apiClient = PlaceApiProvider(sessionToken);
  }
   final sessionToken;
  late PlaceApiProvider apiClient;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  // @override
  // Widget buildResults(BuildContext context) {
  //   return null;
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Suggestion>>(
      // We will put the api call here
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    // we will display the data returned from our future here
                    title:
                        Text(snapshot.data![index].description),
                    onTap: () {
                      close(context, snapshot.data![index]);
                    },
                  ),
                  itemCount: snapshot.data!.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}