within Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.Constants;
package FreezeProtectionStages "Package with constants that indicate the freeze protection stages"
  extends Modelica.Icons.Package;

  constant Integer stage0 = 0 "Freeze protection is deactivated";
  constant Integer stage1 = 1 "First stage of freeze protection";
  constant Integer stage2 = 2 "Second stage of freeze protection";
  constant Integer stage3 = 3 "Third stage of freeze protection";

annotation (
Documentation(info="<html>
<p>
This package provides constants that indicate the
freeze protection stages.
</p>
</html>", revisions="<html>
<ul>
<li>
July 14, 2017, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end FreezeProtectionStages;
