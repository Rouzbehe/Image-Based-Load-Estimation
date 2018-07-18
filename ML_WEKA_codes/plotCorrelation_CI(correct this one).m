function [] = plotCorrelation_CI(tvp,plotfname,Plot_No)







% to remove "NaN" array from calculation in case some exis
tvp(find(isnan(tvp(:,2))),:) = []; 


%tvp(:,2) predicted variable, tvp(:,1) true varaible
NMAE = mean(abs(tvp(:,2)-tvp(:,1))./tvp(:,1))*100;
RMSE = sqrt(mean((tvp(:,2)-tvp(:,1)).^2))/mean(tvp(:,1));
SDR= sqrt(mean((tvp(:,2)-tvp(:,1)-mean(tvp(:,2))+mean(tvp(:,1))).^2));
R = corrcoef(tvp(:,2),tvp(:,1));
[RHO,PVAL] = corr(tvp(:,2)/max(tvp(:,2)),tvp(:,1)/max(tvp(:,1)),'Type','Spearman');
IA = 1 - mean((tvp(:,2)-tvp(:,1)).^2)/max(mean((abs(tvp(:,2)-mean(tvp(:,1)))+abs(tvp(:,1)-mean(tvp(:,1)))).^2),eps);
% CorrectnessTol=mean((abs(tvp(:,2)-tvp(:,1))<tol)*100);
% Correctness=mean((abs(tvp(:,2)-tvp(:,1))<NMAE)*100);
ExVar=1-var(tvp(:,1)-tvp(:,2),1)/var(tvp(:,1),1);
Rn = corrcoef(tvp(:,2)/max(tvp(:,2)),tvp(:,1)/max(tvp(:,1)));

nameFolder='Aug_24';
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
fprintf(fid,'\t RSpearman \t NMAE \t RMSE \t SDR \t R \t IA \t Rn \t ExplVarSco \n');
fprintf(fid, '\t %2.2f \t %2.2f \t %2.2f \t %2.2f \t %2.2f \t %2.2f\t %2.2f \t %2.2f \n',RHO,NMAE,RMSE,SDR,R(2),IA,Rn(2),ExVar) 

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

if Plot_No==21
  xlabel('True shear Stress (Mpa)%','fontsize',size);
  ylabel('Predicted shear Stress (Mpa)%','fontsize',size);
  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','deflection ratio');
elseif Plot_No==22
   xlabel('True shear strain (1e-3)','fontsize',size);
  ylabel('Predicted shear strain (1e-3)','fontsize',size);  
  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','shearforce(kN)');


elseif Plot_No==25
   xlabel('True failure ratio (shear stress/ultimate shear stress)','fontsize',size);
  ylabel('Predicted failure ratio (shear stress/ultimate shear stress)','fontsize',size);    
   NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M/(EI)');
   
elseif Plot_No==26
   xlabel('True failure ratio (shear strain/ultimate shear strain)','fontsize',size);
  ylabel('Predicted failure ratio (shear strain/ultimate shear strain)','fontsize',size);    
   NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M/(EI)');
 
     elseif Plot_No==27
  xlabel('True scaled shear stress   (\tau/(\surd{f_t}) ','fontsize',size);
  ylabel('Predicted scaled shear stress (\tau/(\surd{f_t}) ','fontsize',size);  
  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Vfcabh');

end



alpha=[0.01:0.01:0.1];
[p,S] = polyfitZero(tvp(:,1),tvp(:,2),1);
[Y,DELTA] = polyconf(p,tvp(:,1),S,'alpha',alpha(5));

% hconf = plot(tvp(:,1),Y+DELTA,'-b<','MarkerFaceColor',[.49 1 .63]);

hconf = plot(tvp(:,1),Y+DELTA,'b','LineWidth',2.2);
plot(tvp(:,1),Y-DELTA,'b','LineWidth',2.2);

LEG=legend('prediction', 'prediction trend', 'ideal trend', '95 % prediction intervals','Location','northwest')
set(LEG,'fontsize',size);
set(gca,'fontsize',size)
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




figure 

NameJPG3 = strcat(NameJPG2,'Distribution');

% for ii=1:length(alpha)
for ii=5
plot(tvp(:,1),Delta(ii,:),'b*')
hold on
plot([min(tvp(:,1)),max(tvp(:,1))],[mean(Delta(ii,:)),mean(Delta(ii,:))],'k--','LineWidth',1.5);
end
xlabel(Xlabel,'fontsize',size);
ylabel('Margin of error (95 % prediction intervals)','fontsize',size);  
set(gca,'fontsize',size)
LEG=legend('Margin of error distribution', 'Average margin of error','Location','northwest')
set(LEG,'fontsize',size);
print(char(NameJPG3),'-dpng', '-r300');

end