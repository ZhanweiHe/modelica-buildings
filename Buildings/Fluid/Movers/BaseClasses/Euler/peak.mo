within Buildings.Fluid.Movers.BaseClasses.Euler;
record peak
  "Record for the operation condition at peak efficiency"
  extends Modelica.Icons.Record;
  parameter Modelica.Units.SI.VolumeFlowRate
    V_flow(min=0)=0
    "Volume flow rate at peak efficiency";
  parameter Modelica.Units.SI.PressureDifference
    dp(min=0,displayUnit="Pa")=0
    "Pressure rise at peak efficiency";
  parameter Modelica.Units.SI.Efficiency
    etaHyd=0.7
    "Peak efficiency";
  parameter Modelica.Units.SI.Efficiency
    etaMot=0.7
    "Peak efficiency";
  parameter Modelica.Units.SI.Efficiency
    eta=0.49
    "Peak efficiency";
  annotation (
Documentation(info="<html>
<p>
Record for performance data that describe the operation at peak efficiency.
</p>
</html>",
revisions="<html>
<ul>
<li>
October 15, 2021, by Hongxiang Fu:<br/>
First implementation. This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2668\">#2668</a>.
</li>
</ul>
</html>"));
end peak;
