void my_hist() {
    TCanvas *c1 = new TCanvas("c1", "My Canvas", 800, 600);

    TH1F *hist = new TH1F("hist", "My First ROOT Histogram;X axis;Number of events", 100, -5, 5);

    for (int i = 0; i < 10000; i++) {
        hist->Fill(gRandom->Gaus(0, 1));
    }

    hist->SetFillColor(kBlue-9);
    hist->Draw();
    c1->SaveAs("my_histogram.png");}
