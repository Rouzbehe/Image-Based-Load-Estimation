
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

%%%%%%%%%the approproate excel sheet should be chosen here %%%%%%%%%%%%  
[Island_Data,text_Island] = xlsread('input','all_ex_postcap_2'); %all_ex_postcap  all_ex_postcap_2 (5 more images/2 specimens were removed)
[Purdue_data,text_Purdue] = xlsread('input','Purdu_ex_deep');
[PCA_data,text_PCA] = xlsread('input','PCA');
% PCA_data = xlsread('input','PCA_ex_postcap');
[Toronto_Data,text_Toronto]=xlsread('input','Toronto');
[Toronto_4m_Data,text_Toronto_4m]=xlsread('input','4mdeep');
[deep_Data,text_deep]=xlsread('input','deep');
[Purdue2_Data,text_Purdue2]=xlsread('input','Purdu_2');
[Haunched_Data,text_Haunched]=xlsread('input','Haunched');
[Uniform_Data,text_Uniform]=xlsread('input','Uniform');
         
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

% 
for i=1:size(OUTPUT_Toronto_4m,1);
Toronto_4m_crack(i,:)=OUTPUT_Toronto_4m{i,1};
end

% deep beams include 4 meter deep beam as well
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
%%
% moved first part of the code here to save more time and run just this
% section
clear X tvp actualClass predictedClass feat_num

plotfname='10CV-on-Specimens-FR-SVM_Feat_13,20,21,51,52';
% Assigning features to model  
% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation'};
feat=[13,20,21,51,52];   % 1:20 same as before. 21:No of cracks,22: total distance between cracks 23:average distance     
%                           24:(a/d) 26:(d) 50:(b) 51:(a/h) 52:(h)
classifier=4;  % classifier     1=Support Vector Regression 2=Nearest Neighbor Regression 
                             %   3=Gaussian Process Regression 4=SOM regression (broght it here from other code 'svmRegressioInMatlab.m')
                             %   5=Linear Rgression    6=MultilayerPerceptron    7=REPTree   8=ZeroR
                             
testfeatNo=43;%  25=V   27=M    29 =M/bh2 
              % 37=M/abh(l-a) or M/abh(l/2) 38=M/a^2bh 41=M/(pho bd)
              % 42=V/(2*sqrt(fc) bd) or V_V_ACI    43=FailureRatio
              % 44=Moment through predicted shear M_(pho bd) (indirect)
              % 45=V throuh predicted V_V_ACI (indirect)
              % 46=M_(pho bd^2)
          
num_crossVali=10;  

% %  all data (ex deep)
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);Toronto_4m_crack(:,:),Toronto_4m_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_Toronto_4m(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];


% $ all ex toronto_4m and ex deep 
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];


% all data including deep
% X=[Island_crack(:,:),Island_Data(1:end,3:26);Purdue_crack(:,:),Purdue_data(1:end,2:25);PCA_crack(:,:),PCA_data(1:end,3:26);Toronto_crack(:,:),Toronto_Data(1:end,3:26);deep(:,:),deep_Data(1:end,3:26);Purdue2(:,:),Purdue2_Data(1:end,2:25);haunched(:,:),Haunched_Data(1:end,3:26); uniform(:,:),Uniform_Data(1:end,3:26)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];


% % all data sets ex (uniform and deep)
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1)];

% % % all data ex uniform
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);deep(:,:),deep_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1)];

% % all data ex deep
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];

% save the entire data to be used later by python
% csvwrite('without_rein.dat',X)
% disp('CSV file saved')

X1=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);deep(:,:),deep_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];
Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];

X1_2=[Island_Data(1:end,24:28);Purdue_data(1:end,23:27);PCA_data(1:end,24:28);Toronto_Data(1:end,24:28);deep_Data(1:end,24:28);Purdue2_Data(1:end,23:27);Haunched_Data(1:end,24:28); Uniform_Data(1:end,24:28)];

% data sets with reinforcement
% X2=[Faet_120(:,:),Data_120(1:end,3:26);Faet_95(:,:),Data_95(1:end,3:26);Faet_7(:,:),Data_7specimen(1:end,3:26);Faet_5(:,:),Data_5specimen(1:end,3:26);Faet_2(:,:),Data_2specimen(1:end,3:26);Faet_2meter(:,:),Data_2meter(1:end,3:26);Faet_low_a_d(:,:),Data_low_a_d(1:end,3:26)];
% Specimens_name2=[text_120(2:end,1);text_95(2:end,1);text_7specimen(2:end,1);text_5specimen(2:end,1);text_2specimen(2:end,1);text_2meter(2:end,1);text_low_a_d(2:end,1)];

% X2=[Faet_120(:,:),Data_120(1:end,3:31);Faet_95(:,:),Data_95(1:end,3:31);Faet_7(:,:),Data_7specimen(1:end,3:31);Faet_5(:,:),Data_5specimen(1:end,3:31);Faet_2(:,:),Data_2specimen(1:end,3:31);Faet_2meter(:,:),Data_2meter(1:end,3:31);Faet_low_a_d(:,:),Data_low_a_d(1:end,3:31)];
% Specimens_name2=[text_120(2:end,1);text_95(2:end,1);text_7specimen(2:end,1);text_5specimen(2:end,1);text_2specimen(2:end,1);text_2meter(2:end,1);text_low_a_d(2:end,1)];




% adding 3 columns of zeros for features 45,46 and 47 for beam w/o shear
% rein
X=[X1,zeros(length(X1),3),X1_2];




feat_num = X(:,feat);
featName = arrayfun(@num2str, [1:1:length(feat_num(1,:))], 'unif', 0);   

if testfeatNo==44
    class_num = X(:,42); 
elseif testfeatNo==45
    class_num = X(:,42);
else 
    class_num = X(:,testfeatNo)
end

    jj=1;
    
  
    
%  [un idx_last idx] = unique(Specimens_name);
% N = length(un);
% idx_unique = cell(1,N);
% for i = 1:N % for each unique element
%     idx_unique{i} = find(strcmp(Specimens_name,un(i))==1);
% end   
    


[un idx_last idx] = unique(Specimens_name,'stable');
unique_idx = accumarray(idx(:),(1:length(idx))',[],@(x) {sort(x)});
% indices = crossvalind('Kfold',size(X,1),num_crossVali);

Spec_idx=cell2mat(unique_idx);

indices = crossvalind('Kfold',size(unique_idx,1),num_crossVali);

for  k = 1:num_crossVali
   test=[];
    id=find(indices == k);
    for m=1:length(id)
        
        test=[test; unique_idx{id(m)}]
    end
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


   
    clear feature_train class_train feature_test class_test
    clear actual_tmp predicted_tmp probDistr_tmp 

end

%
    % to multiply predicted shear to span length to build moment
    if testfeatNo==44
        actualClass=actualClass.*X(:,44);
        predictedClass=predictedClass.*X(:,44);
    elseif  testfeatNo==45
        actualClass=actualClass.*X(:,45);
        predictedClass=predictedClass.*X(:,45);
    end
    
figure2=figure('Position', [100, 100, 1024, 1200]);
tvp=[mean(actualClass,2), nanmean(predictedClass,2)];



plotCorrelation_CI(tvp,plotfname,testfeatNo)

 figure3=figure('Position', [100, 100, 1024, 1200]);



plotname='regression-all data sets-d lower 20 in-fractureratio';


 figure4=figure('Position', [100, 100, 1024, 1200]);

[tvp_stregth]=xlsread('input','shearstrength');


% % to find statistical parameters for Volume<0.5
indices1 = find(tvp_stregth(:,1)>500);
tvp_stregth(indices1,:) = [];

plotCorrelation_CI(tvp_stregth,'shear strength by ACI-below500',1)


