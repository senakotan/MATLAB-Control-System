%% Uygulama1
clear; clc;                              % Değişkenleri ve komut penceresini temizler

b = input('Bir Sayı Giriniz=');           % Kullanıcıdan sayı alır

a = 5/3;                                  % a değişkenine 5/3 değerini atar

x = a + 2*b - (b/6*4);                    % Verilen matematiksel ifadeyi hesaplar

t = -2:0.5:4;                             % -2 ile 4 arasında 0.5 adımlı vektör oluşturur

z = 'W';                                  % Karakter değişkeni tanımlar
Adi = 'FSMVU';                            % String (karakter dizisi) tanımlar

disp(x);                                  % x değerini ekrana yazdırır
disp(t);                                  % t vektörünü ekrana yazdırır

fprintf('Çıktılar=%f %c %s %d \n',t(13),z,Adi,x);

%% Uygulama2
clear; clc;                         % Workspace'teki tüm değişkenleri temizler, komut penceresini temizler

A = [3 5 sqrt(49)];                  % 1x3 satır vektörü oluşturur: [3 5 7] (sqrt(49)=7)

B = [5; 6; exp(-A(2))];              % 3x1 sütun vektörü: [5; 6; exp(-5)] (A(2)=5)

C = [1 2; 3 -4];                     % 2x2 matris tanımlar

D = A + B';                          % B' ile B transpozu (1x3) yapılır ve A (1x3) ile eleman bazlı toplanır                                    % B' = [5 6 exp(-5)]

T = C * inv(C);                      % C ile tersinin çarpımı; teorik olarak birim matris (I) verir

X = A' .* B;                         % A' (3x1) ile B (3x1) eleman bazlı çarpılır (.*), sonuç 3x1

Y = power(A, 2);                     % A'nın her elemanının karesini alır (A.^2 ile aynı sonuç)

W = C(:, 1);                         % C matrisinin 1. sütununu alır (tüm satırlar, 1. sütun) => 2x1 vektör

disp(det(C));                        % C'nin determinantını hesaplar ve ekrana yazar

size(C)                              % C'nin boyutunu (satır, sütun) komut penceresinde gösterir

disp(A);                             % A vektörünü ekrana basar
disp(B);                             % B vektörünü ekrana basar
disp(C);                             % C matrisini ekrana basar
disp(D);                             % D vektörünü ekrana basar
disp(W);                             % W vektörünü ekrana basar
disp(X);                             % X vektörünü ekrana basar
disp(T);                             % T matrisini ekrana basar

sort(B)                              % B'yi küçükten büyüğe sıralar ve sonucu yazdırır (değişkene atanmadı)

max(C)                               % C'nin her sütunundaki maksimumu döndürür (1x2), sonucu yazdırır

fprintf('Çıktılar=%d %f %d %f \n', ...
    C(2,1), ...                      % C'nin (2,1) elemanı (2. satır, 1. sütun)
    sum(A), ...                      % A elemanlarının toplamı
    min(W), ...                      % W elemanlarının minimumu
    mean(A));                        % A elemanlarının aritmetik ortalaması



%% Uygulama3
% f(s)=s^3+3s^2+3s-4 ve p(s)=s^2+3s-2 polinomlari;

clear; clc;                  % Değişkenleri temizler, komut penceresini temizler

f = [1 3 3 -4];              % f(s) polinomunun katsayı vektörü (3. dereceden)
p = [1 3 -2];                % p(s) polinomunun katsayı vektörü (2. dereceden)

k = polyder(f);              % f polinomunun türevini alır (katsayı vektörü olarak)
m = polyder(p);              % p polinomunun türevini alır

kokler = roots(f);           % f polinomunun köklerini (çözüm değerlerini) hesaplar

y = polyval(p, [-1:0.5:1]);  % p polinomunu -1 ile 1 aralığında 0.5 adımlarla hesaplar

disp(k);                     % f'nin türev katsayılarını ekrana yazdırır
disp(m);                     % p'nin türev katsayılarını ekrana yazdırır
disp(kokler);                % f'nin köklerini ekrana yazdırır
disp(y);                     % p'nin belirtilen noktalardaki değerlerini yazdırır


%% Uygulama4
clc;
clear;

for i = 2:100                % 2'den 100'e kadar sayıları tek tek kontrol eder
    for j = 2:100            % Her i için 2'den 100'e kadar bölen arar
        
        if (~mod(i,j))       % i sayısı j'ye tam bölünüyorsa (mod(i,j)=0)
            break;           % İç döngüyü kır (bölen bulundu)
        end
        
    end
    
    if (j > (i/j))           % Eğer j, i'nin karekökünden büyükse (asal kontrolü)
        fprintf('%d asal sayı\n', i);  % i sayısını asal olarak yazdır
    end
    
end


% While Döngüsü
fprintf("\n")

a = 10;                      % a değişkenini 10 olarak başlatır

while a < 12                 % a 12'den küçük olduğu sürece döngü çalışır
    
    if a == 5                % Eğer a 5'e eşitse
        a = a + 1;           % a'yı 1 artır
        continue;            % Döngünün başına dön (alt satırları atla)
    end
    
    fprintf('a değeri: %d\n', a);  % a değerini ekrana yazdır
    
    a = a + 1;               % a'yı 1 artır
    
end
%% Uygulama5
% if-elseif-else yapısı

clear; clc;                          % Değişkenleri temizler, komut penceresini temizler

x = input('x=');                    % Kullanıcıdan x değerini alır
y = input('y=');                     % Kullanıcıdan y değerini alır

if x >= 0 & y >= 0                   % x ≥ 0 ve y ≥ 0 ise
    f = x + log(y);                  % f = x + ln(y) (doğal logaritma)
    
elseif x >= 0 & y < 0                % x ≥ 0 ve y < 0 ise
    f = log10(x) + 1/y;              % f = log10(x) + 1/y
    
elseif x < 0 & y >= 0                % x < 0 ve y ≥ 0 ise
    f = sin(2*pi + 1/x + y);         % f = sin(2π + 1/x + y)
    
else                                 % Yukarıdaki durumların hiçbiri değilse (x < 0 ve y < 0)
    f = 1/x + 1/y;                   % f = 1/x + 1/y
    
end   % Koşul yapısının sonu

disp(f)
%% Uygulama6 grafik

clear; clc;                              % Değişkenleri temizler, komut penceresini temizler

t = 0:0.1:5;                              % 0 ile 5 arasında 0.1 adımlı zaman vektörü oluşturur

y1 = 1 - exp(-2*t).*cos(5*t);              % sönümlü kosinüs tabanlı fonksiyon (eleman bazlı çarpım .* )
y2 = sin(2*pi*t - pi/4);                   % faz kaymalı sinüs fonksiyonu

subplot(221);                              % 2x2 grafik alanının 1. bölgesini aktif eder
plot(t, y1, 'r')                           % y1 fonksiyonunu kırmızı (r) çizgi ile çizer
grid on                                    % Izgara çizgilerini açar
xlabel('zaman -saniye')                    % x ekseni etiketi
ylabel('çıkış')                            % y ekseni etiketi
title('iki boyutlu grafik')                % Grafik başlığı

subplot(222);                              % 2x2 grafik alanının 2. bölgesini aktif eder
plot(t, y1, 'r--', t, y2, 'k')              % y1'i kırmızı kesik çizgi, y2'yi siyah düz çizgi ile çizer

a = [10 20 40 30];                         % Pasta grafiği için veri vektörü

figure(2);                                 % 2 numaralı yeni figür penceresi açar
pie(a, {'Ali','Veli','Can','Osman'})        % Pasta grafiği oluşturur ve etiketleri atar

x = 0:10;                                  % 0'dan 10'a kadar vektör oluşturur
y = 0:10;                                  % 0'dan 10'a kadar ikinci vektör oluşturur
z = x' * y;                                % x sütun vektörü ile y satır vektörünün çarpımı (10x10 matris)

figure(3);                                 % 3 numaralı yeni figür penceresi açar
mesh(x, y, z);                             % 3 boyutlu yüzey (mesh) grafiği çizer


