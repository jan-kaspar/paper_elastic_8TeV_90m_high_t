import root;
import pad_layout;

texpreamble("\SelectCMFonts\LoadFonts\NormalFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV/beta90/high_t/";

string diagonal = "45b_56t";
string binning = "ob-1-30-0.10";

xSizeDef = 7.1cm;
ySizeDef = 5cm;

drawGridDef = true;

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "unfolding correction ${\cal U}$");

TH1_x_min = 0.02;


//draw(RootGetObject(topDir + "DS4/unfolding_cf_"+diagonal+".root", binning+"/exp3+exp4/+0,+0/corr_final"), "vl", black+1pt);
//draw(RootGetObject(topDir + "DS4/unfolding_cf_"+diagonal+".root", binning+"/exp5+erf*exp2/+0,+0/corr_final"), "vl", black+1pt);

draw(RootGetObject(topDir + "DS4/unfolding_cf_"+diagonal+".root", binning+"/p1*exp3+p1*exp1/+0,+0/corr_final"), "vl", blue+1pt, "CF, p1*exp3+p1*exp1");
//draw(RootGetObject(topDir + "DS4/unfolding_cf_"+diagonal+".root", binning+"/p1*exp3+p2*exp2/+0,+0/corr_final"), "vl", blue+1pt);

draw(RootGetObject(topDir + "DS4/unfolding_cf_"+diagonal+".root", binning+"/exp3-intf-exp1/+0,+0/corr_final"), "vl", red+1pt, "CF, exp3-intf-exp1");
//draw(RootGetObject(topDir + "DS4/unfolding_cf_"+diagonal+".root", binning+"/(exp3-intf-exp1)*expG/+0,+0/corr_final"), "vl", red+1pt);

//draw(RootGetObject(topDir + "DS4/unfolding_gr_"+diagonal+".root", binning+"/smearing_matrix_mc_"+diagonal+".root,p1*exp3+p2*exp2,"+binning+"/alpha=1.00E-01/h_corr"), "vl", blue+1pt);
//draw(RootGetObject(topDir + "DS4/unfolding_gr_"+diagonal+".root", binning+"/smearing_matrix_mc_"+diagonal+".root,exp3-intf-exp1,"+binning+"/alpha=1.00E-01/h_corr"), "vl", blue+1pt);

TH1_x_max = 1.69;

//draw(RootGetObject(topDir + "DS4/unfolding_gr_"+diagonal+".root", binning+"/smearing_matrix_mc_"+diagonal+".root,p1*exp3+p2*exp2,"+binning+"/alpha=1.00E+00/h_corr"), "vl", heavygreen+1pt);
draw(RootGetObject(topDir + "DS4/unfolding_gr_"+diagonal+".root", binning+"/smearing_matrix_mc_"+diagonal+".root,exp3-intf-exp1,"+binning+"/alpha=1.00E+00/h_corr"), "vl", heavygreen+1pt, "RRMI");

//draw(RootGetObject(topDir + "DS4/unfolding_summarize_"+diagonal+".root", binning+"/model/h_mean_stddev"), "eb", red);

limits((0, 0.8), (2., 1.05), Crop);
currentpad.xTicks = LeftTicks(0.2, 0.1);
currentpad.yTicks = RightTicks(0.05, 0.01);

//limits((0, 0.8), (0.1, 1.10), Crop);

AttachLegend(shift(0, 10)*BuildLegend(SE), SE);
