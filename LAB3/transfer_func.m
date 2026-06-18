%% SORU 1
clc;
clear;
close all;

s = tf('s');

G1 = s / ((s^2 + 1) * (s + 2));
H1 = (s + 1) / ((s + 1) * (s + 1));
G2 = 1 / s;
H2 = 25;
H3 = s / (s^2 + 5);

L1 = feedback(G1, H1, -1); 
L2 = feedback(G2, H2, -1);
G_forward = L1 * L2;
T = feedback(G_forward, H3, -1);

fprintf('--- Kapalı Çevrim Transfer Fonksiyonu T(s) ---\n');
T_sade = minreal(T); 
disp(T_sade);

fprintf('Sıfır Noktaları (Zeros):\n');
z = zero(T_sade);
disp(z);

fprintf('Kutup Noktaları (Poles):\n');
p = pole(T_sade);
disp(p);

figure;
pzmap(T_sade); 
grid on;
title('S-Düzleminde Kutup (x) ve Sıfır (o) Noktaları');

%% SORU 2
clc;
clear;
close all;

num = [7, 45];
den = [1, 12, 32];
G = tf(num, den); % 'gen' değil 'den' olmalı

t = 0:0.1:10;

% Rampa Yanıtı (Değişken ismini y_rampa olarak güncelledim)
r_ramp = t;
y_rampa = lsim(G, r_ramp, t); 

% Birim parabol
r_parabol = (t.^2)/2;                 
y_parabol = lsim(G, r_parabol, t);    

% (1+t)u(t) giriş yanıtı
r_ozel = 1 + t;                     
y_ozel = lsim(G, r_ozel, t);     

% Tüm girişleri ve yanıtları aynı pencerede göster
figure;                             
subplot(3,2,1);                     
step(G, t);                         
grid on;
title('Basamak');

subplot(3,2,2);                     
plot(t, y_rampa, 'LineWidth', 1.5); % Yukarıdakiyle aynı isim (y_rampa)
grid on;
title('Rampa');

subplot(3,2,3);                     
plot(t, y_parabol, 'LineWidth', 1.5); 
grid on;
title('Parabol');

subplot(3,2,4);                     
plot(t, y_ozel, 'LineWidth', 1.5);  
grid on;
title('(1+t)u(t)');

subplot(3,2,5);
impulse(G,t);
grid on;
title('İmpulse cevabı');


%% SORU 3 
% lsim ve gensig kullanımı

clc; clear; close all;

% 1. Sistem Tanımı
num = [1, 15];
den = [1, 5, 12, 32];
G = tf(num, den);

% 2. Zaman Vektörünün Tanımlanması
dt = 0.01;           % Örnekleme adımı
t_son = 20;          % Simülasyon süresi
t = 0:dt:t_son;      % Zaman vektörü

% 3. Giriş Sinyali Oluşturma
% gensig kullanırken zaman vektörünü (t) dışarıdan verebiliriz
periyot = 5;
u = gensig('sin', periyot, t_son, dt); 

% 4. Simülasyon ve Çizim
y = lsim(G, u, t);

figure;
plot(t, u);hold on;
plot(t, y);
grid on;
legend('Giriş (Sinüs)', 'Sistem Çıkışı');
xlabel('Zaman (s)'); ylabel('Genlik');
title('Soru 3: Sinüs Dalga Giriş Cevabı');
