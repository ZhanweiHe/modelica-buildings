within Buildings.Templates.AirHandlersFans.Validation.UserProject.Data;
class AllSystems "Top-level (whole building) system parameters"
  extends Buildings.Templates.Data.AllSystems;

  /*
  The construct below where a replaceable model is used inside the `outer`
  component declaration is for validation purposes only, where various configuration
  classes are tested with the same instance name `VAV_1`.
  It is needed here because
  - the `inner` instance must be a subtype of the `outer` component, and
  - the `outer` component references only the subcomponents from its own type
  (as opposed to all the subcomponents from the `inner` type), and
  - modification of an outer declaration is prohibited.
  The standard export workflow should use an explicit reference to the configuration
  class for each MZVAV model instance.
  */
  replaceable model VAV =
      Buildings.Templates.AirHandlersFans.Interfaces.PartialAirHandler
    "Model of MZVAV";

  outer VAV VAV_1
    "Instance of MZVAV model";

  parameter Buildings.Templates.AirHandlersFans.Data.VAVMultiZone _VAV_1(
    final typ=VAV_1.typ,
    final typFanSup=VAV_1.typFanSup,
    final typFanRet=VAV_1.typFanRet,
    final typFanRel=VAV_1.typFanRel,
    final have_souChiWat=VAV_1.have_souChiWat,
    final have_souHeaWat=VAV_1.have_souHeaWat,
    final typCoiHeaPre=VAV_1.coiHeaPre.typ,
    final typCoiCoo=VAV_1.coiCoo.typ,
    final typCoiHeaReh=VAV_1.coiHeaReh.typ,
    final typValCoiHeaPre=VAV_1.coiHeaPre.typVal,
    final typValCoiCoo=VAV_1.coiCoo.typVal,
    final typValCoiHeaReh=VAV_1.coiHeaReh.typVal,
    final typDamOut=VAV_1.secOutRel.typDamOut,
    final typDamOutMin=VAV_1.secOutRel.typDamOutMin,
    final typDamRet=VAV_1.secOutRel.typDamRet,
    final typDamRel=VAV_1.secOutRel.typDamRel,
    final typCtl=VAV_1.ctl.typ,
    final typSecRel=VAV_1.secOutRel.typSecRel,
    final typSecOut=VAV_1.ctl.typSecOut,
    final buiPreCon=VAV_1.ctl.buiPreCon,
    final stdVen=VAV_1.ctl.stdVen,
    id="VAV_1",
    damOut(dp_nominal=15),
    damOutMin(dp_nominal=15),
    damRel(dp_nominal=15),
    damRet(dp_nominal=15),
    mOutMin_flow_nominal=0.2,
    fanSup(m_flow_nominal=1, dp_nominal=500),
    fanRel(m_flow_nominal=1, dp_nominal=200),
    fanRet(m_flow_nominal=1, dp_nominal=200),
    coiHeaPre(
      cap_nominal=1e4,
      dpAir_nominal=100,
      dpWat_nominal=0.5e4,
      dpValve_nominal=0.3e4,
      mWat_flow_nominal=1e4/4186/10,
      TAirEnt_nominal=273.15,
      TWatEnt_nominal=50 + 273.15),
    coiHeaReh(
      cap_nominal=1e4,
      dpAir_nominal=100,
      dpWat_nominal=0.5e4,
      dpValve_nominal=0.3e4,
      mWat_flow_nominal=1e4/4186/10,
      TAirEnt_nominal=273.15,
      TWatEnt_nominal=50 + 273.15),
    coiCoo(
      cap_nominal=1e4,
      dpAir_nominal=100,
      dpWat_nominal=3e4,
      dpValve_nominal=2e4,
      mWat_flow_nominal=1e4/4186/5,
      TAirEnt_nominal=30 + 273.15,
      TWatEnt_nominal=7 + 273.15,
      wAirEnt_nominal=0.012),
    ctl(
      VOutUnc_flow_nominal=0.4,
      VOutTot_flow_nominal=0.5,
      VOutAbsMin_flow_nominal=0.3,
      VOutMin_flow_nominal=0.4,
      dpDamOutMinAbs=10,
      dpDamOutMin_nominal=15,
      pAirSupSet_rel_max=500,
      pAirRetSet_rel_min=10,
      pAirRetSet_rel_max=40,
      yFanSup_min=0.1,
      yFanRel_min=0.1,
      yFanRet_min=0.1,
      dVFanRet_flow=0.1,
      TAirSupSet_min=12+273.15,
      TAirSupSet_max=18+273.15,
      TOutRes_min=16+273.15,
      TOutRes_max=21+273.15))
    "Paramerers for system VAV_1"
    annotation (Dialog(group="Air handlers and fans"));

annotation (
  defaultComponentPrefixes = "inner parameter",
  defaultComponentName = "datAll",
    Documentation(info="<html>
<p>
This class provides the set of sizing and operating parameters for
the whole HVAC system.
It is aimed for validation purposes only.
</p>
</html>"));
end AllSystems;
