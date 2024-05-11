import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/provider/weather_data.dart';
import 'package:weather_app/view/result&weather_details/result_and_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();

    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        body: SafeArea(
          child: Consumer<WeatherData>(
            builder: (context, weatherProvider, child) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Color(0xff955cd1),
                      Color(0xff3fa2fa),
                    ],
                  ),
                ),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.h,
                          width: 60.w,
                          child: Lottie.asset('assets/lottie/home2.json'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 30),
                              filled: true,
                              fillColor: Colors.white30,
                              icon: const Icon(Icons.location_on_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Enter The Location',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            String location = _searchController.text.trim();
                            if (location.isNotEmpty) {
                              // var weatherProvider = context.read<WeatherData>();

                              // //   try {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ResultPage(location: location),
                                ),
                              );
                              await Provider.of<WeatherData>(context,
                                      listen: false)
                                  .getWeatherData(location);
                              // await weatherProvider.getWeatherData(location);

                              //     // Handle weather data, e.g., show it on the next screen

                              //   } catch (error) {
                              //     // Handle error, e.g., show an error message
                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //         content: Text('Error: $error'),
                              //       ),
                              //     );
                              //   }
                              // } else {
                              //   // Show an error message if the location is empty
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content: Text('Please enter a location'),
                              //     ),
                              //   );
                            }
                          },
                          child: const Text('Search'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
