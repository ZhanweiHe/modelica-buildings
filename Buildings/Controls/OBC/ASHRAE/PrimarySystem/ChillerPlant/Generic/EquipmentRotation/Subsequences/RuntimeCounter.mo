within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.EquipmentRotation.Subsequences;
block RuntimeCounter
  "Equipment rotation signal based on device runtime and current device status"

  parameter Modelica.SIunits.Time stagingRuntime(
    final displayUnit = "h") = 864000
    "Staging runtime for each device";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uDevSta[nDev]
    "Device status: true = proven ON, false = proven OFF"
    annotation (Placement(transformation(extent={{-240,20},{-200,
            60}}), iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPreDevRolSig[nDev]
    "Device roles in the previous time instance: true = lead; false = lag or standby"
    annotation (Placement(transformation(extent={{-240,-100},{-200,-60}}),
        iconTransformation(extent={{-140,-100},{-100,-60}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yRot "Rotation trigger signal"
    annotation (Placement(transformation(extent={{200,-20},{240,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr[nDev](
    final threshold=stagingRuntimes)
    "Staging runtime hysteresis"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim[nDev](accumulate=fill(true, nDev))
    "Measures time spent loaded at the current role (lead or lag)"
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));

protected
  final parameter Integer nDev = 2
    "Total number of devices, such as chillers, isolation valves, CW pumps, or CHW pumps";

  final parameter Boolean initRoles[nDev] = {true, false}
    "Initial roles: true = lead, false = lag/standby"
    annotation (Evaluate=true,Dialog(tab="Advanced", group="Initiation"));

  final parameter Modelica.SIunits.Time stagingRuntimes[nDev] = fill(stagingRuntime, nDev)
    "Staging runtimes array";

  Buildings.Controls.OBC.CDL.Logical.And and2[nDev] "Logical and"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nu=nDev) "Array or"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Buildings.Controls.OBC.CDL.Logical.MultiAnd allOn(
    final nu=nDev) "Outputs true if all devices are enabled"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr anyOn(
    final nu=nDev) "Checks if any device is disabled"
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));

  Buildings.Controls.OBC.CDL.Logical.Not allOff
    "Returns true if all devices are disabled"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep1(
    final nout=nDev) "Booolean replicator"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));

  Buildings.Controls.OBC.CDL.Logical.Or equSig
    "Outputs true if either all devices are enabled or all devices are disabled"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

  Buildings.Controls.OBC.CDL.Logical.FallingEdge  falEdg1[nDev] "Falling Edge"
    annotation (Placement(transformation(extent={{-180,-90},{-160,-70}})));

equation
  connect(greEquThr.y,and2. u1) annotation (Line(points={{22,40},{40,40},{40,0},
          {58,0}}, color={255,0,255}));
  connect(mulOr.u[1:2],and2. y)
    annotation (Line(points={{98,0},{82,0}}, color={255,0,255}));
  connect(tim.y,greEquThr. u)
    annotation (Line(points={{-78,40},{-2,40}}, color={0,0,127}));
  connect(booRep1.y,and2. u2)
    annotation (Line(points={{22,0},{30,0},{30,-8},{58,-8}}, color={255,0,255}));
  connect(anyOn.y, allOff.u)
    annotation (Line(points={{-118,-30},{-102,-30}}, color={255,0,255}));
  connect(booRep1.u, equSig.y)
    annotation (Line(points={{-2,0},{-18,0}},  color={255,0,255}));
  connect(allOff.y, equSig.u2) annotation (Line(points={{-78,-30},{-60,-30},{
          -60,-8},{-42,-8}}, color={255,0,255}));
  connect(allOn.y, equSig.u1) annotation (Line(points={{-78,10},{-60,10},{-60,0},
          {-42,0}}, color={255,0,255}));
  connect(uDevSta, tim.u)
    annotation (Line(points={{-220,40},{-102,40}}, color={255,0,255}));
  connect(uDevSta, allOn.u[1:2]) annotation (Line(points={{-220,40},{-120,40},{
          -120,10},{-102,10}}, color={255,0,255}));
  connect(uDevSta, anyOn.u[1:2]) annotation (Line(points={{-220,40},{-160,40},{
          -160,-30},{-142,-30}}, color={255,0,255}));
  connect(mulOr.y, yRot)
    annotation (Line(points={{122,0},{220,0}}, color={255,0,255}));
  connect(uPreDevRolSig, falEdg1.u)
    annotation (Line(points={{-220,-80},{-182,-80}}, color={255,0,255}));
  connect(falEdg1.y, tim.reset) annotation (Line(points={{-158,-80},{-150,-80},
          {-150,32},{-102,32}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(extent={{-200,-120},{200,120}})),
      defaultComponentName="runCou",
    Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
      Line(points={{-66,-70},{82,-70}},
        color={192,192,192}),
      Line(points={{-58,68},{-58,-80}},
        color={192,192,192}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{90.0,-70.0},{68.0,-62.0},{68.0,-78.0},{90.0,-70.0}}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{-58,90},{-66,68},{-50,68},{-58,90}}),
      Line(points={{-56,-70},{-38,-70},{-38,-26},{40,-26},{40,-70},{68,-70}},
        color={255,0,255}),
      Line(points={{-58,0},{-40,0},{40,90},{40,0},{68,0}},
        color={0,0,127})}),
  Documentation(info="<html>
<p>
This subsequence generates a rotation trigger based on measuring the time each of the devices has spent in its current role. 
The rotation trigger output <code>yRot<\code> is generated as the current lead device runtime in the role
exceeds <code>stagingRuntime<\code> and the conditions are met such that the devices are not hot swapped. To
avoid hot swapping the lead and lag/standby device need to be either both ON or both OFF for the rotation to occur. 
</p>
<p>
<p>
The implementation is based on section 5.1.2.3. and 5.1.2.4.1. of RP1711 July draft.
</p>
</html>", revisions="<html>
<ul>
<li>
September 18, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end RuntimeCounter;
