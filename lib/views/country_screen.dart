import 'package:covid19_tracker_app/views/world_states.dart';
import 'package:flutter/material.dart';

class CountryScreen extends StatefulWidget {
  String name;
  String image;
  String continent;
  int population;
  int totalCases;
  int totalRecovered;
  int totalDeaths;
  int activeCases;
  int todayCases;


  CountryScreen(
      {
      required this.name,
      required this.image,
      required this.continent,
        required this.population,
        required this.totalCases,
        required this.totalRecovered,
        required this.totalDeaths,
        required this.activeCases,
        required this.todayCases
      });

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                 Padding(
                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                   child: Card(
                     color: Colors.grey.shade700,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * .06),
                          ReusableRow(title: "Continent", value: widget.continent),
                          ReusableRow(title: 'Population', value: widget.population.toString()),
                          ReusableRow(title: "Total Cases", value: widget.totalCases.toString()),
                          ReusableRow(title: "Total Deaths", value: widget.totalDeaths.toString()),
                          ReusableRow(title: "Total Recovered", value: widget.totalRecovered.toString()),
                          ReusableRow(title: "Today Cases", value: widget.todayCases.toString()),
                          ReusableRow(title: "Active Cases", value: widget.activeCases.toString()),
                        ],
                      ),
                    ),
                ),
                 ),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


