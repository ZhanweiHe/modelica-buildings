within Buildings.Templates.Interfaces;
partial model Sensor
  extends Buildings.Fluid.Interfaces.PartialTwoPort;

  parameter Types.Sensor typ "Equipment type"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Templates.Types.Location loc
    "Equipment location"
    annotation (Evaluate=true, Dialog(group="Configuration"));

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=
    if typ <> Types.Sensor.None and typ <> Types.Sensor.DifferentialPressure then (
      if loc == Templates.Types.Location.Supply then
        dat.getReal(varName=id + ".Mechanical.Supply air mass flow rate.value")
      elseif loc == Templates.Types.Location.OutdoorAir then
        dat.getReal(varName=id + ".Mechanical.Supply air mass flow rate.value")
      elseif loc == Templates.Types.Location.MinimumOutdoorAir then
        dat.getReal(varName=id + ".Mechanical.Supply air mass flow rate.value")
      elseif loc == Templates.Types.Location.Return then
        dat.getReal(varName=id + ".Mechanical.Return air mass flow rate.value")
      elseif loc == Templates.Types.Location.Relief then
        dat.getReal(varName=id + ".Mechanical.Return air mass flow rate.value")
      elseif loc == Templates.Types.Location.Terminal then
        dat.getReal(varName=id + ".Mechanical.Discharge air mass flow rate.value")
      else 0)
      else 0
    "Mass flow rate"
    annotation (
     Dialog(group="Nominal condition",
       enable=typ <> Types.Sensor.None and typ <> Types.Sensor.DifferentialPressure));

  final parameter String insNam = getInstanceName()
    "Instance name"
    annotation (Evaluate=true);
  outer parameter String id
    "System identifier";
  outer parameter ExternData.JSONFile dat
    "External parameter file";

  Modelica.Fluid.Interfaces.FluidPort_b port_bRef(
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default)) if typ ==
    Types.Sensor.DifferentialPressure
    "Port at the reference pressure for differential pressure sensor"
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Buildings.Templates.BaseClasses.Connectors.BusInterface busCon
    "Control bus"
    annotation (Placement(transformation(extent={{-20,80},{20, 120}}),
      iconTransformation(extent={{-10,90},{10,110}})));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
The location parameter <code>loc</code> is used to assign nominal parameter values
based on the external system parameter file.
The instance name is used to connect to the propoer I/O control signal.
</p>
</html>"));
end Sensor;