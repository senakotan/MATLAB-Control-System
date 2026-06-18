%% UYGULAMA 1

% M matrisini tanımladım.
M = [1 2 3; 4 5 6; 7 8 9]

% M matrisinin determinantını hesaplayıp x'e atadım.
x = det(M)

% M matrisinin tersini bulup U'ya atadım. 
% (Matris singüler olduğu için burada uyarı aldım).
U = inv(M)

% Standart matris çarpımı ve eleman bazlı çarpım işlemlerini yaptım.
y = M * U     
yz = M .* U   

% M matrisinin 1. ve 3. sütunlarını sırasıyla a1 ve a3'e atadım.
a1 = M(:, 1)  
a3 = M(:, 3)  

% a1'in devriği ile a3'ü çarpıp z değişkenine atadım.
z = a1' * a3  

% a1 ve a3'ü eleman elemana çarpıp k'ya atadım.
k = a1 .* a3  

% M'nin 3. satırını [5 6 7] olarak güncelledim.
M(3, :) = [5 6 7] 

% M'nin 1. ve 2. satırlarını sildim.
M([1, 2], :) = [] 

%% UYGULAMA 2 

% 1'den 20'ye kadar sayılardan oluşan u vektörünü oluşturdum.
u = 1:20

% İşlem yapmak için u vektörünü a değişkenine kopyaladım.
a = u;

% a vektörünün çift indeksli (2., 4., 6. vb.) elemanlarını 0 yaptım.
a(2:2:end) = 0

% Alternatif çözüm: Sadece çift sayıları 0 yapmak için mod kullandım.
a = u;
a(mod(a, 2) == 0) = 0;