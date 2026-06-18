%% BLOK DİYAGRAMI İNDİRGEME VE ANALİZ
clc;        % Komut penceresini temizler
clear;      % Çalışma alanındaki (workspace) tüm değişkenleri siler
close all;  % Açık olan tüm grafik pencerelerini kapatır

% 1. Adım: Laplace değişkeni 's' tanımlanır. 
% Bu sayede transfer fonksiyonlarını doğrudan matematiksel formda yazabiliriz.
s = tf('s');

% 2. Adım: Blokların Tanımlanması
% Görseldeki her bir kutucuğu ayrı birer transfer fonksiyonu (TF) olarak tanımlıyoruz.

G1 = s / ((s^2 + 1) * (s + 2));       % İlk ileri yol bloğu
H1 = (s + 1) / ((s + 1) * (s + 1));  % Sol taraftaki ilk geri besleme bloğu
G2 = 1 / s;                          % İkinci toplama noktasından sonraki integratör
H2 = 25;                             % Sağdaki sabit geri besleme bloğu
H3 = s / (s^2 + 5);                  % En alttaki ana geri besleme bloğu

% 3. Adım: Blok Diyagramı İndirgeme (Adım Adım)

% A. Sol taraftaki G1 ve H1 arasındaki iç döngüyü çözelim.
% feedback(ileri_yol, geri_besleme, işaret) -> -1 negatif geri besleme demektir.
L1 = feedback(G1, H1, -1); 

% B. Sağ taraftaki G2 ve 25 (H2) arasındaki iç döngüyü çözelim.
L2 = feedback(G2, H2, -1);

% C. Bu iki iç döngü birbirine seri bağlı olduğu için çarparak 
% "Forward Path" (İleri Yol) toplam transfer fonksiyonunu buluyoruz.
G_forward = L1 * L2;

% D. Son olarak, tüm bu yapıyı en dıştaki H3 geri beslemesi ile kapatıyoruz.
% Bu bize sistemin tamamının "Kapalı Çevrim Transfer Fonksiyonunu" verir.
T = feedback(G_forward, H3, -1);

% 4. Adım: Sonuçların Gösterilmesi

fprintf('--- Kapalı Çevrim Transfer Fonksiyonu T(s) ---\n');
% minreal: Pay ve paydadaki birbirini yok eden (sadeleşen) terimleri temizler.
T_sade = minreal(T); 
disp(T_sade);

% Sistemdeki Sıfır Noktaları (Payı sıfır yapan değerler)
fprintf('Sıfır Noktaları (Zeros):\n');
z = zero(T_sade);
disp(z);

% Sistemdeki Kutup Noktaları (Paydayı sıfır yapan değerler - Kararlılık için kritiktir)
fprintf('Kutup Noktaları (Poles):\n');
p = pole(T_sade);
disp(p);

% 5. Adım: Görselleştirme
% Karmaşık düzlemde (s-düzlemi) kutup ve sıfırların yerini gösterir.
figure;
pzmap(T_sade); 
grid on; % Izgara ekleyerek değerlerin okunmasını kolaylaştırır
title('S-Düzleminde Kutup (x) ve Sıfır (o) Noktaları');

%% Temize cekilmis hali 
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


%% SORU 2: SİSTEM YANITLARI ANALİZİ
clc; clear; close all;

% 1. Transfer Fonksiyonunun Tanımlanması
% G(s) = (7s + 45) / (s^2 + 12s + 32)
num = [7 45];          % Pay katsayıları
den = [1 12 32];       % Payda katsayıları
G = tf(num, den);      % Transfer fonksiyonunu oluştur

% Zaman vektörü (0'dan 10 saniyeye kadar analiz edelim)
t = 0:0.01:10;

% 2. Giriş Yanıtlarının Hesaplanması

% a) Birim Dürtü (Impulse) Yanıtı
[y_impulse, t_imp] = impulse(G, t);

% b) Birim Basamak (Step) Yanıtı
[y_step, t_step] = step(G, t);

% c) Birim Rampa (Ramp) Yanıtı
% Rampa girişi 1/s^2'dir, bu da birim basamağın integrali demektir.
u_ramp = t; 
y_ramp = lsim(G, u_ramp, t);

% d) Birim Parabol (Parabolic) Yanıtı
% Parabol girişi (1/2)*t^2'dir (Laplace karşılığı 1/s^3).
u_parabolic = 0.5 * t.^2;
y_parabolic = lsim(G, u_parabolic, t);

% e) (1 + t)u(t) Giriş Yanıtı
% Bu giriş aslında Birim Basamak + Birim Rampa demektir.
u_custom = 1 + t;
y_custom = lsim(G, u_custom, t);

% 3. Sonuçların Görselleştirilmesi
figure('Name', 'Sistem Giriş Yanıtları');

% Dürtü Yanıtı
subplot(3, 2, 1);
plot(t_imp, y_impulse, 'LineWidth', 1.5);
title('Birim Dürtü (Impulse) Yanıtı'); grid on;

% Basamak Yanıtı
subplot(3, 2, 2);
plot(t_step, y_step, 'LineWidth', 1.5);
title('Birim Basamak (Step) Yanıtı'); grid on;

% Rampa Yanıtı
subplot(3, 2, 3);
plot(t, y_ramp, 'LineWidth', 1.5);
title('Birim Rampa Yanıtı'); grid on;

% Parabol Yanıtı
subplot(3, 2, 4);
plot(t, y_parabolic, 'LineWidth', 1.5);
title('Birim Parabol Yanıtı'); grid on;

% (1+t)u(t) Yanıtı
subplot(3, 2, 5);
plot(t, y_custom, 'LineWidth', 1.5, 'Color', 'r');
title('(1+t)u(t) Giriş Yanıtı'); grid on;

% Tüm grafiklerin düzeni
sgtitle('G(s) = (7s + 45) / (s^2 + 12s + 32) Sistem Yanıtları');

%% temize cekilmis hali 
clc; clear; close all;

num = [7 45];          
den = [1 12 32];       
G = tf(num, den);      

t = 0:0.01:10;

[y_impulse, t_imp] = impulse(G, t);

[y_step, t_step] = step(G, t);

u_ramp = t; 
y_ramp = lsim(G, u_ramp, t);

u_parabolic = 0.5 * t.^2;
y_parabolic = lsim(G, u_parabolic, t);

u_custom = 1 + t;
y_custom = lsim(G, u_custom, t);

figure('Name', 'Sistem Giriş Yanıtları');

subplot(3, 2, 1);
plot(t_imp, y_impulse, 'LineWidth', 1.5);
title('Birim Dürtü (Impulse) Yanıtı'); grid on;

subplot(3, 2, 2);
plot(t_step, y_step, 'LineWidth', 1.5);
title('Birim Basamak (Step) Yanıtı'); grid on;

subplot(3, 2, 3);
plot(t, y_ramp, 'LineWidth', 1.5);
title('Birim Rampa Yanıtı'); grid on;

subplot(3, 2, 4);
plot(t, y_parabolic, 'LineWidth', 1.5);
title('Birim Parabol Yanıtı'); grid on;

subplot(3, 2, 5);
plot(t, y_custom, 'LineWidth', 1.5, 'Color', 'r');
title('(1+t)u(t) Giriş Yanıtı'); grid on;

sgtitle('G(s) = (7s + 45) / (s^2 + 12s + 32) Sistem Yanıtları')


%% SORU 2 DENEYDEKI CEVAP 
clc;                
clear;             
close all;          

% Transfer fonksiyonunu tanımla
num = [7 45];       % Transfer fonksiyonunun pay katsayıları
den = [1 12 32];    % Transfer fonksiyonunun payda katsayıları
G = tf(num, den);   % Pay ve payda kullanılarak transfer fonksiyonu oluşturulur

% Zaman vektörü
t = 0:0.01:10;      % 0 ile 10 saniye arasında 0.01 adımlı zaman dizisi oluşturulur

% 1) Birim dürtü yanıtı
figure;             % Yeni bir grafik penceresi açar
impulse(G, t);      % Sistemin birim dürtü girişine verdiği yanıtı çizer
grid on;            % Grafiğe ızgara ekler
title('Birim Durtu Yaniti');  % Grafik başlığı
xlabel('t (s)');              % x ekseni etiketi
ylabel('y(t)');               % y ekseni etiketi

% 2) Birim basamak yanıtı
figure;             % Yeni bir grafik penceresi açar
step(G, t);         % Sistemin birim basamak girişine verdiği yanıtı çizer
grid on;            % Izgara ekler
title('Birim Basamak Yaniti');% Grafik başlığı
xlabel('t (s)');              % x ekseni etiketi
ylabel('y(t)');               % y ekseni etiketi

% 3) Birim rampa yanıtı
% Birim rampa: r(t) = t*u(t)
r_rampa = t;                     % rampa giriş sinyali oluşturulur
y_rampa = lsim(G, r_rampa, t);   % lsim ile sistemin rampa girişine verdiği yanıt hesaplanır

figure;                          % Yeni grafik penceresi açılır
plot(t, y_rampa, 'LineWidth', 1.5); % Rampa yanıtı çizilir
grid on;                         % Izgara eklenir
title('Birim Rampa Yaniti');     % Grafik başlığı
xlabel('t (s)');                 % x ekseni etiketi
ylabel('y(t)');                  % y ekseni etiketi

% 4) Birim parabol yanıtı
% Birim parabol: r(t) = (t^2/2)*u(t)
r_parabol = (t.^2)/2;                 % Parabol giriş sinyali oluşturulur
y_parabol = lsim(G, r_parabol, t);    % Sistem çıkışı hesaplanır

figure;                               % Yeni grafik penceresi açılır
plot(t, y_parabol, 'LineWidth', 1.5); % Parabol yanıtı çizilir
grid on;                              % Izgara eklenir
title('Birim Parabol Yaniti');        % Grafik başlığı
xlabel('t (s)');                      % x ekseni etiketi
ylabel('y(t)');                       % y ekseni etiketi

%5) (1+t)u(t) giriş yanıtı
% Giriş: r(t) = (1+t)u(t)
r_ozel = 1 + t;                     % (1+t) şeklinde özel giriş sinyali oluşturulur
y_ozel = lsim(G, r_ozel, t);        % Sistem çıkışı hesaplanır

figure;                             % Yeni grafik penceresi açılır
plot(t, y_ozel, 'LineWidth', 1.5);  % Sistem çıkışı çizilir
grid on;                            % Izgara eklenir
title('(1+t)u(t) Giris Yaniti');    % Grafik başlığı
xlabel('t (s)');                    % x ekseni etiketi
ylabel('y(t)');                     % y ekseni etiketi

%%  SORU 3: SİNÜS DALGASI GİRİŞ CEVABI
clc; clear; close all;

% 1. Transfer Fonksiyonunun Tanımlanması
% G(s) = (s + 15) / (s^3 + 5s^2 + 12s + 32)
num = [1 15];              % Pay katsayıları
den = [1 5 12 32];         % Payda katsayıları
G = tf(num, den);          % Transfer fonksiyonunu oluştur

% 2. Sinüs Dalgası Girişinin Oluşturulması (gensig kullanımı)
% gensig(type, period, duration, sampling_interval)
% type: 'sin' (sinüs), 'square' (kare), 'pulse' (darbe)
period = 5;                % Sinüs dalgasının periyodu (saniye)
duration = 20;             % Simülasyonun toplam süresi (saniye)
dt = 0.01;                 % Örnekleme zaman aralığı

[u, t] = gensig('sin', period, duration, dt);

% 3. Sistemin Yanıtının Hesaplanması (lsim kullanımı)
% lsim: Doğrusal sistemlerin verilen herhangi bir girişe tepkisini hesaplar.
[y, t] = lsim(G, u, t);

% 4. Sonuçların Görselleştirilmesi
figure;
plot(t, u, 'r--', 'LineWidth', 1); hold on; % Giriş sinyali (kesikli kırmızı)
plot(t, y, 'b', 'LineWidth', 1.5);         % Çıkış sinyali (düz mavi)

grid on;
title('Sistemin Sinüs Dalgası Girişine Tepkisi');
xlabel('Zaman (s)');
ylabel('Genlik');
legend('Giriş Sinyali (u)', 'Çıkış Sinyali (y)');

%% SORU 3 lab 
clc;               
clear;            
close all;          
% Transfer fonksiyonu tanimlanır
num = [1 15];       % Transfer fonksiyonunun pay katsayıları
den = [1 5 12 32];  % Transfer fonksiyonunun payda katsayıları
G = tf(num, den);   % Pay ve payda kullanılarak sistem transfer fonksiyonu oluşturulur

% Zaman vektoru
t = 0:0.01:20;      % 0 ile 20 saniye arasında 0.01 adımlı zaman dizisi oluşturulur

% 1) lsim kullanarak sinus giris cevabi
% Giris sinyali x(t) = sin(t)
x1 = sin(t);        % Sinüs giriş sinyali oluşturulur

% Sistemin cevabini hesapla
y1 = lsim(G, x1, t); % lsim komutu ile sistemin bu girişe verdiği çıkış hesaplanır

% Grafigi ciz
figure;                               % Yeni grafik penceresi açar
plot(t, x1, '--', 'LineWidth', 1.2);  % Giriş sinyali kesikli çizgi ile çizilir
hold on;                              % Aynı grafikte başka eğrilerin çizilmesine izin verir
plot(t, y1, 'LineWidth', 1.5);        % Sistem çıkışı çizilir
grid on;                              % Grafiğe ızgara ekler
title('lsim ile Sinus Giris Cevabi'); % Grafik başlığı
xlabel('t (s)');                      % x ekseni etiketi
ylabel('Genlik');                     % y ekseni etiketi
legend('Giris: sin(t)', 'Cikis: y(t)'); % Grafik açıklaması

% 2) gensig kullanarak sinus benzeri periyodik giris olusturma
% gensig ile sinyali olusturulur
% 'sin' -> sinus sinyali
% 2*pi -> periyot, yani w = 1 rad/s olur
% 20 -> toplam sure
% 0.01 -> ornekleme araligi
[x2, t2] = gensig('sin', 2*pi, 20, 0.01); % gensig komutu ile sinüs sinyali ve zaman vektörü oluşturulur

% Sistemin cevabini hesapla
y2 = lsim(G, x2, t2);   % Sistem bu giriş sinyali ile simüle edilir ve çıkış hesaplanır

% Grafigi ciz
figure;                               % Yeni grafik penceresi açar
plot(t2, x2, '--', 'LineWidth', 1.2); % Giriş sinyali kesikli çizgi ile çizilir
hold on;                              % Aynı grafikte ikinci eğri çizileceği için tutulur
plot(t2, y2, 'LineWidth', 1.5);       % Sistem çıkışı çizilir
grid on;                              % Izgara eklenir
title('gensig + lsim ile Sinus Giris Cevabi'); % Grafik başlığı
xlabel('t (s)');                      % x ekseni etiketi
ylabel('Genlik');                     % y ekseni etiketi
legend('Giris', 'Cikis');             % Grafik açıklaması

% 3) Karsilastirma grafigi
figure;                               % Yeni grafik penceresi açar
plot(t, y1, 'LineWidth', 1.5);        % lsim ile elde edilen çıkış çizilir
hold on;                              % Aynı grafikte ikinci eğri çizileceği için tutulur
plot(t2, y2, '--', 'LineWidth', 1.5); % gensig ile elde edilen çıkış kesikli çizgi ile çizilir
grid on;                              % Izgara eklenir
title('lsim ve gensig Sonuclarinin Karsilastirilmasi'); % Grafik başlığı
xlabel('t (s)');                      % x ekseni etiketi
ylabel('y(t)');                       % y ekseni etiketi
legend('lsim sonucu', 'gensig sonucu'); % İki yöntemin sonuçlarını gösteren açıklama
