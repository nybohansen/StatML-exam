function [ dataMatrix, classVector] = loadDataSet( basePath, sampleSize, numberOfClases )
% Each Column of datamatrix is a sample of the dataset
% classVector contains the class value for each column in the datamatrix


numberOfSamples = lsr(basePath);

dataMatrix = zeros(sampleSize, numberOfSamples);
classVector = zeros(numberOfSamples,1);

colCounter = 1;

for nNumFolder = 0:numberOfClases-1

    sFolder = num2str(nNumFolder, '%05d');
    
    sPath = [basePath, '/', sFolder, '/'];

    if isdir(sPath)
        files = dir(sPath);
        numberOfFiles = size(files,1);
        for n = 3: numberOfFiles
            fPath = [basePath, '/', sFolder, '/',files(n).name];
            fid = fopen(fPath);
            C = textscan(fid, '%f', sampleSize);
            fclose(fid);    
            dataMatrix(:,colCounter) = C{1}';
            classVector(colCounter,1) = nNumFolder;
            colCounter = colCounter+1;            
        end
                
    end
        
end


function num = lsr(directory)
    %LSR Count number of files including subdirs...
    entries = dir(directory);
    % take the number of files:
    num = sum(~[entries.isdir]);
    % now take a look into every subdirectory
    direcs = find([entries.isdir]);
    % leave out directories '.', '..'
    for i=3:length(direcs)
        num = num + lsr(fullfile(directory, entries(direcs(i)).name));
    end
end

end

