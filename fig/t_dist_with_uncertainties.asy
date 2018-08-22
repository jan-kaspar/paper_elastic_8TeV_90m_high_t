import root;
import pad_layout;

texpreamble("\SelectCMFonts\LoadFonts\NormalFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string dataset = "DS4";

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV/beta90/high_t/";

string binning = "ob-1-30-0.10";
//string binning = "ob-2-20-0.20";

drawGridDef = true;

TH1_x_max = 1.9;

xSizeDef = 12cm;
ySizeDef = 6cm;

pen p_unc_full = yellow;
pen p_unc_anal = red;

//----------------------------------------------------------------------------------------------------

void DrawUncertaintyHist(real yScale=100, RootObject o, pen p=black)
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

		real u_rel = (v > 0) ? u/v : 0.;

		if (v > 0)
		{
			draw((c-w/2, 0.)--(c+w/2, 0.), p);
			draw((c, -u_rel*yScale)--(c, +u_rel*yScale), p);
		}
	}
}

//----------------------------------------------------------------------------------------------------

void DrawBandGraph(real yScale=100, RootObject o, pen p=lightblue)
{
	guide g_u, g_b;
	
	int N = o.iExec("GetN");
	for (int i = 0; i < N; ++i)
	{
		real xa[] = {0.};
		real ya[] = {0.};
		o.vExec("GetPoint", i, xa, ya);
		real x = xa[0];
		real y = ya[0];

		//if (x < rel_diff_low_limit || x > rel_diff_high_limit)
		//	continue;
	
		g_u = g_u -- (x, +y*yScale);
		g_b = g_b -- (x, -y*yScale);
	}

	g_b = reverse(g_b);
	filldraw(g_u--g_b--cycle, p, nullpen);
}

//----------------------------------------------------------------------------------------------------

void DrawBandAroundFit(RootObject of, RootObject ou, pen p=lightblue)
{
	guide g_u, g_b;
	
	int N = of.iExec("GetN");
	for (int i = 0; i < N; ++i)
	{
		real xa[] = {0.};
		real ya[] = {0.};
		of.vExec("GetPoint", i, xa, ya);
		real x = xa[0];
		real y = ya[0];

		real u = ou.rExec("Eval", x);
	
		g_u = g_u -- Scale((x, y * (1.+u)));
		g_b = g_b -- Scale((x, y * (1.-u)));
	}

	g_b = reverse(g_b);
	filldraw(g_u--g_b--cycle, p, nullpen);
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

// TODO: replace the temp objects
RootObject o_dsdt = RootGetObject(topDir+"DS-merged/merged.root", binning+"/"+dataset+"/combined/h_dsdt");
RootObject o_unc_anal = RootGetObject(topDir+dataset+"/systematics_matrix.root", "matrices/all-temp-anal/combined/g_envelope");
RootObject o_unc_full = RootGetObject(topDir+dataset+"/systematics_matrix.root", "matrices/all-temp/combined/g_envelope");
RootObject o_fit = RootGetObject(topDir+"models/exp3-intf-exp1.root", "g_dsdt");

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t \ung{mb/GeV^2}$");
currentpad.xTicks = LeftTicks(0.2, 0.1);
scale(Linear, Log);

//DrawBandAroundFit(o_fit, o_unc_full, p_unc_full);
//DrawBandAroundFit(o_fit, o_unc_anal, p_unc_anal);

draw(o_dsdt, "eb", black);

limits((0, 1e-4), (2., 1e3), Crop);

//----------------------------------------------------------------------------------------------------

/*
NewRow();

NewPad("$|t|\ung{GeV^2}$", "relative uncertainty $\ung{\%}$", ySize = 3.5cm);
currentpad.xTicks = LeftTicks(0.2, 0.1);
currentpad.yTicks = RightTicks(20., 10.);

DrawBandGraph(o_unc_full, p_unc_full);
DrawBandGraph(o_unc_anal, p_unc_anal);
DrawUncertaintyHist(o_dsdt);

limits((0, -60), (2., +60), Crop);
*/

GShipout(vSkip=1mm, margin=1mm);
