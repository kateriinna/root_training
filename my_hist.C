void my_hist() {
    // 1. Створюємо "полотно" (canvas), на якому будемо малювати
    TCanvas *c1 = new TCanvas("c1", "My Canvas", 800, 600);

    // 2. Створюємо саму 1D гістограму (TH1F)
    // Параметри: внутрішнє ім'я, "Заголовок;Назва осі X;Назва осі Y", кількість кошиків (bins), мін. X, макс. X
    TH1F *hist = new TH1F("hist", "My First ROOT Histogram;X axis;Number of events", 100, -5, 5);

    // 3. Заповнюємо гістограму випадковими числами (наприклад, 10 000 разів)
    // gRandom->Gaus(0, 1) генерує числа за нормальним розподілом
    for (int i = 0; i < 10000; i++) {
        hist->Fill(gRandom->Gaus(0, 1));
    }

    // 4. Налаштовуємо колір (наприклад, світло-синій) і малюємо її
    hist->SetFillColor(kBlue-9);
    hist->Draw();

    // 5. Зберігаємо результат як картинку (png) у твою папку
    c1->SaveAs("my_histogram.png");
}
