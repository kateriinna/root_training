#include "TH1F.h"
#include "TCanvas.h"
#include "TRandom3.h"
#include "TLegend.h"
#include "TStyle.h"
#include <algorithm>

void my_plot() {
    gStyle->SetOptStat(0);

    TCanvas *c1 = new TCanvas("c1", "My Plot", 800, 600);

    TH1F *h_bg   = new TH1F("h_bg", "Simulated Distributions;;Entries", 50, 0, 2);
    TH1F *h_sig1 = new TH1F("h_sig1", "Signal 1", 50, 0, 2);
    TH1F *h_sig2 = new TH1F("h_sig2", "Signal 2", 50, 0, 2);

    TRandom3 rand(42);

    for (int i = 0; i < 5000; ++i) h_bg->Fill(rand.Exp(0.6));
    for (int i = 0; i < 2000; ++i) h_sig1->Fill(rand.Gaus(0.4, 0.15));
    for (int i = 0; i < 2500; ++i) h_sig2->Fill(rand.Gaus(1.2, 0.25));
    
    h_bg->SetLineColor(kRed-7);      
    h_bg->SetFillColor(kRed-7);
    h_bg->SetFillStyle(3013);        

    h_sig1->SetLineColor(kGreen+2);  
    h_sig1->SetFillColor(kGreen+2);
    h_sig1->SetFillStyle(3004);      

    h_sig2->SetLineColor(kBlue-7);
    h_sig2->SetFillColor(kBlue-7);
    h_sig2->SetFillStyle(3005);      

    double max_val = std::max({h_bg->GetMaximum(), h_sig1->GetMaximum(), h_sig2->GetMaximum()});
    h_bg->SetMaximum(max_val * 1.2); 

    h_bg->Draw("HIST");
    h_sig1->Draw("HIST SAME");
    h_sig2->Draw("HIST SAME");

    TLegend *leg = new TLegend(0.60, 0.65, 0.88, 0.88); 
    leg->AddEntry(h_sig2, "Signal 1", "f"); 
    leg->AddEntry(h_sig1, "Signal 2", "f"); 
    leg->AddEntry(h_bg,   "Signal 3", "f"); 
    leg->SetBorderSize(1); 
    leg->Draw();

    c1->SaveAs("my_distributions.png");
    c1->SaveAs("my_distributions.pdf");
}
