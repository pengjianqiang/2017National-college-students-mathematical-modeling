 function [x,y]=jingweizhuanhuan(lat1,log1,lat2,log2)
%  ����һ�����Խ���γ��֮��ת���ɾ�������֮��ĺ���
x=distance(lat1,log1,lat2,log1)/180*pi*6370;
y=distance(lat1,log1,lat1,log2)/180*pi*6370;
if log2>log1
     x=-x;   
end
if lat2>lat1
    y=-y;
end

