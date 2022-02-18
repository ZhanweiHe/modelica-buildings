within Buildings.Fluid.Storage.Plant.Examples.BaseClasses.Validation;
model DummyUser "Test model for the dummy user"
  extends Modelica.Icons.Example;

  package Medium = Buildings.Media.Water "Medium model";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal=
    p_CHWS_nominal-p_CHWR_nominal
    "Nominal pressure difference";
  parameter Modelica.Units.SI.AbsolutePressure p_CHWS_nominal=800000
    "Nominal pressure at CHW supply line";
  parameter Modelica.Units.SI.AbsolutePressure p_CHWR_nominal=300000
    "Nominal pressure at CHW return line";
  parameter Modelica.Units.SI.Temperature T_CHWR_nominal(
    final displayUnit="degC")=
     12+273.15
    "Nominal temperature of CHW return";
  parameter Modelica.Units.SI.Temperature T_CHWS_nominal(
    final displayUnit="degC")=
     7+273.15
    "Nominal temperature of CHW supply";
  parameter Boolean allowFlowReversal=false
    "Flow reversal setting";
  parameter Modelica.Units.SI.Power QCooLoa_flow_nominal=5*4200*0.9
    "Nominal cooling load of one consumer";

  Buildings.Fluid.Storage.Plant.Examples.BaseClasses.DummyUser ideUsr(
    redeclare package Medium = Medium,
    vol(T_start=15 + 273.15),
    m_flow_nominal=m_flow_nominal,
    p_a_nominal=p_CHWS_nominal,
    p_b_nominal=p_CHWR_nominal,
    T_a_nominal=T_CHWS_nominal,
    T_b_nominal=T_CHWR_nominal) "Ideal user" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, rotation=0)));
  Modelica.Blocks.Sources.Constant set_TRet(k=12 + 273.15)
    "CHW return setpoint"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare final package Medium = Medium,
    p=p_CHWR_nominal,
    T=T_CHWR_nominal,
    nPorts=1) "Sink representing CHW return line"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,0})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare final package Medium = Medium,
    p=p_CHWS_nominal,
    T=T_CHWS_nominal,
    nPorts=1) "Source representing CHW supply line" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,0})));
  Modelica.Blocks.Sources.TimeTable preQCooLoa_flow(table=[0*3600,0; 0.5*3600,0;
        0.5*3600,QCooLoa_flow_nominal; 0.75*3600,QCooLoa_flow_nominal; 0.75*3600,
        0; 1*3600,0])
    "Placeholder, prescribed cooling load"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
equation
  connect(set_TRet.y,ideUsr. TSet)
    annotation (Line(points={{-59,50},{-30,50},{-30,4},{-11,4}},
                                                       color={0,0,127}));
  connect(sou.ports[1],ideUsr. port_a) annotation (Line(points={{-60,
          -6.66134e-16},{-35.1,-6.66134e-16},{-35.1,0},{-10,0}},
                                                     color={0,127,255}));
  connect(ideUsr.port_b, sin.ports[1])
    annotation (Line(points={{10,0},{60,0}}, color={0,127,255}));
  connect(preQCooLoa_flow.y,ideUsr. QCooLoa_flow) annotation (Line(points={{-39,90},
          {-18,90},{-18,8},{-11,8}},     color={0,0,127}));
annotation(__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Storage/Plant/Examples/BaseClasses/Validation/DummyUser.mos"
        "Simulate and plot"),
experiment(Tolerance=1e-06, StopTime=3600), Documentation(info="<html>
<p>
This is a simple test model for the ideal user.
</p>
</html>", revisions="<html>
<ul>
<li>
February 18, 2022 by Hongxiang Fu:<br/>
First implementation. This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2859\">#2859</a>.
</li>
</ul>
</html>"));
end DummyUser;
