import 'package:covid19_tracker_app/Services/world_states.dart';
import 'package:covid19_tracker_app/views/country_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  WorldStatesData countriesData = WorldStatesData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade800,
      ),
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Search with country name",
                  contentPadding:const EdgeInsets.all(20),
                  hintStyle: const TextStyle(color: Colors.grey),
                  iconColor: Colors.grey,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 3,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 3,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  border: InputBorder.none,
                  enabled: true,
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                future: countriesData.getCountries(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountryScreen(
                                          name: snapshot.data![index]
                                          ['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          continent: snapshot.data![index]['continent'],
                                          population: snapshot.data![index]['population'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          todayCases: snapshot.data![index]['todayCases'],
                                          activeCases: snapshot.data![index]['active'],
                                        )));
                              },
                              child: ListTile(
                                leading: Image(
                                  width: 50,
                                  height: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                title: Text(
                                  snapshot.data![index]['country'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountryScreen(
                                          name: snapshot.data![index]
                                          ['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          continent: snapshot.data![index]['continent'],
                                          population: snapshot.data![index]['population'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          todayCases: snapshot.data![index]['todayCases'],
                                          activeCases: snapshot.data![index]['active'],
                                        )));

                              },
                              child: ListTile(
                                leading: Image(
                                  width: 50,
                                  height: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                title: Text(
                                  snapshot.data![index]['country'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        });
                  } else {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.builder(itemBuilder: (context, position) {
                        return ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                          ),
                          title: Container(
                            width: 89,
                            height: 10,
                            color: Colors.white,
                          ),
                          subtitle: Container(
                            width: 89,
                            height: 10,
                            color: Colors.white,
                          ),
                        );
                      }),
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
