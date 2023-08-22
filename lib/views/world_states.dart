import 'package:covid19_tracker_app/Services/world_states.dart';
import 'package:covid19_tracker_app/views/countrystates_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  final WorldStatesData worldData = WorldStatesData();

  @override
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  static const color = <Color>[Colors.blue, Colors.green, Colors.red];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: FutureBuilder(
          future: worldData.getWorldStates(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  PieChart(
                    chartType: ChartType.disc,
                      chartValuesOptions:
                          const ChartValuesOptions(showChartValuesInPercentage: true),
                      colorList: color,
                      chartRadius: 180,
                      animationDuration: const Duration(seconds: 1),
                      legendOptions: const LegendOptions(
                          legendTextStyle: TextStyle(color: Colors.white),
                          legendPosition: LegendPosition.left),
                      dataMap: {
                        "Total": double.parse(snapshot.data!.cases.toString()),
                        'Recovered': double.parse(snapshot.data!.recovered.toString()),
                        'Death': double.parse(snapshot.data!.deaths.toString())
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade700),
                    child: Card(
                      color: Colors.grey.shade700,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableRow(
                                title: "Total",
                                value: snapshot.data!.recovered.toString()),
                            ReusableRow(
                                title: "Recovered",
                                value: snapshot.data!.recovered.toString()),
                            ReusableRow(
                                title: "Death",
                                value: snapshot.data!.deaths.toString()),
                            ReusableRow(
                                title: "Today Cases",
                                value: snapshot.data!.todayCases.toString()),
                            ReusableRow(
                                title: "Today Deaths",
                                value: snapshot.data!.todayDeaths.toString()),
                            ReusableRow(
                                title: "Today Recovered",
                                value: snapshot.data!.todayRecovered.toString()),
                            ReusableRow(
                                title: "Critical",
                                value: snapshot.data!.critical.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CountryStatesScreen()));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        "Track Countries",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              );
            } else {
              return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50,
                    controller: _controller,
                  ));
            }
          },
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
