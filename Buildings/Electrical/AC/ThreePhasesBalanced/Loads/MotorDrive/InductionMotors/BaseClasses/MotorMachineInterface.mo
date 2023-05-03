within Buildings.Electrical.AC.ThreePhasesBalanced.Loads.MotorDrive.InductionMotors.BaseClasses;
model MotorMachineInterface
  "Calculates the electromagnetic torque based on voltage and frequency"

  parameter Integer pole=2 "Number of pole pairs";
  parameter Modelica.Units.SI.Resistance R_s=0.013 "Electric resistance of stator";
  parameter Modelica.Units.SI.Resistance R_r=0.009 "Electric resistance of rotor";
  parameter Modelica.Units.SI.Reactance X_s=0.14 "Complex component of the impedance of stator";
  parameter Modelica.Units.SI.Reactance X_r=0.12 "Complex component of the impedance of rotor";
  parameter Modelica.Units.SI.Reactance X_m=2.4 "Complex component of the magnetizing reactance";
  parameter Modelica.Units.SI.AngularVelocity omegaHys = 0.01
    "Hysteresis for checking if the angular velocity is greater than zero"
    annotation (Dialog(tab="Advanced"));

  Real s(min=0,max=1) "Motor slip";
  Modelica.Units.SI.AngularVelocity omega_s "Synchronous angular velocity";

  Modelica.Blocks.Interfaces.RealInput V_rms(unit="V") "Prescribed RMS voltage"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,40}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,40})));
  Modelica.Blocks.Interfaces.RealInput f(final quantity="Frequency",
    final unit="Hz")
    "Controllable freuqency to the motor"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealInput omega_r(final quantity="AngularVelocity",
    final unit="rad/s")
    "Prescribed rotational speed of rotor"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-40}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-40})));
  Modelica.Blocks.Interfaces.RealOutput tau_e(final quantity="Torque",
    final unit="N.m")
    "Electromagenetic torque of rotor"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

protected
  Real ratio "Intermediate value used in calculation";

  Boolean y_internal "True: the angular velocity is greater than zero";

equation
  // check if omega_s > 0 with hysteresis
  y_internal = (not pre(y_internal) and omega_s > omegaHys
                        or pre(y_internal) and omega_s >= (omegaHys-0.5*omegaHys));

  omega_s = 4*Modelica.Constants.pi*f/pole;
  s = if y_internal then 1-omega_r/omega_s else 0;
  ratio = X_m/(X_m+X_s);
  tau_e = if y_internal
  then 3*R_r*s*(V_rms*ratio)^2/(omega_s*(((s*R_s*ratio^2+R_r)^2)+s^2*(X_s+X_r)^2))
  else 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
          Text(
          extent={{-82,162},{82,116}},
          textColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="%name")}),
          defaultComponentName="torSpe",
    Documentation(info="<html>
<p>
This block is to implement equations of the simplified model of squirrel cage type 
induction motor. The induction motor operation is based on the principle of 
electromagnetic induction; there are two magnetic fields occurring, one from 
the stator and one from the rotor, the rotor field is induced by the stator 
field. Therefore, an induction motor can be modeled as a rotating transformer. 
</p>
<p>
The per-phase equivalent circuit model for an induction motor supplied by 
balanced three-phase supply based on the transformer model is represented below. 
</p>
<p align=\"center\">
<img alt=\"Induction motor equivalent circuit\" 
     src=\"modelica://Buildings/Resources/Images/Electrical/AC/ThreePhasesBalanced/Loads/MotorDrive/InductionMotors/induction_motor_equivalent_circuit.png\"/> 
</p>
<p>
The electromagnetic torque generated by motor is calculated as follows. 
</p>
<p align=\"center\">
<img alt=\"Electromagnetic torque equation\"
     src=\"modelica://Buildings/Resources/Images/Electrical/AC/ThreePhasesBalanced/Loads/MotorDrive/InductionMotors/torque_euqation.png\"/> 
</p>
<p>
Where,<br/>
<i>n</i> = Number of phases in connected power system<br/>
<i>R<sub>1</sub></i> = Stator resistance [ohm]<br/>
<i>R<sub>2</sub></i> = Rotor resistance [ohm]<br/>
<i>s</i> = Motor slip of asynchronous motors<br/>
<i>V<sub>rms</sub></i> = Root Mean Square (RMS) Voltage of AC waveform [V]<br/>
<i>w<sub>s</sub></i> = Synchronous speed [rad/s]<br/>
<i>X<sub>1</sub></i> = Stator reactance [ohm]<br/>
<i>X<sub>2</sub></i> = Rotor reactance [ohm]<br/>
<i>X<sub>m</sub></i> = Magnetizing reactance [ohm]<br/>
</p>
<h4>Assumption and limitation</h4>
<p>
This implementation assumes that the power supply is a balanced system, 
which allows the total torque to be calculated by multiplying the value of the 
single-phase torque by the number of phases. 
</p>
<h4>Reference</h4>
<p>
<a href=\"https://par.nsf.gov/biblio/10109101\">Fu, Yangyang, et al. 
&quot;Coupling power system dynamics and building dynamics to enabling building-to-grid 
integration.&quot; <i>Link&ouml;ping Electronic Conference Proceedings</i>. 
Vol. 157. 2019.</a>
</p>
</html>", revisions="<html>
<ul>
<li>
March 6, 2019, by Yangyang Fu:<br/>
First implementation.
</li>
</ul>
</html>"));
end MotorMachineInterface;
