function [] = plotCorrelation_CI(tvp,plotfname,Plot_No)







% to remove "NaN" array from calculation in case some exis
tvp(find(isnan(tvp(:,2))),:) = []; 


%tvp(:,2) predicted variable, tvp(:,1) true varaible
NMAE = mean(abs(tvp(:,2)-tvp(:,1))./tvp(:,1))*100;
RMSE = sqrt(mean((tvp(:,2)-tvp(:,1)).^2))/mean(tvp(:,1));
NRMSE=sqrt(mean((tvp(:,2)-tvp(:,1)).^2))/(max(tvp(:,1))-min(tvp(:,1)));
SDR= sqrt(mean((tvp(:,2)-tvp(:,1)-mean(tvp(:,2))+mean(tvp(:,1))).^2));
R = corrcoef(tvp(:,2),tvp(:,1));
[RHO,PVAL] = corr(tvp(:,2)/max(tvp(:,2)),tvp(:,1)/max(tvp(:,1)),'Type','Spearman');
% IA = 1 - mean((tvp(:,2)-tvp(:,1)).^2)/max(mean((abs(tvp(:,2)-mean(tvp(:,1)))+abs(tvp(:,1)-mean(tvp(:,1)))).^2),eps);
IA = 1 - sum((tvp(:,2)-tvp(:,1)).^2)/sum((abs(tvp(:,2)-mean(tvp(:,1)))+abs(tvp(:,1)-mean(tvp(:,1)))).^2);

% CorrectnessTol=mean((abs(tvp(:,2)-tvp(:,1))<tol)*100);
% Correctness=mean((abs(tvp(:,2)-tvp(:,1))<NMAE)*100);
ExVar=1-var(tvp(:,1)-tvp(:,2),1)/var(tvp(:,1),1);
Rn = corrcoef(tvp(:,2)/max(tvp(:,2)),tvp(:,1)/max(tvp(:,1)));

nameFolder='Nov_26_10CV_on_specimen';
if (exist(char(nameFolder),'dir') == 0); mkdir(char(nameFolder)); end;
Namepdf = strcat(nameFolder,'/',plotfname,'.pdf');
NameJPG = strcat(nameFolder,'/',plotfname);
Nametxt = strcat(nameFolder,'/',plotfname,'.txt');


% if (exist(char('test'),'dir') == 0); mkdir(char('test')); end;
% Namepdf = strcat('test','/',plotfname,'.pdf');
% NameJPG = strcat('test','/',plotfname);
% Nametxt = strcat('test','/',plotfname,'.txt');


fid = fopen(Nametxt,'w');

fprintf(fid,'Accuracy Performance of models\n');
fprintf(fid,'\t NRMSE \t NMAE \t RMSE \t SDR \t R \t IA \t Rn \t ExplVarSco \n');
fprintf(fid, '\t %2.2f \t %2.2f \t %2.2f \t %2.2f \t %2.2f \t %2.2f\t %2.2f \t %2.2f \n',NRMSE,NMAE,RMSE,SDR,R(2),IA,Rn(2),ExVar) 

close(ancestor(fid, 'figure'))









%set plot limits
xmin = min(tvp(:,1));
xmax = max(tvp(:,1));
ymin = min(tvp(:,2));
ymax = max(tvp(:,2));
% plotmin = floor(min(xmin,ymin));
plotmin=0;
plotmax = max(xmax,ymax);
% plotmax =2.5;

%find limits for linear fit (equation forced through origin)
A=tvp(:,1);
B=tvp(:,2);
m=sum(A.*B)/sum(A.^2);
mx = [0,plotmax];
my = [0,plotmax*m];

%plot scatter and trendlines (and 45 degree correlation) d
plot(tvp(:,1),tvp(:,2),'k*','markers',7)
hold on
plot(mx,my,'k')
hold on 
plot([0,plotmax],[0,plotmax],'--k')
hold on 

xlim([0 plotmax]);
ylim([0 plotmax]);

% set(gca,'XTick',plotmin:tol:plotmax)
% set(gca,'YTick',plotmin:tol:plotmax)
size=17;
sizeLATEX=13.5;


  
  

if Plot_No==1
  xlabel('True shear strength (KN)','fontsize',size);
  ylabel('Estimated Shear strength by ACI (KN)','fontsize',size);
  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','deflection ratio');
  
  elseif Plot_No==24
  xlabel('True deflection ratio (deflection/beam length)%','fontsize',size);
  ylabel('Predicted deflection ratio (deflection/beam length)%','fontsize',size);
  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','deflection ratio');

elseif Plot_No==25
   xlabel('True shear force (kN)','fontsize',size);
  ylabel('Predicted shear force (kN)','fontsize',size);
    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','shear force');

elseif Plot_No==27
   xlabel('True moment at mid span (kN.mm)','fontsize',size);
  ylabel('Predicted moment at mid span (kN.mm)','fontsize',size);    
      NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','moment');


elseif Plot_No==28
   xlabel('True scaled moment at mid span ($$\frac{M}{EI}$$)','fontsize',sizeLATEX,'FontName','Helvetica','Interpreter','latex');
  h=ylabel('Predicted scaled moment at mid span ($$\frac{M}{EI}$$)','fontsize',sizeLATEX,'FontName','Helvetica','Interpreter','latex');
  
        NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled moment');

elseif Plot_No==29
  xlabel('True scaled moment at mid span ($$\frac{M}{bd^2}$$)','fontsize',sizeLATEX,'FontName','Helvetica','Interpreter','latex');
  h=ylabel('Predicted scaled moment at mid span ($$\frac{M}{bd^2}$$)','fontsize',sizeLATEX,'FontName','Helvetica','Interpreter','latex');
         NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled moment 2');


 
elseif Plot_No==30
   xlabel('True scaled moment at mid span ($$\frac{M}{A_{s}f_{y}d}$$ )','fontsize',sizeLATEX,'FontName','Helvetica','Interpreter','latex');
  h=ylabel('Predicted scaled moment at mid span ($$\frac{M}{A_{s}f_{y}d}$$ )','fontsize',sizeLATEX,'FontName','Helvetica','Interpreter','latex');
  
  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled moment Asfy');

  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled moment Asfy');

elseif Plot_No==31
   xlabel('True scaled shear force (V/(GJ))','fontsize',size);
  ylabel('Predicted sclaed shear force (V/(GJ))','fontsize',size);  
  
    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled shear force GJ');

elseif Plot_No==32
   xlabel('True scaled shear force (V/(bd))','fontsize',size);
  ylabel('Predicted sclaed shear force (V/(bd))','fontsize',size);    
  
      NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled shear force Vbd');

  elseif Plot_No==33
   xlabel('True scaled moment at mid span  (M/(bd))','fontsize',size);
  ylabel('Predicted scaled moment at mid span (M/(bd))','fontsize',size);
  
        NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Mbd');

  elseif Plot_No==34
   xlabel('True scaled moment at mid span  (M/(bh))','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(bh))','fontsize',size); 
  
          NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Mbh');

  elseif Plot_No==35
   xlabel('True scaled moment at mid span  (M/(bhl))','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(bhl))','fontsize',size); 
  
            NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Mbhl');

    elseif Plot_No==36
   xlabel('True scaled moment at mid span  (M/(bdl))','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(bdl))','fontsize',size); 
  
              NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Mdl');

      elseif Plot_No==37
   xlabel('True scaled moment at mid span  (M/(fc bhl))','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(fc bhl))','fontsize',size); 
  
                NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Mfcbhl');

     elseif Plot_No==38
   xlabel('True scaled moment at mid span (Integral Ratio) ','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (Integral Ratio)','fontsize',size); 
  
                  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M Integral');

     elseif Plot_No==39
   xlabel('True scaled moment at mid span (M/(abh (l-a))) ','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(abh (l-a)))','fontsize',size); 
  
                    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M span');

    elseif Plot_No==40
   xlabel('True scaled moment at mid span (M/(a^2bh)) ','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(a^2bh))','fontsize',size); 
  
                    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M midsoan');

     elseif Plot_No==41
   xlabel('True scaled moment at mid span   (M/(\rho bd)) ','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(\rho bd)) ','fontsize',size);  
  
                    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M rho bd');


     elseif Plot_No==42
%  xlabel('True scaled shear $$(V/(2\sqrt{f_c}~bd)$$','fontsize',13,'FontName','Helvetica','Interpreter','latex');
%   ylabel('Predicted scaled shear $$(V/(2\sqrt{f_c}~bd)$$','fontsize',13,'FontName','Helvetica','Interpreter','latex'); 

 xlabel('True scaled shear     ','fontsize',size);
 ylabel('Predicted scaled shear     ','fontsize',size);  
  
                      NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','V aci');

      elseif Plot_No==43
  xlabel('True  Failure ratio (M/M_{failure}) or (V/V_{failure})','fontsize',size);
  ylabel('Predicted  Failure ratio (M/M_{failure}) or (V/V_{failure})','fontsize',size); 
  
                        NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Failure Ratio');

       elseif Plot_No==44
   xlabel('True scaled moment at mid span   (M/(\rho bd)) ','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(\rho bd)) ','fontsize',size);  
  
                    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M rho bd');
       elseif Plot_No==45
    xlabel('True shear force (kN)','fontsize',size);
    ylabel('Predicted shear force (kN)','fontsize',size);
    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','shear force');
         elseif Plot_No==46
   xlabel('True scaled moment at mid span   (M/(\rho bd^2)) ','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(\rho bd^2)) ','fontsize',size);  
end


% messy part to creat a space between axis title and axis created by latex interpreter in Malab        
% set(h,'unit','normalized')
% set(h,'interpreter','latex')
% ylabh = get(gca,'YLabel');
% set(ylabh,'Position',get(ylabh,'Position') - [0.039 0.05 0])


alpha=[0.01:0.01:0.1];
[p,S] = polyfitZero(tvp(:,1),tvp(:,2),1);
[Y,DELTA] = polyconf(p,tvp(:,1),S,'alpha',alpha(5));

% hconf = plot(tvp(:,1),Y+DELTA,'-b<','MarkerFaceColor',[.49 1 .63]);

hconf = plot(tvp(:,1),Y+DELTA,'b','LineWidth',2.2);
plot(tvp(:,1),Y-DELTA,'b','LineWidth',2.2);

LEG=legend('prediction', 'prediction trend', 'ideal trend', '95 % prediction intervals','Location','northwest')
set(LEG,'fontsize',size);
set(gca,'fontsize',size)

% set(gcf, 'PaperPositionMode', 'auto')

h = gcf;
% print('-dpdf',char(Namepdf),'-r300')
print(char(NameJPG),'-dpng', '-r300');
% saveas(h, char(NameJPG),'-r300');
% hold off

for ii=1:length(alpha)
[Y,Delta(ii,:)] = polyconf(p,tvp(:,1),S,'alpha',alpha(ii)) ;   

delta(ii)=mean(Delta(ii,:));
end



figure 
plot((1-alpha)*100,delta,'b-','LineWidth',1.5)
grid on
xlim([ min((1-alpha)*100) max((1-alpha)*100)]);

xlabel('Prediction Interval (%)','fontsize',size);
ylabel('Average margin of error','fontsize',size);  
set(gca,'fontsize',size)
% print('-dpdf',char(Namepdf),'-r300')
print(char(NameJPG2),'-dpng', '-r300');



% 
% figure 
% 
% NameJPG3 = strcat(NameJPG2,'Distribution');
% 
% % for ii=1:length(alpha)
% for ii=5
% plot(tvp(:,1),Delta(ii,:),'b*')
% hold on
% plot([min(tvp(:,1)),max(tvp(:,1))],[mean(Delta(ii,:)),mean(Delta(ii,:))],'k--','LineWidth',1.5);
% end
% xlabel(Xlabel,'fontsize',size);
% ylabel('Margin of error (95 % prediction intervals)','fontsize',size);  
% set(gca,'fontsize',size)
% LEG=legend('Margin of error distribution', 'Average margin of error','Location','northwest')
% set(LEG,'fontsize',size);
% print(char(NameJPG3),'-dpng', '-r300');

end