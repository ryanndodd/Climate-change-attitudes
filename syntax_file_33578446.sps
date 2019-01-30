* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
WEIGHT BY pspwght.


USE ALL.
DO IF (impenv <=2 AND (wrclmch <=2)).
 COMPUTE envclimatt = 1.
 ELSE IF (impenv <=2 AND (wrclmch >2 AND (wrclmch <=6))).
  COMPUTE envclimatt = 2.
 ELSE IF (impenv <=2 AND (wrclmch =8)). 
  COMPUTE envclimatt = $SYSMIS.
 ELSE IF (impenv > 2).
   COMPUTE envclimatt = $SYSMIS.
END IF.

VARIABLE LABEL envclimatt 'Enviroment is important and climate change attitudes'.
VALUE LABELS envclimatt 1 'Environment important, but not worried'  2 'Environment important and worried ' 3 'Environment Important and don’t know'.

*###################################################################*

*Filter by country

USE ALL. 
COMPUTE filter_$=(cntry ="GB" AND (envclimatt=1 or (envclimatt =2))).
VARIABLE LABELS filter_$ "cntry = ''GB' (FILTER)".
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
 
 
*###################################################################*

*DEMOGRAPHIC*

RECODE agea (16 thru 24 = 1) (25 thru 44 = 2) (45 thru 64 = 3) (65 thru 120 = 4) into agegen.
VARIABLE LABELS agegen 'Generation'.
VALUE LABELS agegen 1 '16-24' 2 '25-44' 3 '45-64' 4 '65-120'.

RECODE agegen (1=1) (ELSE=0) INTO gen1.
VARIABLE LABELS  gen1 '16-24'.
VALUE LABELS gen1 1 'is 16-24' 2 'is not 16-24'.

RECODE agegen (2=1) (ELSE=0) INTO gen2.
VARIABLE LABELS  gen2 '25-44'.

RECODE agegen (3=1) (ELSE=0) INTO gen3.
VARIABLE LABELS  gen3 '44-64'.

RECODE agegen (4=1) (ELSE=0) INTO gen4.
VARIABLE LABELS  gen4 '65-120'.

*gender*

RECODE gndr(1=1)(2=0)(ELSE=SYSMIS) INTO gender.
VARIABLE LABELS gender 'is Male'.
VALUE LABELS gender 1 'Male' 0 'Female'.

*ethnicity*

RECODE blgetmg(1=1)(2=0)(ELSE=SYSMIS) INTO isMinority.
VARIABLE LABELS isMinority 'Belongs to a minority ethnic group'.
VALUE LABELS isMinority 1 'Minority' 0 'Not a '.

*marital status*

RECODE marsts(1 thru 2=1)(ELSE=0) INTO isMarried.
VARIABLE LABELS isMarried 'Is Married/Civil Partnership'.
VALUE LABELS isMarried 1 'Yes' 0 'No'.

RECODE marsts(3 thru 4=1)(ELSE=0) INTO isSeperated.
VARIABLE LABELS isSeperated 'Is Divorced/Legally Seperated'.
VALUE LABELS isSeperated 1 'Yes' 0 'No'.

RECODE marsts(5 thru 6=1)(ELSE=0) INTO neverMarried.
VARIABLE LABELS neverMarried 'Never Married/in Civil Partnership'.
VALUE LABELS neverMarried 1 'Yes' 0 'No'.


*income*

FREQUENCIES hinctnta.
RECODE hinctnta (1 thru 2=1) (ELSE=0) INTO incdec1.
VARIABLE LABELS incdec1 'income decile 1'.
VALUE LABELS incdec1 1 'Yes' 0 'No'.



RECODE hinctnta (3 thru 4=1) (ELSE=0) INTO incdec2.
VARIABLE LABELS incdec2 'income decile 2'.
VALUE LABELS incdec2 1 'Yes' 0 'No'.

RECODE hinctnta (5 thru 6=1) (ELSE=0) INTO incdec3.
VARIABLE LABELS incdec3 'income decile 3'.
VALUE LABELS incdec3 1 'Yes' 0 'No'.

RECODE hinctnta (7 thru 8=1) (ELSE=0) INTO incdec4.
VARIABLE LABELS incdec4 'income decile 4'.
VALUE LABELS incdec4 1 'Yes' 0 'No'.

RECODE hinctnta (9 thru 10=1) (ELSE=0) INTO incdec5.
VARIABLE LABELS incdec5 'income decile 5'.
VALUE LABELS incdec5 1 'Yes' 0 'No'.

RECODE lknemny(3 thru 4=1)(ELSE=0) into houseMoney.
VARIABLE LABELS houseMoney 'Likely to not enough money for household necessities next 12 months'.
VALUE LABELS houseMoney 1 'Likely' 0 'Unlikely'.
FREQUENCIES houseMoney.

*UK education*

RECODE eduagb2 (1 thru 10=1)(ELSE=0) INTO ukGrad.
VARIABLE LABELS ukGrad 'Education at high level (Graduate/Post Graduate)'.
VALUE LABELS ukGrad 1 'Yes' 0 'No'.

RECODE edubgb1 (1 thru 2=1)(ELSE=0) INTO ukle_1.
VARIABLE LABELS ukle_1 'Education at College/A-level Standard'.
VALUE LABELS ukle_1 1 'Yes' 0 'No'.

RECODE edubgb1 (3 thru 5=1)(ELSE=0) INTO ukle_2.
VARIABLE LABELS ukle_2 'Education at Secondary School/GCSE Standard'.
VALUE LABELS ukle_2 1 'Yes' 0 'No'.

RECODE edubgb1 (6 thru 7=1)(ELSE=0) INTO ukle_3.
VARIABLE LABELS ukle_3 'No formal education'.
VALUE LABELS ukle_3 1 'Yes' 0 'No'.

FREQUENCIES ukle_3.

*PL education*

RECODE edlvepl(15 thru 16=1)(ELSE=0) INTO plhi_1.
VARIABLE LABELS plhi_1 'Education at Post-Graduate Standard'.
VALUE LABELS plhi_1 1 'Yes' 0 'No'.

RECODE edlvepl(12 thru 14=1)(ELSE=0) INTO plhi_2.
VARIABLE LABELS plhi_2 'Education at Graduate Standard'.
VALUE LABELS plhi_2 1 'Yes' 0 'No'.

RECODE edlvepl(4 thru 11=1)(ELSE=0) INTO plle_2.
VARIABLE LABELS plle_2 'Education at Secondary School Standard'.
VALUE LABELS plle_2 1 'Yes' 0 'No'.

RECODE edlvepl(1 thru 3=1)(ELSE=0) INTO plle_3.
VARIABLE LABELS plle_3 'No formal education'.
VALUE LABELS plle_3 1 'Yes' 0 'No'.

*SW education*

RECODE edlvdse(15 thru 20=1)(ELSE=0) INTO swhi_1.
VARIABLE LABELS swhi_1 'SW Education at Post-Graduate Standard'.
VALUE LABELS swhi_1 1 'Yes' 0 'No'.

RECODE edlvdse(10 thru 14=1)(ELSE=0) INTO swhi_2.
VARIABLE LABELS swhi_2 'SW Education at Graduate Standard'.
VALUE LABELS swhi_2 1 'Yes' 0 'No'.

RECODE edlvdse(4 thru 8=1)(ELSE=0) INTO swle_1.
VARIABLE LABELS swle_1 'SW Education at Secondary School Standard'.
VALUE LABELS swle_1 1 'Yes' 0 'No'.

RECODE edlvdse(1 thru 3=1)(ELSE=0) INTO swle_2.
VARIABLE LABELS swle_2 'SW No formal education'.
VALUE LABELS swle_2 1 'Yes' 0 'No'.

*Internet use*

RECODE netusoft(1 thru 2=1)(ELSE=0) INTO intUse.
VARIABLE LABELS intUse 'Occasionally/Never uses the internet'.
VALUE LABELS intUse 1 'Yes' 0 'No'.


*###################################################################*

*POLTIICS*

*General Politics Attitudes*

RECODE polintr(1 thru 2 = 1)(ELSE=0) INTO polint.
VARIABLE LABELS polint 'Interested in politics'.
VALUE LABELS polint 1 'Yes' 0 'No'.

RECODE actrolga(3 thru 5 =1)(ELSE=0) INTO polGrp.
VArIABLE LABELS polGrp 'Able to take role in a political group'.
VALUE LABELS polGrp 1 'Yes' 0 'No'.

RECODE cptppola(3 thru 5 = 1) (ELSE=0) INTO polconf.
VARIABLE LABELS polconf 'Confident in own ability to participate in politics'.
VALUE LABELS polconf 1 'Yes' 0 'No'.


*Political Activities*

RECODE sgnptit(1=1)(2=0)(ELSE = SYSMISS) INTO sgnPetition.
VARIABLE LABELS sgnPetition 'Signed petition in the last 12mo'.
VALUE LABELS sgnPetition 1 'Yes' 0 'No'.

RECODE pbldmn(1=1)(2=0)(ELSE = SYSMISS) INTO prtDmn.
VARIABLE LABELS prtDmn 'Taken part in a lawful public demonstration last 12mo'.
VALUE LABELS prtDmn 1 'Yes' 0 'No'.

RECODE vote(1=1)(2=0)(ELSE = SYSMISS) INTO elgVoted.
VARIABLE LABELS elgVoted 'Eledigble to vote and voted'.
VALUE LABELS elgVoted 1 'Yes' 0 'No'.

RECODE  nwspol (0 THRU 20=1) (21 THRU 40=2) (41 THRU 60=3) (61 THRU 120=4) (121 THRU HI=5) (ELSE=SYSMIS) INTO nwsbin.
VARIABLE LABELS  nwsbin 'News about politics and current affairs, watching, reading or listening, in minutes (Binned)'.
VALUE LABELS  nwsbin 1 '0-20 minutes' 2 '21-40 minutes' 3 '41-60 minutes' 4 '61-120 minutes' 5 '121 minutes or higher'.

RECODE nwsbin (1=1) (ELSE=0) INTO nws1.
VARIABLE LABELS nws1 '0-20 minutes'.
VALUE LABELS nws1 1 'Yes' 0 'No'.

RECODE nwsbin (2=1) (ELSE=0) INTO nws2.
VARIABLE LABELS nws2 '21-40 minutes'.
VALUE LABELS nws2 1 'Yes' 0 'No'.

RECODE nwsbin (3=1) (ELSE=0) INTO nws3.
VARIABLE LABELS nws3 '41-60 minutes'.
VALUE LABELS nws3 1 'Yes' 0 'No'.

RECODE nwsbin (4=1) (ELSE=0) INTO nws4.
VARIABLE LABELS nws4 '61-120 minutes'.
VALUE LABELS nws4 1 'Yes' 0 'No'.

RECODE nwsbin (5=1) (ELSE=0) INTO nws5.
VARIABLE LABELS nws5 '121 minutes or higher'.
VALUE LABELS nws5 1 'Yes' 0 'No'.


*Political Bodies*

RECODE trstep(6 thru 10 = 1)(ELSE = 0) INTO trustEU.
VARIABLE LABELS trstEP 'Trust European Parliment'.
VALUE LABELS trstEP 1 'Trust' 0 'Neutral or dont trust'.

RECODE trstun(6 thru 10 = 1)(ELSE = 0) INTO trustUN.
VARIABLE LABELS trstUN 'Trust United Nations'.
VALUE LABELS trstUN 1 'Trust' 0 'Neutral or dont trust'.

*-UK*

RECODE prtclbgb(1=1)(ELSE=0) INTO isConservative.
VARIABLE LABELS isConservative 'Conservative'.

RECODE prtclbgb(2=1)(ELSE=0) INTO isLabour.
VARIABLE LABELS isLabour 'Labour'.

RECODE prtclbgb(3=1)(ELSE=0) INTO isLibDem.
VARIABLE LABELS isLibDem 'Liberal Democrat'.

RECODE prtclbgb(4=1)(ELSE=0) INTO isSNP.
VARIABLE LABELS isSNP 'Scottish National Party'.

RECODE prtclbgb(5=1)(ELSE=0) INTO isPlaidCymru.
VARIABLE LABELS isPlaidCymru 'Plaid Cymru'.

RECODE prtclbgb(6=1)(ELSE=0) INTO isGreenParty.
VARIABLE LABELS isGreenParty 'Green Party'.

RECODE prtclbgb(7=1)(ELSE=0) INTO isUKIP.
VARIABLE LABELS isUKIP 'UK Independence Party'.

FREQUENCIES prtclbgb.

*-Poland*

RECODE prtclgpl(1=1)(ELSE=0) INTO isKORWIN.
VARIABLE LABELS isKORWIN 'KORWIN'.
VALUE LABELS isKORWIN 1 'Yes' 0 'No'.

RECODE prtclgpl(2=1)(ELSE=0) INTO isKukiz.
VARIABLE LABELS isKukiz 'Kukiz15'.
VALUE LABELS isKukiz 1 'Yes' 0 'No'.

RECODE prtclgpl(3=1)(ELSE=0) INTO isModernpol.
VARIABLE LABELS isModernpol 'Modern Poland'.
VALUE LABELS isModernpol 1 'Yes' 0 'No'.

RECODE prtclgpl(4=1)(ELSE=0) INTO isCvcplat.
VARIABLE LABELS isCvcplat 'Civic Platform'.
VALUE LABELS isCvcplat 1 'Yes' 0 'No'.

RECODE prtclgpl(5=1)(ELSE=0) INTO isPstparty.
VARIABLE LABELS isPstparty 'Poland Peasents Party'.
VALUE LABELS isPstparty 1 'Yes' 0 'No'.

RECODE prtclgpl(6=1)(ELSE=0) INTO isLaj.
VARIABLE LABELS isLaj 'Law and Justice'.
VALUE LABELS isLaj 1 'Yes' 0 'No'.

RECODE prtclgpl(7=1)(ELSE=0) INTO isTgtparty.
VARIABLE LABELS isTgtparty 'Together Party'.
VALUE LABELS isTgtparty 1 'Yes' 0 'No'.

RECODE prtclgpl(8=1)(ELSE=0) INTO isDemola.
VARIABLE LABELS isDemola 'Democratic Left Alliance'.
VALUE LABELS isDemola 1 'Yes' 0 'No'.

*-sweden*

RECODE prtclbse(1=1)(ELSE=0) INTO isCenter.
VARIABLE LABELS isCenter 'The Center'.
VALUE LABELS isCenter 1 'Yes' 0 'No'.

RECODE prtclbse(2=1)(ELSE=0) INTO isPplib.
VARIABLE LABELS isPplib 'Peoples Party Liberals'.
VALUE LABELS isPplib 1 'Yes' 0 'No'.

RECODE prtclbse(3=1)(ELSE=0) INTO isChrsdemo.
VARIABLE LABELS isChrsdemo 'The Christian Democrats'.
VALUE LABELS isChrsdemo 1 'Yes' 0 'No'.

RECODE prtclbse(4=1)(ELSE=0) INTO isGreens.
VARIABLE LABELS isGreens 'Green Party'.
VALUE LABELS isGreens 1 'Yes' 0 'No'.

RECODE prtclbse(5=1)(ELSE=0) INTO isModcp.
VARIABLE LABELS isModcp 'Moderate Collection Party'.
VALUE LABELS isModcp 1 'Yes' 0 'No'.

RECODE prtclbse(6=1)(ELSE=0) INTO isSocdemo.
VARIABLE LABELS isSocdemo 'The Social Democrats'.
VALUE LABELS isSocdemo 1 'Yes' 0 'No'.

RECODE prtclbse(7=1)(ELSE=0) INTO isLeft.
VARIABLE LABELS isLeft 'The Left'.
VALUE LABELS isLeft 1 'Yes' 0 'No'.

RECODE prtclbse(8=1)(ELSE=0) INTO isFi.
VARIABLE LABELS isFi 'Feminist Initiative'.
VALUE LABELS isFi 1 'Yes' 0 'No'.

RECODE prtclbse(9=1)(ELSE=0) INTO isPirate.
VARIABLE LABELS isPirate 'Pirate Party'.
VALUE LABELS isPirate 1 'Yes' 0 'No'.

RECODE prtclbse(10=1)(ELSE=0) INTO isSwdemo.
VARIABLE LABELS isSwdemo 'sweden Democrats'.
VALUE LABELS isCenter 1 'Yes' 0 'No'.

RECODE prtclbse(11=1)(ELSE=0) INTO ispAny.
VARIABLE LABELS ispAny 'Any Party'.
VALUE LABELS ispAny 1 'Yes' 0 'No'.

*###################################################################*

*RELIGON*

RECODE rlgblg(1=1)(2=0)(ELSE = SYSMIS) INTO isRlg.
VARIABLE LABELS isRlg 'Belongs to a particular religion or denomination'.
VALUE LABELS isRlg 1 'Yes' 0 'No'.

RECODE rlgdgr(6 thru 10 = 1)(ELSE = 0) INTO rlgAtt.
VARIABLE LABELS rlgAtt 'Is strongly religous'.
VALUE LABELS rlgAtt 1 'Yes' 0 'No'.

*Religous Bodies*

*- UK*

RECODE rlgdngb(1=1)(ELSE=0) INTO isRomanCatholic.
VARIABLE LABELS isRomanCatholic 'Roman Catholic'.
VALUE LABELS isRomanCatholic 1 'Yes' 0 'No'.

RECODE rlgdngb(2=1)(ELSE=0) INTO isCoE.
VARIABLE LABELS isCoE 'Church of England/ Anglican'.
VALUE LABELS isCoE 1 'Yes' 0 'No'.

RECODE rlgdngb(3=1)(ELSE=0) INTO isCoI.
VARIABLE LABELS isCoI 'Church of Ireland'.
VALUE LABELS isCoI 1 'Yes' 0 'No'.

RECODE rlgdngb(4=1)(ELSE=0) INTO isBaptist.
VARIABLE LABELS isBaptist 'Baptist'.
VALUE LABELS isBaptist 1 'Yes' 0 'No'.

RECODE rlgdngb(5=1)(ELSE=0) INTO isMethodist.
VARIABLE LABELS isMethodist 'Methodist'.
VALUE LABELS isMethodist 1 'Yes' 0 'No'.

RECODE rlgdngb(6=1)(ELSE=0) INTO isCoS.
VARIABLE LABELS isCoS 'Church of Scotland'.
VALUE LABELS isCoS 1 'Yes' 0 'No'.

RECODE rlgdngb(7=1)(ELSE=0) INTO isURC.
VARIABLE LABELS isURC 'United Reformed Church'.
VALUE LABELS isURC 1 'Yes' 0 'No'.

RECODE rlgdngb(10=1)(ELSE=0) INTO othProt.
VARIABLE LABELS othProt 'Other Protestant'.
VALUE LABELS othProt 1 'Yes' 0 'No'.

RECODE rlgdngb(13=1)(ELSE=0) INTO othChris.
VARIABLE LABELS othChris 'Other Christian'.
VALUE LABELS othChris 1 'Yes' 0 'No'.

RECODE rlgdngb(14=1)(ELSE=0) INTO isHindu.
VARIABLE LABELS isHindu 'Hindu'.
VALUE LABELS isHindu 1 'Yes' 0 'No'.

RECODE rlgdngb(15=1)(ELSE=0) INTO isSikh.
VARIABLE LABELS isSikh 'Sikh'.
VALUE LABELS isSikh 1 'Yes' 0 'No'.

RECODE rlgdngb(16=1)(ELSE=0) INTO isBuddhist.
VARIABLE LABELS isBuddhist 'Buddhist'.
VALUE LABELS isBuddhist 1 'Yes' 0 'No'.

RECODE rlgdngb(19=1)(ELSE=0) INTO isIslam.
VARIABLE LABELS isIslam 'Islam / Muslim'.
VALUE LABELS isIslam 1 'Yes' 0 'No'.

RECODE rlgdngb(20=1)(ELSE=0) INTO othNChris.
VARIABLE LABELS othNChris 'Other non-Christian'.
VALUE LABELS othNChris 1 'Yes' 0 'No'.

*-Poland*

RECODE rlgdnapl(100=1)(ELSE=0) INTO plCatholic.
VARIABLE LABELS plCatholic 'PL Catholic (denomination not specified)'.
VALUE LABELS plCatholic 1 'Yes' 0 'No'.

RECODE rlgdnapl(110=1)(ELSE=0) INTO plrCatholic.
VARIABLE LABELS plCatholic 'PL Roman Catholic Church'.
VALUE LABELS plCatholic 1 'Yes' 0 'No'.

RECODE rlgdnapl(1=1)(ELSE=0) INTO plgCatholic.
VARIABLE LABELS plCatholic 'PL Greek Catholic Church'.
VALUE LABELS plgCatholic 1 'Yes' 0 'No'.

RECODE rlgdnapl(1=1)(ELSE=0) INTO plJW.
VARIABLE LABELS plCatholic 'PL Jehovas Witnesses'.
VALUE LABELS plgCatholic 1 'Yes' 0 'No'.

RECODE rlgdnapl(1=1)(ELSE=0) INTO plCatholic.
VARIABLE LABELS plCatholic 'PL Catholic (denomination not specified)'.
VALUE LABELS plCatholic 1 'Yes' 0 'No'.

FREQUENCIES rlgdnapl.


*-sweden*

RECODE rlgdease(1=1)(ELSE=0) INTO swCatholic.
VARIABLE LABELS swCatholic 'SW Catholic Church'.
VALUE LABELS swCatholic 1 'Yes' 0 'No'.

RECODE rlgdease(2=1)(ELSE=0) INTO swChurch.
VARIABLE LABELS swChurch 'SW Sweedish Church'.
VALUE LABELS swChurch 1 'Yes' 0 'No'.

RECODE rlgdease(3=1)(ELSE=0) INTO swProt.
VARIABLE LABELS swProt 'SW Protestant Church'.
VALUE LABELS swProt 1 'Yes' 0 'No'.

RECODE rlgdease(4=1)(ELSE=0) INTO swOrth.
VARIABLE LABELS swOrth 'SW Orthodox Church'.
VALUE LABELS swOrth 1 'Yes' 0 'No'.

RECODE rlgdease(5=1)(ELSE=0) INTO swChrsa.
VARIABLE LABELS swChrsa 'SW Other Christian Assembly'.
VALUE LABELS swChrsa 1 'Yes' 0 'No'.

RECODE rlgdease(6=1)(ELSE=0) INTO swJudaism.
VARIABLE LABELS swJudaism 'SW Judaism'.
VALUE LABELS swJudaism 1 'Yes' 0 'No'.

RECODE rlgdease(7=1)(ELSE=0) INTO swIslam.
VARIABLE LABELS swIslam 'SW Islam'.
VALUE LABELS swIslam 1 'Yes' 0 'No'.

RECODE rlgdease(8=1)(ELSE=0) INTO swOth.
VARIABLE LABELS swOth 'SW Other (Buddhism, Sikh, Hindu)'.
VALUE LABELS swOth 1 'Yes' 0 'No'.

RECODE rlgdease(9=1)(ELSE=0) INTO swOthc.
VARIABLE LABELS swOthc 'SW Other Christrian '.
VALUE LABELS swOthc 1 'Yes' 0 'No'.

*###################################################################*

*BREXIT AND REFUGEES*

RECODE imwbcnt(6 thru 10=1)(ELSE=0) INTO imgAtt.
VARIABLE LABELS imgAtt 'Immigrants make country a better place to live'.
VALUE LABELS imgAtt 1 'Better Place' 0 'Worse Place'.
FREQUENCIES imgAtt.

*UK Brexit*

RECODE vteumbgb(2=1)(1=0)(ELSE=SYSMIS) INTO ukBrexit.
VARIABLE LABELS ukBrexit 'Would vote to leave the EU'.
VALUE LABELS ukBrexit 1 'Leave' 0 'Remain'.

*All countries EU ref*

RECODE vteurmmb(2=1)(1=0)(ELSE=SYSMIS) into euRef.
VARIABLE LABELS euRef 'Would vote for Poland/sweden to leave the EU'.
VALUE LABELS euRef 1 'Leave' 0 'Remain'.


*###################################################################*

*CLIMATE*
  
RECODE rdcenr(4 thru 6=1)(ELSE=0) INTO  reduceEnergy.
VARIABLE LABELS reduceEnergy 'Reduces energy use'.
VALUE LABELS reduceEnergy 1 'Reduces energy use' 0 'Does not reduce energy use'.
FREQUENCIES reduceEnergy.

RECODE ccrdprs(6 thru 10=1)(ELSE=0) INTO reduceClm.
VARIABLE LABELS reduceClm 'Personally responsible to reduce climate change'.
VALUE LABELS reduceClm 1 'Yes' 0 'No'.

RECODE ccnthum(1 thru 2=1)(ELSE=0) INTO clmCause1.
VARIABLE LABELS clmCause1 'Climate change caused by natural factors'.
VALUE LABELS clmCause1 1 'Yes' 0 'No'.

RECODE ccnthum(3=1)(ELSE=0) INTO clmCause2.
VARIABLE LABELS clmCause2 'Climate change caused equally by natural and human factors'.
VALUE LABELS clmCause2 1 'Yes' 0 'No'.

RECODE ccnthum(4 thru 5=1)(ELSE=0) INTO clmCause3.
VARIABLE LABELS clmCause3 'Climate change caused by Human Factors'.
VALUE LABELS clmCause3 1 'Yes' 0 'No'.

RECODE lklmten(6 thru 10=1)(ELSE=0) INTO lklReduce.
VARIABLE LABELS lklReduce 'Likely Large numbers of people limit energy use'.
VALUE LABELS lklReduce 1 'Yes' 0 'No'.

RECODE gvsrdcc(6 thru 10=1)(ELSE=0) INTO govReduce.
VARIABLE LABELS govReduce 'Likely goverment takes enough action on reducing energy use'.
VALUE LABELS govReduce 1 'Yes' 0 'No'.

*###################################################################*

DATASET ACTIVATE DataSet1.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT envclimatt
  /METHOD=ENTER gen2 gen3 gen4 gender isMinority isMarried isSeperated incdec2 incdec3 incdec4 
    incdec5 houseMoney ukle_2 ukle_1 ukGrad intUse polint polGrp polconf sgnPetition prtDmn elgVoted 
    nws2 nws3 nws4 nws5 trustEU trustUN isLabour isLibDem isSNP isPlaidCymru isGreenParty isUKIP isRlg 
    rlgAtt isCoE isCoI isBaptist isMethodist isCoS isURC othProt othChris isHindu isSikh isBuddhist 
    isIslam othNChris imgAtt ukBrexit reduceEnergy clmCause2 clmCause3 lklReduce govReduce.

USE ALL. 
COMPUTE filter_$=(cntry ="SE" AND (envclimatt=1 or (envclimatt =2))).
VARIABLE LABELS filter_$ "cntry = ''GB' (FILTER)".
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.

DATASET ACTIVATE DataSet1.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT envclimatt
  /METHOD=ENTER gen2 gen3 gen4 gender isMinority isMarried isSeperated incdec2 incdec3 incdec4 
    incdec5 houseMoney swle_1 swhi_2 swhi_1 intUse polint polGrp polconf sgnPetition prtDmn elgVoted 
    nws2 nws3 nws4 nws5 trustEU trustUN isPplib isChrsdemo isGreens isModcp isSocdemo isLeft isFi 
    isPirate isSwdemo ispAny isRlg rlgAtt swCatholic swChurch swProt swOrth swChrsa swIslam 
    swOth swOthc imgAtt euRef reduceEnergy clmCause2 clmCause3 lklReduce govReduce.

USE ALL. 
COMPUTE filter_$=(cntry ="PL" AND (envclimatt=1 or (envclimatt =2))).
VARIABLE LABELS filter_$ "cntry = ''GB' (FILTER)".
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT envclimatt
  /METHOD=ENTER gen2 gen3 gen4 gender isMinority isMarried isSeperated incdec2 incdec3 incdec4 
    incdec5 houseMoney plle_2 plhi_2 plhi_1 intUse polint polGrp polconf sgnPetition prtDmn elgVoted 
    nws2 nws3 nws4 nws5 trustEU trustUN isKORWIN isKukiz isModernpol isCvcplat isPstparty isTgtparty 
    isDemola imgAtt euRef isRlg rlgAtt reduceEnergy clmCause2 clmCause3 lklReduce govReduce.
