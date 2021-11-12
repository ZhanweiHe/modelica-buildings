within Buildings.Templates.ChilledWaterPlant.Components.Controls.Interfaces;
block PartialController

  parameter Buildings.Templates.ChilledWaterPlant.Components.Types.Controller typ "Type of controller"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  outer parameter String id
    "System identifier";
  outer parameter ExternData.JSONFile dat
    "External parameter file";

  parameter Integer nChi "Number of chillers";
  parameter Integer nPumPri "Number of primary pumps";
  parameter Integer nPumSec "Number of secondary pumps";
  parameter Integer nPumCon "Number of condenser pumps";
  parameter Integer nCooTow "Number of cooling towers";

  parameter Boolean is_airCoo;

  .Buildings.Templates.ChilledWaterPlant.BaseClasses.BusChilledWater busCHW(
    final nChi=nChi,
    final nPumPri=nPumPri,
    final nPumSec=nPumSec)
    annotation (Placement(transformation(extent={{200,-20},{240,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  .Buildings.Templates.ChilledWaterPlant.BaseClasses.BusCondenserWater busCW(
    final nPum=nPumCon,
    final nCooTow=nCooTow) if not is_airCoo annotation (
      Placement(transformation(extent={{-218,-20},{-178,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  annotation (
    __Dymola_translate=true,
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-151,-114},{149,-154}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{220,
            200}})));
end PartialController;
