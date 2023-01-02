within Buildings.Experimental.DHC.Plants.Combined.Subsystems.BaseClasses;
partial model PartialMultiplePumps
  "Base class for modeling multiple identical pumps in parallel"
  extends Buildings.Fluid.Interfaces.LumpedVolumeDeclarations(
    final massDynamics=energyDynamics,
    final mSenFac=1);
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow_nominal(final min=Modelica.Constants.small)=nPum * mPum_flow_nominal,
    show_T=false,
    port_a(
      h_outflow(start=h_outflow_start)),
    port_b(
      h_outflow(start=h_outflow_start),
      p(start=p_start),
      final m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0)));

  parameter Integer nPum(
    final min=1,
    start=1)
    "Number of pumps"
    annotation(Evaluate=true);
  parameter Boolean have_var = true
    "Set to true for variable speed pumps, false for constant speed"
    annotation(Evaluate=true);
  parameter Boolean have_valve = true
    "Set to true for inline check valve"
    annotation(Evaluate=true);
  parameter Modelica.Units.SI.MassFlowRate mPum_flow_nominal
    "Design mass flow rate (each pump)"
    annotation(Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dpPum_nominal
    "Design head (each pump)"
    annotation(Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal=1E4
    "Pressure drop of check valve fully open"
    annotation(Dialog(group="Nominal condition", enable=have_valve));
  replaceable parameter Fluid.Movers.Data.Generic per
    constrainedby Buildings.Fluid.Movers.Data.Generic(
      pressure(
        V_flow={0, 1, 2} * mPum_flow_nominal / rho_default,
        dp={1.14, 1, 0.42} * dpPum_nominal),
      motorCooledByFluid=false) "Pump parameters"
    annotation (Placement(transformation(extent={{-10,-98},{10,-78}})));

  parameter Modelica.Units.SI.Time tau=1
    "Time constant of fluid volume for nominal flow, used if energy or mass balance is dynamic"
    annotation (Dialog(
      tab="Dynamics",
      group="Nominal condition",
      enable=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState));

  // Classes used to implement the filtered speed
  parameter Boolean use_inputFilter=true
    "= true, if speed is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(tab="Dynamics", group="Filtered speed"));
  parameter Modelica.Units.SI.Time riseTime=30
    "Rise time of the filter (time to reach 99.6 % of the speed)" annotation (
      Dialog(
      tab="Dynamics",
      group="Filtered speed",
      enable=use_inputFilter));
  parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (no init/steady state/initial state/initial output)"
    annotation(Dialog(tab="Dynamics", group="Filtered speed",enable=use_inputFilter));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput y1[nPum]
    "Start signal (VFD Run or motor starter contact)"
    annotation (Placement(
        transformation(extent={{-140,80},{-100,120}}), iconTransformation(
          extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput P(final unit="W")
    "Total power (all pumps)"
    annotation (Placement(transformation(extent={{100,40},{140,80}}),
        iconTransformation(extent={{100,20},{140,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1_actual[nPum]
    "Pump status" annotation (Placement(transformation(extent={{100,80},{140,
            120}}), iconTransformation(extent={{100,60},{140,100}})));

  Fluid.BaseClasses.MassFlowRateMultiplier mulOut(
    redeclare final package Medium=Medium,
    final use_input=true)
    "Flow rate multiplier"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Fluid.BaseClasses.MassFlowRateMultiplier mulInl(
    redeclare final package Medium=Medium,
    final use_input=true)
    "Flow rate multiplier"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  replaceable Fluid.Movers.SpeedControlled_y pum
    constrainedby Buildings.Fluid.Movers.BaseClasses.PartialFlowMachine(
    redeclare final package Medium=Medium,
    final tau=tau,
    final show_T=show_T,
    final allowFlowReversal=allowFlowReversal,
    final energyDynamics=energyDynamics,
    final use_inputFilter=use_inputFilter,
    final riseTime=riseTime,
    final init=init,
    final per=per,
    addPowerToMedium=false) "Pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  MultipleCommands com(final nUni=nPum) "Convert command signal"
    annotation (Placement(transformation(extent={{-90,90},{-70,110}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    "Convert to real"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,100})));
  Buildings.Controls.OBC.CDL.Continuous.Multiply mul "Compute total power"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Buildings.Controls.OBC.CDL.Continuous.Multiply inp
    "Compute pump input signal" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-20,50})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant cst
               if not have_var "Constant setpoint"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold sta(t=1E-2, h=0.5E-2)
    "Compute pump status"
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator rep(nout=nPum)
    "Replicate signal"
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Fluid.FixedResistances.CheckValve cheVal(
    redeclare final package Medium=Medium,
    final m_flow_nominal=mPum_flow_nominal,
    final dpValve_nominal=dpValve_nominal,
    final show_T=show_T,
    final allowFlowReversal=allowFlowReversal) if have_valve "Check valve"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default)
    "State of the medium at the medium default properties";
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density at the medium default properties";
  final parameter Medium.ThermodynamicState sta_start=Medium.setState_pTX(
    T=T_start,
    p=p_start,
    X=X_start)
    "Medium state at start values";
  final parameter Modelica.Units.SI.SpecificEnthalpy h_outflow_start=
    Medium.specificEnthalpy(sta_start)
    "Start value for outflowing enthalpy";
equation
  connect(mulOut.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
  connect(port_a, mulInl.port_a)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  connect(mulOut.uInv, mulInl.u) annotation (Line(points={{82,6},{90,6},{90,-20},
          {-90,-20},{-90,6},{-82,6}},color={0,0,127}));
  connect(mulInl.port_b, pum.port_a)
    annotation (Line(points={{-60,0},{-10,0}}, color={0,127,255}));
  connect(y1, com.y1)
    annotation (Line(points={{-120,100},{-94,100},{-94,105},{-92,105}},
                                                    color={255,0,255}));
  connect(com.nUniOnBou, mulOut.u) annotation (Line(points={{-68,107},{-64,107},
          {-64,80},{50,80},{50,6},{58,6}},
                      color={0,0,127}));
  connect(com.y1One, booToRea.u)
    annotation (Line(points={{-68,109},{-66,109},{-66,100},{-62,100}},
                                                   color={255,0,255}));
  connect(mul.y, P)
    annotation (Line(points={{82,60},{120,60}}, color={0,0,127}));
  connect(com.nUniOn, mul.u1) annotation (Line(points={{-68,105},{-66,105},{-66,
          78},{40,78},{40,66},{58,66}},
                    color={0,0,127}));
  connect(pum.P, mul.u2) annotation (Line(points={{11,9},{40,9},{40,54},{58,54}},
                color={0,0,127}));
  connect(pum.y_actual, sta.u) annotation (Line(points={{11,7},{20,7},{20,-60},{
          28,-60}},           color={0,0,127}));
  connect(sta.y, rep.u)
    annotation (Line(points={{52,-60},{58,-60}}, color={255,0,255}));
  connect(rep.y, y1_actual) annotation (Line(points={{82,-60},{94,-60},{94,100},
          {120,100}}, color={255,0,255}));
  connect(pum.port_b, cheVal.port_a)
    annotation (Line(points={{10,0},{30,0}}, color={0,127,255}));
  connect(cheVal.port_b, mulOut.port_a)
    annotation (Line(points={{50,0},{60,0}}, color={0,127,255}));
  connect(cst.y, inp.u1) annotation (Line(points={{-58,30},{-40,30},{-40,44},{
          -32,44}},
                color={0,0,127}));
  connect(booToRea.y, inp.u2) annotation (Line(points={{-38,100},{-36,100},{-36,
          56},{-32,56}},
                     color={0,0,127}));
  annotation (
    defaultComponentName="pum",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),                                   graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={27,0,55},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,120}})),
    Documentation(info="<html>
<p>
This base class is used to construct the various multiple-pump 
models within 
<a href=\"modelica://Buildings.Experimental.DHC.Plants.Combined.Subsystems\">
Buildings.Experimental.DHC.Plants.Combined.Subsystems</a>.
</p>
</html>"));
end PartialMultiplePumps;
