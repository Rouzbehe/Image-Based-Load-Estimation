
clear all; close all;clc;
tic
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
            



%  % % % %  % % % % % % % % % % % % % % % % 
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


% for i=1:size(OUTPUT_Toronto_4m,1);
% Toronto_4m_crack(i,:)=OUTPUT_Toronto_4m{i,1};
% end

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
% clear X Specimens_name tvp actualClass predictedClass

plotfname='L2--5percent-20-10-7-Learning-2-V-Feat_13,20,21,24,26';
% Assigning features to model  
% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation'};
feat=[13,20,21,24,26];   % 1:20 same as before. 21:No of cracks,22: total distance between cracks 23:average distance       24:(a/d) 26:(d)
                          
testfeatNo=25;%  25=V   27=M  28=M/EI  29 =M/bd2 30=M/Asfy  32=M/bh 33=M/bhl 34=M/bdl 35=M/fcbhl 36=M/bh(l-a) or M/bh(l/2)
              % 37=M/abh(l-a) or M/abh(l/2) 38=M/a^2bh 41=M/(pho bd)
              % 42=V/(2*sqrt(fc) bd) or V_V_ACI    43=FailureRatio
              % 44= M_(pho bd) (indirect) through predicted shear
              % 45=V throuh predicted V_V_ACI (indirect)
              % 46=M_(pho bd^2)
              
% Performing num_crossVali fold Cross Validation          
num_crossVali=10;  



% % all data sets 
% data sets without reinforcement
% all data including deep
X=[Island_crack(:,:),Island_Data(1:end,3:25);Purdue_crack(:,:),Purdue_data(1:end,2:24);PCA_crack(:,:),PCA_data(1:end,3:25);Toronto_crack(:,:),Toronto_Data(1:end,3:25);deep(:,:),deep_Data(1:end,3:25);Purdue2(:,:),Purdue2_Data(1:end,2:24);haunched(:,:),Haunched_Data(1:end,3:25); uniform(:,:),Uniform_Data(1:end,3:25)];
Specimens_name=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];

feat_num0 = X(:,feat);
feat_num=zscore(feat_num0);

featName = arrayfun(@num2str, [1:1:length(feat_num(1,:))], 'unif', 0);   

if testfeatNo==44
    class_num = X(:,42); 
elseif testfeatNo==45
    class_num = X(:,42);
else 
    class_num = X(:,testfeatNo)
end

    jj=1;
    
% linear mapping of the data to -1 to +1 range
% class_num=zscore(class_num);
Max=max(class_num(:)); Min=min(class_num(:));
class_num=-1+2*(class_num-Min)/(Max-Min);  

% linear mapping of the data to 0 to +1 range
% class_num=zscore(class_num);
% Max=max(class_num(:)); Min=min(class_num(:));
% class_num=(class_num-Min)/(Max-Min);  

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
    k
   test=[];
    id=find(indices == k);
    for m=1:length(id)
        
        test=[test; unique_idx{id(m)}];
    end
%     train = unique_idx{(k~=indices)};
    train=Spec_idx(~ismember(Spec_idx,test));
%     train = Spec_idx(~(Spec_idx==unique_idx{k}));
    

    Zfeature_train = feat_num(train,:);
    Zclass_train = class_num(train,1);
    

    Zfeature_test=feat_num(test,:);
    Zclass_test = class_num(test,1);
   
%     class_test = class_num(test,1);

    
    net = NeuralNet2([size(feat_num,2) 20 10 7  size(class_num,2)]); % 20 7 for FR(small size feature set) / 20 15 10 for v-shearsterngth
    net.LearningRate = 2; % 0.5 and 1.5 best/ 1 for v-shear strength/ new v-vaci 1
    net.RegularizationType = 'L2'; % no L1 was best for FR/L2 for v-shear strength/new v-vaci L1
    net.RegularizationRate = 0.05; % 0 or 0.01 best for FR/0.05 for v-shear strength/new v-vaci 0
%     net.ActivationFunction = 'elu';
    net.BatchSize =1000;  % 1000 for FR/2000 for v-shear strength/new v-vaci 1000
    display(net)

% % Training and Testing Network

N = 5000;  % number of iterations 5000 default
disp('Training...'); tic
costVal = net.train(Zfeature_train, Zclass_train, N);
toc

% compute predictions
disp('Test...'); tic
% predictTrain = net.sim(feature_train);
ZpredictTest = net.sim(Zfeature_test);
 
% convert Zscored value to real values
% predictTest=ZpredictTest*std(class_test(:))+mean(class_test(:));
% predictTest=ZpredictTest*std( X(:,testfeatNo))+mean( X(:,testfeatNo));
% class_test=Zclass_test*std( X(:,testfeatNo))+mean( X(:,testfeatNo));






    %performing regression
%     [actual_tmp, predicted_tmp, stdDev_tmp] = wekaRegression(feature_train, class_train, feature_test, class_test, featName, classifier);
%     selectedAttr(jj,kk)=wekaFeatureSelection(feature_train, feature_test, class_train, class_test, featName, 1);

    %accumulating the results
    actualClass(ismember(Spec_idx,test),:) = Zclass_test;
    predictedClass(ismember(Spec_idx,test),:) = ZpredictTest;   


    clear feature_train class_train feature_test class_test Zclass_test ZpredictTest
    clear net

end

toc
% changing back the mapped data -1 +1
actualClass=(actualClass+1)*(Max-Min)/2+Min;
predictedClass=(predictedClass+1)*(Max-Min)/2+Min;    

% changing back the mapped data 0 +1
% actualClass=(actualClass)*(Max-Min)+Min;
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




