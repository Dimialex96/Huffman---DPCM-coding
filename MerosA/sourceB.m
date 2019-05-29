clear;
clc;
A = importdata('kwords.txt');                       %load to vector A each row from kword.txt
str = strjoin(A);                                   %merge rows of A to 1x1 matrix
str = str(find(~isspace(str)));                     %delete spaces from str
disp('SourceB:');
disp(str);                                          %display sourceB
b = cellstr(str')';                                 %split and put chars from str to different rows in order to make sourceB
[alphabet,~,idx] = unique(b);                       %distinct symbols to make alphabet
counts = accumarray(idx(:),1,[],@sum);              %count the occurrences of each symbol
totalcount = 0 ;                                    %initialize the total symbol occurrences
for i=1:length(counts)                              %for-loop  to count the total number of symbols
    totalcount = totalcount + counts(i);
end
prob(1,length(counts)) = 0;                         %initialize probability vector
for i=1:length(counts)                              %for-loop to measure the probability of each symbol
    prob(i) = counts(i)/totalcount;                     %prob = probability of each symbol
end
sumprob(1,1) = 0;                                   %initialize sumprob
for i=1:length(prob)                                %for-loop to see if sum of all probabilities are 1
    sumprob=sumprob + prob(i);
end
dict = huffmandict_( alphabet, prob );              %create huffman dictionary
signalencoded = huffmanenco_( str , dict );         %encode sourceB
disp('Encoded signal:');
disp(signalencoded);                                %display signalencoded
signaldecoded = huffmandeco_( signalencoded, dict );%decode encoded signal to retrieve sourceB
signaldecoded = char(signaldecoded);                %convert cell to char matrix
signaldecoded = signaldecoded';                     %transpose signaldecoded to look like the original source(str)
disp('Decoded signal:');
disp(signaldecoded);                                %display signaldecoded
avglength = 0;
entropy = 0;
for k=1:length(dict.code)
    avglength = avglength + length(dict.code{k})*prob(k);
end
for l=1:length(prob)
    entropy = entropy + prob(l)*log2(1/prob(l));
end
avgl = 'Average Length is %4.4f bit/symbol \n';                   %average length of huffman encoding
fprintf(avgl,avglength);
entr = 'Entropy is %4.4f bit/symbol \n';                          %entropy for alphabet
fprintf(entr,entropy);
efficiency = entropy/avglength;                                   %Efficiency of huffmanenco_
disp('Efficiency:');
disp(efficiency);