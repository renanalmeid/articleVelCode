function deviationSumGroup = calcDP(leitura2,quantityGroups2,velMeanX)

    deviationSumGroup = 0;
    
    %calcula standard deviation
    for y = 1:quantityGroups2 %loop pra calccular vel de 10588 grupos no arquivo file
        dataSety = hdf5read(leitura2.GroupHierarchy.Groups(6).Groups(y).Datasets)'; %matriz de vel e posicao 5x500 e trasforma 500x5 
        ionsDatay = dataSety; % modulo da velocidade
        sizeIonsDatay = size(ionsDatay);   % entende tamanho da matriz ---> 500x5
        quantityIonsDatay = sizeIonsDatay(1); % armazena linhas de velocidades --> 500
        sumSquaredDiff = 0;

        for n1 = 1:quantityIonsDatay % loop soma velocidades do grupo x 
           positionz{n1} = ionsDatay(n1,1);
           velz{n1} = ionsDatay(n1,3);
           if positionz{n1} <= 0.3
              squaredDiff{n1} = (velz{n1} - velMeanX)^2; 
              sumSquaredDiff = sumSquaredDiff + squaredDiff{n1};
           end

        end  %armazenamento das velocidades
        deviStorage{y} = sumSquaredDiff; %calcula velocidade media do file 
        deviationSumGroup = deviationSumGroup + deviStorage{y}; %guarda valor vel pro calculo final de todas vel
    end

end
