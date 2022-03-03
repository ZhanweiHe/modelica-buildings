within Buildings.Experimental.DHC.Plants.Steam.Examples;
model SingleBoiler "Example model to demonstrate the single-boiler steam plant 
  in a single closed loop"
  extends Modelica.Icons.Example;

  package MediumSte = Buildings.Media.Steam (
    p_default=300000,
    T_default=273.15+200)
    "Steam medium";
  package MediumWat =
    Buildings.Media.Specialized.Water.TemperatureDependentDensity (
      p_default=101325,
      T_default=273.15+100)
    "Water medium";

  parameter Modelica.Units.SI.AbsolutePressure pSat=300000
    "Saturation pressure";
  parameter Modelica.Units.SI.Temperature TSat=
     MediumSte.saturationTemperature(pSat)
     "Saturation temperature";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate of plant";
  parameter Modelica.Units.SI.PressureDifference dpPip=6000
    "Pressure drop in the condensate return pipe";
  // pumps
  parameter Buildings.Fluid.Movers.Data.Generic perPumFW(
    pressure(
      V_flow=m_flow_nominal*1000*{0.4,0.6,0.8,1.0},
      dp=(pSat-101325)*{1.34,1.27,1.17,1.0}))
    "Performance data for feedwater pump";
    parameter Buildings.Fluid.Movers.Data.Generic perPumCNR(
   pressure(
     V_flow=m_flow_nominal*1000*{0,1,2},
     dp=dpPip*{2,1,0}))
    "Performance data for condensate return pumps";

  Buildings.Experimental.DHC.Plants.Steam.SingleBoiler pla(
    redeclare package Medium = MediumWat,
    redeclare package MediumHea_b = MediumSte,
    fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
    VBoi=500,
    VTanFW_start=10,
    m_flow_nominal=m_flow_nominal,
    pSteSet=pSat,
    per=perPumFW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Plant"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Buildings.Experimental.DHC.Loads.Steam.BaseClasses.ControlVolumeCondensation vol(
    redeclare package MediumSte = MediumSte,
    redeclare package MediumWat = MediumWat,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    p_start=pSat,
    T_start=TSat,
    m_flow_nominal=m_flow_nominal,
    V=1)
    "Volume"
    annotation (Placement(transformation(extent={{-40,50},{-20,30}})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = MediumWat,
    m_flow_nominal=m_flow_nominal,
    dp_nominal = dpPip)
    "Resistance in district network"
    annotation (Placement(transformation(extent={{-60,-50},{-80,-30}})));
  Buildings.Experimental.DHC.Loads.Steam.BaseClasses.SteamTrap steTra(
    redeclare package Medium = MediumWat,
    m_flow_nominal=m_flow_nominal)
    "Steam trap"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Sources.Sine inp(
    amplitude=-0.5,
    f=1/86400,
    phase=3.1415926535898,
    offset=0.5)
    "Input signal"
    annotation (Placement(transformation(extent={{90,-20},{70,0}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(
    redeclare package Medium = MediumWat)
    "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{20,-50},{0,-30}})));
  Buildings.Controls.Continuous.LimPID conPumCNR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=15)
    "Controller"
    annotation (Placement(transformation(extent={{20,-20},{0,0}})));
  Modelica.Blocks.Math.Gain m_flow(k=m_flow_nominal)
    "Gain to calculate m_flow"
    annotation (Placement(transformation(extent={{60,-20},{40,0}})));
  Buildings.Fluid.Movers.SpeedControlled_y pumCNR(
    redeclare package Medium = MediumWat,
    per=perPumCNR,
    y_start=1)
    "Condensate return pump"
    annotation (Placement(transformation(extent={{-20,-50},{-40,-30}})));
equation
  connect(res.port_b, pla.port_aSerHea) annotation (Line(points={{-80,-40},{-90,
          -40},{-90,40},{-80,40}},
                              color={0,127,255}));
  connect(vol.port_b, steTra.port_a)
    annotation (Line(points={{-20,40},{0,40}}, color={0,127,255}));
  connect(pla.port_bSerHea, vol.port_a)
    annotation (Line(points={{-60,40},{-40,40}},
                                               color={0,127,255}));
  connect(steTra.port_b, senMasFlo.port_a) annotation (Line(points={{20,40},{30,
          40},{30,-40},{20,-40}}, color={0,127,255}));
  connect(senMasFlo.port_b, pumCNR.port_a)
    annotation (Line(points={{0,-40},{-20,-40}},color={0,127,255}));
  connect(pumCNR.port_b, res.port_a)
    annotation (Line(points={{-40,-40},{-60,-40}}, color={0,127,255}));
  connect(senMasFlo.m_flow, conPumCNR.u_m)
    annotation (Line(points={{10,-29},{10,-22}}, color={0,0,127}));
  connect(conPumCNR.y, pumCNR.y)
    annotation (Line(points={{-1,-10},{-30,-10},{-30,-28}}, color={0,0,127}));
  connect(m_flow.y, conPumCNR.u_s)
    annotation (Line(points={{39,-10},{22,-10}}, color={0,0,127}));
  connect(inp.y, m_flow.u)
    annotation (Line(points={{69,-10},{62,-10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=864000, __Dymola_Algorithm="Dassl"),
      __Dymola_Commands(file=
    "modelica://Buildings/Resources/Scripts/Dymola/Experimental/DHC/Plants/Steam/Examples/SingleBoiler.mos"
    "Simulate and plot"),
    Documentation(info="<html>
<p>This model validates the steam plant implemented in
<a href=\"modelica://Buildings.Experimental.DHC.Plants.Steam.SingleBoiler\">
Buildings.Experimental.DHC.Plants.Steam.SingleBoiler</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 3, 2022 by Kathryn Hinkelman:<br/>
First implementation.
</li>
</ul>
</html>"));
end SingleBoiler;
