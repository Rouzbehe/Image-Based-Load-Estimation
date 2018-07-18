clear all,clc
close all
% data set 1
data = 100*[0.06 ,0.06 , 0.1,0.07 ; 0.97 ,0.97 ,0.84 ,0.92 ; 0.94 ,0.94 ,0.91 , 0.96; 0.88 , 0.88,0.7 ,0.85 ];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Gaussian-All Features-a/d-d','SOM-All Features-a/d-d','SOM-All Features','SOM-Total major axis-I_{p}-No cracks-a/d-d','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_10CV_Vaci','-dpng', '-r1000');

%% Data set 2
clear all,clc
close all
% data set 1

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
data = 100*[0.11 ,0.11 ,0.13 ,0.12 ; 0.91 ,0.91 ,0.86 ,0.90 ;0.95 ,0.95 ,0.92 ,0.94 ;0.82,0.82 , 0.74, 0.8];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Gaussian-All Features-a/d-d','SOM-All Features-a/d-d','SOM-All Features','SOM-Total major axis-I_{p}-No cracks-a/d-d','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_10CV_FR','-dpng', '-r1000');

%% paper figure 3

clear all,clc
close all
% data set 1

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
data = 100*[ 0.03 , 0.04 , 0.04 , 0.03 ; 0.93  , 0.94 , 0.91 , 0.94 ; 0.96, 0.97 ,0.95 , 0.97 ; 0.87,0.85  , 0.83 , 0.87];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Direct-SOM-All Features-a/d-d','Indirect-SOM-All Features-a/d-d','Direct-SOM-All Features','Indirect-SOM-Total major axis-I_{p}-No cracks-a/d-d','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_10CV_M','-dpng', '-r1000');
