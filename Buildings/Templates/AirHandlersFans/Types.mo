within Buildings.Templates.AirHandlersFans;
package Types "Package with type definitions"
  extends Modelica.Icons.TypesPackage;
  type Configuration = enumeration(
      SupplyOnly
      "Supply only system",
      ExhaustOnly
      "Exhaust only system",
      DualDuct
      "Dual duct system with supply and return",
      SingleDuct
      "Single duct system with supply and return")
    "Enumeration to configure the AHU";
  type Controller = enumeration(
      G36VAVMultiZone
      "Guideline 36 controller for multiple-zone VAV",
      OpenLoop
      "Open loop controller")
    "Enumeration to configure the AHU controller";
  type ControlEconomizer = enumeration(
      FixedDryBulb
      "Fixed dry bulb",
      DifferentialDryBulb
      "Differential dry bulb",
      FixedDryBulbWithDifferentialDryBulb
      "Fixed dry bulb with differential dry bulb",
      FixedEnthalpyWithFixedDryBulb
      "Fixed enthalpy with fixed dry bulb",
      DifferentialEnthalpyWithFixedDryBulb
      "Differential enthalpy with fixed dry bulb")
    "Enumeration to configure the economizer control";
  /*
  RFE #1913: Add option for calculated airflow.
      AirflowCalculated
      "Calculated based on return fan speed and VAV box flow rates",
  */
  type ControlFanReturn = enumeration(
      AirflowTracking
      "Airflow tracking",
      BuildingPressure
      "Building pressure (via discharge static pressure)")
    "Enumeration to configure the return fan control";
  // RFE: Add support for heat recovery.
  type HeatRecovery = enumeration(
      None
      "No heat recovery",
      FlatPlate
      "Flat plate heat exchanger",
      EnthalpyWheel
      "Enthalpy wheel",
      RunAroundCoil
      "Run-around coil")
    "Enumeration to configure the heat recovery";
  type OutdoorSection = enumeration(
      DedicatedDampersAirflow
      "Separate dedicated OA dampers with AFMS",
      DedicatedDampersPressure
      "Separate dedicated OA dampers with differential pressure sensor",
      NoEconomizer
      "No economizer",
      SingleDamper
      "Single common OA damper with AFMS")
    "Enumeration to configure the outdoor air section";
  type OutdoorReliefReturnSection = enumeration(
      Economizer
      "Air economizer",
      EconomizerNoRelief
      "Air economizer without relief branch",
      NoEconomizer
      "No air economizer")
    "Enumeration to configure the outdoor/relief/return air section";
  /* RFE: Add support for the following configurations.
      Barometric
        "Barometric relief damper without fan",
  */
  type ReliefReturnSection = enumeration(
      NoEconomizer
      "No economizer",
      NoRelief
      "No relief branch",
      ReliefDamper
      "Modulating relief damper without fan",
      ReliefFan
      "Relief fan with two-position relief damper",
      ReturnFan
      "Return fan with modulating relief damper")
    "Enumeration to configure the relief/return air section";
  annotation (Documentation(info="<html>
<p>
This package contains type definitions.
</p>
</html>"));
end Types;
