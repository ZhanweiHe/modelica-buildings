within Buildings.Templates.ChilledWaterPlants;
model AirCooled "Air-cooled chiller plant"
  extends  Buildings.Templates.ChilledWaterPlants.Interfaces.PartialChilledWaterLoop(
    redeclare replaceable package MediumCon=Buildings.Media.Air,
    redeclare final Buildings.Templates.ChilledWaterPlants.Components.Economizers.None eco,
    ctl(final typCtlHea=Buildings.Templates.ChilledWaterPlants.Types.ChillerLiftControl.BuiltIn),
    final typChi=Buildings.Templates.Components.Types.Chiller.AirCooled,
    final typCoo=Buildings.Templates.Components.Types.Cooler.None,
    final nCoo=0,
    final nPumConWat=0,
    final typValCooInlIso=Buildings.Templates.Components.Types.Valve.None,
    final typValCooOutIso=Buildings.Templates.Components.Types.Valve.None);

  // Air loop
  Fluid.Sources.Boundary_pT bouCon(
    redeclare final package Medium = MediumCon,
    final nPorts=1)
    "Air pressure boundary condition"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-120,0})));
  Fluid.Sources.MassFlowSource_WeatherData souAir[nChi](
    redeclare each final package Medium = MediumCon,
    each final nPorts=1,
    each final use_m_flow_in=true)
    "Air flow source"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-118,-180})));
  Controls.OBC.CDL.Conversions.BooleanToReal y1Chi[nChi]
    "Convert chiller Start/Stop signal into real value"
    annotation (Placement(transformation(extent={{-230,130},{-210,150}})));
  Controls.OBC.CDL.Continuous.MultiplyByParameter mCon_flow[nChi](
    final k=chi.mConChi_flow_nominal)
    "Compute air mass flow rate at condenser"
    annotation (Placement(transformation(extent={{-188,130},{-168,150}})));
protected
  Buildings.Templates.Components.Interfaces.Bus busChi[nChi]
    "Chiller control bus"
    annotation (Placement(transformation(extent={{-280, 120},{-240,160}}),
    iconTransformation(extent={{-756,-40},{-716,0}})));
equation
  for i in 1:nChi loop
      connect(busWea, souAir[i].weaBus) annotation (Line(
      points={{0,280},{0,260},{-140,260},{-140,-180.2},{-128,-180.2}},
      color={255,204,51},
      thickness=0.5));
  end for;
  connect(souAir.ports[1], inlConChi.ports_a)
    annotation(Line(
      points={{-108,-180},{-100,-180}}, color={0,127,255}));
  connect(outConChi.port_b, bouCon.ports[1])
    annotation (Line(points={{-100,0},{-105,0},{-105,-4.44089e-16},{-110,-4.44089e-16}},
     color={0,127,255}));
  connect(y1Chi.y, mCon_flow.u)
    annotation (Line(points={{-208,140},{-190,140}}, color={0,0,127}));
  connect(mCon_flow.y, souAir.m_flow_in) annotation (Line(points={{-166,140},{-160,
          140},{-160,-188},{-128,-188}}, color={0,0,127}));
  connect(busChi.y1, y1Chi.u) annotation (Line(
      points={{-260,140},{-232,140}},
      color={255,204,51},
      thickness=0.5));
  connect(bus.chi, busChi) annotation (Line(
      points={{-300,140},{-260,140}},
      color={255,204,51},
      thickness=0.5));
  annotation (Documentation(info="<html>
<p>
This template represents a chilled water plant with water-cooled chillers.
</p>
<p>
The possible equipment configurations are enumerated in the table below.
The user may refer to ASHRAE (2021) for further details.
The first option displayed in bold characters corresponds to the default configuration.<br/>
</p>
<table summary=\"summary\" border=\"1\">
<tr><th>Configuration parameter</th><th>Options</th><th>Notes</th></tr>
<tr><td>Chillers</td>
<td>
<b>Compression chillers</b>
</td>
<td>
Currently, only compression chillers are supported.
</td>
</tr>
<tr><td>Chiller arrangement</td>
<td>
<b>Parallel chillers</b><br/>
Series chillers
</td>
<td></td>
</tr>
<tr><td>Chiller CHW isolation valve</td>
<td>
No valve<br/>
Two-way modulating valve<br/>
Two-way two-position valve
</td>
<td>
If the primary CHW pumps are dedicated, the option with no isolation valve
is automatically selected.<br/>
If the primary CHW pumps are headered, the choice between 
two-way modulating valves and two-way two-position valve is possible.
A modulating valve is recommended on primary-only variable flow systems 
to allow for slow changes in flow during chiller staging. 
Sometimes electric valve timing may be sufficiently slow that two-position 
valves can provide stable performance. 
Two-position valves are acceptable on primary-secondary systems.
</td>
</tr>
<tr><td>CHW distribution</td>
<td>
<b>Variable primary-only</b><br/>
Constant primary-only<br/>
Constant primary-variable secondary<br/>
Variable primary-variable secondary with centralized secondary pumps<br/>
Variable primary-variable secondary with distributed secondary pumps
</td>
<td>
Constant primary-only systems are typically encountered when 
only one or two very large air handlers are served by the plant.<br/>
Variable primary-variable secondary with centralized secondary pumps 
refers to configurations with a single group of secondary pumps that 
is typically integrated into the plant.<br/>
Variable secondary with distributed secondary pumps refers to configurations 
with multiple secondary loops, each loop being served by a dedicated group
of secondary pumps.
</td>
</tr>
<tr><td>Primary CHW pump arrangement</td>
<td>
<b>Headered</b><br/>
Dedicated
</td>
<td>
Headered pumps are required (and automatically selected) for configurations with
<ul>
<li>series chillers, or</li>
<li>waterside economizer.</li>
</ul>
</td>
</tr>
<tr><td>Type of primary CHW pumps for constant flow configurations</td>
<td>
<b>Constant speed pumps</b><br/>
Variable speed pumps operated at a constant speed
</td>
<td>
Variable speed pumps operated at a constant speed most commonly applies 
to constant flow primary-only plants, for example, a plant serving 
only one or two very large air handlers.
</td>
</tr>
</table>
<h4>References</h4>
<ul>
<li id=\"ASHRAE2021\">
ASHRAE, 2021. Guideline 36-2021, High-Performance Sequences of Operation
for HVAC Systems. Atlanta, GA.
</li>
</ul>
</html>"));
end AirCooled;
