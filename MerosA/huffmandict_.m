function dict = huffmandict_( alphabet, prob )
%Initialize working space.
for i = 1:length( prob )             %For each probability.
    codewords{i} = '';               %Create an empty codeword.
    symbol{i} = i;                   %Index the codeword.
end
%Coding state.
while ( prob ~= 1 )                  %Loop,until we reach the root.
    [~, arr] = sort(prob);           %Sort probabilities at every loop and get arrangement of sorted probabilities.
    %Get the index of the two sets to be merged.
    last = arr(1);
    next = arr(2);
    %Get their main index.
    right_set = symbol{last};
    left_set  = symbol{next};
    %Get their probabilities.
    right_probability = prob(last);
    left_probability  = prob(next);
    %Append them in a new set.
    merged_set = [right_set, left_set];
    new_prob   = right_probability + left_probability;
    %Update probability and symbol sets
    symbol(arr(1:2)) = '';
    prob(arr(1:2))   = '';
    symbol = [symbol merged_set];
    prob   = [prob new_prob];
    %Get the updated codeword.
    codewords = append_(codewords,right_set,'1');
    codewords = append_(codewords,left_set,'0');
end
%Output structure {symbol,codewords}.
dict.symbol = alphabet; dict.code = codewords;
end