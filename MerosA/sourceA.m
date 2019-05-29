clear;
clc;
alphabet = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};%alphabet
prob     = [ 0.08167 0.01492 0.02782 0.04253 0.12702 0.02228 0.02015 0.06094 0.06966 0.00153 0.00772 0.04025 0.02406 0.06749 0.07507 0.01929 0.00095 0.05987 0.06327 0.09056 0.02758 0.00978 0.02361 0.00150 0.01974 0.00074 ];%probability of each symbol from alphabet
sumprob(1,1) = 0;                                                  %initialize sumprob
for i=1:length(prob)                                               %for-loop to see if sum of all probabilities are 1
    sumprob=sumprob + prob(i);
end
randsrc_ = alphabet( randsrc( 1, 10000, [1:length(prob); prob] ) );%create 10.000 random symbols as sourceA from alphabet
dict = huffmandict_( alphabet, prob );                             %create huffman dictionary
signalencoded = huffmanenco_( randsrc_, dict );                    %encode sourceA
randsrc_ = char(randsrc_);                                         %convert cell to char matrix
randsrc_ = randsrc_';
disp('SourceA');
disp(randsrc_);                                                    %display randsrc_
disp('Encoded signal:');
disp(signalencoded);                                               %display signalencoded
signaldecoded = huffmandeco_( signalencoded, dict );               %decode encoded signal to retrieve sourceA
signaldecoded = char(signaldecoded);                               %convert cell to char matrix
signaldecoded = signaldecoded';                                    %transpose signaldecoded to look like the original source(A)
disp('Decoded signal:');
disp(signaldecoded);                                               %display signaldecoded
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