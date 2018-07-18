
clear all; close all;clc;

%% Initializing 
% adding the path to matlab2weka codes
addpath([pwd filesep 'matlab2weka']);
% adding Weka Jar file
if strcmp(filesep, '\')% Windows    
    javaaddpath('C:\Program Files\Weka-3-6\weka.jar');
elseif strcmp(filesep, '/')% Mac OS X
    javaaddpath('/Applications/weka-3-6-12/weka.jar')
end
% adding matlab2weka JAR file that converts the matlab matrices (and cells)
% to Weka instances.
javaaddpath([pwd filesep 'matlab2weka' filesep 'matlab2weka.jar']);

%% 

plotfname='LOOCV-V_V_ACI_Gaussian_Feat_1T22,24';

%%%%%%%%%the approproate excel sheet should be chosen here %%%%%%%%%%%%  
[Island_Data,text_Island] = xlsread('input','all_ex_postcap');
[Purdue_data,text_Purdue] = xlsread('input','Purdu_ex_deep');

[PCA_data,text_PCA] = xlsread('input','PCA');
% PCA_data = xlsread('input','PCA_ex_postcap');



[Toronto_Data,text_Toronto]=xlsread('input','Toronto');

[Toronto_4m_Data,text_Toronto_4m]=xlsread('input','4mdeep');
[deep_Data,text_deep]=xlsread('input','deep');

[Purdue2_Data,text_Purdue2]=xlsread('input','Purdu_2');
[Haunched_Data,text_Haunched]=xlsread('input','Haunched');
[Uniform_Data,text_Uniform]=xlsread('input','Uniform');

% Assigning features to model  
% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation'};
feat=[1:22,24];   % 1:20 same as before. 21:No of cracks, 22:(a/d) 24:(d)
classifier=3;  % classifier     1=Support Vector Regression 2=Nearest Neighbor Regression 
                             %   3=Gaussian Process Regression 4=SOM regression (broght it here from other code 'svmRegressioInMatlab.m')
                             %   5=Linear Rgression    6=MultilayerPerceptron    7=REPTree   8=ZeroR
                             
testfeatNo=40;%  24=deflectionRatio, 23=V   25=M  26=M/EI  27=M/bd^2  28=M/Asfy  29=V/GJ  30=V/bd 30=M/bd 32=M/bh 33=M/bhl 34=M/bdl 35=M/fcbhl 36=M/bh(l-a) or M/bh(l/2)
              % 37=M/abh(l-a) or M/abh(l/2) 38=M/a^2bh 39=M/(pho bd)
              % 40=V/(2*sqrt(fc) bd) or V_V_ACI    41=FailureRatio
              % 42=Moment through predicted shear M_(pho bd)
              
%% Performing Leave one out cross validation


% Island data
% [OUTPUT_Crackshields]=FeatureExtraction_ex_postcap('all');
% [OUTPUT_Crackshields]=FeatureExtraction_ex_postcap_line('all');
% [OUTPUT_Crackshields]=FeatureExtraction_ex_postcap_BeamCropped('all');
[OUTPUT_Training]=FeatureExtraction_ex_postcap_BeamCropped_line('all');
% [OUTPUT_Crackshields]=Island_Scaled_segmented_ex_postcap_cropped_Skeltonized('all');


% Purdue data
% [OUTPUT_test]=FeatureExtraction_PurdeData_BeamCropped_line('all');
[OUTPUT_test]=FeatureExtraction_PurdeData_BeamCropped_line_ex_deep('all');


% PCA data
[OUTPUT_PCA]=FeatureExtraction_PCA_BeamCropped_line('all');
% [OUTPUT_PCA]=FeatureExtraction_PCA_BeamCropped_line_ex_postcap('all')


[OUTPUT_Toronto_4m]=FeatureExtraction_Toronto_4m('all');
[OUTPUT_deep]=FeatureExtraction_deep('all');

[OUTPUT_Toronto]=FeatureExtraction_Toronto('all');
[OUTPUT_Purdue2]=FeatureExtraction_Purdue2('all');
[OUTPUT_Haunched]=FeatureExtraction_haunched('all');
[OUTPUT_Uniform]=FeatureExtraction_uniform('all');



%   end
    
for i=1:size(OUTPUT_Training,1);
Island_crack(i,:)=OUTPUT_Training{i,1};
end

for i=1:size(OUTPUT_test,1);
Purdue_crack(i,:)=OUTPUT_test{i,1};
end

for i=1:size(OUTPUT_PCA,1);
PCA_crack(i,:)=OUTPUT_PCA{i,1};
end


for i=1:size(OUTPUT_Toronto,1);
Toronto_crack(i,:)=OUTPUT_Toronto{i,1};
end


for i=1:size(OUTPUT_Toronto_4m,1);
Toronto_4m_crack(i,:)=OUTPUT_Toronto_4m{i,1};
end

for i=1:size(OUTPUT_deep,1);
deep(i,:)=OUTPUT_deep{i,1};
end



for i=1:size(OUTPUT_Purdue2,1);
Purdue2(i,:)=OUTPUT_Purdue2{i,1};
end

for i=1:size(OUTPUT_Haunched,1);
haunched(i,:)=OUTPUT_Haunched{i,1};
end

for i=1:size(OUTPUT_Uniform,1);
uniform(i,:)=OUTPUT_Uniform{i,1};
end



% %  all data (ex deep)
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);Toronto_4m_crack(:,:),Toronto_4m_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_Toronto_4m(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];


% $ all ex toronto_4m and ex deep 
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];


% % all data including deep
X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);deep(:,:),deep_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];
Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];


% % all data sets ex (uniform and deep)
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1)];

% % % all data ex uniform
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);deep(:,:),deep_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1)];

% % all data ex deep
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];



feat_num = X(:,feat);
featName = arrayfun(@num2str, [1:1:length(feat_num(1,:))], 'unif', 0);   

if testfeatNo==42
    class_num = X(:,40); 
else
    class_num = X(:,testfeatNo);    

end

    jj=1;
    
  
    
%  [un idx_last idx] = unique(Specimens_name);
% N = length(un);
% idx_unique = cell(1,N);
% for i = 1:N % for each unique element
%     idx_unique{i} = find(strcmp(Specimens_name,un(i))==1);
% end   
    


[un idx_last idx] = unique(Specimens_name,'stable');
unique_idx = accumarray(idx(:),(1:length(idx))',[],@(x) {sort(x)})
% indices = crossvalind('Kfold',size(X,1),num_crossVali);

Spec_idx=cell2mat(unique_idx);

for k = 1:length(un)
   
    
    test = unique_idx{(k)}; 
%     train = unique_idx{(k~=indices)};
    train=Spec_idx(~ismember(Spec_idx,test));
%     train = Spec_idx(~(Spec_idx==unique_idx{k}));
    

    
    feature_train = feat_num(train,:);
    class_train = class_num(train,1);
    

    feature_test = feat_num(test,:);
    class_test = class_num(test,1);
   

    %performing regression
    [actual_tmp, predicted_tmp, stdDev_tmp] = wekaRegression(feature_train, class_train, feature_test, class_test, featName, classifier);
%     selectedAttr(jj,kk)=wekaFeatureSelection(feature_train, feature_test, class_train, class_test, featName, 1);

    %accumulating the results
    actualClass(ismember(Spec_idx,test),:) = actual_tmp;
    predictedClass(ismember(Spec_idx,test),:) = predicted_tmp;   


    

%     jj=jj+1;
%     ii=ii+3;
    clear feature_train class_train feature_test class_test
    clear actual_tmp predicted_tmp probDistr_tmp 

end

%%
    % to multiply predicted shear to span length to build moment
    if testfeatNo==42
        actualClass=actualClass.*X(:,42);
        predictedClass=predictedClass.*X(:,42);
    end
    
figure2=figure('Position', [100, 100, 1024, 1200]);
tvp=[mean(actualClass,2), nanmean(predictedClass,2)];



plotCorrelation_CI(tvp,plotfname,testfeatNo)

% figure3=figure('Position', [100, 100, 1024, 1200]);

Xaxis=13;Yaxis=41;curveaxis=40; %13 15
% plotRegression(X,plotfnameRegression,Xaxis,Yaxis,curveaxis)
  xlabel('d ','fontsize',17);
  ylabel('Fracture Ratio','fontsize',17);  

% figure4=figure('Position', [100, 100, 1024, 1200]);

% Zaxis=41;Xaxis=13;Yaxis=21; %Zaxis=40;Xaxis=13;Yaxis=5;
% plotMultipleregression(X,plotmultiRegression,Xaxis,Yaxis,Zaxis)


figure4=figure('Position', [100, 100, 1024, 1200]);

% plot the regression line vs tru line
Xcurve=X(:,Xaxis); Ycurve=X(:,Yaxis);

RegressionEQ=2.8876e-12*Xcurve.^3-5.4306e-08*Xcurve.^2+0.00031.*Xcurve+0.28;

tvr=[Ycurve, RegressionEQ];
Plot_No=1;
plotfregression='regressioin_feature13_includingultimatepointNEW';
plotCorrelation_regressionfit(tvr,plotfregression,Plot_No)


