#include "TH1F.h"
#include "TCanvas.h"
#include "TRandom3.h"
#include "TLegend.h"
#include "TStyle.h"
#include <algorithm>

void my_plot() {
    // Вимикаємо стандартне віконце зі статистикою (як на вашому фото)
    gStyle->SetOptStat(0);

    // Створюємо канвас (полотно для малювання)
    TCanvas *c1 = new TCanvas("c1", "My First Plot", 800, 600);

    // Створюємо 3 гістограми (50 корзин, діапазон від 0 до 2)
    TH1F *h_bg   = new TH1F("h_bg", "Zmodeliovani Rozpodily;mRecoil GeV/c^{2};Entries", 50, 0, 2);
    TH1F *h_sig1 = new TH1F("h_sig1", "Signal 1", 50, 0, 2);
    TH1F *h_sig2 = new TH1F("h_sig2", "Signal 2", 50, 0, 2);

    // Ініціалізуємо генератор випадкових чисел
    TRandom3 rand(42);

    // Заповнюємо гістограми випадковими даними
    for (int i = 0; i < 5000; ++i) h_bg->Fill(rand.Exp(0.6));        // Експоненційний фон
    for (int i = 0; i < 2000; ++i) h_sig1->Fill(rand.Gaus(0.4, 0.15)); // Гаусіан 1
    for (int i = 0; i < 2500; ++i) h_sig2->Fill(rand.Gaus(1.2, 0.25)); // Гаусіан 2

    // --- НАЛАШТУВАННЯ ДИЗАЙНУ (як на скріншоті) ---
    
    // Фон (Червоний, перехресна штриховка)
    h_bg->SetLineColor(kRed-7);      // Світло-червоний контур
    h_bg->SetFillColor(kRed-7);
    h_bg->SetFillStyle(3013);        // ROOT код для перехресної штриховки (xx)

    // Сигнал 1 (Зелений, діагональ вправо)
    h_sig1->SetLineColor(kGreen+2);  
    h_sig1->SetFillColor(kGreen+2);
    h_sig1->SetFillStyle(3004);      // ROOT код для штриховки (//)

    // Сигнал 2 (Синій, діагональ вліво)
    h_sig2->SetLineColor(kBlue-7);
    h_sig2->SetFillColor(kBlue-7);
    h_sig2->SetFillStyle(3005);      // ROOT код для штриховки (\\)

    // Знаходимо максимальне значення по осі Y, щоб графік не обрізався зверху
    double max_val = std::max({h_bg->GetMaximum(), h_sig1->GetMaximum(), h_sig2->GetMaximum()});
    h_bg->SetMaximum(max_val * 1.2); // Додаємо 20% вільного місця зверху

    // Малюємо гістограми ("HIST" малює лініями без похибок, "SAME" накладає їх)
    h_bg->Draw("HIST");
    h_sig1->Draw("HIST SAME");
    h_sig2->Draw("HIST SAME");

    // Створюємо легенду
    TLegend *leg = new TLegend(0.55, 0.65, 0.88, 0.88); // Координати (X1, Y1, X2, Y2)
    leg->AddEntry(h_sig2, "Signal 2 (Gaussian)", "f");  // "f" означає показати Fill style (штриховку)
    leg->AddEntry(h_sig1, "Signal 1 (Gaussian)", "f");
    leg->AddEntry(h_bg, "Background (Exp)", "f");
    leg->SetBorderSize(1); // Додаємо рамку
    leg->Draw();

    // --- ЗБЕРЕЖЕННЯ ---
    // Зберігаємо у картинку та PDF (зручно для GitHub)
    c1->SaveAs("my_distributions.png");
    c1->SaveAs("my_distributions.pdf");
}
