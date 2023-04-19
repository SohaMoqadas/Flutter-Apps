import 'package:flutter/material.dart';

void main() => runApp(const ResumeApp());

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Resume'),
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 50, // adjust as needed
                  backgroundImage: AssetImage('assets/soha.jpg'),
                ),


                const Text(
                  'Soha Moqadas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Software Engineer',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Colors.grey[700],
                  ),
                ),


                const SizedBox(height: 20.0),
                Text(
                  'Education',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.blueGrey[900],
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bachelor in Computer Science, (2020 - Present)',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green,
                                size: 20.0),
                            const SizedBox(width: 5.0),
                            Expanded(
                              child: Text(
                                'COMSATS University Islamabad, Vehari Campus',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Intermediate (2017 - 2019)',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.grey[800],
                          )
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green,
                                size: 20.0),
                            const SizedBox(width: 5.0),
                            Expanded(
                              child: Text(
                                'Aspire College, Vehari Campus',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),



                const SizedBox(height: 10.0),
                Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Matric (2015 - 2017)',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green,
                                size: 20.0),
                            const SizedBox(width: 5.0),
                            Expanded(
                              child: Text(
                                'Divisional Public School, Vehari Campus',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Skills',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.blueGrey[900],
                  ),
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 5.0,
                  children: const [
                    Chip(
                      backgroundColor: Colors.purple,
                      label: Text(
                        'C++',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(
                      backgroundColor: Colors.purple,
                      label: Text(
                        'HTML/CSS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(
                      backgroundColor: Colors.purple,
                      label: Text(
                        'Python',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(
                      backgroundColor: Colors.purple,
                      label: Text(
                        'C#',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 20.0),
                Text(
                  'Hobbies',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.blueGrey[900],
                  ),
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 5.0,
                  children: const [
                    Chip(
                      backgroundColor: Colors.purple,
                      label: Text(
                        'Badminton',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(
                      backgroundColor: Colors.purple,
                      label: Text(
                        'Designing',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(
                      backgroundColor: Colors.purple,
                      label: Text(
                        'Reading',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),)
        ,
      )
      ,
    );
  }
}