void my_function() {
    // 1. Створюємо полотно
    TCanvas *c1 = new TCanvas("c1", "c1", 800, 600);

    // 2. Створюємо функцію f(x) = sin(x)*x в діапазоні від 0 до 20
    TF1 *f1 = new TF1("f1", "sin(x)*x", 0, 20);

    double integral_val = f1->Integral(0, 10);
    printf("Integral(0, 10) = %f\n", integral_val);


    f1->SetTitle("My Energy Spectrum Analysis");
    f1->GetXaxis()->SetTitle("Energy [GeV]");
    f1->GetYaxis()->SetTitle("Events / 0.1 GeV");

    f1->GetYaxis()->SetTitleOffset(1.2);
    f1->GetXaxis()->SetTitleColor(kBlue);

    f1->Draw();
    c1->SaveAs("spectrum_analysis.png");}
