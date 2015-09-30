{

gStyle->Reset();

// Turn off some borders
  gStyle->SetCanvasBorderMode(0);
  gStyle->SetFrameBorderMode(0);
  gStyle->SetPadBorderMode(0);
  gStyle->SetDrawBorder(0);
  gStyle->SetCanvasBorderSize(0);
  gStyle->SetFrameBorderSize(0);
  gStyle->SetPadBorderSize(1);
  gStyle->SetTitleBorderSize(0);

  // 0=white, 1=black, 2=red, 3=green, 4=blue, 5=yellow
  gStyle->SetAxisColor(1, "xyz");
  gStyle->SetCanvasColor(0);
  gStyle->SetFrameFillColor(0);
  gStyle->SetFrameLineColor(1);
  //gStyle->SetHistFillColor(2);
  gStyle->SetHistLineColor(2);
  //gStyle->SetErrorX(0);         // turn off x error bars
  //gStyle->SetPadColor(1);
  gStyle->SetPadColor(kWhite);
  gStyle->SetStatColor(0);
  gStyle->SetStatTextColor(1);
  gStyle->SetTitleColor(1);
  gStyle->SetTitleTextColor(1);
  gStyle->SetLabelColor(1,"xyz");
  gStyle->SetFuncColor(2);

  gStyle->SetCanvasDefH(600);
  gStyle->SetCanvasDefW(600);
  gStyle->SetCanvasDefX(10);
  gStyle->SetCanvasDefY(10);

  int style_label_font=42;  // font number info here: https://root.cern.ch/root/html/TAttText.html
  /* int style_title_font=62; */
  /* gStyle->SetLabelFont(style_label_font,"xyz"); */
  /* gStyle->SetLabelSize(0.045,"xyz"); */
  /* gStyle->SetLabelOffset(0.1,"xyz"); */
  /* gStyle->SetStatFont(style_label_font); */
  /* gStyle->SetTitleFont(style_label_font,"xyz");  // axis titles */
  /* gStyle->SetTitleFont(style_title_font,"h");    // histogram title */
  /* gStyle->SetTitleSize(0.05,"xyz");              // axis titles */
  /* gStyle->SetTitleSize(0.05,"h");                // histogram title */
  /* gStyle->SetTitleOffset(1.5,"x"); */
  /* gStyle->SetTitleOffset(1.5,"y"); */
  /* gStyle->SetStripDecimals(kFALSE);              // if we have 1.5 do not set 1.0 -> 1 */
  /* gStyle->SetTitleX(0.12);                       // spot where histogram title goes */
  /* gStyle->SetTitleY(0.99); */
  /* gStyle->SetTitleW(0.78);                       // width computed so that title is centered */
  /* //gStyle->SetTitleAlign(xy);         // x=123 left middle right y = 123 bottom middle top */

  /* // TGaxis::SetMaxDigits(2); // restricts number of s.f. on axes (uses standard form) */

  gStyle->SetFrameLineWidth(2);
  gStyle->SetFuncWidth(2);
  gStyle->SetHistLineWidth(2);

int style_label_font = 42;
//gStyle->SetLabelFont(style_label_font,"xyz");
//gStyle->SetLabelSize(0.045,"xyz");
//gStyle->SetLabelOffset(0.03,"xyz");
gStyle->SetOptTitle(0);
gStyle->SetStatFont(style_label_font);
gStyle->SetTitleFont(style_label_font,"xyz"); // axis titles
gStyle->SetTitleFont(style_label_font,"h"); // histogram title
gStyle->SetTitleSize(0.05,"xyz"); // axis titles
gStyle->SetTitleSize(0.05,"h"); // histogram title
gStyle->SetTitleOffset(1.2,"x");
gStyle->SetTitleOffset(1.2,"y");
gStyle->SetStripDecimals(kFALSE); // if we have 1.5 do not set 1.0 -> 1
//gStyle->SetTitleX(0.12); // spot where histogram title goes
gStyle->SetTitleW(1.1); // width computed so that title is centered
//TGaxis::SetMaxDigits(2); // restrict the number of digits in labels

// Set all fill styles to be empty and line styles to be solid
gStyle->SetFrameFillStyle(0);
gStyle->SetHistFillStyle(1001);
gStyle->SetFrameLineStyle(0);
gStyle->SetHistLineStyle(0);
gStyle->SetTitleStyle(0);
gStyle->SetFuncStyle(1);

// Set margins -- I like to shift the plot a little up and to the
// right to make more room for axis labels
gStyle->SetPadTopMargin(0.08);
gStyle->SetPadBottomMargin(0.15);
gStyle->SetPadLeftMargin(0.2);
//gStyle->SetPadRightMargin(0.1);

// Set Data/Stat/... and other options
gStyle->SetOptDate(0);
gStyle->SetDateX(0.01);
gStyle->SetDateY(0.01);
gStyle->SetOptFile(0);
gStyle->SetOptFit(111);
gStyle->SetOptLogx(0);
gStyle->SetOptLogy(0);
gStyle->SetOptLogz(0);
gStyle->SetOptStat(1110);// no histogram title
gStyle->SetStatFormat("6.4f");
gStyle->SetFitFormat("6.4f");
gStyle->SetStatStyle(0); // hollow
//gStyle->SetStatStyle(1001); // filled
gStyle->SetStatBorderSize(0);
gStyle->SetStatW(0.25);
gStyle->SetStatH(0.125);
//gStyle->SetStatX(0.90);
//gStyle->SetStatY(0.90);
gStyle->SetStatX(1.0-gStyle->GetPadRightMargin()-0.02);
gStyle->SetStatY(1.0-gStyle->GetPadTopMargin()-0.02);
gStyle->SetOptTitle(1);
// Set tick marks and turn off grids
//gStyle->SetNdivisions(1005,"xyz");
gStyle->SetNdivisions(510,"xyz");
gStyle->SetPadTickX(1);
gStyle->SetPadTickY(1);
gStyle->SetTickLength(0.02,"xyz");
gStyle->SetPadGridX(0);
gStyle->SetPadGridY(0);

// no supressed zeroes!
gStyle->SetHistMinimumZero(kTRUE);

// Set paper size for life in the US
//gStyle->SetPaperSize(TStyle::kUSLetter);
// or europe
gStyle->SetPaperSize(TStyle::kA4);

// use a pretty palette for color plots
gStyle->SetPalette(1,0);

//gStyle->SetLabelColor(1,"xyz");
// Force this style on all histograms
gROOT->ForceStyle();
gStyle->SetFillStyle(4000);
gStyle->SetFillColor(0);


}
