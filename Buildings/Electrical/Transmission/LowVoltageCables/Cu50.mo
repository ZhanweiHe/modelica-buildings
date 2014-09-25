within Buildings.Electrical.Transmission.LowVoltageCables;
record Cu50 "Cu cable 50 mm^2"
  extends Buildings.Electrical.Transmission.LowVoltageCables.Generic(
    material=Types.Material.Cu,
    M = 234.5 + 273.15,
    Amp=170,
    RCha=0.362e-003,
    XCha=0.073e-003);
  annotation (Documentation(info="<html>
<p>
Copper cable with a cross-sectional area of 50mm^2.
This type of cable has the following properties
</p>
<pre>
RCha = 0.362e-003 // Characteristic resistance [Ohm/m] 
XCha = 0.073e-003 // Characteristic reactance [Ohm/m] 
</pre>
</html>", revisions="<html>
<ul>
<li>
September 24, 2014, by Marco Bonvini:<br/>
Revised structure of the record, now the temperature constant <code>M</code>
is directly specified in the record.
</li>
<li>
Sept 19, 2014, by Marco Bonvini:<br/>
Added User's guide.
</li>
</ul>
</html>"));
end Cu50;
