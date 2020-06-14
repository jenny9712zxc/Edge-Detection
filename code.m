%a.	Histogram equalization

file= imread('input1.png');%讀檔
gray=rgb2gray(file);%轉成灰階圖

[M N]=size(file);%M:row   N:col
N=N/3;%N包含RGB 3種範圍的col，只需1個代表column

subplot(3,2,1),imshow(gray);
title('原圖');

[counts,x]=imhist(gray);%imhist是對圖像直方圖進行統計，其中count，是每個灰度值得個數，x代表灰度值。一般的，x=1:256
P=counts/(M*N);%P每個灰階出現的機率

accumulate=counts;%accumulate:累計灰階個數
for i=2:256
    accumulate(i)=accumulate(i)+accumulate(i-1);
end

H=im2double(gray);%注意:一定要變換成double型別!!!
location=find(counts~=0);%找到所有畫素個數不為0的灰度級

MinCDF=min(counts(location));%找到包含個數最少的灰度級

for  j=1:length(location)

      CDF=sum(counts(location(1:j)));%計算各個灰度級畫素個數累計分佈

      P=find(H==x(location(j)));%找到影象中等於某個灰度級所有畫素點所在位置

      H(P)=(CDF-MinCDF)/(M*N-MinCDF);%利用灰度換算公式，修改所有位置上的畫素值

end

subplot(3,2,2),hold on;
A=histeq(H);
[counts,x]=imhist(A);
bar(counts);
%plot(accumulate);
title('Histogram equalization');
hold off;

%H=A;

%b.	Sobel operator
 
gx=[-1 -2 -1; 0 0 0; 1 2 1];%?????????? ????
gy=[-1 0 1; -2 0 2; -1 0 1];%???????? ????
gradx=filter2(gx,H,'same');%濾波
gradx=abs(gradx);%絕對值
subplot(3,2,3);
imshow(gradx,[]);
title('sobel垂直梯度');

grady=filter2(gy,H,'same');
grady=abs(grady); 
subplot(3,2,4);
imshow(grady,[]);
title('sobel水平梯度');
  
grad=gradx+grady;
subplot(3,2,5);
imshow(grad,[]);
title('sobel垂直+水平梯度');