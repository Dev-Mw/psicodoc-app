import 'package:flutter/material.dart';
import 'package:psicodoc/service/config.dart';
import 'package:psicodoc/service/home_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartData {
  ChartData(this.x, this.y, this.size);
  final String x;
  final double y;
  final String size;
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool loaded = false;

  static double horrible = 0;
  static double mal = 0;
  static double meh = 0;
  static double bien = 0;
  static double increible = 0;


  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    SingleChildScrollView(child: Column(children: [

      Center(
          child: Container(
              child: SfCircularChart(

                  title: ChartTitle(text:"GRÁFICO DE \nSENTIMIENTOS\n\n", textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
                  tooltipBehavior: TooltipBehavior(enable: true,shared: true,header: "% estado de ánimo"),
                  legend: Legend(isResponsive: true, isVisible: true, title: LegendTitle(text: "Sentimientos",
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      alignment: ChartAlignment.center)),
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                        dataSource: [ // aqui iba chartData
                          ChartData('horrible', horrible, (horrible*3).toString()+'%'), // (cantidad, )
                          ChartData('mal', horrible, (mal*3).toString()+'%'),
                          ChartData('meh', meh, (meh*3).toString()+'%'),
                          ChartData('bien', bien, (bien*3).toString()+'%'),
                          ChartData('increible', increible, (increible*3).toString()+'%')
                        ],
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        // Radius for each segment from data source
                        pointRadiusMapper: (ChartData data, _) => data.size,
                        enableTooltip: true,
                        radius: "20",
                        legendIconType: LegendIconType.circle
                    )
                  ]
              )
          )
      ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 20), child:
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 90),
          decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tip:', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),),
              Text('Recuerda siempre que existen personas que te esperan en casa... o no jaja', style: TextStyle(color: Colors.white, fontSize: 17),)
            ],
          ),
        )
      ),

    ],)),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (!loaded) {
      prefs.then((pref) {
        final email = pref.getString("email").toString();
        Future<Map<String, dynamic>> res = get_feeling_service(email);

        res.then((body) {
          if (body["data"] == "ok") {
            setState(() {
              double hor = body["total"]["horrible"] == null ? 0.0 : double
                  .parse(body["total"]["horrible"]);
              double mal = body["total"]["mal"] == null ? 0.0 : double.parse(
                  body["total"]["mal"]);
              double meh = body["total"]["meh"] == null ? 0.0 : double.parse(
                  body["total"]["meh"]);
              double bie = body["total"]["bien"] == null ? 0.0 : double.parse(
                  body["total"]["bien"]);
              double inc = body["total"]["increible"] == null ? 0.0 : double
                  .parse(body["total"]["increible"]);

              horrible = hor;
              mal = mal;
              meh = meh;
              bien = bie;
              increible = inc;

              loaded = true;
            });
          } else {
            print("No existe");
          }
        });
      });
    }


    return Scaffold(body: SafeArea(child:
        _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Entretenimiento',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),

    );
  }
}
