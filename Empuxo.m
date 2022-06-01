clear all
close all
clc

%% Inicia arquivos
files = dir('*.dmp'); %call files type dmp
numFiles = length(files);  
sumQuantityParticle = 0;
velMeanStorage = 0;
deviationStorage = 0;
numPartStorage = 0;
veloPlotFinal= 0;
positionPlotFinal = 0;
%% Loop para cálculo velocidade Média
for j = 1 : numFiles  %loop to access files
    leitura = hdf5info(files(j).name);
    sizeGroupsData = size(leitura.GroupHierarchy.Groups(6).Groups);
    quantityGroups = sizeGroupsData(2);
    %
    [velSumGroup,numPartEnd,veloPlot,positionPlot] = calcVel(leitura, quantityGroups); %% funçao para calcular velocidade
    %
    
    numPartGroup{j} = numPartEnd;
    numPartStorage = numPartStorage + numPartGroup{j};
    velMeanGroup{j} = velSumGroup;
    velMeanStorage = velMeanStorage + velMeanGroup{j};
    sumQuantityParticle = sumQuantityParticle + quantityGroups;
   
    veloPlotFinal(j) = veloPlot;
    positionPlotFinal(j) = positionPlot;
    
    %% funçao
    % Pro arquivo 1
    % 10k pastas 
    % num particulas 
end

%% for loopp fazer a diferença 
% numpartGroup{j+1} - numpartGroup{j}
% entre os 10 arquivos 
% Q=  fazer a media das diferenças

%particles = sumQuantityParticle*500;
velMeanTotal = velMeanStorage/numPartStorage;
plot(veloPlotFinal, positionPlotFinal,'.'); 
%% Loop para cálculo de desvio padrão

for k = 1: numFiles 
    leituraDP = hdf5info(files(k).name);
    sizeGroupsDataDP = size(leituraDP.GroupHierarchy.Groups(6).Groups);
    quantityGroupsDP = sizeGroupsDataDP(2);
    %
    deviationSumGroup = calcDP(leituraDP,quantityGroupsDP, velMeanTotal); %% funçao calcular desvio padrao
    
    %
    deviationGroup{k} = deviationSumGroup;
    deviationStorage = deviationStorage + deviationGroup{k};
    
end
standardDeviation = sqrt(deviationStorage/numPartStorage);

%% Cálculo Empuxo 

Np = 1.00e+05; %% Numero de particulas
m_proton = 1.672e-27;
m_arg = 39.948;
Mi = m_proton *m_arg; %% ion mass
delT = 5.00e-10; %% time step 
T = (Np*Mi*velMeanTotal)/delT;
Isp = T/9.81;