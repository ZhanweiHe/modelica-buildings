within Buildings.Experimental.DHC.Examples.Combined.Generation5.Networks.BaseClasses;
model PipeStandard "Pipe model parameterized with hydraulic diameter"
  extends Buildings.Fluid.FixedResistances.HydraulicDiameter(
    dp(nominal=1E5),
    final linearized=false,
    final v_nominal=m_flow_nominal * 4 / (rho_default * dh^2 * Modelica.Constants.pi));

equation
  when terminal() then
    if length > Modelica.Constants.eps then
      Modelica.Utilities.Streams.print(
       "Pipe nominal pressure drop for '" + getInstanceName() + "': " +
        String(integer(floor(dp_nominal / length + 0.5))) +
        " Pa/m, pipe diameter: " + String(integer(floor(dh * 100))/100) + " m.");
    else
      Modelica.Utilities.Streams.print(
        "Pipe nominal pressure drop for '" + getInstanceName() +
         "' as the pipe length is set to zero.");
    end if;
  end when;
annotation (
  DefaultComponentName="pipDis",
  Icon(graphics={
        Rectangle(
          extent={{-100,22},{100,-24}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,140,72})}),
    Documentation(revisions="<html>
<ul>
<li>
February 23, 2021, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model is similar to
<a href=\"Buildings.Fluid.FixedResistances.HydraulicDiameter\">
Buildings.Fluid.FixedResistances.HydraulicDiameter</a>
except that a binding equation is provided to compute the nominal fluid velocity
from the hydraulic diameter (as opposed to the hydraulic diameter being
computed from the nominal fluid velocity in the original model).
</p>
</html>"));
end PipeStandard;