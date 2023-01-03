within Buildings.Experimental.DHC.Plants.Combined.Subsystems.Validation;
model ChillerGroup "Validation of the chiller group model"
  extends Modelica.Icons.Example;

  replaceable package MediumChiWat=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "CHW medium";
  replaceable package MediumConWat=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "CW medium";

  parameter
    Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_Carrier_19XR_1403kW_7_09COP_VSD
    dat "Chiller parameters"
    annotation (Placement(transformation(extent={{90,92},{110,112}})));

  Buildings.Experimental.DHC.Plants.Combined.Subsystems.ChillerGroup chi(
    redeclare final package Medium1 = MediumConWat,
    redeclare final package Medium2 = MediumChiWat,
    show_T=true,
    nUni=2,
    typValEva=Buildings.Experimental.DHC.Types.Valve.TwoWayTwoPosition,
    typValCon=Buildings.Experimental.DHC.Types.Valve.None,
    dpEva_nominal=3E5,
    dpCon_nominal=3E5,
    final dat=dat,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Chiller group"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Fluid.Sources.Boundary_pT retChiWat(
    redeclare final package Medium = MediumChiWat,
    p=supChiWat.p + chi.dpEva_nominal + chi.dpBalEva_nominal + chi.dpValveEva_nominal,
    T=288.15,
    nPorts=1)
    "Boundary conditions for CHW"
    annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={20,-102})));

  Fluid.Sources.Boundary_pT supConWat(
    redeclare final package Medium = MediumConWat,
    p=retConWat.p + chi.dpCon_nominal + chi.dpBalCon_nominal + chi.dpValveCon_nominal,
    nPorts=1) "Boundary conditions for CW" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-20,100})));

  Fluid.Sources.Boundary_pT retConWat(
    redeclare final package Medium = MediumConWat,
    p=200000,
    nPorts=1) "Boundary conditions for CW" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,100})));
  Fluid.Sources.Boundary_pT supChiWat(
    redeclare final package Medium = MediumChiWat,
    p=200000,
    nPorts=1) "Boundary conditions for CHW"
    annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,-102})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TChiWatSupSet(
    y(displayUnit="degC", unit="K"),
    height=+5,
    duration=1000,
    offset=dat.TEvaLvg_nominal) "CHW supply temperature setpoint"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1Chi(
    table=[0,1,1; 0.5,1,1; 0.5,1,0; 0.8,1,0; 0.8,0,0; 1,0,0],
    timeScale=1000,
    period=1000)
    "Chiller On/Off command"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
equation
  connect(chi.port_b1, retConWat.ports[1])
    annotation (Line(points={{10,6},{20,6},{20,90}}, color={0,127,255}));
  connect(supConWat.ports[1], chi.port_a1)
    annotation (Line(points={{-20,90},{-20,6},{-10,6}}, color={0,127,255}));
  connect(retChiWat.ports[1], chi.port_a2)
    annotation (Line(points={{20,-92},{20,-6},{10,-6}}, color={0,127,255}));
  connect(supChiWat.ports[1], chi.port_b2)
    annotation (Line(points={{-20,-92},{-20,-6},{-10,-6}}, color={0,127,255}));
  connect(TChiWatSupSet.y, chi.TSet) annotation (Line(points={{-88,-40},{-16,
          -40},{-16,-9},{-12,-9}}, color={0,0,127}));
  connect(y1Chi.y, chi.y1Chi) annotation (Line(points={{-88,80},{-60,80},{-60,9},
          {-12,9}},        color={255,0,255}));
  connect(y1Chi.y, chi.y1ValEva) annotation (Line(points={{-88,80},{-60,80},{-60,
          -16},{-9,-16},{-9,-12}},      color={255,0,255}));
  annotation (
    __Dymola_Commands(
      file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/DHC/Plants/Combined/Subsystems/Validation/ChillerGroup.mos"
      "Simulate and plot"),
    experiment(
      StopTime=1000,
      Tolerance=1e-06),
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}})),
    Documentation(info="<html>
<p>
This model validates 
<a href=\"modelica://Buildings.Experimental.DHC.Plants.Combined.Subsystems.ChillerGroup\">
Buildings.Experimental.DHC.Plants.Combined.Subsystems.ChillerGroup</a>
in a configuration with two \"cooling-only\" chillers.
The chillers are switched <i>Off</i> one after the other, and 
receive an increasing CHW supply temperature setpoint.
</p>
</html>"));
end ChillerGroup;
