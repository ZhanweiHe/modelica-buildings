within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Towers.FanSpeed.ReturnWaterTemperature.Subsequences;
block Coupled
  "Sequence of defining cooling tower fan speed when the plant is close coupled"

  parameter Integer nChi = 2 "Total number of chillers";
  parameter Integer nConWatPum = 2 "Total number of condenser water pumps";
  parameter Real fanSpeMin = 0.1 "Minimum cooling tower fan speed";
  parameter Real pumSpeChe = 0.01
    "Lower threshold value to check if condenser water pump is proven on";
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerType=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI "Type of controller"
    annotation (Dialog(group="Controller"));
  parameter Real k=1 "Gain of controller"
    annotation (Dialog(group="Controller"));
  parameter Real Ti(final quantity="Time", final unit="s")=0.5 "Time constant of integrator block"
    annotation (Dialog(group="Controller"));
  parameter Real Td(final quantity="Time", final unit="s")=0.1 "Time constant of derivative block"
    annotation (Dialog(group="Controller", enable=
          controllerType == Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
          controllerType == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real yMax=1 "Upper limit of output"
    annotation (Dialog(group="Controller"));
  parameter Real yMin=0 "Lower limit of output"
    annotation (Dialog(group="Controller"));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TConWatRetSet(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Condenser water return temperature setpoint"
    annotation (Placement(transformation(extent={{-160,60},{-120,100}}),
      iconTransformation(extent={{-140,80},{-100,120}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TConWatRet(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Condenser water return temperature (condenser leaving)"
    annotation (Placement(transformation(extent={{-160,30},{-120,70}}),
      iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatPumSpe[nConWatPum](
    final min=fill(0, nConWatPum),
    final max=fill(1, nConWatPum),
    final unit=fill("1", nConWatPum)) "Current condenser water pump speed"
    annotation (Placement(transformation(extent={{-160,0},{-120,40}}),
      iconTransformation(extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uMaxTowSpeSet[nChi](
    final min=fill(0, nChi),
    final max=fill(1, nChi),
    final unit=fill("1", nChi))
    "Maximum cooling tower speed setpoint from each chiller head pressure control loop"
    annotation (Placement(transformation(extent={{-160,-40},{-120,0}}),
      iconTransformation(extent={{-140,-40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[nChi]
    "Chiller enabling status: true=ON"
    annotation (Placement(transformation(extent={{-160,-80},{-120,-40}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput plrTowMaxSpe(
    final min=0,
    final max=1,
    final unit="1")
    "Tower maximum speed that reset based on plant partial load ratio"
    annotation (Placement(transformation(extent={{-160,-120},{-120,-80}}),
      iconTransformation(extent={{-140,-120},{-100,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput ySpeSet(
    final min=0,
    final max=1,
    final unit="1") "Fan speed setpoint of each cooling tower cell"
    annotation (Placement(transformation(extent={{120,-60},{160,-20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Continuous.PIDWithReset conPID(
    final controllerType=controllerType,
    final k=k,
    final Ti=Ti,
    final Td=Td,
    final yMax=yMax,
    final yMin=yMin,
    final reverseActing=false,
    final y_reset=yMin) "Condenser water return temperature controller"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant minTowSpe(
    final k=fanSpeMin) "Minimum tower speed"
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  Buildings.Controls.OBC.CDL.Continuous.Line CWRTSpd
    "Fan speed calculated based on return water temperature control loop"
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zer(
    final k=yMin) "Zero constant"
    annotation (Placement(transformation(extent={{0,110},{20,130}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant one(
    final k=yMax) "Constant one"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis proOn[nConWatPum](
    final uLow=fill(pumSpeChe, nConWatPum),
    final uHigh=fill(2*pumSpeChe, nConWatPum))
    "Check if the condenser water pump is proven on"
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr anyProOn(
    final nin=nConWatPum)
    "Check if there is any condenser water pump is proven on"
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMin fanSpe(final nin=3)
    "Cooling tower fan speed"
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMin maxSpe(final nin=nChi)
    "Lowest value of the maximum cooling tower speed from each chiller head pressure control loop"
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.Switch swi  "Logical switch"
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Switch swi1[nChi] "Logical switch"
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant one1[nChi](
    final k=fill(1, nChi)) "Constant one"
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));

equation
  connect(TConWatRet, conPID.u_m)
    annotation (Line(points={{-140,50},{-70,50},{-70,68}}, color={0,0,127}));
  connect(TConWatRetSet, conPID.u_s)
    annotation (Line(points={{-140,80},{-82,80}}, color={0,0,127}));
  connect(conPID.y, CWRTSpd.u)
    annotation (Line(points={{-58,80},{78,80}}, color={0,0,127}));
  connect(zer.y, CWRTSpd.x1)
    annotation (Line(points={{22,120},{60,120},{60,88},{78,88}}, color={0,0,127}));
  connect(minTowSpe.y, CWRTSpd.f1)
    annotation (Line(points={{-58,120},{-20,120},{-20,84},{78,84}}, color={0,0,127}));
  connect(one.y, CWRTSpd.x2)
    annotation (Line(points={{22,60},{40,60},{40,76},{78,76}},
      color={0,0,127}));
  connect(one.y, CWRTSpd.f2)
    annotation (Line(points={{22,60},{40,60},{40,72},{78,72}},
      color={0,0,127}));
  connect(uConWatPumSpe, proOn.u)
    annotation (Line(points={{-140,20},{-102,20}}, color={0,0,127}));
  connect(proOn.y, anyProOn.u)
    annotation (Line(points={{-78,20},{-62,20}}, color={255,0,255}));
  connect(anyProOn.y, conPID.trigger)
    annotation (Line(points={{-38,20},{0,20},{0,40},{-76,40},{-76,68}},
      color={255,0,255}));
  connect(uChi, swi1.u2)
    annotation (Line(points={{-140,-60},{-62,-60}}, color={255,0,255}));
  connect(one1.y, swi1.u3)
    annotation (Line(points={{-78,-80},{-70,-80},{-70,-68},{-62,-68}},
      color={0,0,127}));
  connect(uMaxTowSpeSet, swi1.u1)
    annotation (Line(points={{-140,-20},{-80,-20},{-80,-52},{-62,-52}},
      color={0,0,127}));
  connect(swi1.y, maxSpe.u)
    annotation (Line(points={{-38,-60},{-30,-60},{-30,-60},{-22,-60}},
      color={0,0,127}));
  connect(CWRTSpd.y, fanSpe.u[1])
    annotation (Line(points={{102,80},{110,80},{110,40},{10,40},{10,-60.6667},{
          18,-60.6667}},color={0,0,127}));
  connect(maxSpe.y, fanSpe.u[2])
    annotation (Line(points={{2,-60},{18,-60}}, color={0,0,127}));
  connect(plrTowMaxSpe, fanSpe.u[3])
    annotation (Line(points={{-140,-100},{10,-100},{10,-59.3333},{18,-59.3333}},
      color={0,0,127}));
  connect(anyProOn.y, swi.u2)
    annotation (Line(points={{-38,20},{0,20},{0,-40},{78,-40}}, color={255,0,255}));
  connect(zer.y, swi.u3)
    annotation (Line(points={{22,120},{60,120},{60,-48},{78,-48}},
      color={0,0,127}));
  connect(fanSpe.y, swi.u1)
    annotation (Line(points={{42,-60},{50,-60},{50,-32},{78,-32}}, color={0,0,127}));
  connect(swi.y,ySpeSet)
    annotation (Line(points={{102,-40},{140,-40}}, color={0,0,127}));

annotation (
  defaultComponentName="couTowSpe",
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-140},{120,140}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
         graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          textColor={0,0,255},
          textString="%name"),
        Polygon(
          points={{-20,80},{20,80},{0,10},{-20,80}},
          lineColor={28,108,200},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,10},{40,-10}},
          lineColor={28,108,200},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-10},{-20,-80},{20,-80},{0,-10}},
          lineColor={28,108,200},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid)}),
Documentation(info="<html>
<p>
Block that outputs cooling tower fan speed <code>ySpeSet</code> based on the control
of condenser water return temperature for the plant that is close coupled. 
This is implemented according to ASHRAE RP-1711 Advanced Sequences of Operation for 
HVAC Systems Phase II – Central Plants and Hydronic Systems (Draft on March 23, 
2020), section 5.2.12.2, item 2.e-f.
</p>
<ul>
<li>
When any condenser water pump is proven on (<code>uConWatPumSpe</code> &gt; 0),
condenser water return temperature <code>TConWatRet</code> shall be maintained at 
setpoint <code>TConWatRetSet</code> by a direct acting PID loop. The loop output 
shall be mapped to the variable tower speed. Map the tower speed from minimum tower
speed <code>fanSpeMin</code> at 0% loop output to 100% speed at 100% loop output.
</li>
<li>
The output tower speed <code>ySpeSet</code> shall be the lowest value of tower speed
from loop mapping, maximum cooling tower speed setpoint from each chiller head 
pressure control loop <code>uMaxTowSpeSet</code>, and tower maximum speed that reset 
based on plant partial load ratio <code>plrTowMaxSpe</code>. All operating fans shall
receive the same speed signal.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
August 9, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Coupled;
