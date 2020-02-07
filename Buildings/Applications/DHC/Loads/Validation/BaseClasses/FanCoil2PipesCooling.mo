within Buildings.Applications.DHC.Loads.Validation.BaseClasses;
model FanCoil2PipesCooling
  extends Buildings.Applications.DHC.Loads.BaseClasses.PartialTerminalUnit(
    redeclare package Medium1 = Buildings.Media.Water,
    redeclare package Medium2 = Buildings.Media.Air,
    final have_fan=true,
    final have_watHea=false,
    final have_watCoo=true,
    final have_QReq_flow=true,
    final mHeaWat_flow_nominal=abs(QHea_flow_nominal/cpHeaWat_nominal/(
          T_aHeaWat_nominal - T_bHeaWat_nominal)),
    final mChiWat_flow_nominal=abs(QCoo_flow_nominal/cpChiWat_nominal/(
      T_aChiWat_nominal - T_bChiWat_nominal)));
  import hexConfiguration = Buildings.Fluid.Types.HeatExchangerConfiguration;
  parameter hexConfiguration hexConHea=
    hexConfiguration.CounterFlow
    "Heating heat exchanger configuration";
  parameter hexConfiguration hexConCoo=
    hexConfiguration.CounterFlow
    "Cooling heat exchanger configuration";
  Buildings.Controls.OBC.CDL.Continuous.LimPID con(
    Ti=120,
    yMax=1,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    reverseAction=true,
    yMin=0) "PI controller"
    annotation (Placement(transformation(extent={{-10,210},{10,230}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare final package Medium=Medium2,
    energyDynamics=energyDynamics,
    m_flow_nominal=mLoaCoo_flow_nominal,
    redeclare Fluid.Movers.Data.Generic per,
    nominalValuesDefineDefaultPressureCurve=true,
    dp_nominal=200,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU hex(
    redeclare final package Medium1 = Medium1,
    redeclare final package Medium2 = Medium2,
    final configuration=hexConHea,
    final m1_flow_nominal=mChiWat_flow_nominal,
    final m2_flow_nominal=mLoaCoo_flow_nominal,
    final dp1_nominal=0,
    dp2_nominal=100,
    final Q_flow_nominal=QCoo_flow_nominal,
    final T_a1_nominal=T_aChiWat_nominal,
    final T_a2_nominal=T_aLoaCoo_nominal,
    final allowFlowReversal1=allowFlowReversal,
    final allowFlowReversal2=allowFlowReversal)
    annotation (Placement(transformation(extent={{-80,4},{-60,-16}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain gaiMasFlo(k=mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{20,210},{40,230}})));
  Modelica.Blocks.Sources.RealExpression Q_flowCoo(y=hex.Q2_flow)
    annotation (Placement(transformation(extent={{120,190},{140,210}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain gaiFloNom2(k=mLoaCoo_flow_nominal)
    annotation (Placement(transformation(extent={{20,90},{40,110}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant sigFlo2(k=1)
    annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare final package Medium=Medium2,
    final m_flow_nominal=max(mLoaHea_flow_nominal, mLoaCoo_flow_nominal),
    final allowFlowReversal=allowFlowReversal)
    "Return air temperature (sensed, steady-state)"
    annotation (Placement(transformation(extent={{130,-10},{110,10}})));
  Fluid.Sources.Boundary_pT sinAir(
    redeclare package Medium = Medium2,
    use_T_in=false,
    nPorts=1)
    "Sink for supply air"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-152,0})));
  Fluid.Sources.Boundary_pT retAir(
    redeclare package Medium = Medium2,
    use_T_in=true,
    nPorts=1)
    "Source for return air"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={150,0})));
  Buildings.Applications.DHC.Loads.BaseClasses.FirstOrderODE TLoaODE(
    TOutHea_nominal=273.15 - 5,
    TIndHea_nominal=T_aLoaHea_nominal,
    QHea_flow_nominal=QHea_flow_nominal,
    Q_flow_nominal=QCoo_flow_nominal)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
equation
  if have_fluPor then
  end if;
  if not have_QReq_flow then
  end if;
  connect(gaiFloNom2.u, sigFlo2.y)
    annotation (Line(points={{18,100},{-58,100}}, color={0,0,127}));
  connect(gaiFloNom2.y, fan.m_flow_in)
    annotation (Line(points={{42,100},{80,100},{80,12}}, color={0,0,127}));

  connect(con.y, gaiMasFlo.u)
    annotation (Line(points={{12,220},{18,220}}, color={0,0,127}));

  connect(senTem.port_b, fan.port_a)
    annotation (Line(points={{110,0},{90,0}}, color={0,127,255}));
  connect(fan.P, scaPFan.u) annotation (Line(points={{69,9},{60,9},{60,140},{
          158,140}}, color={0,0,127}));
  connect(fan.port_b, hex.port_a2)
    annotation (Line(points={{70,0},{-60,0}}, color={0,127,255}));
  connect(hex.port_b2, sinAir.ports[1])
    annotation (Line(points={{-80,0},{-142,0}}, color={0,127,255}));
  connect(Q_flowCoo.y, con.u_m) annotation (Line(points={{141,200},{150,200},{150,
          180},{0,180},{0,208}}, color={0,0,127}));
  connect(Q_flowCoo.y, TLoaODE.QAct_flow) annotation (Line(points={{141,200},{150,
          200},{150,180},{-20,180},{-20,32},{-12,32}},          color={0,0,127}));
  connect(senTem.port_a, retAir.ports[1])
    annotation (Line(points={{130,0},{140,0}}, color={0,127,255}));
  connect(TLoaODE.TInd, retAir.T_in) annotation (Line(points={{12,40},{180,40},{
          180,4},{162,4}}, color={0,0,127}));
  connect(gaiMasFlo.y, scaMasFloReqChiWat.u) annotation (Line(points={{42,220},{
          100,220},{100,80},{158,80}}, color={0,0,127}));
  connect(scaQReqCoo_flow.y, con.u_s) annotation (Line(points={{-158,100},{-100,
          100},{-100,220},{-12,220}}, color={0,0,127}));
  connect(scaQReqCoo_flow.y, TLoaODE.QReq_flow) annotation (Line(points={{-158,100},
          {-100,100},{-100,40},{-12,40}}, color={0,0,127}));
  connect(Q_flowCoo.y, scaQActCoo_flow.u)
    annotation (Line(points={{141,200},{158,200}}, color={0,0,127}));
  connect(TSetCoo, TLoaODE.TSet) annotation (Line(points={{-220,180},{-120,180},
          {-120,48},{-12,48}}, color={0,0,127}));
  connect(port_aChiWat, hex.port_a1) annotation (Line(points={{-200,-180},{-100,
          -180},{-100,-12},{-80,-12}}, color={0,127,255}));
  connect(hex.port_b1, port_bChiWat) annotation (Line(points={{-60,-12},{-40,
          -12},{-40,-180},{200,-180}}, color={0,127,255}));
end FanCoil2PipesCooling;
