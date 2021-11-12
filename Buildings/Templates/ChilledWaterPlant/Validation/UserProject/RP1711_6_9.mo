within Buildings.Templates.ChilledWaterPlant.Validation.UserProject;
model RP1711_6_9
  extends Buildings.Templates.ChilledWaterPlant.AirCooledParallel(
    final nChi=2,
    final nCooTow=2,
    final nPumPri=2,
    final has_byp=false,
    final id="CHW_1");

  annotation (
    defaultComponentName="ahu");
end RP1711_6_9;
