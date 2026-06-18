%% UYGULAMA 3

% Devre parametrelerini tanımladım (1k Ohm ve 1 µF).
R1 = 1000; 
C1 = 1e-6; 

% İstenen frekans aralığına göre açısal frekans (w) vektörünü oluşturdum.
w = 0:0.1:1000;  

% RC alçak geçiren filtre için transfer fonksiyonunu (H) hesapladım.
H = 1 ./ (1 + 1j .* w .* R1 .* C1);

% H'nin genliğini ve fazını bulup, fazı dereceye çevirdim.
genlik = abs(H);      
faz_radyan = angle(H); 
faz_derece = faz_radyan * (180/pi); 

% Genlik ve faz grafiklerini tek bir pencerede alt alta çizdirdim.
figure; 

subplot(2, 1, 1); 
plot(w, genlik, 'b', 'LineWidth', 1.5);
title('RC Filtresi Genlik Yanıtı');
xlabel('Frekans \omega (rad/s)');
ylabel('|H| (Genlik)');
grid on; 

subplot(2, 1, 2); 
plot(w, faz_derece, 'r', 'LineWidth', 1.5);
title('RC Filtresi Faz Yanıtı');
xlabel('Frekans \omega (rad/s)');
ylabel('\angleH (Derece)');
grid on;




%% UYGULAMA 4

% Devre parametrelerini tanımladım (10k Ohm, 10 H ve 10 nF).
R1 = 10000; 
L1 = 10;    
C1 = 10e-9; 

% İstenen frekans aralığına göre açısal frekans (w) vektörünü oluşturdum.
w = 0:0.01:1000; 

% Rezonans frekansını (w0) ve bant genişliğini (BW) hesapladım.
w0 = 1 / sqrt(L1 * C1);
BW = R1 / L1;

% RLC devresi için transfer fonksiyonunu (H) hesapladım.
H = (1j .* w .* R1 .* C1) ./ (1 - (w.^2 .* L1 .* C1) + (1j .* w .* R1 .* C1));

% H'nin genliğini ve fazını bulup, çizim için fazı dereceye çevirdim.
genlik = abs(H);      
faz_radyan = angle(H); 
faz_derece = faz_radyan * (180/pi); 

% Genlik ve faz grafiklerini tek bir pencerede alt alta çizdirdim.
figure; 

subplot(2, 1, 1); 
plot(w, genlik, 'b', 'LineWidth', 1.5);
title('RLC Bant Geçiren Filtre Genlik Yanıtı');
xlabel('Frekans \omega (rad/s)');
ylabel('|H| (Genlik)');
grid on;

subplot(2, 1, 2); 
plot(w, faz_derece, 'r', 'LineWidth', 1.5);
title('RLC Bant Geçiren Filtre Faz Yanıtı');
xlabel('Frekans \omega (rad/s)');
ylabel('\angleH (Derece)');
grid on;


