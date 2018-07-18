clear all,clc
close all


% data set 1

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
data = 100*[  0.16 , 0.13  ,0.13   , 0.11  ; 0.82   , 0.87 , 0.86   ,0.89  ; 0.86   , 0.93  , 0.92  , 0.94  ; 0.66  , 0.76  ,  0.73  ,  0.80  ];



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
legend('Nonlionear regression-Total major axis','LOOCV-on Specimen-SOM-All Features-a/d-d','10CV-on Specimen-SOM-All Features-a/d-d','10CV-on Specimen-SOM-Total major axis-a/d-d','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_regression_ex_deep_uniform','-dpng', '-r1000');

%%
% data set 1

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
data = 100*[  0.15  ,  0.13  , 0.14   ,  0.15  ;  0.82  , 0.87  , 0.85    ,  0.83 ;  0.89   , 0.92   ,  0.92  ,  0.91  ; 0.67 ,0.75   ,0.72     , 0.69   ];

% data = 100*[    ,    ,    ,    ;    ,   ,     ,   ;     ,    ,    ,    ;  ,   ,     ,    ];


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
legend('Nonlionear regression-Total major axis-a/d-d-All data sets','Nonlionear regression-Total major axis-a/d-d-data sets d<20 in','10CV-on Specimen-SOM-All features-a/d-d-All data sets','10CV-on Specimen-SOM-Total major axis-a/d-d-All data sets','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 120])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_regression_FR','-dpng', '-r1000');
%%
% data set 3

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];

data = 100*[  0.11  , 0.09   , 0.08   ,  0.08  ; 0.78   ,0.87   , 0.9    , 0.89  ; 0.87    ,  0.93  , 0.95   ,  0.94  ; 0.61 ,  0.77 ,  0.81   ,  0.79  ];


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
legend('Nonlionear regression-Crack length-Total major axis-a/d-d-All data sets','Nonlionear regression-Crack length-Total major axis-a/d-d-data sets d<20 in','10CV-on Specimen-Gaussian-All features-a/d-d-All data sets','10CV-on Specimen-Gaussian-Crack length-Total major axis-a/d-d-All data sets','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 120])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_regression_V','-dpng', '-r1000');