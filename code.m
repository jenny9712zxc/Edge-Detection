%a.	Histogram equalization

file= imread('input1.png');%Ū��
gray=rgb2gray(file);%�ন�Ƕ���

[M N]=size(file);%M:row   N:col
N=N/3;%N�]�tRGB 3�ؽd��col�A�u��1�ӥN��column

subplot(3,2,1),imshow(gray);
title('���');

[counts,x]=imhist(gray);%imhist�O��Ϲ�����϶i��έp�A�䤤count�A�O�C�Ӧǫ׭ȱo�ӼơAx�N��ǫ׭ȡC�@�몺�Ax=1:256
P=counts/(M*N);%P�C�ӦǶ��X�{�����v

accumulate=counts;%accumulate:�֭p�Ƕ��Ӽ�
for i=2:256
    accumulate(i)=accumulate(i)+accumulate(i-1);
end

H=im2double(gray);%�`�N:�@�w�n�ܴ���double���O!!!
location=find(counts~=0);%���Ҧ��e���ӼƤ���0���ǫׯ�

MinCDF=min(counts(location));%���]�t�ӼƳ̤֪��ǫׯ�

for  j=1:length(location)

      CDF=sum(counts(location(1:j)));%�p��U�Ӧǫׯŵe���ӼƲ֭p���G

      P=find(H==x(location(j)));%���v�H������Y�ӦǫׯũҦ��e���I�Ҧb��m

      H(P)=(CDF-MinCDF)/(M*N-MinCDF);%�Q�Φǫ״��⤽���A�ק�Ҧ���m�W���e����

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
gradx=filter2(gx,H,'same');%�o�i
gradx=abs(gradx);%�����
subplot(3,2,3);
imshow(gradx,[]);
title('sobel�������');

grady=filter2(gy,H,'same');
grady=abs(grady); 
subplot(3,2,4);
imshow(grady,[]);
title('sobel�������');
  
grad=gradx+grady;
subplot(3,2,5);
imshow(grad,[]);
title('sobel����+�������');