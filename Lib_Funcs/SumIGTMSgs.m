
function IGTLMsg = SumIGTMSgs(Data_Dir)

    Pre_Dir = pwd;
    cd(Data_Dir);


    filelist = ls('*.igtl');

    [r,c] = size(filelist);

    for i=1:r
        i
        filename = filelist(i,:);
        if i == 1
            IGTLMsg =  ReadSingleIGTLMsg(filename);
        else
            IGTLMsgT =  ReadSingleIGTLMsg(filename);
            IGTLMsg.Body.data = IGTLMsg.Body.data+IGTLMsgT.Body.data;
        end
    end
    
    cd(Pre_Dir);
    
    scale = diag(1./double(max(abs(IGTLMsg.Body.data))));
    
    %IGTLMsg.Body.data = double(IGTLMsg.Body.data)*double(scale);
    IGTLMsg.Body.data = double(IGTLMsg.Body.data)*double(scale);
    
    

    
    figure;
    imagesc(IGTLMsg.Body.data);
    colorbar;
    

end 
