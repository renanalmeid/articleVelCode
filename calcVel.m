function [velSumGroup,numPartEnd,veloPlot,positionPlot] = calcVel(leitura1,quantityGroups1)

    velSumGroup = 0;
    numPartEnd =0;
    positionPlot = 0;
    veloPlot =0;
    for w = 1 : quantityGroups1 
        %matriz de vel e posicao 5x500 e trasforma 500x5
        dataSet = hdf5read(leitura1.GroupHierarchy.Groups(6).Groups(w).Datasets)'; 
        ionsData = dataSet; % modulo da velocidade
        sizeIonsData = size(ionsData);   % entende tamanho da matriz ---> 500x5
        quantityIonsData = sizeIonsData(1); % armazena linhas de velocidades --> 500
        sumVelFile =0;
        v =0;          
        for n = 1:quantityIonsData % loop soma velocidades do grupo x 
            positionZ{n} = ionsData(n,1);
            velZ{n} = ionsData(n,3);
            if positionZ{n} <=0.3
                sumVelFile = sumVelFile + velZ{n};
                numPartEnd = numPartEnd + 1;
                positionPlot = positionZ{n};
                veloPlot = velZ{n};
            end
        end  %armazenamento das velocidades
        velStorage{w} = sumVelFile; %calcula velocidade media do file 
        velSumGroup = velSumGroup + velStorage{w}; %guarda valor vel pro calculo final de todas vel
    end

end
