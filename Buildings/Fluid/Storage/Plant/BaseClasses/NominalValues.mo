within Buildings.Fluid.Storage.Plant.BaseClasses;
record NominalValues "Nominal values"
  extends Modelica.Icons.Record;

  parameter Boolean allowRemoteCharging = true
    "= true if the tank is allowed to be charged by a remote source"
    annotation(dialog(group="Plant configuration"));

  final parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=
     mTan_flow_nominal+mChi_flow_nominal
    "Nominal mass flow rate"
    annotation(enable=false);
  parameter Modelica.Units.SI.MassFlowRate mTan_flow_nominal(min=0)
    "Nominal mass flow rate for CHW tank branch"
    annotation(dialog(group="Nominal values"));
  parameter Modelica.Units.SI.MassFlowRate mChi_flow_nominal(min=0)
    "Nominal mass flow rate for CHW tank branch"
    annotation(dialog(group="Nominal values"));
  parameter Modelica.Units.SI.PressureDifference dp_nominal(final displayUnit="Pa")
    "Nominal pressure difference"
    annotation(dialog(group="Nominal values"));
  parameter Modelica.Units.SI.Temperature T_CHWS_nominal=7+273.15
    "Nominal temperature of CHW supply"
    annotation(dialog(group="Nominal values"));
  parameter Modelica.Units.SI.Temperature T_CHWR_nominal=12+273.15
    "Nominal temperature of CHW return"
    annotation(dialog(group="Nominal values"));

  annotation (
  defaultComponentPrefixes = "parameter",
  defaultComponentName = "nom");
end NominalValues;
