import '../screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/icon_content.dart';
import '../components/reusable_card.dart';
import '../constants.dart';
import '../components/round_icon_button.dart';
import '../components/bottom_button.dart';
import '../calculator_brain.dart';

enum Gender {
  male,
  female,
}

enum BMIParameter {
  weight,
  age,
}

enum ActionType {
  increase,
  decrease,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 60;
  int age = 18;
  bool longPressIsStart = false;

  void changeValueContinuously(BMIParameter bmiParameter, ActionType actionType) async {
    print("auto decrement is started");
    while (longPressIsStart) {
      if(bmiParameter == BMIParameter.age){
        print("current value: $age");
        setState(() {
          age = actionType == ActionType.increase ? age + 1 : age - 1;
        });
        print("new value: $age");
      }
      else {
        print("current value: $weight");
        setState(() {
          weight = actionType == ActionType.increase ? weight + 1 : weight - 1;
        });
        print("new value: $weight");
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                  colour: selectedGender == Gender.male
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild:
                      IconContent(icon: FontAwesomeIcons.mars, label: 'MALE'),
                )),
                Expanded(
                    child: ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  colour: selectedGender == Gender.female
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.venus,
                    label: 'FEMALE',
                  ),
                ))
              ],
            )),
            Expanded(
                child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        height.toString(),
                        style: kNumberTextStyle,
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: kInActiveSliderColour,
                        activeTrackColor: Colors.white,
                        thumbColor: Color(0xFFEB1555),
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0)),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      //activeColor: kActiveSliderColour,
                      //inactiveColor: kInActiveSliderColour,
                      onChanged: (value) {
                        print('new height value is $value');
                        setState(() {
                          height = value.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            )),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'WEIGHT',
                        style: kLabelTextStyle,
                      ),
                      Text(
                        weight.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onLongPressStart: (details) {
                              print('long press is started');
                              setState(() {
                                longPressIsStart = true;
                              });
                              changeValueContinuously(BMIParameter.weight, ActionType.decrease);
                            },
                            onLongPressUp: () {
                              print('long press is upped');
                              setState(() {
                                longPressIsStart = false;
                              });
                            },
                            child: RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                              icon: FontAwesomeIcons.minus,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onLongPressStart: (details) {
                              print('long press is started');
                              setState(() {
                                longPressIsStart = true;
                              });
                              changeValueContinuously(BMIParameter.weight, ActionType.increase);
                            },
                            onLongPressUp: () {
                              print('long press is upped');
                              setState(() {
                                longPressIsStart = false;
                              });
                            },
                            child: RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                              icon: FontAwesomeIcons.plus,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AGE',
                        style: kLabelTextStyle,
                      ),
                      Text(
                        age.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onLongPressStart: (details) {
                              print('long press is started');
                              setState(() {
                                longPressIsStart = true;
                              });
                              changeValueContinuously(BMIParameter.age, ActionType.decrease);
                            },
                            onLongPressUp: () {
                              print('long press is upped');
                              setState(() {
                                longPressIsStart = false;
                              });
                            },
                            child: RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                              icon: FontAwesomeIcons.minus,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onLongPressStart: (details) {
                              print('long press is started');
                              setState(() {
                                longPressIsStart = true;
                              });
                              changeValueContinuously(BMIParameter.age, ActionType.increase);
                            },
                            onLongPressUp: () {
                              print('long press is upped');
                              setState(() {
                                longPressIsStart = false;
                              });
                            },
                            child: RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                              icon: FontAwesomeIcons.plus,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            )),
            BottomButton(
              buttonTitle: "CALCULATE",
              onTap: () {
                CalculatorBrain calc =
                    CalculatorBrain(height: height, weight: weight);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                          bmiResult: calc.calculateBMI(),
                          resultText: calc.getResult(),
                          interpretation: calc.getInterpretation())),
                );
                /*
                Navigator.pushNamed(
                    context,
                    '/result',
                    arguments: ResultsPage(
                        bmiResult: calc.calculateBMI(),
                        resultText: calc.getResult(),
                        interpretation: calc.getInterpretation()
                    )
                );
                */
              },
            )
          ],
        ));
  }
}
