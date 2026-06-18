%% SORU 1
clc;               
clear;             
close all;          

s = tf('s');        % Laplace değişkeni s kullanılarak transfer fonksiyonu tanımlama

G1 = s / ((s^2 + 1)*(s + 2));    % İleri yol transfer fonksiyonu G1
H1 = (s + 1) / ((s + 1)*(s + 1)); % İlk geri besleme bloğu (basitleşirse 1/(s+1))
H2 = s / (s^2 + 5);               % Alt geri besleme kolundaki transfer fonksiyonu

G2 = 1/s;        % İkinci toplama noktasından sonra bulunan integratör bloğu
H3 = 25;         % Sağ taraftaki sabit geri besleme kazancı

% İkinci toplama noktası + integratörün kapalı çevrimi
Ginner = feedback(G2, H3);   % G2 ileri yol, H3 negatif geri besleme olacak şekilde iç kapalı çevrim oluşturulur

% İlk toplama noktasındaki toplam geri besleme
Heq = H1 + H2*Ginner;        % İki geri besleme kolu eşdeğer tek geri besleme olarak birleştirilir

% Tüm sistemin kapalı çevrimi
T = feedback(G1*Ginner, Heq); % İleri yol (G1*Ginner) ile eşdeğer geri besleme Heq kullanılarak sistem kapatılır

disp('Kapali cevrim transfer fonksiyonu T(s) = Y(s)/X(s):');
minreal(T)                   % Transfer fonksiyonunu sadeleştirerek ekrana yazdırır

disp('Sifirlar:');
z = zero(T)                  % Sistem sıfırlarını hesaplar

disp('Kutuplar:');
p = pole(T)                  % Sistem kutuplarını hesaplar

figure;                      % Yeni bir grafik penceresi açar
pzmap(T);                    % Kutup-sıfır diyagramını çizer
grid on;                     % Grafiğe ızgara ekler
title('Kapali Cevrim Kutup-Sifir Diyagrami'); % Grafiğin başlığını yazdırır



%% SORU 2
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

% İstenirse tüm girişleri ve yanıtları aynı pencerede görmek için
figure;                             % Yeni grafik penceresi açılır

subplot(2,2,1);                     % 2x2 grafik alanının 1. kısmı
step(G, t);                         % Basamak yanıtı çizilir
grid on;
title('Basamak');

subplot(2,2,2);                     % 2x2 grafik alanının 2. kısmı
plot(t, y_rampa, 'LineWidth', 1.5); % Rampa yanıtı çizilir
grid on;
title('Rampa');

subplot(2,2,3);                     % 2x2 grafik alanının 3. kısmı
plot(t, y_parabol, 'LineWidth', 1.5); % Parabol yanıtı çizilir
grid on;
title('Parabol');

subplot(2,2,4);                     % 2x2 grafik alanının 4. kısmı
plot(t, y_ozel, 'LineWidth', 1.5);  % (1+t) girişinin yanıtı çizilir
grid on;
title('(1+t)u(t)');

%% SORU 3
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


%% Hocanın Sorduğu Soru

s = tf('s');

G1 = s/(s+2);                       
H1 = (s+1)/((s+1)*(s+1));           
H2 = s/(s^2 + 25);                  
G2 = 1/(s+1);                       
H3 = 25;                            

% ilk geri besleme
K = (1/G2) + H3;    

% tüm kapalı çevrim
T = 1 / ( K/G1 + H1*K + H2 );

disp('Transfer Function T(s) = Y(s)/X(s)')
T

z = zero(T)
p = pole(T)

figure
pzmap(T)
grid on
title('Pole-Zero Map')

