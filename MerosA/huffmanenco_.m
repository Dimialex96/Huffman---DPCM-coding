function enco = huffmanenco_( sig, dict )
%Encoding state.
dictLength = length(dict.code);
enco = '';                                   %Empty encoded signal (char).
while( ~isempty(sig) )                       %Loop for each signal value.
    tempcode = '';                           %Empty signal value (char).
    for j = 1 : dictLength
        %Search sequentially through the dictionary to
        %find the proper code for the given signal.
        if( strcmp(sig(1),dict.symbol{j}) ) %If there is a match.
            tempcode = dict.code{j};
            break;
        end
    end
    enco = strcat( enco,tempcode );          %Append the code to the encryption message.
    sig = sig(2:end);                        %Update the signal vector.
end
end
