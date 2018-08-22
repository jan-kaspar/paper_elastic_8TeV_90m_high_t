import root;
import pad_layout;

texpreamble("\SelectCMFonts\LoadFonts\NormalFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV/beta90/high_t/fits/";

string f = topDir + "make_fits.root";

xSizeDef = 6.8cm;
ySizeDef = 5cm;

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\sigma/\d t\ung{mb/GeV^2}$");
//scale(Linear, Log);

draw(RootGetObject(f, "h_dsdt"), "eb", black, "data with stat.~unc.");

//draw(RootGetObject(f, "h_dsdt|ff0"), "l", red);
//draw(RootGetObject(f, "h_dsdt|ff1"), "l", heavygreen);

draw(RootGetObject(f, "h_dsdt|ff2"), "l", blue+1pt);
draw(RootGetObject(f, "h_dsdt|ff3"), "l", red+1pt);

limits((0.3, 1e-2), (1., 0.05), Crop);

AttachLegend();
