%% SORU 1                     

clear; clc; close all;          

t = linspace(0,5,2000);          % 0 ile 5 saniye arasında 2000 noktalı zaman vektörü oluşturulur

f = 10*exp(-5*t);                % f(t)=10e^(-5t) üstel azalan fonksiyon tanımlanır
x = 1 - exp(-10*t);              % x(t)=1-e^(-10t) asimptotik olarak 1'e yaklaşan fonksiyon
y = exp(-4*t).*sin(10*t);        % y(t)=e^(-4t)sin(10t) sönümlü sinüs fonksiyonu
u = exp(-5*t) + t.*exp(-4*t);    % u(t)=e^(-5t)+t e^(-4t) birleşik üstel fonksiyon

figure;                          % Yeni grafik penceresi açılır

subplot(2,2,1); plot(t,f); grid on; title('f(t)=10e^{-5t}'); xlabel('t'); ylabel('f(t)');  % f(t) grafiği çizdirilir
subplot(2,2,2); plot(t,x); grid on; title('x(t)=1-e^{-10t}'); xlabel('t'); ylabel('x(t)'); % x(t) grafiği çizdirilir
subplot(2,2,3); plot(t,y); grid on; title('y(t)=e^{-4t}sin(10t)'); xlabel('t'); ylabel('y(t)'); % y(t) grafiği çizdirilir
subplot(2,2,4); plot(t,u); grid on; title('u(t)=e^{-5t}+t e^{-4t}'); xlabel('t'); ylabel('u(t)'); % u(t) grafiği çizdirilir
set(gcf,'Color','white');


%% SORU 2 

clear; clc; close all;                     
t = linspace(0,5,2000);                     % 0-5 saniye aralığında 2000 noktalı zaman vektörü oluşturulur

x_step = ones(size(t));                     % Birim basamak (step) sinyali oluşturulur
x_ramp = t;                                 % Ramp sinyali (x=t) tanımlanır
x3 = 2*exp(-3*t);                           % x3(t)=2e^{-3t} üstel azalan sinyal tanımlanır
x4 = cos(5*t);                              % x4(t)=cos(5t) kosinüs sinyali tanımlanır

% sistemler:                                % Üç farklı statik (hafızasız) sistem tanımlanacak
% a) y = e^{-2t} x                          % Sistem (a): giriş sinyali e^{-2t} ile çarpılır
ya_step = exp(-2*t).*x_step;                % Step girişinin sistem (a) çıktısı
ya_ramp = exp(-2*t).*x_ramp;                % Ramp girişinin sistem (a) çıktısı
ya_x3   = exp(-2*t).*x3;                    % x3 girişinin sistem (a) çıktısı
ya_x4   = exp(-2*t).*x4;                    % x4 girişinin sistem (a) çıktısı

% b) y = 2t x                               % Sistem (b): giriş sinyali 2t ile çarpılır
yb_step = (2*t).*x_step;                    % Step girişinin sistem (b) çıktısı
yb_ramp = (2*t).*x_ramp;                    % Ramp girişinin sistem (b) çıktısı
yb_x3   = (2*t).*x3;                        % x3 girişinin sistem (b) çıktısı
yb_x4   = (2*t).*x4;                        % x4 girişinin sistem (b) çıktısı

% c) y = sin(10t) x                         % Sistem (c): giriş sinyali sin(10t) ile çarpılır
yc_step = sin(10*t).*x_step;                % Step girişinin sistem (c) çıktısı
yc_ramp = sin(10*t).*x_ramp;                % Ramp girişinin sistem (c) çıktısı
yc_x3   = sin(10*t).*x3;                    % x3 girişinin sistem (c) çıktısı
yc_x4   = sin(10*t).*x4;                    % x4 girişinin sistem (c) çıktısı

% çizimler                                  % Grafik çizim bölümü başlıyor
figure('Name','Soru 2 - Statik Sistemler','Color','white');
titles = {'Step','Ramp','2e^{-3t}','cos(5t)'}; % Grafik başlıkları için hücre dizisi oluşturulur

Y_A = {ya_step, ya_ramp, ya_x3, ya_x4};     % Sistem (a) çıktıları hücre dizisine atanır
Y_B = {yb_step, yb_ramp, yb_x3, yb_x4};     % Sistem (b) çıktıları hücre dizisine atanır
Y_C = {yc_step, yc_ramp, yc_x3, yc_x4};     % Sistem (c) çıktıları hücre dizisine atanır

for k=1:4    

    subplot(3,4,k);     plot(t,Y_A{k}); grid on; title(['(a) ',titles{k}]);  % Sistem (a) çıktısı çizilir
    subplot(3,4,k+4);   plot(t,Y_B{k}); grid on; title(['(b) ',titles{k}]);  % Sistem (b) çıktısı çizilir
    subplot(3,4,k+8);   plot(t,Y_C{k}); grid on; title(['(c) ',titles{k}]);  % Sistem (c) çıktısı çizilir
end                                           % Döngü sonlandırılır




%% SORU 3                                 
clear; clc; close all;                  

t = linspace(0,5,2000);                  % 0-5 saniye aralığında 2000 noktalı zaman vektörü oluşturulur
x_step = ones(size(t));                  % Birim basamak (step) giriş sinyali tanımlanır
x_ramp = t;                              % Ramp giriş sinyali (x=t) tanımlanır

% (3a) y = 10 * integral x               % Sistem (3a): giriş sinyalinin 10 katı integrali alınır
y3a_step = 10*t;                         % Step için 10*∫0^t 1 dτ = 10t sonucu yazılır
y3a_ramp = 5*t.^2;                       % Ramp için 10*∫0^t τ dτ = 5t² sonucu yazılır

% (3b) dy/dt + 2y = 10x, y(0)=0          % Birinci dereceden lineer diferansiyel denklem sistemi
y3b_step = 5*(1 - exp(-2*t));             % Step girişi için çözüm: y(t)=5(1-e^{-2t})
y3b_ramp = 5*t - 2.5 + 2.5*exp(-2*t);     % Ramp girişi için analitik çözüm yazılır

                                 % Yeni grafik penceresi açılır
figure('Color','white');    
subplot(2,2,1); plot(t,y3a_step); grid on; title('(3a) Step'); xlabel t; ylabel y   % (3a) Step çıktısı çizilir
subplot(2,2,2); plot(t,y3a_ramp); grid on; title('(3a) Ramp'); xlabel t; ylabel y   % (3a) Ramp çıktısı çizilir
subplot(2,2,3); plot(t,y3b_step); grid on; title('(3b) Step'); xlabel t; ylabel y   % (3b) Step çıktısı çizilir
subplot(2,2,4); plot(t,y3b_ramp); grid on; title('(3b) Ramp'); xlabel t; ylabel y   % (3b) Ramp çıktısı çizilir





%% SORU 4                                     

clear; clc; close all;                        

syms s t                                       % Laplace dönüşümü için sembolik s ve zaman değişkeni t tanımlanır
a_list = [1 2 4 10];                           % Sistem parametresi a için test edilecek değerler tanımlanır

figure('Name','Soru 4 - Step ve Ramp','Color','white');        % İsimlendirilmiş yeni grafik penceresi açılır

for i = 1:length(a_list)                       % a_list içindeki her değer için döngü başlatılır
    a = a_list(i);                             % Mevcut iterasyondaki a değeri atanır

    G = 4/(s^2 + a*s + 5);                     % Transfer fonksiyonu G(s)=4/(s^2 + a s + 5) tanımlanır

    Y_step_s = G*(1/s);                        % Step giriş (1/s) ile sistem çıkışı Laplace domaininde hesaplanır
    y_step_t = ilaplace(Y_step_s, s, t);       % Step çıkışı ters Laplace ile zaman domainine çevrilir

    Y_ramp_s = G*(1/s^2);                      % Ramp giriş (1/s^2) ile sistem çıkışı Laplace domaininde hesaplanır
    y_ramp_t = ilaplace(Y_ramp_s, s, t);       % Ramp çıkışı ters Laplace ile zaman domainine çevrilir

    tt = linspace(0,10,2000);                  % 0-10 saniye aralığında sayısal zaman vektörü oluşturulur
    y_step = double(subs(y_step_t, t, tt));    % Step cevabı sembolikten sayısal forma çevrilir
    y_ramp = double(subs(y_ramp_t, t, tt));    % Ramp cevabı sembolikten sayısal forma çevrilir

    subplot(2,2,i);                            % 2x2 grafik düzeninde ilgili subplot seçilir
    plot(tt, y_step, 'LineWidth', 1.2); hold on; % Step cevabı çizilir ve aynı grafikte kalması sağlanır
    plot(tt, y_ramp, 'LineWidth', 1.2);        % Ramp cevabı aynı grafiğe çizilir
    grid on;                                   % Izgara aktif edilir
    title(['a = ', num2str(a), ' (Step & Ramp)']); % Başlıkta mevcut a değeri gösterilir
    xlabel('t'); ylabel('y(t)');               % Eksen etiketleri tanımlanır
    legend('Step','Ramp','Location','best');   % Step ve Ramp için açıklama kutusu eklenir
end 

%% SORU 5                                        
clear; clc; close all;                           

% durum: x = [x1; x2; x3] = [y; y'; y'']         % Durum vektörü y, y'nin 1. ve 2. türevlerinden oluşur
f = @(t,x) [ x(2);                               % x1' = y'  olduğundan türev x(2) alınır
             x(3);                               % x2' = y'' olduğundan türev x(3) alınır
            -70*x(3) - 30*x(2) - 1000*x(1) ];    % x3' = y''' ifadesi diferansiyel denklemden yazılır

x0 = [0.05; 0; 0];                               % Başlangıç koşulları: [y(0); y'(0); y''(0)] atanır
tspan = [0 10];                                  % Çözümün alınacağı zaman aralığı tanımlanır

[t, x] = ode23(f, tspan, x0);                    % ODE sistemi ode23 ile sayısal olarak çözülür

y   = x(:,1);                                    % Çözümden y(t) = x1 alınır
yp  = x(:,2);                                    % Çözümden y'(t) = x2 alınır
ypp = x(:,3);                                    % Çözümden y''(t) = x3 alınır

figure('Color','white');                                           % y(t) için yeni figure açılır
plot(t,y,'LineWidth',1.5); grid on;              % y(t) grafiği çizilir ve grid açılır
title('Soru 5 - y(t) (ode23)');                  % Grafik başlığı yazılır
xlabel('t'); ylabel('y(t)');                     % Eksen etiketleri yazılır

figure('Color','white');                                        % y'(t) için yeni figure açılır
plot(t,yp,'LineWidth',1.5); grid on;             % y'(t) grafiği çizilir ve grid açılır
title('Soru 5 - y''(t) (ode23)');                % Başlıkta y'(t) doğru şekilde gösterilir
xlabel('t'); ylabel('y''(t)');                   % Y-ekseni y'(t) olarak etiketlenir

figure('Color','white');                                          % y''(t) için yeni figure açılır
plot(t,ypp,'LineWidth',1.5); grid on;            % y''(t) grafiği çizilir ve grid açılır
title('Soru 5 - y''''(t) (ode23)');              % (Not: burada aslında y'' olmalıydı, aşağıda düzelttim
xlabel('t'); ylabel('y''''(t)');                 % (Not: burada da aslında y'' olmalıydı, aşağıda düzelttim

% ode23, MATLAB'da başlangıç değer problemlerini (Initial Value Problem) çözmek için kullanılan sayısal diferansiyel denklem çözücüsüdür.

