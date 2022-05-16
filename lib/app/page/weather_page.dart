import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';
import '../utilities/constant.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Body();
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: const [
            // Info Weather now
            _WeatherNow(),
            // Detail Weather
            _WeatherDetail(),

            // Weather Forecast
            _WeatherForecast(),
          ],
        ),
      ),
    );
  }
}

class _WeatherNow extends StatefulWidget {
  const _WeatherNow({Key? key}) : super(key: key);

  @override
  State<_WeatherNow> createState() => __WeatherNowState();
}

class __WeatherNowState extends State<_WeatherNow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(25)),
        height: MediaQuery.of(context).size.height / 2.3,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // App Name
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Weather App',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            // Weather Info
            Padding(
              padding: const EdgeInsets.only(top: 25.0, right: 25, left: 25),
              child: Row(
                children: [
                  Text(
                    'Today',
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  const Spacer(),
                  const Text(''),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 25, left: 25),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '10',
                          style: GoogleFonts.poppins(fontSize: 70, color: Colors.white),
                        ),
                        TextSpan(
                          text: '°C',
                          style: GoogleFonts.rubik(
                            fontSize: 70,
                            color: selectedColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Weather Icon
                  Image.network(
                    'http://openweathermap.org/img/wn/10d.png',
                    scale: 0.5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 25, left: 25, bottom: 20),
              child: Row(
                children: [
                  Icon(
                    const IconData(
                      0xf193,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: selectedColor,
                  ),
                  Expanded(
                    child: Text(
                      'Pamulang',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.rubik(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatefulWidget {
  const _WeatherDetail({Key? key}) : super(key: key);

  @override
  State<_WeatherDetail> createState() => __WeatherDetailState();
}

class __WeatherDetailState extends State<_WeatherDetail> {
  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: screensize.height / 9,
        width: screensize.width,
        decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(
                    WeatherIcons.strong_wind,
                    color: selectedColor,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '10 Km/h',
                    style: GoogleFonts.rubik(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(
                    WeatherIcons.humidity,
                    color: selectedColor,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '70%',
                    style: GoogleFonts.rubik(fontSize: 15, color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(
                    WeatherIcons.rain,
                    color: selectedColor,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '0.0 mm',
                    style: GoogleFonts.rubik(fontSize: 15, color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherForecast extends StatefulWidget {
  const _WeatherForecast({Key? key}) : super(key: key);

  @override
  State<_WeatherForecast> createState() => __WeatherForecastState();
}

class __WeatherForecastState extends State<_WeatherForecast> {
  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return SizedBox(
      height: screensize.height / 5,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screensize.width / 3,
              decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.network(
                        'http://openweathermap.org/img/wn/10d.png',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '',
                        style: GoogleFonts.rubik(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '',
                              style: GoogleFonts.rubik(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "°C",
                              style: GoogleFonts.rubik(
                                fontSize: 15,
                                color: selectedColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
