within Buildings.Applications.DHC.Loads.BaseClasses;
model FlowDistribution "Model of building hydraulic distribution system"
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
    redeclare replaceable package Medium = Buildings.Media.Water,
    final m_flow_small=1E-4*m_flow_nominal,
    final show_T=false,
    final allowFlowReversal=false);
  import typ = Buildings.Applications.DHC.Loads.Types.DistributionType
    "Types of distribution system";
  parameter Integer nPorts_a1 = 0
    "Number of terminal units return ports"
    annotation(Dialog(connectorSizing=true), Evaluate=true);
  parameter Integer nPorts_b1 = 0
    "Number of terminal units supply ports"
    annotation(Dialog(connectorSizing=true), Evaluate=true);
  final parameter Integer nUni = nPorts_a1
    "Number of served units"
    annotation(Evaluate=true);
  parameter typ disTyp = typ.HeatingWater
    "Type of distribution system"
    annotation(Evaluate=true);
  parameter Boolean have_pum = false
    "Set to true if the system has a pump"
    annotation(Evaluate=true);
  parameter Boolean have_val = false
    "Set to true if the system has a mixing valve"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.PressureDifference dp_nominal(
    min=0, displayUnit="Pa")
    "Pressure drop at nominal conditions (without mixing valve)"
    annotation(Dialog(group="Nominal condition"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=
    Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance (except for the pump always modeled in steady state)"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Equations"));
  final parameter Modelica.Fluid.Types.Dynamics massDynamics = energyDynamics
    "Type of mass balance (except for the pump always modeled in steady state)"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Equations"));
  parameter Modelica.SIunits.Time tau = 120
    "Time constant of fluid temperature variation at nominal flow rate"
    annotation (Dialog(tab="Dynamics", group="Nominal condition"));
  // IO CONNECTORS
  Modelica.Fluid.Interfaces.FluidPorts_a ports_a1[nPorts_a1](
    redeclare each final package Medium=Medium,
    each m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    each h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Terminal units return ports"
    annotation (Placement(transformation(extent={{-110,120},{-90,200}}),
      iconTransformation(extent={{90,20},{110,100}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports_b1[nPorts_b1](
    redeclare each final package Medium=Medium,
    each m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    each h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Terminal units supply ports"
    annotation (Placement(transformation(extent={{90,120},{110,200}}),
      iconTransformation(extent={{-110,20},{-90,100}})));
  Modelica.Blocks.Interfaces.RealInput mReq_flow[nUni](
    each quantity="MassFlowRate")
    "Heating or chilled water flow rate required to meet the load"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,220}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-40})));
  Modelica.Blocks.Interfaces.IntegerInput modChaOve if
    have_val and disTyp == typ.ChangeOver
    "Operating mode in change-over (1 for heating, -1 for cooling)"
    annotation (Placement(
      transformation(
      extent={{-20,-20},{20,20}},
      rotation=0,
      origin={-120,-70}),
      iconTransformation(
      extent={{-10,-10},{10,10}},
      rotation=0,
      origin={-110,-60})));
  Modelica.Blocks.Interfaces.RealInput TSupSet(
    quantity="ThermodynamicTemperature",
    displayUnit="degC") if have_val "Supply temperature set point"
    annotation (Placement(transformation(
      extent={{-20,-20},{20,20}},
      rotation=0,
      origin={-120,-100}),
      iconTransformation(
      extent={{-10,-10},{10,10}},
      rotation=0,
      origin={-110,-80})));
  Modelica.Blocks.Interfaces.RealOutput mReqTot_flow(quantity="MassFlowRate")
    "Total heating or chilled water flow rate required to meet the loads"
    annotation (Placement(transformation(extent={{100,200},{140,240}}),
      iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput QActTot_flow(quantity="HeatFlowRate")
    "Total heat flow rate transferred to the loads (>=0 for heating)"
    annotation (Placement(transformation(extent={{100,80},{140,120}}),
      iconTransformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput PPum(
    quantity="Power", final unit="W") if have_pum
    "Power drawn by pump motor"
    annotation (Placement(transformation(extent={{100,40},{140,80}}),
      iconTransformation(extent={{100,-90},{120,-70}})));
  // COMPONENTS
  Buildings.Controls.OBC.CDL.Continuous.MultiSum sumMasFloReq(final k=fill(1,
        nUni), final nin=nUni) "Total required mass flow rate"
    annotation (Placement(transformation(extent={{-80,210},{-60,230}})));
  Buildings.Fluid.Sources.MassFlowSource_T sou_m_flow[nUni](
    redeclare each final package Medium = Medium,
    each final use_m_flow_in=true,
    each final use_T_in=true,
    each final nPorts=1)
    "Source for terminal units supplied flow rate"
    annotation (Placement(transformation(extent={{60,150},{80,170}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare final package Medium=Medium,
    final nPorts=nUni)
    "Sink for terminal units return flow rate"
    annotation (Placement(transformation(extent={{-60,150},{-80,170}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiSum Q_flowSum(
    final nin=nUni)
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  Modelica.Blocks.Sources.RealExpression mAct_flow[nUni](y=mReq_flow .*
        Buildings.Utilities.Math.Functions.smoothMin(
        1,
        senMasFlo.m_flow/Buildings.Utilities.Math.Functions.smoothMax(
          mReqTot_flow,
          m_flow_small,
          m_flow_small),
        1E-2))
    "Actual supplied mass flow rate (constrained by sum(mAct_flow)<=port_a.m_flow)"
    annotation (Placement(transformation(extent={{-20,158},{0,178}})));
  Modelica.Blocks.Sources.RealExpression QAct_flow[nUni](
    y=mAct_flow.y .* (ports_b1.h_outflow - inStream(ports_a1.h_outflow)))
    "Actual heat flow rate transferred to each load"
    annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pum(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    per(motorCooledByFluid=false),
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    use_inputFilter=false,
    dp_nominal=dp_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState) if have_pum
    "Distribution pump"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    redeclare package Medium = Medium,
    portFlowDirection_1=if allowFlowReversal then
      Modelica.Fluid.Types.PortFlowDirection.Bidirectional else
      Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then
      Modelica.Fluid.Types.PortFlowDirection.Bidirectional else
      Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then
      Modelica.Fluid.Types.PortFlowDirection.Bidirectional else
      Modelica.Fluid.Types.PortFlowDirection.Entering,
    dpValve_nominal=1/9*dp_nominal,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal,
    linearized={true,true},
    energyDynamics=energyDynamics,
    massDynamics=massDynamics) if have_val
    "Mixing valve"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}}, origin={-80,0})));
  Buildings.Fluid.Movers.BaseClasses.IdealSource ideSou(
    redeclare package Medium = Medium,
    dp_start=dp_nominal,
    m_flow_start=m_flow_nominal,
    show_T=false,
    show_V_flow=false,
    control_m_flow=false,
    control_dp=true,
    allowFlowReversal=allowFlowReversal,
    m_flow_small=m_flow_small)
    "Fictitious pipe used to prescribe total pressure drop"
    annotation (Placement(transformation(extent={{-20,10},{0,-10}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u heaCoo(
    redeclare final package Medium=Medium,
    dp_nominal=dp_nominal,
    m_flow_nominal=m_flow_nominal,
    tau=tau,
    Q_flow_nominal=-1,
    allowFlowReversal=allowFlowReversal,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics)
    "Heat transfer from the terminal units to the distribution system"
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Buildings.Fluid.FixedResistances.Junction spl(
    redeclare package Medium=Medium,
    portFlowDirection_1=if allowFlowReversal then
      Modelica.Fluid.Types.PortFlowDirection.Bidirectional else
      Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then
      Modelica.Fluid.Types.PortFlowDirection.Bidirectional else
      Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then
      Modelica.Fluid.Types.PortFlowDirection.Bidirectional else
      Modelica.Fluid.Types.PortFlowDirection.Leaving,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=0*{1,1,1},
    energyDynamics=energyDynamics,
    massDynamics=massDynamics) if have_val
    "Flow splitter"
    annotation (Placement(transformation(
      extent={{-10,10},{10,-10}}, origin={80,0})));
  Modelica.Blocks.Sources.RealExpression TSupVal(y=TSup)
    "Supply temperature value"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
      rotation=180, origin={-90,80})));
  Buildings.Utilities.Math.Polynominal pol(a={dp_nominal})
    "Polynomial expression defining pressure drop variation with flow rate"
    annotation (Placement(transformation(extent={{20,-30},{0,-10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(
    redeclare package Medium=Medium,
    allowFlowReversal=allowFlowReversal)
    "Supply mass flow rate sensor"
    annotation (Placement(transformation(extent={{18,10},{38,-10}})));
  Buildings.Controls.OBC.CDL.Routing.RealReplicator reaRep(nout=nUni)
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  MixingValveControl conVal(final disTyp=disTyp) if have_val
    "Mixing valve controller"
    annotation (Placement(transformation(extent={{-48,-106},{-28,-86}})));
  // MISCELLANEOUS VARIABLES
  Modelica.SIunits.Temperature TSup(displayUnit="degC") = Medium.temperature(
    state=Medium.setState_phX(
      p=ideSou.port_a.p,
      h=inStream(ideSou.port_a.h_outflow),
      X=inStream(ideSou.port_a.Xi_outflow)))
    "Supply temperature";
initial equation
  assert(nPorts_a1 == nPorts_b1,
    "In " + getInstanceName() +
    ": The numbers of terminal units return ports (" + String(nPorts_a1) +
    ") and supply ports (" + String(nPorts_b1) + ") must be equal.");
  assert(if have_val then have_pum else true,
    "In " + getInstanceName() +
    ": The configuration where have_val is true and have_pum is false is not allowed.");
equation
  connect(sumMasFloReq.y, mReqTot_flow)
    annotation (Line(points={{-58,220},{120,220}}, color={0,0,127}));
  connect(mReq_flow, sumMasFloReq.u)
    annotation (Line(points={{-120,220},{-82,220}}, color={0,0,127}));
  connect(mAct_flow.y, sou_m_flow.m_flow_in)
    annotation (Line(points={{1,168},{58,168}}, color={0,0,127}));
  connect(ports_a1, sin.ports)
    annotation (Line(points={{-100,160},{-80,160}}, color={0,127,255}));
  connect(sou_m_flow.ports[1], ports_b1)
    annotation (Line(points={{80,160},{100,160}}, color={0,127,255}));
  connect(val.port_2, pum.port_a)
    annotation (Line(points={{-70,0},{-50,0}}, color={0,127,255}));
  connect(pum.port_b, ideSou.port_a)
    annotation (Line(points={{-30,0},{-20,0}}, color={0,127,255}));
  connect(ideSou.port_b, senMasFlo.port_a)
    annotation (Line(points={{0,0},{18,0}}, color={0,127,255}));
  connect(senMasFlo.port_b, heaCoo.port_a)
    annotation (Line(points={{38,0},{46,0}}, color={0,127,255}));
  connect(Q_flowSum.y, QActTot_flow)
    annotation (Line(points={{-48,100},{120,100}}, color={0,0,127}));
  connect(QAct_flow.y, Q_flowSum.u)
    annotation (Line(points={{-79,100},{-72,100}}, color={0,0,127}));
  connect(Q_flowSum.y, heaCoo.u) annotation (Line(points={{-48,100},{40,100},{40,
          6},{44,6}}, color={0,0,127}));
  connect(pol.y, ideSou.dp_in)
    annotation (Line(points={{-1,-20},{-4,-20},{-4,-8}},   color={0,0,127}));
  connect(senMasFlo.m_flow, pol.u) annotation (Line(points={{28,-11},{28,-20},{22,
          -20}},                  color={0,0,127}));
  connect(TSupVal.y, reaRep.u)
    annotation (Line(points={{-79,80},{-22,80}}, color={0,0,127}));
  connect(reaRep.y, sou_m_flow.T_in) annotation (Line(points={{2,80},{20,80},{20,
          164},{58,164}}, color={0,0,127}));
  if have_val then
    connect(port_a, val.port_1)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
    connect(heaCoo.port_b, spl.port_1)
      annotation (Line(points={{66,0},{70,0}}, color={0,127,255}));
    connect(spl.port_2, port_b)
      annotation (Line(points={{90,0},{100,0}}, color={0,127,255}));
    connect(spl.port_3, val.port_3)
      annotation (Line(points={{80,10},{80,40},{-80,40},{-80,10}}, color={0,127,255}));
    connect(TSupSet, conVal.TSupSet) annotation (Line(points={{-120,-100},{-49,
            -100}},                       color={0,0,127}));
    connect(TSupVal.y, conVal.TSupMes) annotation (Line(points={{-79,80},{-60,
            80},{-60,-104},{-49,-104}}, color={0,0,127}));
    connect(conVal.yVal, val.y) annotation (Line(points={{-27,-96},{-20,-96},{
            -20,-70},{-80,-70},{-80,-12}},  color={0,0,127}));
    if disTyp == typ.ChangeOver then
      connect(modChaOve, conVal.modChaOve)
        annotation (Line(points={{-120,-70},{-88,-70},{-88,-88},{-49,-88}},
                                              color={255,127,0}));
    end if;
  else
    connect(heaCoo.port_b, port_b)
      annotation (Line(points={{66,0},{100,0}}, color={0,127,255}));
    if have_pum then
      connect(port_a, pum.port_a)
      annotation (Line(points={{-100,0},{-50,0}}, color={0,127,255}));
    else
      connect(port_a, ideSou.port_a)
        annotation (Line(points={{-100,0},{-20,0}}, color={0,127,255}));
    end if;
  end if;
  if have_pum then
    connect(sumMasFloReq.y, pum.m_flow_in)
      annotation (Line(points={{-58,220},{-40,
            220},{-40,12}}, color={0,0,127}));
      connect(pum.P, PPum)
    annotation (Line(points={{-29,9},{-20,9},{-20,60},{120,60}},
        color={0,0,127}));
  end if;
annotation (
  defaultComponentName="disFlo",
  Documentation(info="<html>
<p>
This model represents a hydraulic distribution system serving multiple terminal units.
It is primarily intended to be used in conjunction with models that derive from
<a href=\"modelica://Buildings.Applications.DHC.Loads.BaseClasses.PartialTerminalUnit\">
Buildings.Applications.DHC.Loads.BaseClasses.PartialTerminalUnit</a>.
</p>
<p>
The fluid flow modeling is decoupled between a main distribution loop and several terminal
branch circuits:
</p>
<ul>
<li>
The flow rate in each branch circuit is equal to the flow rate demand yielded by the terminal
unit model, constrained by the condition that the sum of all demands is lower or equal to
the flow rate in the main loop.
</li>
<li>
The inlet temperature in each branch circuit is equal to the supply temperature in the main loop.
The outlet temperature in the main loop results from transferring the enthalpy flow rate of each
individual fluid stream to the main fluid stream.
</li>
<li>
The pressure drop in the main distribution loop corresponds to the pressure drop
over the whole distribution system (the pump head): it is governed by an equation representing
the control logic of the distribution pump. The pressure drop in each branch circuit is
irrelevant: <code>dp_nominal</code> (water side) must be set to zero for each terminal unit component.
</li>
</ul>
<p>
This modeling approach aims to minimize the number of algebraic equations by avoiding an explicit
modeling of the terminal actuators and the whole flow network.
</p>
<p>
In addition the assumption <code>allowFlowReversal=false</code> is used systematically
together with boundary conditions which actually ensure that no reverse flow conditions are
encountered in simulation. This allows directly accessing the inlet enthalpy value of a
component from the fluid port <code>port_a</code> with the built-in function <code>inStream</code>.
This approach is preferred to the use of two-port sensors which introduce a state to ensure
a smooth transition at flow reversal.
All connected components must meet the same requirements.
</p>
<p>
Optionally:
</p>
<ul>
<li>
a distribution pump can be modeled with a prescribed flow rate corresponding to the total flow rate
demand,
</li>
<li>
a mixing valve can be modeled (together with a distribution pump) with a control loop
tracking the supply temperature.
</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false,
    extent={{-100,-100},{100,100}}),
    graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-101,5},{100,-4}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={0,0,255},
        fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{
            100,240}})));
end FlowDistribution;
