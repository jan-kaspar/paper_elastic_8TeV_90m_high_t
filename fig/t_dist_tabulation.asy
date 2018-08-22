import root;
import pad_layout;

texpreamble("\SelectCMFonts\LoadFonts\NormalFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV/beta90/high_t/";

drawGridDef = true;

TH1_x_max = 1.9;

xSizeDef = 12cm;
ySizeDef = 6cm;

pen p_unc_full = orange;
//pen p_unc_anal = red;

//----------------------------------------------------------------------------------------------------

void DrawUncBoxes(RootObject o, pen p=black)
{
	int N = o.iExec("GetNbinsX");
	for (int bi = 1; bi <= N; ++bi)
	{
		real c = o.rExec("GetBinCenter", bi);
		real w = o.rExec("GetBinWidth", bi);
		real v = o.rExec("GetBinContent", bi);
		real u = o.rExec("GetBinError", bi);

		if (c > TH1_x_max)
			continue;

		if (v > 0)
		{
			filldraw(Scale((c-w/2, v-u))--Scale((c+w/2, v-u))--Scale((c+w/2, v+u))--Scale((c-w/2, v+u))--cycle, p, nullpen);
		}
	}
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

string f = topDir + "tabulation/tabulate.root";

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t \ung{mb/GeV^2}$");
currentpad.xTicks = LeftTicks(0.2, 0.1);
scale(Linear, Log);

AddToLegend("data with statistical uncertainties", mPl+black+5pt);
AddToLegend("systematic uncertainties", mSq+p_unc_full+5pt);

RootObject h_dsdt_syst = RootGetObject(f, "h_dsdt_val_exp_unc_syst");
DrawUncBoxes(h_dsdt_syst, p_unc_full);

draw(RootGetObject(f, "h_dsdt_val_exp_unc_stat"), "eb", black);

limits((0, 1e-4), (1.9, 1e3), Crop);

AttachLegend();

GShipout(vSkip=1mm, margin=1mm);
