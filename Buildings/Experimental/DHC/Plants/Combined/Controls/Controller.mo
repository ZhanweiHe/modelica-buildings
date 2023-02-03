within Buildings.Experimental.DHC.Plants.Combined.Controls;
block Controller "Open-loop controller for validation purposes"
  extends BaseClasses.PartialController;

  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator repHeaPum(nout=
        nHeaPum) "Replicate signal"
    annotation (Placement(transformation(extent={{220,-230},{240,-210}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal cvtValBypTan
    "Convert DO to AO"
    annotation (Placement(transformation(extent={{-40,-290},{-20,-270}})));
  Buildings.Controls.OBC.CDL.Continuous.Switch TChiHeaSupSet[nChiHea]
    "Switch supply temperature setpoint"
    annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
  BaseClasses.StagingPump staPumChiWat(
    final nPum=nPumChiWat,
    final m_flow_nominal=mChiWat_flow_nominal)
    "CHW pump staging"
    annotation (Placement(transformation(extent={{120,230},{140,250}})));
  EnergyTransferStations.Combined.Controls.PIDWithEnable pumChiWat(
    k=0.1,
    Ti=60,
    r=dpChiWatSet_max,
    y_reset=1,
    y_neutral=0)
    "Pump speed controller"
    annotation (Placement(transformation(extent={{190,230},{210,250}})));
  EnergyTransferStations.Combined.Controls.PIDWithEnable pumHeaWat(
    k=0.1,
    Ti=60,
    r=dpHeaWatSet_max,
    y_reset=1,
    y_neutral=0)
    "Pump speed controller"
    annotation (Placement(transformation(extent={{190,-50},{210,-30}})));
  BaseClasses.StagingPump staPumHeaWat(
    final nPum=nPumHeaWat,
    final m_flow_nominal=mHeaWat_flow_nominal)
    "HW pump staging"
    annotation (Placement(transformation(extent={{120,-50},{140,-30}})));
  BaseClasses.StagingPump staPumConWatCon(
    final nPum=nPumConWatCon,
    final m_flow_nominal=mConWatCon_flow_nominal)
    "CW pump staging"
    annotation (Placement(transformation(extent={{120,-130},{140,-110}})));
  EnergyTransferStations.Combined.Controls.PIDWithEnable pumConWatCon(
    k=0.1,
    Ti=60,
    final r=dpConWatConSet_max,
    y_reset=1,
    y_neutral=0)
    "Pump speed controller"
    annotation (Placement(transformation(extent={{190,-130},{210,-110}})));
  EnergyTransferStations.Combined.Controls.PIDWithEnable pumConWatEva(
    k=0.1,
    Ti=60,
    final r=dpConWatEvaSet_max,
    y_reset=1,
    y_neutral=0)
    "Pump speed controller"
    annotation (Placement(transformation(extent={{190,-190},{210,-170}})));
  BaseClasses.StagingPump staPumConWatEva(
    final nPum=nPumConWatEva,
    final m_flow_nominal=mConWatEva_flow_nominal)
    "CW pump staging"
    annotation (Placement(transformation(extent={{120,-190},{140,-170}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant dpConNom(final k=
        dpConWatConSet_max) "Constant"
    annotation (Placement(transformation(extent={{160,-130},{180,-110}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant dpEvaNom(final k=
        dpConWatEvaSet_max) "Constant"
    annotation (Placement(transformation(extent={{160,-190},{180,-170}})));
  BaseClasses.StagingPlant staPla(
    final nChi=nChi,
    final QChiWatChi_flow_nominal=QChiWatChi_flow_nominal,
    final nChiHea=nChiHea,
    final QChiWatCasCoo_flow_nominal=QChiWatCasCoo_flow_nominal,
    final QHeaWat_flow_nominal=QHeaWat_flow_nominal,
    final cp_default=cp_default) "Plant staging"
    annotation (Placement(transformation(extent={{-210,140},{-190,172}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator repTSet(nout=nChiHea)
    "Replicate signal"
    annotation (Placement(transformation(extent={{-140,110},{-120,130}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator repTSet1(nout=nChiHea)
    "Replicate signal"
    annotation (Placement(transformation(extent={{-140,70},{-120,90}})));
  BaseClasses.ModeCondenserLoop modConLoo(
    final TTanSet=TTanSet,
    final fraUslTan=fraUslTan,
    final ratFraChaTanLim=ratFraChaTanLim,
    nTTan=nTTan) "Condenser loop operating mode"
    annotation (Placement(transformation(extent={{-170,-170},{-150,-150}})));
  BaseClasses.TankCycle cycTan(final TTanSet=TTanSet, nTTan=nTTan)
    "Determine tank cycle"
    annotation (Placement(transformation(extent={{-170,-110},{-150,-90}})));
  Buildings.Controls.OBC.CDL.Integers.Equal isModChaAss
    "Return true if charge assist mode is active"
    annotation (Placement(transformation(extent={{-120,-190},{-100,-170}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant chaAss(
    final k=Buildings.Experimental.DHC.Plants.Combined.Controls.ModeCondenserLoop.chargeAssist)
    "Charge assist mode index"
    annotation (Placement(transformation(extent={{-170,-198},{-150,-178}})));
  Buildings.Controls.OBC.CDL.Logical.And assAndPum
    "Charge assist mode and any CW pump On"
    annotation (Placement(transformation(extent={{186,-210},{206,-230}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant THeaPumSetVal[2](
    final k={max(TTanSet[i]) + 3 for i in 1:2})
    "HP supply temperature sepoint for each tank cycle"
    annotation (Placement(transformation(extent={{-170,-230},{-150,-210}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor extIndRea(final nin=2)
    "Extract active setpoint"
    annotation (Placement(transformation(extent={{-120,-230},{-100,-210}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant heaRej(
    final k=Buildings.Experimental.DHC.Plants.Combined.Controls.ModeCondenserLoop.heatRejection)
    "Heat rejection mode index"
    annotation (Placement(transformation(extent={{-170,-290},{-150,-270}})));
  Buildings.Controls.OBC.CDL.Integers.Equal isModHeaRej
    "Return true if heat rejection mode is active"
    annotation (Placement(transformation(extent={{-120,-290},{-100,-270}})));
  Buildings.Controls.OBC.CDL.Logical.Not isModNotHeaRej
    "Return true if heat rejection mode is NOT active"
    annotation (Placement(transformation(extent={{-80,-290},{-60,-270}})));
  BaseClasses.ValveCondenserEvaporator valConEva(
    final nChi=nChi,
    final nChiHea=nChiHea,
    final mChiWatChi_flow_nominal=mChiWatChi_flow_nominal,
    final mChiWatChi_flow_min=mChiWatChi_flow_min,
    final mConWatChi_flow_nominal=mConWatChi_flow_nominal,
    final mChiWatChiHea_flow_nominal=mChiWatChiHea_flow_nominal,
    final mChiWatChiHea_flow_min=mChiWatChiHea_flow_min,
    final mConWatChiHea_flow_nominal=mConWatChiHea_flow_nominal,
    final mHeaWatChiHea_flow_min=mHeaWatChiHea_flow_min,
    final TTanSet=TTanSet)
    "Controller for chiller and HRC condenser and evaporator valves"
    annotation (Placement(transformation(extent={{-80,20},{-60,60}})));
  Buildings.Experimental.DHC.Plants.Combined.Controls.BaseClasses.DirectHeatRecovery dirHeaCoo(
    final nChi=nChi,
    final nChiHea=nChiHea,
    final mChiWatChi_flow_nominal=mChiWatChi_flow_nominal,
    final mChiWatChi_flow_min=mChiWatChi_flow_min,
    final mChiWatChiHea_flow_nominal=mChiWatChiHea_flow_nominal,
    final mChiWatChiHea_flow_min=mChiWatChiHea_flow_min)
    "Control logic for HRC in direct HR mode"
    annotation (Placement(transformation(extent={{-120,-12},{-100,8}})));
  BaseClasses.CoolingTowerLoop coo(
    final nCoo=nCoo,
    final nPumConWatCoo=nPumConWatCoo,
    final QChiWat_flow_nominal=QChiWat_flow_nominal,
    final dTLifChi_min=dTLifChi_min,
    final dTLifChi_nominal=dTLifChi_nominal,
    final TTanSet=TTanSet,
    final dTHexCoo_nominal=dTHexCoo_nominal) "Cooling tower loop"
    annotation (Placement(transformation(extent={{40,-356},{60,-320}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter scaFloChiWat(final k=1
        /mChiWat_flow_nominal) "Scale minimum flow setpoint" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={240,200})));
  Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter scaFloHeaWat(final k=1
        /mHeaWat_flow_nominal) "Scale minimum flow setpoint" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={240,-80})));
equation
  connect(repHeaPum.y, y1HeaPum)
    annotation (Line(points={{242,-220},{280,-220}},color={255,0,255}));
  connect(cvtValBypTan.y, yValBypTan) annotation (Line(points={{-18,-280},{280,-280}},
                                        color={0,0,127}));
  connect(staPumChiWat.y1, y1PumChiWat) annotation (Line(points={{142,246},{180,
          246},{180,260},{280,260}},
                                color={255,0,255}));
  connect(pumChiWat.y, yPumChiWat)
    annotation (Line(points={{212,240},{280,240}}, color={0,0,127}));
  connect(dpChiWatSet, pumChiWat.u_s) annotation (Line(points={{-280,320},{-10,
          320},{-10,260},{176,260},{176,240},{188,240}},
                                     color={0,0,127}));
  connect(staPumHeaWat.y1, y1PumHeaWat)
    annotation (Line(points={{142,-34},{180,-34},{180,-20},{280,-20}},
                                                color={255,0,255}));
  connect(pumHeaWat.y, yPumHeaWat)
    annotation (Line(points={{212,-40},{280,-40}}, color={0,0,127}));
  connect(dpHeaWatSet, pumHeaWat.u_s) annotation (Line(points={{-280,300},{4,
          300},{4,-20},{160,-20},{160,-40},{188,-40}},
                                      color={0,0,127}));
  connect(pumConWatEva.y, yPumConWatEva)
    annotation (Line(points={{212,-180},{280,-180}}, color={0,0,127}));
  connect(pumConWatCon.y, yPumConWatCon) annotation (Line(points={{212,-120},{220,
          -120},{220,-140},{280,-140}},     color={0,0,127}));
  connect(staPumConWatCon.y1, y1PumConWatCon) annotation (Line(points={{142,-114},
          {150,-114},{150,-100},{240,-100},{240,-120},{280,-120}},
                                          color={255,0,255}));
  connect(staPumConWatEva.y1, y1PumConWatEva)
    annotation (Line(points={{142,-174},{150,-174},{150,-160},{280,-160}},
                                                    color={255,0,255}));
  connect(dpHeaWat, pumHeaWat.u_m) annotation (Line(points={{-280,-360},{-234,-360},
          {-234,-64},{200,-64},{200,-52}}, color={0,0,127}));
  connect(mHeaWatPri_flow, staPumHeaWat.m_flow) annotation (Line(points={{-280,
          -200},{-242,-200},{-242,-40},{118,-40}},
                                        color={0,0,127}));
  connect(dpChiWat, pumChiWat.u_m) annotation (Line(points={{-280,-340},{-226,
          -340},{-226,208},{200,208},{200,228}},
                                           color={0,0,127}));
  connect(mConWatEva_flow, staPumConWatEva.m_flow) annotation (Line(points={{-280,
          -260},{-252,-260},{-252,-140},{60,-140},{60,-180},{118,-180}},
                                                  color={0,0,127}));
  connect(mConWatCon_flow, staPumConWatCon.m_flow) annotation (Line(points={{-280,
          -240},{-244,-240},{-244,-120},{118,-120}},
                                               color={0,0,127}));
  connect(mChiWatPri_flow, staPumChiWat.m_flow) annotation (Line(points={{-280,-180},
          {-238,-180},{-238,240},{118,240}},    color={0,0,127}));
  connect(dpConNom.y, pumConWatCon.u_s) annotation (Line(points={{182,-120},{188,
          -120}},                      color={0,0,127}));
  connect(dpEvaNom.y, pumConWatEva.u_s)
    annotation (Line(points={{182,-180},{188,-180}}, color={0,0,127}));
  connect(mHeaWatPri_flow, staPla.mHeaWatPri_flow) annotation (Line(points={{-280,
          -200},{-236,-200},{-236,152},{-212,152}},    color={0,0,127}));
  connect(THeaWatSupSet, staPla.THeaWatSupSet) annotation (Line(points={{-280,
          340},{-250,340},{-250,150},{-212,150}}, color={0,0,127}));
  connect(mChiWatPri_flow, staPla.mChiWatPri_flow) annotation (Line(points={{-280,
          -180},{-238,-180},{-238,166},{-212,166}},color={0,0,127}));
  connect(u1Coo, staPla.u1Coo) annotation (Line(points={{-280,440},{-236,440},{
          -236,170.2},{-212,170.2}},                   color={255,0,255}));
  connect(u1Hea, staPla.u1Hea) annotation (Line(points={{-280,400},{-240,400},{
          -240,168.2},{-212,168.2}},                   color={255,0,255}));
  connect(TChiWatSupSet, staPla.TChiWatSupSet) annotation (Line(points={{-280,
          360},{-242,360},{-242,164},{-212,164}}, color={0,0,127}));
  connect(TChiWatPriRet, staPla.TChiWatPriRet) annotation (Line(points={{-280,
          240},{-242,240},{-242,160},{-212,160}},
                                                color={0,0,127}));
  connect(THeaWatPriRet, staPla.THeaWatPriRet) annotation (Line(points={{-280,80},
          {-242,80},{-242,146},{-212,146}},     color={0,0,127}));
  connect(repTSet1.y, TChiHeaSupSet.u3) annotation (Line(points={{-118,80},{
          -106,80},{-106,92},{-102,92}}, color={0,0,127}));
  connect(repTSet.y, TChiHeaSupSet.u1) annotation (Line(points={{-118,120},{
          -106,120},{-106,108},{-102,108}}, color={0,0,127}));
  connect(staPla.y1CooChiHea, TChiHeaSupSet.u2) annotation (Line(points={{-188,148},
          {-110,148},{-110,100},{-102,100}},      color={255,0,255}));
  connect(TChiHeaSupSet.y, TChiHeaSet)
    annotation (Line(points={{-78,100},{280,100}}, color={0,0,127}));
  connect(TChiWatSupSet, repTSet.u) annotation (Line(points={{-280,360},{-254,
          360},{-254,120},{-142,120}}, color={0,0,127}));
  connect(THeaWatSupSet, repTSet1.u) annotation (Line(points={{-280,340},{-250,
          340},{-250,80},{-142,80}}, color={0,0,127}));
  connect(mConWatHexCoo_flow, modConLoo.mConWatHexCoo_flow) annotation (Line(
        points={{-280,-280},{-248,-280},{-248,-154},{-172,-154}},
                                                                color={0,0,127}));
  connect(mConWatOutTan_flow, modConLoo.mConWatOutTan_flow) annotation (Line(
        points={{-280,-300},{-234,-300},{-234,-160},{-172,-160}},
                                                                color={0,0,127}));
  connect(TTan, modConLoo.TTan) annotation (Line(points={{-280,60},{-180,60},{-180,
          -166},{-172,-166}},    color={0,0,127}));
  connect(TTan, cycTan.TTan) annotation (Line(points={{-280,60},{-180,60},{-180,
          -106},{-172,-106}},
                          color={0,0,127}));
  connect(mConWatOutTan_flow, cycTan.mConWatOutTan_flow) annotation (Line(
        points={{-280,-300},{-226,-300},{-226,-94},{-172,-94}},
                                                            color={0,0,127}));
  connect(chaAss.y, isModChaAss.u2) annotation (Line(points={{-148,-188},{-122,
          -188}},                         color={255,127,0}));
  connect(modConLoo.mode, isModChaAss.u1) annotation (Line(points={{-148,-160},
          {-144,-160},{-144,-180},{-122,-180}},
                                              color={255,127,0}));
  connect(assAndPum.y, repHeaPum.u)
    annotation (Line(points={{208,-220},{218,-220}}, color={255,0,255}));
  connect(isModChaAss.y, assAndPum.u1)
    annotation (Line(points={{-98,-180},{-80,-180},{-80,-220},{184,-220}},
                                                     color={255,0,255}));
  connect(THeaPumSetVal.y, extIndRea.u)
    annotation (Line(points={{-148,-220},{-122,-220}}, color={0,0,127}));
  connect(extIndRea.y, THeaPumSet) annotation (Line(points={{-98,-220},{-80,
          -220},{-80,-240},{280,-240}},            color={0,0,127}));
  connect(cycTan.idxCycTan, extIndRea.index) annotation (Line(points={{-148,
          -100},{-140,-100},{-140,-240},{-110,-240},{-110,-232}},
                                                         color={255,127,0}));
  connect(heaRej.y, isModHeaRej.u1)
    annotation (Line(points={{-148,-280},{-122,-280}}, color={255,127,0}));
  connect(modConLoo.mode, isModHeaRej.u2) annotation (Line(points={{-148,-160},{
          -144,-160},{-144,-288},{-122,-288}},color={255,127,0}));
  connect(isModNotHeaRej.y, cvtValBypTan.u)
    annotation (Line(points={{-58,-280},{-42,-280}}, color={255,0,255}));
  connect(isModHeaRej.y, isModNotHeaRej.u)
    annotation (Line(points={{-98,-280},{-82,-280}}, color={255,0,255}));
  connect(mEvaChi_flow,valConEva. mEvaChi_flow) annotation (Line(points={{-280,
          -100},{-212,-100},{-212,42},{-82,42}}, color={0,0,127}));
  connect(mConChi_flow,valConEva. mConChi_flow) annotation (Line(points={{-280,
          -120},{-256,-120},{-256,40},{-82,40}},     color={0,0,127}));
  connect(mEvaChiHea_flow,valConEva. mEvaChiHea_flow) annotation (Line(points={{-280,
          -140},{-254,-140},{-254,38},{-82,38}},           color={0,0,127}));
  connect(mConChiHea_flow,valConEva. mConChiHea_flow) annotation (Line(points={{-280,
          -160},{-252,-160},{-252,36},{-82,36}},           color={0,0,127}));
  connect(staPla.y1Chi,valConEva. u1Chi) annotation (Line(points={{-188,164},{
          -164,164},{-164,58},{-82,58}},
                                    color={255,0,255}));
  connect(staPla.y1ChiHea,valConEva. u1ChiHea) annotation (Line(points={{-188,
          154},{-166,154},{-166,56},{-82,56}}, color={255,0,255}));
  connect(staPla.y1CooChiHea,valConEva. u1CooChiHea) annotation (Line(points={{-188,
          148},{-168,148},{-168,54},{-82,54}},      color={255,0,255}));
  connect(staPla.y1HeaCooChiHea,valConEva. u1HeaCooChiHea) annotation (Line(
        points={{-188,142},{-170,142},{-170,52},{-82,52}}, color={255,0,255}));
  connect(valConEva.yValEvaChi, yValEvaChi) annotation (Line(points={{-58,42},{
          0,42},{0,320},{280,320}}, color={0,0,127}));
  connect(valConEva.yValConChi, yValConChi) annotation (Line(points={{-58,40},{
          2,40},{2,300},{280,300}}, color={0,0,127}));
  connect(valConEva.yValConSwiChiHea, yValConSwiChiHea)
    annotation (Line(points={{-58,32},{260,32},{260,20},{280,20}},
                                                 color={0,0,127}));
  connect(valConEva.yValEvaSwiChiHea, yValEvaSwiHea) annotation (Line(points={{-58,34},
          {240,34},{240,40},{280,40}},         color={0,0,127}));
  connect(valConEva.yValConChiHea, yValConChiHea) annotation (Line(points={{-58,36},
          {238,36},{238,60},{280,60}},     color={0,0,127}));
  connect(valConEva.yValEvaChiHea, yValEvaChiHea) annotation (Line(points={{-58,38},
          {236,38},{236,80},{280,80}},     color={0,0,127}));
  connect(dpConWatEva, pumConWatEva.u_m) annotation (Line(points={{-280,-400},{-240,
          -400},{-240,-204},{200,-204},{200,-192}},      color={0,0,127}));
  connect(dpConWatCon, pumConWatCon.u_m) annotation (Line(points={{-280,-380},{-242,
          -380},{-242,-144},{200,-144},{200,-132}},      color={0,0,127}));
  connect(cycTan.idxCycTan,valConEva. idxCycTan) annotation (Line(points={{-148,
          -100},{-140,-100},{-140,48},{-82,48}},     color={255,127,0}));
  connect(modConLoo.mode,valConEva. mode) annotation (Line(points={{-148,-160},
          {-144,-160},{-144,50},{-82,50}},     color={255,127,0}));
  connect(TChiWatSup, staPla.TChiWatSup) annotation (Line(points={{-280,260},{
          -246,260},{-246,162},{-212,162}},         color={0,0,127}));
  connect(dpChiWatSet, staPla.dpChiWatSet) annotation (Line(points={{-280,320},
          {-246,320},{-246,158},{-212,158}},         color={0,0,127}));
  connect(dpChiWat, staPla.dpChiWat) annotation (Line(points={{-280,-340},{-238,
          -340},{-238,156},{-212,156}},         color={0,0,127}));
  connect(valConEva.y1PumChiWat, staPumChiWat.y1Ena) annotation (Line(points={{-58,58},
          {-4,58},{-4,246},{118,246}},        color={255,0,255}));
  connect(pumChiWat.y, staPumChiWat.y) annotation (Line(points={{212,240},{220,240},
          {220,220},{110,220},{110,234},{118,234}},   color={0,0,127}));
  connect(pumHeaWat.y, staPumHeaWat.y) annotation (Line(points={{212,-40},{220,
          -40},{220,-60},{110,-60},{110,-46},{118,-46}},
                                                  color={0,0,127}));
  connect(valConEva.y1PumHeaWat, staPumHeaWat.y1Ena) annotation (Line(points={{-58,56},
          {74,56},{74,-34},{118,-34}},    color={255,0,255}));
  connect(pumConWatCon.y, staPumConWatCon.y) annotation (Line(points={{212,-120},
          {220,-120},{220,-140},{114,-140},{114,-126},{118,-126}},
                                                            color={0,0,127}));
  connect(pumConWatEva.y, staPumConWatEva.y) annotation (Line(points={{212,-180},
          {220,-180},{220,-200},{114,-200},{114,-186},{118,-186}},
                                                                color={0,0,127}));
  connect(valConEva.y1PumConWatEva, staPumConWatEva.y1Ena) annotation (Line(
        points={{-58,52},{-4,52},{-4,-174},{118,-174}},color={255,0,255}));
  connect(valConEva.y1PumConWatCon, staPumConWatCon.y1Ena) annotation (Line(
        points={{-58,54},{-2,54},{-2,-114},{118,-114}},
                                                     color={255,0,255}));
  connect(staPla.y1Chi, y1Chi) annotation (Line(points={{-188,164},{-6,164},{-6,
          340},{280,340}}, color={255,0,255}));
  connect(staPla.y1ChiHea, y1ChiHea) annotation (Line(points={{-188,154},{6,154},
          {6,160},{280,160}}, color={255,0,255}));
  connect(staPla.y1CooChiHea, y1CooChiHea) annotation (Line(points={{-188,148},{
          6,148},{6,140},{280,140}},   color={255,0,255}));
  connect(staPla.y1HeaCooChiHea, y1HeaCooChiHea) annotation (Line(points={{-188,
          142},{4,142},{4,120},{280,120}},   color={255,0,255}));
  connect(staPla.y1ChiHea, dirHeaCoo.y1) annotation (Line(points={{-188,154},{
          -166,154},{-166,6},{-122,6}},         color={255,0,255}));
  connect(staPla.y1HeaCooChiHea, dirHeaCoo.y1HeaCoo) annotation (Line(points={{-188,
          142},{-170,142},{-170,2},{-122,2}},                       color={255,
          0,255}));
  connect(TChiWatSupSet, dirHeaCoo.TChiWatSupSet) annotation (Line(points={{-280,
          360},{-254,360},{-254,-2},{-122,-2}},        color={0,0,127}));
  connect(TEvaLvgChiHea, dirHeaCoo.TEvaLvg) annotation (Line(points={{-280,140},
          {-232,140},{-232,-6},{-122,-6}},      color={0,0,127}));
  connect(THeaWatPriRet, dirHeaCoo.THeaWatPriRet) annotation (Line(points={{-280,80},
          {-242,80},{-242,-10},{-122,-10}},              color={0,0,127}));
  connect(dirHeaCoo.mEvaChiSet_flow,valConEva. mEvaChiSet_flow) annotation (
      Line(points={{-98,4},{-92,4},{-92,46},{-82,46}},         color={0,0,127}));
  connect(dirHeaCoo.mEvaChiHeaSet_flow,valConEva. mEvaChiHeaSet_flow)
    annotation (Line(points={{-98,-2},{-88,-2},{-88,44},{-82,44}},   color={0,0,
          127}));
  connect(dpHeaWatSet, staPla.dpHeaWatSet) annotation (Line(points={{-280,300},
          {-240,300},{-240,144},{-212,144}},color={0,0,127}));
  connect(dpHeaWat, staPla.dpHeaWat) annotation (Line(points={{-280,-360},{-234,
          -360},{-234,142},{-212,142}}, color={0,0,127}));
  connect(THeaWatSup, staPla.THeaWatSup) annotation (Line(points={{-280,100},{-230,
          100},{-230,148},{-212,148}},color={0,0,127}));
  connect(coo.y1PumConWatCoo, y1PumConWatCoo) annotation (Line(points={{62,-326},
          {240,-326},{240,-320},{280,-320}}, color={255,0,255}));
  connect(coo.yPumConWatCoo, yPumConWatCoo) annotation (Line(points={{62,-332},
          {166,-332},{166,-340},{280,-340}},color={0,0,127}));
  connect(coo.y1Coo, y1Coo) annotation (Line(points={{62,-344},{244,-344},{244,
          -360},{280,-360}},
                       color={255,0,255}));
  connect(coo.yCoo, yCoo) annotation (Line(points={{62,-350},{240,-350},{240,
          -380},{280,-380}},
                       color={0,0,127}));
  connect(cycTan.idxCycTan, coo.idxCycTan) annotation (Line(points={{-148,-100},
          {0,-100},{0,-324},{38,-324}}, color={255,127,0}));
  connect(modConLoo.mode, coo.mode) annotation (Line(points={{-148,-160},{2,-160},
          {2,-322},{38,-322}}, color={255,127,0}));
  connect(TChiWatSupSet, coo.TChiWatSupSet) annotation (Line(points={{-280,360},
          {-2,360},{-2,-328},{38,-328}}, color={0,0,127}));
  connect(TConWatConChiEnt, coo.TConWatConChiEnt) annotation (Line(points={{-280,
          40},{-252,40},{-252,-330},{38,-330}}, color={0,0,127}));
  connect(TConWatConChiLvg, coo.TConWatConChiLvg) annotation (Line(points={{-280,
          20},{-248,20},{-248,-332},{38,-332}}, color={0,0,127}));
  connect(TConWatCooSup, coo.TConWatCooSup) annotation (Line(points={{-280,0},{-250,
          0},{-250,-335.8},{38,-335.8}}, color={0,0,127}));
  connect(TConWatCooRet, coo.TConWatCooRet) annotation (Line(points={{-280,-20},
          {-244,-20},{-244,-337.8},{38,-337.8}},                       color={0,
          0,127}));
  connect(TConWatHexCooEnt, coo.TConWatHexCooEnt) annotation (Line(points={{-280,
          -40},{-248,-40},{-248,-339.8},{38,-339.8}}, color={0,0,127}));
  connect(TConWatHexCooLvg, coo.TConWatHexCooLvg) annotation (Line(points={{-280,
          -60},{-236,-60},{-236,-341.8},{38,-341.8}}, color={0,0,127}));
  connect(staPla.QCooReq_flow, coo.QCooReq_flow) annotation (Line(points={{-188,
          170},{-8,170},{-8,-346},{38,-346}}, color={0,0,127}));
  connect(mConWatHexCoo_flow, coo.mConWatHexCoo_flow) annotation (Line(points={{
          -280,-280},{-232,-280},{-232,-350},{38,-350}}, color={0,0,127}));
  connect(cvtValBypTan.y, coo.yValBypTan) annotation (Line(points={{-18,-280},{-6,
          -280},{-6,-354},{38,-354}}, color={0,0,127}));
  connect(dirHeaCoo.TConEntChiHeaSet,valConEva. TConEntChiHeaSet) annotation (
      Line(points={{-98,-8},{-84,-8},{-84,34},{-82,34}},             color={0,0,
          127}));
  connect(TConEntChiHea,valConEva. TConEntChiHea) annotation (Line(points={{-280,
          180},{-220,180},{-220,32},{-82,32}},              color={0,0,127}));
  connect(staPumConWatCon.y1Any, pumConWatCon.uEna) annotation (Line(points={{142,
          -120},{154,-120},{154,-136},{196,-136},{196,-132}}, color={255,0,255}));
  connect(staPumConWatEva.y1Any, pumConWatEva.uEna) annotation (Line(points={{142,
          -180},{150,-180},{150,-198},{196,-198},{196,-192}}, color={255,0,255}));
  connect(staPumConWatCon.y1Any, assAndPum.u2) annotation (Line(points={{142,-120},
          {154,-120},{154,-212},{184,-212}}, color={255,0,255}));
  connect(staPumHeaWat.y1Any, pumHeaWat.uEna) annotation (Line(points={{142,-40},
          {152,-40},{152,-56},{196,-56},{196,-52}}, color={255,0,255}));
  connect(staPumChiWat.y1Any, pumChiWat.uEna) annotation (Line(points={{142,240},
          {170,240},{170,224},{196,224},{196,228}}, color={255,0,255}));
  connect(valConEva.yValConWatEvaMix, yValConWatEvaMix) annotation (Line(points={{-58,30},
          {240,30},{240,0},{280,0}},                  color={0,0,127}));
  connect(TEvaLvgChiHea, valConEva.TEvaLvgChiHea) annotation (Line(points={{-280,
          140},{-244,140},{-244,26},{-82,26}},              color={0,0,127}));
  connect(TConWatEvaEnt, valConEva.TConWatEvaEnt) annotation (Line(points={{-280,
          200},{-256,200},{-256,22},{-82,22}},      color={0,0,127}));
  connect(TConLvgChiHea, valConEva.TConLvgChiHea) annotation (Line(points={{
          -280,160},{-250,160},{-250,30},{-82,30}}, color={0,0,127}));
  connect(TConLvgChi, valConEva.TConLvgChi) annotation (Line(points={{-280,120},
          {-258,120},{-258,28},{-82,28}}, color={0,0,127}));
  connect(TConWatConRet, valConEva.TConWatConRet) annotation (Line(points={{
          -280,220},{-242,220},{-242,24},{-82,24}}, color={0,0,127}));
  connect(scaFloChiWat.y, yValChiWatMinByp)
    annotation (Line(points={{252,200},{280,200}}, color={0,0,127}));
  connect(scaFloHeaWat.y, yValHeaWatMinByp)
    annotation (Line(points={{252,-80},{280,-80}}, color={0,0,127}));
  connect(valConEva.mHeaWatMinSet_flow, scaFloHeaWat.u) annotation (Line(points
        ={{-58,46},{-10,46},{-10,-80},{228,-80}}, color={0,0,127}));
  connect(valConEva.mChiWatMinSet_flow, scaFloChiWat.u) annotation (Line(points
        ={{-58,48},{-10,48},{-10,200},{228,200}}, color={0,0,127}));
annotation (
  defaultComponentName="ctl", Documentation(info="<html>
All pump speed control loops are biased to launch from 
100 % (maximum speed).

<h4>
CW pumps
</h4>
<p>
CW pumps serving the evaporator loop or the condenser loop
are controlled to track the loop differential pressure
setpoint.
A constant setpoint is used.
Optimizations are possible, for instance by resetting the setpoint 
based on valve requests, or based on a linear relationship with
the loop flow setpoint.
</p>
</html>"));
end Controller;
