within Buildings.Templates.AHUs.Validation;
model BaseNoEquipment
  extends Modelica.Icons.Example;
  replaceable package MediumAir=Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Air medium";
  replaceable package MediumCoo=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Cooling medium (such as CHW)";
  inner parameter ExternData.JSONFile dat(
    fileName=Modelica.Utilities.Files.loadResource(
      "modelica://Buildings/Resources/Data/Templates/Validation/systems.json"))
    annotation (
      Evaluate=true,
      Placement(transformation(extent={{76,76},{96,96}})));

  replaceable UserProject.AHUs.BaseNoEquipment ahu(redeclare final package
      MediumAir = MediumAir, redeclare final package MediumCoo = MediumCoo)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Fluid.Sources.Boundary_pT bou(
    redeclare final package Medium=MediumAir,
    nPorts=2)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare final package Medium=MediumAir,
    nPorts=2)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));

  /*
  FIXME: test snippet working with Dymola but not with OCT
  External object constructors are not allowed inside functions.
  
  parameter Integer nTest = Templates.BaseClasses.getArraySize1D(
     varName="VAV_1.Supply fan.Pressure curve",
     fileName=dat.fileName);

  Modelica.Blocks.Sources.TimeTable timeTable(
  table=dat.getRealArray2D("VAV_1.Supply fan.Pressure curve", nTest, 2));
  */


equation
  connect(bou.ports[1], ahu.port_Out) annotation (Line(points={{-60,2},{-40,2},
          {-40,-10},{-20,-10}},color={0,127,255}));
  connect(ahu.port_Sup, bou1.ports[1]) annotation (Line(points={{20,-10},{40,
          -10},{40,2},{60,2}},
                          color={0,127,255}));
  connect(bou.ports[2], ahu.port_Exh) annotation (Line(points={{-60,-2},{-40,-2},
          {-40,10},{-20,10}}, color={0,127,255}));
  connect(ahu.port_Ret, bou1.ports[2]) annotation (Line(points={{20,10},{40,10},
          {40,-2},{60,-2}}, color={0,127,255}));
  annotation (
  experiment(Tolerance=1e-6, StopTime=1),
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseNoEquipment;