import 'package:flutter/material.dart';

class LinearStepsWidget extends StatefulWidget {
  const LinearStepsWidget({Key? key, required this.status}) : super(key: key);
  final String status;
  @override
  // ignore: library_private_types_in_public_api
  _LinearStepsWidgetState createState() => _LinearStepsWidgetState();
}

class _LinearStepsWidgetState extends State<LinearStepsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentStep = 0;

  final List<String> _stepTitles = [
    'PRONTO PARA EMBARQUE',
    'EM TRÂNSITO INTERNACIONAL',
    'CUSTOMER CLEARENCE',
    'LIBERADO',
  ];

  final List<String> _stepDates = [
    '20/03/23',
    '22/03/23',
    '24/03/23',
    '26/03/23'
  ];

  final List<IconData> _stepIcons = [
    Icons.conveyor_belt,
    Icons.flight_takeoff,
    Icons.request_quote,
    Icons.check_circle,
  ];

  @override
  void initState() {
    super.initState();
    final status = widget.status;
    int status_code = 0;

    if (status == 'Pronto para embarque') {
      status_code = 0;
    } else if (status == 'Em trânsito internacional') {
      status_code = 1;
    } else if (status == 'Customer clearence') {
      status_code = 2;
    } else if (status == 'Liberado') {
      status_code = 3;
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    _getStep(status_code);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getStep(int step) {
    setState(() {
      _currentStep = step;
    });
    _controller.reset();
  }

  Widget _buildStep(int step) {
    bool completed = step+1 <= _currentStep;
    
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      _stepIcons[step],
                      color: step <= _currentStep ? Colors.blue : Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _stepTitles[step],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: step <= _currentStep ? Colors.blue : Colors.grey,
                        fontWeight: step <= _currentStep
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ]
                ),
                Text(
                  _stepDates[step],
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    color: step <= _currentStep
                        ? const Color.fromARGB(255, 36, 36, 36)
                        : Colors.transparent,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ]
            ),
            const SizedBox(height: 15),
          ],
        );
        } else {
        return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                _stepIcons[step],
                color: step <= _currentStep ? Colors.blue : Colors.grey,
                size: 20,
              ),
              const SizedBox(height: 10),
              Text(
                _stepTitles[step],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: step <= _currentStep ? Colors.blue : Colors.grey,
                  fontWeight: step <= _currentStep ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                _stepDates[step],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: step <= _currentStep
                      ? const Color.fromARGB(255, 36, 36, 36)
                      : Colors.transparent,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('2 DIAS',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 8,
                      color: step != 3 && completed
                          ? Colors.grey
                          : Colors.transparent,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  height: 2,
                  width: step != 3 ? 200 : 0,
                  decoration: BoxDecoration(
                    color: completed ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ],
          )
        ],
      );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) { 
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStep(0),
              _buildStep(1),
              _buildStep(2),
              _buildStep(3),
            ],
          ),
        );
        } else {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStep(0),
              _buildStep(1),
              _buildStep(2),
              _buildStep(3),
            ],
          ),
        );
        }
      }
    );
  }
}
