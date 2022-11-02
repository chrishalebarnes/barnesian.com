---
layout: post
title:  Arduino Powered Smart Fan Controller
date:   2011-05-09
categories:
  - Software
  - Electronics
permalink: /arduino-powered-smart-fan-controller/
redirect_from:
  - /2011/05/arduino-powered-smart-fan-controller.html
thumb:
  path: /assets/posts/arduino-powered-smart-fan-controller/FanController.jpg
  alt: picture from the left of a DIY fan controller
lede:
  This project will focus on using Arduino to build a smart fan controller. Fan controllers are an effective way to limit or boost the rotation speed of the cooling fans in a desktop computer. While doing something that is CPU and GPU intensive, it may be preferable to have more airflow through the computer case. Quite the opposite is true when there is little load on the CPU and GPU. Silence is golden when performance is not necessary.
---
<iframe src="//www.youtube.com/embed/WPPnDY188vI?vq=hd1080" allowfullscreen="allowfullscreen" width="100%" height="510"></iframe>
**Introduction**
This project will focus on using [Arduino](http://amzn.to/1KSDbsZ) to build a smart fan controller. Fan controllers are an effective way to limit or boost the rotation speed of the cooling fans in a desktop computer. While doing something that is CPU and GPU intensive, it may be preferable to have more airflow through the computer case. Quite the opposite is true when there is little load on the CPU and GPU. Silence is golden when performance is not necessary. Typically, case fans are noisy and are connected directly to the 12 Volt power supply. This means the fans are on full strength whether it is needed or not. By limiting the effective voltage in certain situations, one can reduce the noise produced by the fans without affecting performance when needed. The primary objective here is to set a temperature threshold and have the case fans ramp up as needed to keep the case and components cool. To implement a reasonable system where the fans do not kick on and off, proportional-integral-derivative (PID) will be implemented. This feedback mechanism should make sure the fans stay quiet while providing adequate cooling in the computer case. The case fans in any desktop computer are controlled in one of two ways: either they are connected directly to a 12 volt branch of the power supply or they are controlled by the motherboard. Typically, at least the CPU heat-sink’s fan is controlled by the motherboard. The heat-sink’s fan is critical and is excluded from this project. The case fans move air through the chassis, providing cool air across all of the components. The RPM of each case fan is directly related to the voltage applied to the pins cased in their Molex connector. By regulating this voltage, the RPM of each fan can be controlled. By regulating the RPM of the fans, the noise can be reduced when needed.

{% include post_image.md name="FanController.jpg" %}

**Reading the Temperature**

The first task is to reliably read the temperature, so the PID algorithm in the next section can do its job to regulate the fans. A Dallas One-Wire digital temperature sensor is used to get the temperature (1). As seen later in the wiring diagram (Figure 3), the reading is taken from the middle pin with a pull up resistor. There is a One-Wire library for Arduino, so it is pretty easy to call upon the sensor to get a reading in the main loop.

{% include post_image.md name="temp_sensor3.jpg" %}


Dallas One-Wire DS18B20 Digital Temperature Sensor

**PID and How it Controls Temperature**

PID is a standard way of setting a temperature and having the cooling or heating system reach that temperature without overshooting or undershooting (2) (3). The plot of temperature over time is a smooth curve that reaches the desired temperature. Let’s jump in head first. Here is the equation for PID:

{% include post_image.md name="pid_equation.gif" %}

Where
{% include post_image.md name="prop_equation.gif" %}
is Proportional gain

{% include post_image.md name="integral_gain_equation.gif" %}
 is Integral gain

{% include post_image.md name="derivative_gain_equation.gif" %}
 is Derivative gain
*e* is Error
*t* is time

There are three terms here: the proportional gain, the integral gain and the derivative gain. The proportional gain is most influential term in the equation. *e(t)*, the error,calculates the distance between the current temperature and the desired temperature and sets the proper adjustment to the output. The constant, K<sub>p</sub>, determines the magnitude of change due to the proportional gain. The integral gain adds up the difference between the set point and the desired point over time. Given the history of the error it calculates the required change in output. In plainer terms, it determines the amount of acceleration that is required to reach the set point. Again, the constant, K<sub>i</sub>, determines the magnitude of change due to the integral gain. Finally, the last term is the derivative gain. It balances the integral gain by lessening the potential for overshooting the set point. It does so by calculating the slope of the error over time and slows the change in output. Similarly to the previous two terms it also has a constant, K<sub>d,</sub> which determines the magnitude of change due to the derivative gain. Taking a step back, one can see that the proportional gain is responsible for adjusting the output to manipulate the temperature; the integral gain is responsible for accelerating or decelerating that change; and the derivative gain is responsible for limiting the aggression of the integral gain when nearing the set point. By manipulating the constants in front of each term one can tune the system to perform within the scale that is needed. For the purpose of a fan controller inside of a computer, the output is in RPM and the set point is a temperature in Celsius. Obviously a higher RPM pushes more air through the case to cool the components. By tweaking the output (RPM) using PID, the temperature can be maintained at a set point with minimal noise and effort from the fans.

**How to implement PID in code**

Luckily there already exists a library for PID control for Arduino (4). In terms of code, the tunings are set and the adjustment to the output is computed in a loop. For every temperature reading, the output is computed with the PID library command, Compute(), and the output of the fan is set to the value that the library returns. The library also makes a distinction between aggressive PID and conservative PID. This is done so that when the temperature is close to the desired temperature the change in output is more conservative than when the temperature is far away from the desired temperature. In this example, the code specifies that swing to be one degree Celsius. When the temperature is within a degree of the desired temperature the PID responds more slowly and consistently. Conversely, when the temperature is farther than a degree away from the desired temperature, the PID output will be more drastic with larger tuning values.

**Results of the PID**

There are many methods of setting the tunings. For testing, the temperature sensor (1) was taped to a heating element which was placed in front of the case fan. To get the results displayed here, the integral and derivative gains were initially eliminated to zero. Once the proportional gain was behaving by oscillating around the set point, the last two terms were added in until the plot of temperature over time seemed to be stable. The results are displayed below in Figure 1. In addition, Figure 2 shows the output of the PID to the fan over the same time scale. The output pin on the Arduino microcontroller can be a value between zero and 255. At maximum speed this particular fan rotates at 1200 RPM.

{% include post_image.md name="tempovertime.png" %}


Figure 1: Temperature over Time

**User Interface with a Rotary Encoder and an LCD Panel**

The secondary objective is to apply an effective user interface using an LCD panel and a rotary encoder. Since the voltage on the pins of the fan controls the RPM, the noise can be significantly reduced without any decrease in performance. The user should be able to set a temperature in the case and the fans will ramp up accordingly. Of course the hardware must be protected, so if a critical temperature is reached, the fans will turn on with full force and lower the temperature.

{% include post_image.md name="front_lcd.jpg" %}


LCD Displaying the Information to the User

The rotary encoder allows the user to set the desired temperature in the case. Rotary encoders work with two pins. Each pin is either high or low. Each pin moves in a certain pattern through high and low states. This is an implementation of a concept called a “Gray code,” because their patterns are the same but shifted by one cycle. As you can see in the below illustration, if there is a low to high transition on pin A and pin B is low, then the wheel must be spinning counterclockwise (left in the diagram). Likewise, if there is a low to high transition on pin A and pin B is high then the wheel must be spinning clockwise (right in the diagram).

{% include post_image.md name="RotaryEncoderWaveform.gif" %}


Photo Courtesy of Arduino Playground (5)

In the code, interrupts must be used so the turning of the rotary encoder does not disturb the PID loop. When the rotary encoder is turned, it generates an interrupt. The interrupt pauses the main PID loop and iterates a variable in the proper direction. The desired temperature is then set to equal the rotary encoder’s value. The end result is that the user can twist the rotary encoder and the fans will work to make the temperature inside the case equal the temperature set by the user. The LCD panel reflects the current set temperature, the current temperature, and the approximate RPM of the fan. The RPM of the fan is derived from the value that comes off the Arduino pin. In the main loop where the PID is computed and set, the LCD is also updated. The LCD is compatible with the HD44780 chipset. This is a well documented Hitachi chipset, which eases the programming. Have a look at the diagram for the pin out of the LCD panel.

**Putting it All Together**

There are a few more considerations in putting all of the components together and running the code on the Arduino Uno. The Arduino will be mounted in a 5.25” storage container with the front punched out to make room for the LCD panel and the rotary encoder. The assembly must take power from a typical computer power supply, which is 12 volts. The microcontroller takes the 12 volts from the power supply and regulates it into five volts. The catch is that the temperature sensor needs five volts to operate, but the fan needs the full 12 volts to operate at maximum RPM. The full schematic of the fan controller is below.

{% include post_image.md name="RPM.png" %}


Figure 3: Schematic for the PID Fan Controller

{% include post_image.md name="final\_assembly.jpg" %}


Final Assembly

To achieve the fan control with the voltage from the power supply, a mosfet is used to handle the switching of the power supply on and off with pulse-width-modulation (PWM). PWM is performed by the Arduino. It is simply a square wave of high voltage and low voltage where the ratio of time off and on is regulated. At its highest, the controller outputs the full 12 volts. At effective half voltage the PWM is on for half the time and at its lowest the controller outputs zero volts. Effectively, this controls the RPM of the fan by quickly switching the motor on and off for a certain amount of time, which is determined by the PID process. This scheme of fan control should provide quiet fans that effectively react to the temperature inside the case and near the critical components while handing control over to the user through the LCD UI. In addition to control, the user should also be able to get real-time temperature and fan statistics from the LCD panel. As a result we have an Arduino-powered smart fan system that is open source and helps users control the temperature and airflow of their desktop computers.

### Works Cited

1. **Burton, Miles.** Dallas Temperature Control Library. *MilesBurton.com.*\[Online\] \[Cited: May 1, 2011.\] [https://www.milesburton.com/](https://www.milesburton.com/Dallas_Temperature_Control_Library).
2. **Wikipedia.** PID Controller. *Wikipedia.*\[Online\] \[Cited: May 1, 2011.\] [http://en.wikipedia.org/wiki/PID_controller](http://en.wikipedia.org/wiki/PID_controller).
3. **Matlab.** Control Tutorials for Matlab: PID Tutorial. \[Online\] \[Cited: May 1, 2011.\] [http://www.engin.umich.edu/group/ctm/PID/PID.html#controller](http://www.engin.umich.edu/group/ctm/PID/PID.html#controller).
4. **Arduino Playground.** PID Library. *Arduino Playground.*\[Online\] \[Cited: May 1, 2011.\] [ http://www.arduino.cc/playground/Code/PIDLibrary](http://www.arduino.cc/playground/Code/PIDLibrary).
5. —. Reading Rotary Encoders. *Arduino.*\[Online\] \[Cited: May 1, 2011.\] [https://www.arduino.cc/playground/Main/RotaryEncoders](https://www.arduino.cc/playground/Main/RotaryEncoders).

**Appendix A: Bill of Materials**

||||
|---|---|---|
|**Device**|**Quantity**|**Price**|
|[Arduino Uno](http://amzn.to/1KSDbsZ)|1|0 – already had one|
|[DS18B20 Thermometer](http://www.sparkfun.com/products/245)|1|4.25|
|[IRF510 Mosfet](http://www.jameco.com/webapp/wcs/stores/servlet/Product_10001_10001_209234_-1)|1|0.79|
|Molex 8981|1|0.00|
|[5.25” Storage](http://www.newegg.com/Product/Product.aspx?Item=N82E16811997011&cm_re=5.25_storage-_-11-997-011-_-Product)|1|11.99|
|[Display HD44780](http://www.sparkfun.com/products/709)|1|15.95|
|[Rotary Encoder](http://www.sparkfun.com/products/9117)|1|2.95|
|[10kO Resistor](http://www.jameco.com/webapp/wcs/stores/servlet/Product_10001_10001_691104_-1)|1|0.02|
|[4.6kO Resistor](http://www.jameco.com/webapp/wcs/stores/servlet/Product_10001_10001_691024_-1)|1|0.02|
|[1kO Variable Resistor](http://www.jameco.com/webapp/wcs/stores/servlet/Product_10001_10001_240750_-1)|1|1.49|
|[120mm 3 pin Fan](http://www.newegg.com/Product/Product.aspx?Item=N82E16835185056&cm_re=sythe_fan_3_pin_120mm-_-35-185-056-_-Product)|2|8.99|
|[Breadboard](http://www.jameco.com/webapp/wcs/stores/servlet/Product_10001_10001_2125042_-1)|1|3.95|
|[Diode](http://www.jameco.com/webapp/wcs/stores/servlet/Product_10001_10001_36012_-1)|1|0.05|
|Total|13|59.44|


**Appendix B: The Code**
```cpp
#include <OneWire.h>
#include <DallasTemperature.h>
#include <PID_v1.h>
#include <LiquidCrystal.h>

//Definitions
#define FAN 9           // Output pin for fan
#define ONE_WIRE_BUS 8  // Temperature Input is on Pin 2
#define click 3         //Rotary Encoder Click
#define encoder0PinA  2 //Rotary Encoder Pin A
#define encoder0PinB  4 //Rotary Encoder Pin B
#define CRITICAL 50.00  //Critical temperature to ignore PID and turn on fans

volatile unsigned int encoder0Pos = 0;  //Encoder value for ISR

LiquidCrystal lcd(12, 11, 13, 5,6,7);  //set up LCD

//Setup Temperature Sensor
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

//Setup PID
double Setpoint, Input, Output;                                          //I/O for PID
double aggKp=40, aggKi=2, aggKd=10;                                      //original: aggKp=4, aggKi=0.2, aggKd=1, Aggressive Turning,50,20,20
double consKp=20, consKi=1, consKd=5;                                    //original consKp=1, consKi=0.05, consKd=0.25, Conservative Turning,20,10,10
PID myPID(&Input, &Output, &Setpoint, consKp, consKi, consKd, REVERSE);  //Initialize PID

//interface
int timeCounter;
void setup()
{
  // start serial port for temperature readings
  Serial.begin(9600);
  Serial.println("Start");

  //Temperature Setup
  sensors.begin();                    //Start Library
  sensors.requestTemperatures();      // Send the command to get temperatures
  Input = sensors.getTempCByIndex(0); //Set Input to Current Temperature
  Setpoint = 28;                      //Inintialize desired Temperature in Deg C
  encoder0Pos=28;

  //PID Setup
  myPID.SetMode(AUTOMATIC);
  //TCCR2B = TCCR2B & 0b11111000 | 0x01;  //adjust the PWM Frequency, note: this changes timing like delay()

  //Setup Pins
  pinMode(FAN, OUTPUT);                   // Output for fan speed, 0 to 255
  pinMode(click, INPUT);                  // Click button is an input
  pinMode(encoder0PinA, INPUT);
  digitalWrite(encoder0PinA, HIGH);       // Turn on pullup resistor
  pinMode(encoder0PinB, INPUT);
  digitalWrite(encoder0PinB, HIGH);       // Turn on pullup resistor

  //Set up Interupts
  attachInterrupt(1, clicked, RISING);    // Click button on interrupt 1 - pin 3
  attachInterrupt(0, doEncoder, CHANGE);  // Encoder pin on interrupt 0 - pin 2

  //interface

  timeCounter=0;

  //Setup LCD 16x2 and display startup message
  lcd.begin(16, 2);
  lcd.print("  Smart   Fan");
  lcd.setCursor(0,1);
  lcd.print("  Starting Up");
  delay(1000);
  lcd.clear();
}

void loop()
{
  timeCounter++;

  //Get temperature and give it to the PID input
  sensors.requestTemperatures();
  Input=sensors.getTempCByIndex(0);

  //print out info to LCD
  lcd.setCursor(1,0);
  lcd.print("Temp:");
  lcd.print((int)Input);
  lcd.setCursor(9,0);
  lcd.print("RPM:");
  lcd.print((int)Output*4.7059);
  lcd.setCursor(1,1);
  lcd.print("Set:");
  lcd.print((int)Setpoint);

  //Compute PID value
  double gap = abs(Setpoint-Input); //distance away from setpoint
  if(gap < 1)
  {
    //Close to Setpoint, be conservative
    myPID.SetTunings(consKp, consKi, consKd);
  }
  else
  {
     //Far from Setpoint, be aggresive
     myPID.SetTunings(aggKp, aggKi, aggKd);
  }
  myPID.Compute();
  Serial.print(timeCounter);
  Serial.print(" ");
  Serial.print(Input);
  Serial.print(" ");
  Serial.println(Output);

  //Write PID output to fan if not critical
  if (Input < CRITICAL)
    analogWrite(FAN,Output);
  else
    analogWrite(FAN,255);
}

void doEncoder()
{
  //pinA and pinB are both high or both low, spinning forward, otherwise it's spinning backwards
  if (digitalRead(encoder0PinA) == digitalRead(encoder0PinB))
  {
    encoder0Pos++;
  }
  else
  {
    encoder0Pos--;
  }
  Serial.println (encoder0Pos, DEC);  //Print out encoder value to Serial
  Setpoint=encoder0Pos;
}

void clicked()
{
  //For interface
  lcd.clear();
  lcd.print("clicked!");
  delay(1000);
}
```
