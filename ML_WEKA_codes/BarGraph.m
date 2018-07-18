clear all,clc
close all
% Case 10
data = 100*[0.16 ,0.15  , 0.14 ,0.26 ,0.21 ,  0.2 ,0.21; 0.84 ,0.87  , 0.87 , 0.90 , 0.93 , 0.88 ,0.92; 0.91 , 0.93 , 0.93 , 0.94 ,0.96  , 0.93  ,0.96; 0.71 , 0.76 ,0.77  ,0.80  , 0.86 ,0.77 , 0.85];


fH = gcf; colormap(jet(7));
Labels = {'RMSE (error)', '(R)', 'IA','Explained variance Score'};
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
legend('Case10-FailureRatio-Gaussian-Feat-3,6,20','Case10-FailureRatio-Gaussian-Feat-3-till-20','Case10-FailureRatio-som-Feat-3-till-20','Case10-M-\rho bd-Gaussian-Feat-1-till-20','Case10-M-bd-Gaussian-Feat-1-till-20','Case10-V-bd-Gaussian-Feat-3-till-20','Case10-(V/(2\surd{f_c} bd)-Gaussian-Feat-3-till-20','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 115])
applyhatch_pluscolor(fH,'ww/x.c\', 0, [0 1 0 1 0 1 1], jet(7))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_moment','-dpng', '-r1000');

%% Data set 1
clear all,clc
close all
% data set 1
data2 = 100*[0.22  , 0.24  ,0.22    , 0.39, 0.19 ,   0.67 ; 0.69 ,0.61  ,0.67  ,0.7 , 0.72  ,0.0  ;0.7 ,0.77 , 0.77 , 0.5, 0.79 , 0.27  ;0.47  , 0 , 0.37 , 0.43 , 0.51 ,  0];



fH2 = gcf; colormap(jet(6));
Labels = {'RMSE (error)', '(R)', 'IA','Explained variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

h2=bar(data2);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h2)
    XDATA=get(get(h2(i),'Children'),'XData');
    YDATA=get(get(h2(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Case 1-FailureRatio-SOM-Feat-6,11,13,14,17','Case4-FailureRatio-Gaussian-Feat-3,10,19','Case5-FailureRatio-Gaussian-Feat-6,11,13,14,17', 'Case1-V-bd-Nearest-Feat-1,6,11,19','Case4-V-bd-Gaussian-Feat-10,11,19','Case5-V-bd-Gaussian-Feat-3,10,19','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH2,'ww/x.c', 0, [0 1 0 1 0 1], jet(6))
% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_dataset1','-dpng', '-r1000');

%% Data set 2
clear all,clc
close all
% data set 1
data2 = 100*[  0.18 , 0.18   , 0.19   , 0.18 , 0.24  ,   0.25  ;0.7   ,0.77   , 0.75  ,0.78  ,0.73    , 0.86  ;0.84  , 0.79, 0.68 , 0.88 , 0.78  , 0.88  ;  0.45 , 0.57  , 0.42  ,  0.61 ,0.54   , 0.32];



fH2 = gcf; colormap(jet(6));
Labels = {'RMSE (error)', '(R)', 'IA','Explained variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

h2=bar(data2);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h2)
    XDATA=get(get(h2(i),'Children'),'XData');
    YDATA=get(get(h2(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Case2-FailureRatio-Gaussian10-Feat-1,2,6,10,13,19,20','Case6-FailureRatio-Gaussian-Feat-20','Case7-FailureRatio-Gaussian-Feat-1,10,20', 'Case2-V-bd-Gaussian10-Feat-6,10,15,16,17,18,19,20','Case6-V-bd-Gaussian-Feat-2,10','Case7-V-bd-Gaussian-Feat-2,10,20','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH2,'ww/x.c', 0, [0 1 0 1 0 1], jet(6))
% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_dataset2','-dpng', '-r1000');
%% Data set 3
clear all,clc
close all
% data set 1
data2 = 100*[  0.18  , 0.32    , 0.19   , 0.53  , 0.51  ,   0.44   ; 0.88   , 0.87   ,0.88    , 0.57  , 0.27    ,  0.66  ; 0.91  , 0.79 , 0.92  , 0.65  ,  0.4  ,  0.7 ;  0.77  , 0.75   , 0.76   ,  0.25  , 0.05   ,  0.44];



fH2 = gcf; colormap(jet(6));
Labels = {'RMSE (error)', '(R)', 'IA','Explained variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

h2=bar(data2);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h2)
    XDATA=get(get(h2(i),'Children'),'XData');
    YDATA=get(get(h2(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Case3-FailureRatio-Gaussian10-Feat-2,6,20','Case8-FailureRatio-Gaussian-Feat-4,20','Case9-FailureRatio-Gaussian-Feat-4,20', 'Case3-V-bd-Gaussian10-Feat-1,6,11,16,17,20','Case8-V-bd-Gaussian-Feat-10,20','Case9-V-bd-Gaussian-Feat-10,20','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH2,'ww/x.c', 0, [0 1 0 1 0 1], jet(6))
% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_dataset3','-dpng', '-r1000');