clear;clc;close all;
data=xlsread('data.xlsx','sheet1');%����
data4=xlsread('data.xlsx','sheet4');%�������޶�
 % data1Ϊsheet1�е�����
tasknumber=length(data);
 % tasknumberΪ��¼2����������
x=data(:,1);
y=data(:,2);
 % x,y�ֱ��ʾdata4���и����������
 
%price=data4(:,3);
%response=data4(:,4);



% �õ�������
data2=xlsread('data.xlsx','sheet2'); %��Ⱥ�����ֵ
%data2��ҪΪsheet2�й��ڻ�Ա������
huiyuan=data4(:,1:2); 
%huiyuanΪ��Ա��γ������
xiane=data4(:,3);
%xiane��ÿλ��Ա�����

data3=xlsread('data.xlsx','sheet3');
xinyu=data2(:,2);
% ��Ա������
set_valid=unique([find(and(huiyuan(:,1)>22,huiyuan(:,1)<24)); find(and(huiyuan(:,2)>112,huiyuan(:,2)<115))]); 
% ���ݴ���
huiyuan_valid=huiyuan(set_valid,:);

% ��ʼ����
center=mean(huiyuan_valid);
% ���ĵ����� ��Ա�����ĵ�
huiyuan_cart=zeros(size(huiyuan_valid));
% coord_cart��һ���������������������㷽��
for i=1:size(huiyuan_valid,1)
    [x,y]=jingweizhuanhuan(center(1),center(2),huiyuan_valid(i,1),huiyuan_valid(i,2));
    huiyuan_cart(i,1)=x;% �û�Ա���굽���ĵ�ĺ������
    huiyuan_cart(i,2)=y;% �û�Ա���굽���ĵ���������
end

%% ��������ָ��
task_cart=zeros(tasknumber,2);
%���������



for iTask=1:tasknumber 
    [x,y]=jingweizhuanhuan(center(1),center(2),data(iTask,1),data(iTask,2));

     task_cart(iTask,:)=[x y];%��������ڻ�Ա���ĵ�����
    
end



edge_box=9;
area=edge_box^2;
% ѡȡһ���߳�Ϊ9��������
peiemidu=zeros(tasknumber,1);
shenqi=ones(size(huiyuan_valid,1),1);
% ȫ1�Ļ�Ա�о���
shenqi2=ones(tasknumber,1);
% ȫ1�������о���
renkoumidu=zeros(tasknumber,1);
xiyujunzhi=zeros(tasknumber,1);
renwumidu=zeros(tasknumber,1);

xin_renwumidu=zeros(tasknumber,1);

for iTask=1:tasknumber
    x=task_cart(iTask,1);
    y=task_cart(iTask,2);
    %������������
    in_box=intersect(find(and(huiyuan_cart(:,1)>x-edge_box/2, huiyuan_cart(:,1)<x+edge_box/2)), find(and(huiyuan_cart(:,2)>y-edge_box/2,huiyuan_cart(:,2)<y+edge_box/2)));
    % ɸѡ�õ���Χ�ڻ�Ա�ı��
    in_box2=intersect(find(and(task_cart(:,1)>x-edge_box/2, task_cart(:,1)<x+edge_box/2)), find(and(task_cart(:,2)>y-edge_box/2,task_cart(:,2)<y+edge_box/2)));
    % ɸѡ�õ���Χ������ı��
    renkoumidu(iTask)=sum(shenqi(in_box))/area;
    % ��λ����ڻ�Ա������
    peiemidu(iTask)=sum(xiane(in_box))/area;
    % ��λ�������������
    xiyujunzhi(iTask)=sum(xinyu(in_box))/area;
     % ��λ���������ֵ�ܺ�
    renwumidu(iTask)=sum(shenqi2(in_box2))/area;
     % ��λ�������������ܺ�
    
end


