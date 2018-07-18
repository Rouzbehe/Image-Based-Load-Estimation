
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
         
%%%%%%%%%the approproate function should be chosen here %%%%%%%%%%%%
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
clear X tvp actualClass predictedClass

plotfname='Imagelevel-10CV_FailureRatio_svm_Feat_1T21,23';
% Assigning features to model  
% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation'};
feat=[1:21,23];   % 1:20 same as before. 21:No of cracks,22: total distance between cracks 23:average distance       24:(a/d) 26:(d)
classifier=4;  % classifier     1=Support Vector Regression 2=Nearest Neighbor Regression 
                             %   3=Gaussian Process Regression 4=SOM regression (broght it here from other code 'svmRegressioInMatlab.m')
                             %   5=Linear Rgression    6=MultilayerPerceptron    7=REPTree   8=ZeroR
                             
testfeatNo=43;%  25=V   27=M  28=M/EI  29 =M/bd2 30=M/Asfy  32=M/bh 33=M/bhl 34=M/bdl 35=M/fcbhl 36=M/bh(l-a) or M/bh(l/2)
              % 37=M/abh(l-a) or M/abh(l/2) 38=M/a^2bh 41=M/(pho bd)
              % 42=V/(2*sqrt(fc) bd) or V_V_ACI    43=FailureRatio
              % 44=Moment through predicted shear M_(pho bd) (indirect)
              % 45=V throuh predicted V_V_ACI (indirect)
              % 46=M_(pho bd^2)
          
num_crossVali=10;  
% all data including deep
X=[Island_crack(:,:),Island_Data(1:end,3:25);Purdue_crack(:,:),Purdue_data(1:end,2:24);PCA_crack(:,:),PCA_data(1:end,3:25);Toronto_crack(:,:),Toronto_Data(1:end,3:25);deep(:,:),deep_Data(1:end,3:25);Purdue2(:,:),Purdue2_Data(1:end,2:24);haunched(:,:),Haunched_Data(1:end,3:25); uniform(:,:),Uniform_Data(1:end,3:25)];
Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];

% % % all data ex uniform
% X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);deep(:,:),deep_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23)];
% Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1)];


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
    
    
indices = crossvalind('Kfold',size(X,1),num_crossVali);
for k = 1:num_crossVali
    k
    test = (indices == k); train = ~test;
    

    
    feature_train = feat_num(train,:);
    class_train = class_num(train,1);
    

    feature_test = feat_num(test,:);
    class_test = class_num(test,1);
   

    %performing regression
    [actual_tmp, predicted_tmp, stdDev_tmp] = wekaRegression(feature_train, class_train, feature_test, class_test, featName, classifier);
%     selectedAttr(jj,kk)=wekaFeatureSelection(feature_train, feature_test, class_train, class_test, featName, 1);

    %accumulating the results
    actualClass(indices == k,:) = actual_tmp;
    predictedClass(indices == k,:) = predicted_tmp;   
    

    clear feature_train class_train feature_test class_test
    clear actual_tmp predicted_tmp probDistr_tmp 

end



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


Zaxis=41;Xaxis=13;Yaxis=21; %Zaxis=40;Xaxis=13;Yaxis=5;




